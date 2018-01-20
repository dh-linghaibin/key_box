/***********************************************************
* 工程: 基于STM8单片机的回单柜控制-从机
* 编译: STVD MainFrame Version 3.6.5.2 CXSTM8
* 创建: 2015-2-2 11:13:14
* 更新: NULL
* 版本: 1.0
***********************************************************/
/***********************************************************
* 文档: main.c
* 作者: Haibin Ling
* 描述: 1.
*       2.
*       3.
*       4.
*       5.
*       6.
*       7.
***********************************************************/
#include "type.h"
/**********************************************************/
/* 程序变量定义                                           */
/**********************************************************/
/*串口通信层函数*/
volatile u8 R_RsBuffer[R_MaxNumberofCom];//串口缓存区
volatile u8 R_TsBuffer[R_MaxNumberofCom];
volatile _Bool c_ok_Flag = 0;/*串口命令完成标志位*/
volatile u8 com_i = 0;/*保存接收数据*/
volatile u16 addre = 0x01;/*地址*/
volatile u8 com_Flag = 0;/*串口开始接受标志位*/
volatile u8 r_Flag = 0;/*机械手成功出来标志位*/
volatile u8 r_num = 0;/*保存机械手状态*/
volatile u16 T1msFlg = 0;/*定时器累加计数*/
volatile u16 T2msFlg = 0;/*定时器累加计数*/
volatile u8 run_Falg = 0;/*运行状态标志*/
volatile u16 Duty_Val = 0;/*呼吸灯呼吸值*/
volatile u8 TS_count = 0;/**/
#define rs485_dr1 OPD7
#define back_seat IPC6/*回来限位*/
#define out_seat	IPC5/*出去限位*/
		
/**********************************************************/
/* MAIN主程序                                             */
/**********************************************************/
main()
{
	BSP_Init();/*板层初始化*/
	Eeprom_Init();/*解锁EEPROM*/
	UART1_Init();/*初始化USART1*/
	Addr_Read(&addre);/*读取地址*/
	_asm("rim");//开中断，sim为关中断
	//robot_mode(0);
	while (1)
	{
		
		/*呼吸灯服务用，从51-101行*/
		if(run_Falg == 0)
		{
			if(Duty_Val < 499)
			{
				if(T1msFlg >= 2)
				{
					T1msFlg = 0;
					Duty_Val++;
					//TIM2_CCR3H = Duty_Val>>8;
					//TIM2_CCR3L = Duty_Val;
				}
			}
			else
			{
				run_Falg = 1;
				T1msFlg = 0;
			}
		}
		else if(run_Falg == 1)
		{
			if(T1msFlg >= 100)
			{
				run_Falg = 2;
			}
		}
		else if(run_Falg == 2)
		{
			if(Duty_Val > 0)
			{
				if(T1msFlg >= 2)
				{
					T1msFlg = 0;
					Duty_Val--;
					//TIM2_CCR3H = Duty_Val>>8;
					//TIM2_CCR3L = Duty_Val;
				}
			}
			else
			{
				run_Falg = 3;
				T1msFlg = 0;
			}
		}
		else if(run_Falg == 3)
		{
			if(T1msFlg >= 400)
			{
				run_Falg = 0;
			}
		}
		/*串口服务*/
		if(c_ok_Flag == 1)
		{
			r_Flag = 0;
			if(R_RsBuffer[6] == c_last)
			{
				//UART1_Send(R_TsBuffer,TRUE,addre);
				//delayms(10);
				R_TsBuffer[1] = 0x00;
				R_TsBuffer[2] = 0x00;
				R_TsBuffer[3] = 0x00;
				R_TsBuffer[4] = 0x00;
				R_TsBuffer[5] = 0x00;
				switch(R_RsBuffer[0])
				{
					case Drawer_out:/*机械手出去*/
						r_num = robot_mode(1);
						if(r_num == 0)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
							r_Flag = 1;/*机械手成功出去，这样可以手推回来*/
							TS_count = 0;
							delayms(20);
						}
						else if(r_num == 1)
						{
							UART1_Send(R_TsBuffer,0x02,addre);
							robot_mode(0);
						}
						else if(r_num == 2)
						{
							UART1_Send(R_TsBuffer,0x03,addre);
							//robot_mode(0);
						}
						eeprom_count(2);
					break;
					case Drawer_out_place:/*机械手出去是否到位*/
						if(out_seat == 1)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
						}
						else 
						{
							UART1_Send(R_TsBuffer,0x02,addre);
						}
					break;
					case Drawer_back:/*机械手回来*/
						r_Flag = 0;
						r_num = robot_mode(0);
						if(r_num==0)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
							r_Flag = 0;
						}
						else if(r_num==1)
						{
							UART1_Send(R_TsBuffer,0x02,addre);
							robot_mode(1);
						}
						else if(r_num == 2)
						{
							UART1_Send(R_TsBuffer,0x03,addre);
							//robot_mode(1);
						}
						eeprom_count(2);
					break;
					case Drawer_back_place:/*机械手回来是否到位*/
						if(back_seat == 1)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
						}
						else
						{
							UART1_Send(R_TsBuffer,0x02,addre);
						}
					break;
					case Check_num://查询机械手使用次数
						R_TsBuffer[2] = Eeprom_Read(2);
						R_TsBuffer[3] = Eeprom_Read(3);
						R_TsBuffer[4] = Eeprom_Read(4);
						R_TsBuffer[5] = Eeprom_Read(5);
						R_TsBuffer[6] = Eeprom_Read(6);
						UART1_Send(R_TsBuffer,0x01,addre);
					break;
					case Check_num_zero:
						Eeprom_Write(2,0);
						Eeprom_Write(3,0);
						Eeprom_Write(4,0);
						Eeprom_Write(5,0);
						Eeprom_Write(6,0);
					break;
					case OPEN_LOGIHT:
						if(R_RsBuffer[1] == 0) {
							SetLed(0);
						} else {
							SetLed(1);
						}
						break;
					default:
					UART1_Send(R_TsBuffer,ERROR,addre);
					break;
				}
			}
			else
			{
				UART1_Send(R_TsBuffer,ERROR,addre);
			}
			c_ok_Flag = 0;
		}
		WDT();//清看门狗
	}
}
/***************************************
说明: TIM中断函数，1ms
***************************************/
@far @interrupt void TIM1_UPD_OVF_IRQHandler (void)
{
	TIM1_SR1 &= (~0x01);        //清除中断标志
	T1msFlg++;
	T2msFlg++;
	return;
}
/***************************************
说明: 串口1中断接收函数
***************************************/
@far @interrupt void UART1_Recv_IRQHandler (void)
{
	unsigned char ch;
	ch=UART1_DR;
	//TIM2_CCR3H = ch;
	if(c_ok_Flag == 0)
	{
		if(com_Flag == 0)
		{
			if(ch == c_head)
			{
				com_Flag = 1;
				com_i = 0;
			}
		}
		else if(com_Flag == 1)
		{
			if(addre == ch)
			{
				com_Flag = 2;
			}
			else
			{
				com_Flag = 0;
			}
		}
		else if(com_Flag == 2)//2
		{
			R_RsBuffer[com_i] = ch;
			if(com_i == 6)
			{
				com_i = 0;
				com_Flag = 0;
				c_ok_Flag = 1;
			}
			else
			{
				com_i++;
			}
		}
	}
	return;
}

/***************************************
说明: 串口1发送中断函数
***************************************/
u8 fs_i = 0;
u8 fs_ok = 0;
@far @interrupt void UART1_Txcv_IRQHandler (void)
{
	_asm("sim");//开中断，sim为关中断
	//u8 i;
	UART1_SR &= ~(1<<6);    //清除送完成状态位
	UART1_DR = R_TsBuffer[fs_i];
	if(fs_i < 8)fs_i++;
	else 
	{
		fs_i = 0;
		rs485_dr1 = 0;
		UART1_CR2 &= ~(1<<6);//关闭发送完成中断
		fs_ok = 0;
	}
	//for(i = 0;i < 5;i++)
	//{
		//	UART1_Sendint(R_TsBuffer[i]);
	//}
	_asm("rim");//开中断，sim为关中断
	return;
}