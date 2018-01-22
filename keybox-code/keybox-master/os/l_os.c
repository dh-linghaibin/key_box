/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "l_os.h"

static task_tcb_obj Task_TCB[8];
static uint8_t IdleStack[50];
void Task_Idle(void);
static uint8_t Pri_Current,Pri;//Pri_Hightest
uint16_t Current_Ready_StackTop;
static uint8_t const PriMapTbl[]={0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80,0x00};
static uint8_t const MapTbl[] = {
    7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x00 to 0x0F                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x10 to 0x1F                             */
    5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x20 to 0x2F                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x30 to 0x3F                             */
    6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x40 to 0x4F                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x50 to 0x5F                             */
    5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x60 to 0x6F                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x70 to 0x7F                             */
    7, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x80 to 0x8F                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0x90 to 0x9F                             */
    5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xA0 to 0xAF                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xB0 to 0xBF                             */
    6, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xC0 to 0xCF                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xD0 to 0xDF                             */
    5, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0,       /* 0xE0 to 0xEF                             */
    4, 0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0        /* 0xF0 to 0xFF                             */
};

static uint8_t os_time_counter;
#pragma vector=TIM2_OVR_UIF_vector
__interrupt void Tim2_Overflow(void)
{
    TIM2_SR1=0;//清楚中断标志位
    
    for(os_time_counter=0;os_time_counter<8;os_time_counter++)
    {
        if(Task_TCB[os_time_counter].Remain_Time)
        {
            Task_TCB[os_time_counter].Remain_Time--;
            if(!Task_TCB[os_time_counter].Remain_Time)
            {
                Pri|=PriMapTbl[os_time_counter];
            }
        }     
    }
    if(Pri_Current>MapTbl[Pri])
    {
        asm("LDW X,SP"); 
        asm("INCW X");//定时器中断时会多进栈3字节,调整SP
        asm("INCW X");
        asm("INCW X");
        asm("LDW SP,X"); 
        asm("push $0");//保存虚拟寄存器
        asm("push $1");
        asm("push $2");
        asm("push $3");
        asm("push $4");
        asm("push $5");
        asm("push $6");
        asm("push $7");
        asm("push $8");
        asm("push $9");
        asm("push $a");
        asm("push $b");
        asm("push $c");
        asm("push $d");
        asm("push $e");
        asm("push $f");
        Current_Ready_StackTop=(unsigned int)(&Task_TCB[Pri_Current].StackTop);
        asm("ldw X,L:Current_Ready_StackTop");//保存到当前任务栈顶到任务表中.
        asm("ldw Y,SP");
        asm("ldw (X),Y");
        Pri_Current=MapTbl[Pri];
        Current_Ready_StackTop=(unsigned int)(Task_TCB[Pri_Current].StackTop);
        asm("ldw X,L:Current_Ready_StackTop");//读取最高优先任务栈顶地址到SP中.
        asm("ldw SP,X");
        asm("pop $f");
        asm("pop $e");
        asm("pop $d");
        asm("pop $c");
        asm("pop $b");
        asm("pop $a");
        asm("pop $9");
        asm("pop $8");
        asm("pop $7");
        asm("pop $6");
        asm("pop $5");
        asm("pop $4");
        asm("pop $3");
        asm("pop $2");
        asm("pop $1");
        asm("pop $0");
        asm("IRET");
    }
}

#pragma vector=1
__interrupt void softinterrutp(void)
{
    asm("LDW X,SP"); 
    asm("INCW X");//软中断时会多进栈2个字节,调整SP
    asm("INCW X");
    asm("LDW SP,X"); 
    asm("push $0");
    asm("push $1");
    asm("push $2");
    asm("push $3");
    asm("push $4");
    asm("push $5");
    asm("push $6");
    asm("push $7");
    asm("push $8");
    asm("push $9");
    asm("push $a");
    asm("push $b");
    asm("push $c");
    asm("push $d");
    asm("push $e");
    asm("push $f");
    Current_Ready_StackTop=(unsigned int)(&Task_TCB[Pri_Current].StackTop);
    asm("ldw X,L:Current_Ready_StackTop");//保存到当前任务栈顶到任务表中.
    asm("ldw Y,SP");
    asm("ldw (X),Y");
    Pri_Current=MapTbl[Pri];
    Current_Ready_StackTop=(unsigned int)(Task_TCB[Pri_Current].StackTop);
    asm("ldw X,L:Current_Ready_StackTop");//读取最高优先任务栈顶地址到SP中.
    asm("ldw SP,X");
    asm("pop $f");
    asm("pop $e");
    asm("pop $d");
    asm("pop $c");
    asm("pop $b");
    asm("pop $a");
    asm("pop $9");
    asm("pop $8");
    asm("pop $7");
    asm("pop $6");
    asm("pop $5");
    asm("pop $4");
    asm("pop $3");
    asm("pop $2");
    asm("pop $1");
    asm("pop $0");
    asm("IRET");
}

void los_init(void) {
    CLK_CKDIVR=0x00;//时钟预分频，默认8分配，0x18.16M-0x00；8M-0x08;4M-0x10;
    
    TIM2_PSCR=0x02;//1/4prescale
    TIM2_ARRH=0x9c;
    TIM2_ARRL=0x40;
    TIM2_CNTRH=0x00;
    TIM2_CNTRL=0x00;
}

void los_create(void (*function)(void),uint8_t* StackTop,uint8_t priority) {
    unsigned i;
    *StackTop--=(unsigned long)function;
    *StackTop--=(unsigned long)function>>8;
    *StackTop--=(unsigned long)function>>16;
    for(i=0;i<5;i++)
        *StackTop--=0;
    *StackTop--=0x20;
    for(i=0;i<16;i++)
        *StackTop--=0;
    Task_TCB[priority].StackTop=(unsigned int)StackTop;
    Pri|=PriMapTbl[priority];
    
}

void los_delay(uint8_t time) {
    if(time>100)time=10;
    Task_TCB[Pri_Current].Remain_Time=time;
    Pri&=~PriMapTbl[Pri_Current];
    asm("TRAP");
}

void los_start(void) {
    Pri_Current=7;
    los_create(Task_Idle,&IdleStack[49],7);
    TIM2_CR1=MASK_TIM2_CR1_ARPE|MASK_TIM2_CR1_CEN;
    TIM2_IER=0x01;
    asm("rim");
    Task_Idle();
}

void Task_Idle(void) {
    while(1); 
}

