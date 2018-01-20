/***********************************************************
* 文档: uart.c
* 作者: Haibin Ling
* 描述: 1.串口1初始化，串口1发送函数
*       2.串口3初始化，串口3发送函数
***********************************************************/
#include "type.h"

#define rs485_dr1 PA_ODR_ODR6
#define rs485_dr2 PD_ODR_ODR7
/*****************************
函数名: UART1_Init()
返回值：无
功  能:	初始化串口1 波特率设置为9600  开中断
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
    /***485方向流控制_PA6****/
    PA_DDR |= BIT(6);
    PA_CR1 |= BIT(6); 
    PA_CR2 |= BIT(6);
    rs485_dr1 = 0;
    UART1_CR1=0x00;
    UART1_CR2=0x00;
    UART1_CR3=0x00; 
    UART1_BRR2=0x02;
    UART1_BRR1=0x68;
    UART1_CR2=0x2c;//允许接收，发送，开接收中断
    UART1_CR2 &= ~BIT(2);/*关闭接收中断*/
}
/*****************************
函数名: UART1_Sendint(unsigned char ch)
返回值：无
输入值：需要发送的字节
功  能:	发送字节的串口1
*****************************/
void UART1_Sendint(unsigned char ch)
{
    while((UART1_SR & 0x80) == 0x00);    // 等待数据的传送  
    UART1_DR = ch;                    
}
/*****************************
函数名: UART1_Send
返回值：无
输入值：接收数组  命令 成功与否
功  能:	发送字节的串口1
*****************************/
extern u8 ts1_ok;
void UART1_Send(u8 *Array,u8 command,u8 situ)
{
    volatile u8 i;
    //while( (UART1_SR&(1<<6)) )/*等待发送完毕*/
    while(ts1_ok == 1);
    UART1_SR&= ~BIT(6);  //清除送完成状态位
    UART1_CR2 |= BIT(6);//开发送完成中
    Array[0] = situ;
    Array[1] = command;
    Array[7] = c_last;
    rs485_dr1 = 1;
    ts1_ok = 1;
    UART1_DR = c_head;
}
/*****************************
函数名: UART3_Init()
返回值：无
功  能:	初始化串口3 波特率设置为9600  开中断
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
    /***485方向流控制_PD7****/
    PD_DDR |= BIT(7);
    PD_CR1 |= BIT(7); 
    PD_CR2 |= BIT(7);
    rs485_dr2 = 0;
    UART3_CR1=0x00;
    UART3_CR2=0x00;
    UART3_CR3=0x00; 
    UART3_BRR2=0x02;
    UART3_BRR1=0x68;
    UART3_CR2=0x2c;//允许接收，发送，开接收中断
}
/*****************************
函数名: UART3_Sendint(unsigned char ch)
返回值：无
输入值：需要发送的字节
功  能:	发送字节的串3
*****************************/
void UART3_Sendint(unsigned char ch)
{
    while((UART3_SR & 0x80) == 0x00);    // 等待数据的传送  
    UART3_DR = ch;   
    delayus(100);	
}
/*****************************
函数名: void UART_interrupt(u8 uart,u8 mode)
返回值：无
输入值：0-串口1 1-串口3  0-关接中断 1-开接收中断
功  能:	开关中断 
*****************************/
void UART_interrupt(u8 uart,u8 mode)
{
    if(uart == 0)
    {
        if(mode == 0)
        {
            UART1_CR2 &= ~BIT(2);/*关闭接收中断*/
        }
        else if(mode == 1)
        {
            UART1_CR2 |= BIT(2);/*使能接收中断*/
        }
    }
    else if(uart == 1)
    {
        if(mode == 0)
        {
            UART3_CR2 &= ~BIT(2);/*关闭接收中断*/
        }
        else if(mode == 1)
        {
            UART3_CR2 |= BIT(2);/*使能接收中断*/
        }
    }
}
/*****************************
函数名: UART3_Send
返回值：无
输入值：接收数组  命令 成功与否
功  能:	发送字节的串3
*****************************/
extern u8 ts3_ok;
void UART3_Send(u8 *Array,u8 command,u8 situ)
{
    volatile u8 i;
    //while( (UART3_SR&(1<<6)) )/*等待发送完毕*/
    while(ts3_ok == 1);
    UART3_SR&= ~BIT(6);  //清除送完成状态位
    UART3_CR2 |= BIT(6);//开发送完成中?
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
        /*累加校验*/
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
函数名: UART1_Init()
返回值：无
功  能:	初始化串口1 波特率设置为9600  开中断
*****************************/
extern u16 T2msFlg;
extern u8 wr_new;/*保存回单情况*/
extern u8 fr_Flag;/*回单检测标志位*/
extern u8 RsBuffer[MaxNumberofCom];//串口缓存区
extern u8 mirro;/*自动回来标志*/
u16 cheak_wait_2 = 1500;//重发等待时间
u8 cf_jj2 = 0;
/*运行标志   从发送缓存 从接收缓存  主发送缓存 主接收缓存 模式 从机接收完成标志*/
void Drawer_cont(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                 u8 *ts,u8 *rs,u8 mode,u8 *ts_flag)
{
    *rb_Flag = 1;
    *ts_flag = 0;
    T2msFlg = 0;
    cf_jj2 = 0;
    UART_interrupt(0,1);/*使能串口1接收中断*/
    UART1_Send(R_ts,mode,rs[1]);
    while(*rb_Flag > 0)
    {
        WDT();//清看门狗
        if(*ts_flag == 1)/*等待返回命令*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*正常*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x02)/*过流*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x03)/*保险丝*/
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,no);
                    }
                }
                else
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        UART3_Send(ts,mode,no);
                    }
                }
            }
            else
            {
                WDT();//清看门狗
                *ts_flag = 0;/*接收命令完成，可以再次接收*/
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
                        *rb_Flag = 0;/*发送不成功，退出*/
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
                *rb_Flag = 0;/*发送不成功，退出*/
                UART3_Send(ts,mode,no);
            }
        }
        if(mode == Drawer_back)
        {
            Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*检测回单*/
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
    UART_interrupt(0,1);/*使能串口1接收中断*/
    UART1_Send(R_ts,mode,rs[1]);
    while(*rb_Flag > 0)
    {
        WDT();//清看门狗
        if(*ts_flag == 1)/*等待返回命令*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*正常*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                         return 0;
                        //UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x02)/*过流*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        return 0;
                        //UART3_Send(ts,mode,ok);
                    }
                }
                else if(R_rs[1] == 0x03)/*保险丝*/
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
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
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    if(mirro == 0)
                    {
                        return 1;
                        //UART3_Send(ts,mode,no);
                    }
                }
            }
            else
            {
                WDT();//清看门狗
                *ts_flag = 0;/*接收命令完成，可以再次接收*/
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
                        *rb_Flag = 0;/*发送不成功，退出*/
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
                *rb_Flag = 0;/*发送不成功，退出*/
                return 1;
                //UART3_Send(ts,mode,no);
            }
        }
        if(mode == Drawer_back)
        {
            //Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*检测回单*/
        }
    }
}

/********************
检测阻挡使用，发送命令判断阻挡情况
*********************/
u8 cf_jj = 0;
u8 cheak_wait = 20;//重发等待时间
void rawer_back_judge(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                      u8 i,u8 *ts_flag,u8 *place_flag)
{
    *rb_Flag = 1;
    *ts_flag = 0;
    T2msFlg = 0;
    cf_jj = 0;
    UART_interrupt(0,1);/*使能串口1接收中断*/
    UART1_Send(R_ts,Drawer_back_place,i);
    while(*rb_Flag > 0)
    {
        WDT();//清看门狗
        if(*ts_flag == 1)/*等待返回命令*/
        {
            if(R_rs[7] == 0x0a)
            {
                if(R_rs[1] == 0x01)/*正常*/
                {
                    R_rs[1] = 0x00;
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    *place_flag = 0;
                }/*未到位*/
                else
                {
                    *rb_Flag = 0;
                    *ts_flag = 0;
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
                    *place_flag = 1;
                }
            }
            else
            {
                WDT();//清看门狗
                *ts_flag = 0;/*接收命令完成，可以再次接收*/
                if(T2msFlg > cheak_wait)//200
                {
                    T2msFlg = 0;
                    if(*rb_Flag == 1)
                    {
                        *rb_Flag = 2;
                        UART1_Send(R_ts,Drawer_back_place,i);
                    }
                    else/*发送不成功，退出*/
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
                *rb_Flag = 0;/*发送不成功，退出*/
                *place_flag = 1;
            }
        }
    }
}

