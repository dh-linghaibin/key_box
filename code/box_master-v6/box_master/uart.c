/***********************************************************
* �ĵ�: uart.c
* ����: Haibin Ling
* ����: 1.����1��ʼ��������1���ͺ���
*       2.����3��ʼ��������3���ͺ���
***********************************************************/
#include "type.h"

#define rs485_dr1 PA_ODR_ODR6
#define rs485_dr2 PD_ODR_ODR7
/*****************************
������: UART1_Init()
����ֵ����
��  ��:	��ʼ������1 ����������Ϊ9600  ���ж�
*****************************/
void UART1_Init(void)
{
    /***485_PA4****/
    PA_DDR |= BIT(5);
    PA_CR1 |= BIT(5); 
    PA_CR2 |= BIT(5);
    /***485_PA5****/
    PA_DDR &= ~BIT(4);
    PA_CR1 |= BIT(4); 
    PA_CR2 &= ~BIT(4);
    /***485����������_PA6****/
    PA_DDR |= BIT(6);
    PA_CR1 |= BIT(6); 
    PA_CR2 |= BIT(6);
    rs485_dr1 = 0;
    UART1_CR1=0x00;
    UART1_CR2=0x00;
    UART1_CR3=0x00; 
    UART1_BRR2=0x02;
    UART1_BRR1=0x68;
    UART1_CR2=0x2c;//������գ����ͣ��������ж�
    UART1_CR2 &= ~BIT(2);/*�رս����ж�*/
}
/*****************************
������: UART1_Sendint(unsigned char ch)
����ֵ����
����ֵ����Ҫ���͵��ֽ�
��  ��:	�����ֽڵĴ���1
*****************************/
void UART1_Sendint(unsigned char ch)
{
    while((UART1_SR & 0x80) == 0x00);    // �ȴ����ݵĴ���  
    UART1_DR = ch;                    
}
/*****************************
������: UART1_Send
����ֵ����
����ֵ����������  ���� �ɹ����
��  ��:	�����ֽڵĴ���1
*****************************/
extern u8 ts1_ok;
void UART1_Send(u8 *Array,u8 command,u8 situ)
{
    volatile u8 i;
    //while( (UART1_SR&(1<<6)) )/*�ȴ��������*/
    while(ts1_ok == 1);
    UART1_SR&= ~BIT(6);  //��������״̬λ
    UART1_CR2 |= BIT(6);//�����������
    Array[0] = situ;
    Array[1] = command;
    Array[7] = c_last;
    rs485_dr1 = 1;
    ts1_ok = 1;
    UART1_DR = c_head;
}
/*****************************
������: UART3_Init()
����ֵ����
��  ��:	��ʼ������3 ����������Ϊ9600  ���ж�
*****************************/
void UART3_Init(void)
{
    /***485_PD5****/
    PD_DDR |= BIT(5);
    PD_CR1 |= BIT(5); 
    PD_CR2 |= BIT(5);
    /***485_PD6****/
    PD_DDR &= ~BIT(6);
    PD_CR1 |= BIT(6); 
    PD_CR2 &= ~BIT(6);
    /***485����������_PD7****/
    PD_DDR |= BIT(7);
    PD_CR1 |= BIT(7); 
    PD_CR2 |= BIT(7);
    rs485_dr2 = 0;
    UART3_CR1=0x00;
    UART3_CR2=0x00;
    UART3_CR3=0x00; 
    UART3_BRR2=0x02;
    UART3_BRR1=0x68;
    UART3_CR2=0x2c;//������գ����ͣ��������ж�
}
/*****************************
������: UART3_Sendint(unsigned char ch)
����ֵ����
����ֵ����Ҫ���͵��ֽ�
��  ��:	�����ֽڵĴ�3
*****************************/
void UART3_Sendint(unsigned char ch)
{
    while((UART3_SR & 0x80) == 0x00);    // �ȴ����ݵĴ���  
    UART3_DR = ch;   
    delayus(100);	
}
/*****************************
������: void UART_interrupt(u8 uart,u8 mode)
����ֵ����
����ֵ��0-����1 1-����3  0-�ؽ��ж� 1-�������ж�
��  ��:	�����ж� 
*****************************/
void UART_interrupt(u8 uart,u8 mode)
{
    if(uart == 0)
    {
        if(mode == 0)
        {
            UART1_CR2 &= ~BIT(2);/*�رս����ж�*/
        }
        else if(mode == 1)
        {
            UART1_CR2 |= BIT(2);/*ʹ�ܽ����ж�*/
        }
    }
    else if(uart == 1)
    {
        if(mode == 0)
        {
            UART3_CR2 &= ~BIT(2);/*�رս����ж�*/
        }
        else if(mode == 1)
        {
            UART3_CR2 |= BIT(2);/*ʹ�ܽ����ж�*/
        }
    }
}
/*****************************
������: UART3_Send
����ֵ����
����ֵ����������  ���� �ɹ����
��  ��:	�����ֽڵĴ�3
*****************************/
extern u8 ts3_ok;
void UART3_Send(u8 *Array,u8 command,u8 situ)
{
    volatile u8 i;
    //while( (UART3_SR&(1<<6)) )/*�ȴ��������*/
    while(ts3_ok == 1);
    UART3_SR&= ~BIT(6);  //��������״̬λ
    UART3_CR2 |= BIT(6);//�����������?
    Array[14] = c_last;
    Array[0] = command;
    Array[12] = Array[0];
    if( (command == CORRECT)||(command == ERROR) )
    {
        Array[12] = Array[0];
        Array[13] = 0;
        for(i = 1;i < 12;i++)
        {
            Array[i] = 0x00;
        }
    }
    else
    {
        /*�ۼ�У��*/
        for(i = 1;i < 12;i++)
        {
            Array[13] += Array[i];
        }
        if(situ == ok)
        {
            Array[0] = TRUE;
            Array[12] = Array[0];
        }
        else
        {
            Array[0] = FALSE;
            Array[12] = Array[0];
        }
    }
    rs485_dr2 = 1;
    ts3_ok = 1;
    UART3_DR = c_head;
}
/*****************************
������: UART1_Init()
����ֵ����
��  ��:	��ʼ������1 ����������Ϊ9600  ���ж�
*****************************/
extern u16 T2msFlg;
extern u8 wr_new;/*����ص����*/
extern u8 fr_Flag;/*�ص�����־λ*/
extern u8 RsBuffer[MaxNumberofCom];//���ڻ�����
extern u8 mirro;/*�Զ�������־*/
u16 cheak_wait_2 = 1500;//�ط��ȴ�ʱ��
u8 cf_jj2 = 0;
/*���б�־   �ӷ��ͻ��� �ӽ��ջ���  �����ͻ��� �����ջ��� ģʽ �ӻ�������ɱ�־*/
void Drawer_cont(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                 u8 *ts,u8 *rs,u8 mode,u8 *ts_flag)
{
    *rb_Flag = 1;
    *ts_flag = 0;
    T2msFlg = 0;
    cf_jj2 = 0;
    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
    UART1_Send(R_ts,mode,rs[1]);
    while(*rb_Flag > 0)
    {
        WDT();//�忴�Ź�
        if(*ts_flag == 1)/*�ȴ���������*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*����*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x02)/*����*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x03)/*����˿*/
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,no);
                    }
                }
                else
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,no);
                    }
                }
            }
            else
            {
                WDT();//�忴�Ź�
                *ts_flag = 0;/*����������ɣ������ٴν���*/
                if(T2msFlg > cheak_wait_2)
                {
                    T2msFlg = 0;
                    if(*rb_Flag == 1)
                    {
                        *rb_Flag = 2;
                        UART1_Send(R_ts,mode,rs[1]);
                    }
                    else
                    {
                        *rb_Flag = 0;/*���Ͳ��ɹ����˳�*/
                        if(mirro == 0)
                        {
                            UART3_Send(ts,mode,no);
                        }
                    }
                }
            }
        }
        if(T2msFlg > cheak_wait_2)
        {
            T2msFlg = 0;
            if(*rb_Flag == 1)
            {
               // *rb_Flag = 2;
                if(cf_jj2 < 5) {
                    cf_jj2++;
                } else {
                    cf_jj2 = 0;
                    *rb_Flag = 2;
                }
                UART1_Send(R_ts,mode,rs[1]);
            }
            else
            {
                *rb_Flag = 0;/*���Ͳ��ɹ����˳�*/
                UART3_Send(ts,mode,no);
            }
        }
        if(mode == Drawer_back)
        {
            Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*���ص�*/
        }
    }
}


u8 Drawer_cont_ls(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                 u8 *ts,u8 *rs,u8 mode,u8 *ts_flag)
{
    *rb_Flag = 1;
    *ts_flag = 0;
    T2msFlg = 0;
    cf_jj2 = 0;
    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
    UART1_Send(R_ts,mode,rs[1]);
    while(*rb_Flag > 0)
    {
        WDT();//�忴�Ź�
        if(*ts_flag == 1)/*�ȴ���������*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*����*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                         return 0;
                        //UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x02)/*����*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        return 0;
                        //UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x03)/*����˿*/
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                       return 1;
                        //UART3_Send(ts,mode,no);
                    }
                }
                else
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(mirro == 0)
                    {
                        return 1;
                        //UART3_Send(ts,mode,no);
                    }
                }
            }
            else
            {
                WDT();//�忴�Ź�
                *ts_flag = 0;/*����������ɣ������ٴν���*/
                if(T2msFlg > cheak_wait_2)
                {
                    T2msFlg = 0;
                    if(*rb_Flag == 1)
                    {
                        *rb_Flag = 2;
                        UART1_Send(R_ts,mode,rs[1]);
                    }
                    else
                    {
                        *rb_Flag = 0;/*���Ͳ��ɹ����˳�*/
                        if(mirro == 0)
                        {
                             return 1;
                            //UART3_Send(ts,mode,no);
                        }
                    }
                }
            }
        }
        if(T2msFlg > cheak_wait_2)
        {
            T2msFlg = 0;
            if(*rb_Flag == 1)
            {
               // *rb_Flag = 2;
                if(cf_jj2 < 10) {
                    cf_jj2++;
                } else {
                    cf_jj2 = 0;
                    *rb_Flag = 2;
                }
                UART1_Send(R_ts,mode,rs[1]);
            }
            else
            {
                *rb_Flag = 0;/*���Ͳ��ɹ����˳�*/
                return 1;
                //UART3_Send(ts,mode,no);
            }
        }
        if(mode == Drawer_back)
        {
            //Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*���ص�*/
        }
    }
}

/********************
����赲ʹ�ã����������ж��赲���
*********************/
u8 cf_jj = 0;
u8 cheak_wait = 20;//�ط��ȴ�ʱ��
void rawer_back_judge(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                      u8 i,u8 *ts_flag,u8 *place_flag)
{
    *rb_Flag = 1;
    *ts_flag = 0;
    T2msFlg = 0;
    cf_jj = 0;
    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
    UART1_Send(R_ts,Drawer_back_place,i);
    while(*rb_Flag > 0)
    {
        WDT();//�忴�Ź�
        if(*ts_flag == 1)/*�ȴ���������*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*����*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    *place_flag = 0;
                }/*δ��λ*/
                else
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    *place_flag = 1;
                }
            }
            else
            {
                WDT();//�忴�Ź�
                *ts_flag = 0;/*����������ɣ������ٴν���*/
                if(T2msFlg > cheak_wait)//200
                {
                    T2msFlg = 0;
                    if(*rb_Flag == 1)
                    {
                        *rb_Flag = 2;
                        UART1_Send(R_ts,Drawer_back_place,i);
                    }
                    else/*���Ͳ��ɹ����˳�*/
                    {
                        *rb_Flag = 0;
                        *place_flag = 1;
                    }
                }
            }
        }
        if(T2msFlg > cheak_wait)//200
        {
            T2msFlg = 0;
            if(*rb_Flag == 1)
            {
                if(cf_jj < 5) {
                    cf_jj++;
                } else {
                    cf_jj = 0;
                    *rb_Flag = 2;
                }
                UART1_Send(R_ts,Drawer_back_place,i);
            }
            else
            {
                *rb_Flag = 0;/*���Ͳ��ɹ����˳�*/
                *place_flag = 1;
            }
        }
    }
}

