/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */
#include "stime.h"

void time(void) {
    int i = 0;
    i++;
}

void Task_Led(void);
void Task_Led1(void);
static unsigned char Task0Stack[100];
static unsigned char Task1Stack[100];
extern void Task_Create(void (*function)(void),unsigned char* StackTop,unsigned char priority);
extern void Tim2_Init(void);
extern void OutPut_IO_Init(void);
extern void Delay_Time(unsigned char time);
extern void OS_Start(void);
extern void CLK_Init(void);

int main( void ) {
    CLK_Init();
    Tim2_Init();
    OutPut_IO_Init();
    Task_Create(Task_Led,&Task0Stack[99],1);
    Task_Create(Task_Led1,&Task1Stack[99],2);  
    OS_Start();
  
    create_stime(5,time);
    while(1) {
        input_loop();
    }
}


void Task_Led(void)
{
  while(1)
  {
    PC_ODR_ODR1=~PC_IDR_IDR1;
    Delay_Time(50);
  }
}
void Task_Led1(void)
{
 while(1)
 {
  PG_ODR_ODR1=~PG_IDR_IDR1;
  Delay_Time(20);
 }
}
void Task_Idle(void)
{
 while(1); 
}
