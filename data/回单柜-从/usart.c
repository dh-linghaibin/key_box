/***********************************************************
* 文档: uart.c
* 作者: Haibin Ling
* 描述: 1.串口1初始化，串口1发送函数
*       2.串口3初始化，串口3发送函数
***********************************************************/
#include "main.h"

#define rs485_dr1 OPD7
/*****************************
函数名: UART1_Init()
返回值：无
功  能:	初始化串口1 波特率设置为9600  开中断
*****************************/
void UART1_Init(void)
{
  /***485_PD6****/
	PD_DDR |= BIT(5);
	PD_CR1 |= BIT(5); 
	PD_CR2 |= BIT(5);
	/***485_PD5****/
	PD_DDR &= ~BIT(6);
	PD_CR1 |= BIT(6); 
	PD_CR2 &= ~BIT(6);
/***485方向流控制——PD7****/
	PD_DDR |= BIT(7);
	PD_CR1 |= BIT(7);
	PD_CR2 |= BIT(7);
	rs485_dr1 = 0;
	UART1_CR1=0x00;
	UART1_CR2=0x00;
	UART1_CR3=0x00; 
	UART1_BRR2=0x02;
	UART1_BRR1=0x68;
	UART1_CR2=0x2c;//允许接收，发送，开接收中断
}
/*****************************
函数名: UART1_Sendint(unsigned char ch)
返回值：无
输入值：需要发送的字节
功  能:	发送字节的串口1
*****************************/
void UART1_Sendint(u8 ch)
{
  while((UART1_SR & 0x80) == 0x00);    // 等待数据的传送  
  UART1_DR = ch;                     
}
/*****************************
函数名: UART1_Sendint(unsigned char ch)
返回值：无
输入值：需要发送的字节
功  能:	发送字节的串口1
*****************************/
extern u8 fs_ok;
void UART1_Send(u8 *Array,u8 command,u8 situ)
{
	volatile u8 i;
	//while( (UART1_SR&(1<<6)) )
	while(fs_ok == 1);
	UART1_SR&= ~BIT(6);  
	UART1_CR2 |= BIT(6);
	Array[0] = situ;
	Array[1] = command;
	Array[7] = c_last;
	rs485_dr1 = 1;
	fs_ok = 1;
	UART1_DR = c_head;
}



