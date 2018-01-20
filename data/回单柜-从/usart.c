/***********************************************************
* �ĵ�: uart.c
* ����: Haibin Ling
* ����: 1.����1��ʼ��������1���ͺ���
*       2.����3��ʼ��������3���ͺ���
***********************************************************/
#include "main.h"

#define rs485_dr1 OPD7
/*****************************
������: UART1_Init()
����ֵ����
��  ��:	��ʼ������1 ����������Ϊ9600  ���ж�
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
/***485���������ơ���PD7****/
	PD_DDR |= BIT(7);
	PD_CR1 |= BIT(7);
	PD_CR2 |= BIT(7);
	rs485_dr1 = 0;
	UART1_CR1=0x00;
	UART1_CR2=0x00;
	UART1_CR3=0x00; 
	UART1_BRR2=0x02;
	UART1_BRR1=0x68;
	UART1_CR2=0x2c;//������գ����ͣ��������ж�
}
/*****************************
������: UART1_Sendint(unsigned char ch)
����ֵ����
����ֵ����Ҫ���͵��ֽ�
��  ��:	�����ֽڵĴ���1
*****************************/
void UART1_Sendint(u8 ch)
{
  while((UART1_SR & 0x80) == 0x00);    // �ȴ����ݵĴ���  
  UART1_DR = ch;                     
}
/*****************************
������: UART1_Sendint(unsigned char ch)
����ֵ����
����ֵ����Ҫ���͵��ֽ�
��  ��:	�����ֽڵĴ���1
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



