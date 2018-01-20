/***********************************************************
* 工程: 基于STM8单片机的回单柜控制-主
* 编译: STVD MainFrame Version 3.6.5.2 CXSTM8
* 创建: 2015-1-30 09:57:14
* 更新: NULL
* 版本: 1.0
***********************************************************/
/***********************************************************
* 文档: main.c
* 作者: Haibin Ling
* 描述: 1串口接收检测
*       2.
*       3.
*       4.
*       5.
*       6.
*       7.
***********************************************************/
#include "type.h"
#include <string.h>
/**********************************************************/
/* 程序变量定义                                           */
/**********************************************************/
extern const u8 jm_a[1024];/*开机画面*/
/*串口通信层函数*/
volatile u8 RsBuffer[MaxNumberofCom];//串口缓存区
volatile u8 TsBuffer[MaxNumberofCom];
volatile u8 R_RsBuffer[R_MaxNumberofCom];//从机串口缓存区
volatile u8 R_TsBuffer[R_MaxNumberofCom];
volatile _Bool c_ok_Flag = 0;/*串口命令完成标志位3*/
volatile _Bool but_Flag = 0;/*按钮是否按下标志位*/
volatile u8 rebot_dr = 0;/*机械手出来或进去1 出来*/
volatile u8 com_i = 0;/*保存接收数据3*/
volatile u8 addre = 0x01;/*地址*/
volatile u8 com_Flag = 0;/*串口3开始接受标志位*/
volatile u8 Rc_ok_Flag = 0;/*串口命令完成标志位1*/
volatile u8 Rcom_i = 0;/*保存接收数据1*/
volatile u8 Rcom_Flag = 0;/*串口1开始接受标志位*/
volatile u8 SDr_Num_Save;/*保存选在柜子位置*/
volatile u8 rb_Flag = 0;/*机械手运行状态标志位*/
volatile u8 wr_new = 0;/*保存回单情况*/
volatile u8 Dr_Num_Save = 0;/*保存旋转位置*/
volatile u8 fr_Flag = 0;/*回单检测标志位*/
volatile u8 bu_Flag = 0;/*按钮使能标志位*/
volatile u8 mirro = 0;/*自动回来标志*/
volatile u8 Encoder = 0;/*保存是否使用编码器*/
volatile u8 place_sava = 0;/*保存机械手位置情况*/
volatile u16 Shield = 0;/*保存屏蔽情况*/
volatile u8 S_buf[10] = {1,1,1,1,1,1,1,1,1,1};/*保存屏蔽情况*/
volatile _Bool Encoder_bz = 0;/*编码器标志位*/
volatile _Bool dis_play = 0;/*显示*/
extern volatile u8 hd_num;/*回单*/
volatile u16 Encoder_count = 0;/*编码器计数*/
volatile _Bool jxs_out = 0;//机械手状态标志
													//0：回来
													//1：出去
extern u8 cheak_wait;//重发等待时间

volatile u16 cheak_wait_count = 0;//重发等待时间

/*时间标志位*/
volatile u16 T1msFlg;
volatile u16 T2msFlg;

/*测试定义区*/
#define rs485_dr2 OPD7
#define rs485_dr1 OPA6

#define but_led OPD3/*led指示灯*/
#define but_sw IPD4/*进仓按钮*/

#define bu_Encoder IPC4 /*编码器输入口*/

#define ts_up IPE0
#define ts_next IPE1
#define ts_ok IPE2
#define ts_page IPD0

page_num page_n;/*菜单结构体*/

/**********************************************************/
/* MAIN主程序                                             */
/**********************************************************/
main()
{
	BSP_Init();
	UART1_Init();
	UART3_Init();
	Eeprom_Init();/*eeprom解锁*/
	LCD12864_Init();//12864初始化
	Draw_PM(jm_a);
	delayms(1000);
	LCD_Clear_BMP();
	Addr_Read(&addre);
	/*读取保存的旋转位置*/
	Dr_Num_Save += Eeprom_Read(10)*10;
	Dr_Num_Save += Eeprom_Read(11);
	
	Encoder = Eeprom_Read(5);
	
	page_n.dr_num = 1;
	page_n.rb_num = 1;
	Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
	while (1)
	{
		WDT();//清看门狗
		/*翻页*/
		if(ts_page == 0)
		{
			if(page_n.ts_page_cnt < 5000)
			{
				page_n.ts_page_cnt++;
			}
		}
		else
		{
			if(page_n.ts_page_cnt > 4000)
			{
				if(page_n.page < 4)
				{
					page_n.page++;
					if(page_n.page == 1)
					{
						page_n.row = 0;
					}
				}
				else
				{
					page_n.page = 0;
				}
				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
			}
			page_n.ts_page_cnt = 0;
		}
		/*加按键*/
		if(ts_up == 0)
		{
			if(page_n.ts_up_cnt < 5000)
			{
				page_n.ts_up_cnt++;
			}
		}
		else
		{
			if(page_n.ts_up_cnt > 4000)
			{
				if(page_n.ins_row == 0)
				{
					if(page_n.page == 1)
					{
						page_n.row = 1;
					}
					else if(page_n.page < 4)
					{
						if(page_n.row < 3)
						{
							page_n.row++;
						}
					}
					else if(page_n.page == 5)
					{
						if(page_n.row < 3)
						{
							page_n.row++;
						}
					}
				}
				else
				{
					if(page_n.ins_row == 1)
					{
						if(page_n.dr_num < 72)
						{
							page_n.dr_num ++;
						}
					}
					else if(page_n.ins_row == 2)
					{
						if(page_n.rb_num < 10)
						{
							page_n.rb_num ++;
						}
					}
					else if(page_n.ins_row == 3)
					{
						if(page_n.rb_num < 10)
						{
							page_n.rb_num ++;
						}
					}
				}
				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
			}
			page_n.ts_up_cnt = 0;
		}
		/*减按键*/
		if(ts_next == 0)
		{
			if(page_n.ts_next_cnt < 5000)
			{
				page_n.ts_next_cnt++;
			}
		}
		else
		{
			if(page_n.ts_next_cnt > 4000)
			{
				if(page_n.ins_row == 0)
				{
					if(page_n.page == 1)
					{
						page_n.row = 0;
					}
					else if(page_n.page < 4)
					{
						if(page_n.row > 0)
						{
							page_n.row--;
						}
					}
					else if(page_n.page == 5)
					{
						if(page_n.row > 0)
						{
							page_n.row--;
						}
					}
				}
				else
				{
					if(page_n.ins_row == 1)
					{
						if(page_n.dr_num > 1)
						{
							page_n.dr_num --;
						}
					}
					else if(page_n.ins_row == 2)
					{
						if(page_n.rb_num > 1)
						{
							page_n.rb_num --;
						}
					}
					else if(page_n.ins_row == 3)
					{
						if(page_n.rb_num > 1)
						{
							page_n.rb_num --;
						}
					}
				}
				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
			}
			page_n.ts_next_cnt = 0;
		}
		/*OK按键*/
		if(ts_ok == 0)
		{
			if(page_n.ts_ok_cnt < 65000)
			{
				page_n.ts_ok_cnt++;
			}
		}
		else
		{
			if(page_n.ts_ok_cnt > 64000)
			{
				if(page_n.page == 1)
				{
					if(page_n.row == 0)
					{
						eeprom_cle(r_sive_n);
					}
					else if(page_n.row == 1)
					{
						eeprom_cle(r_sive_n+5);
					}
				}
				else if(page_n.page == 2)
				{
					if(page_n.row == 0)
					{
						eeprom_cle(r_sive_n+10);
					}
					else if(page_n.row == 1)
					{
						eeprom_cle(r_sive_n+15);
					}
					else if(page_n.row == 2)
					{
						eeprom_cle(r_sive_n+20);
					}
					else if(page_n.row == 3)
					{
						eeprom_cle(r_sive_n+25);
					}
				}
				else if(page_n.page == 3)
				{
					if(page_n.row == 0)
					{
						eeprom_cle(r_sive_n+30);
					}
					else if(page_n.row == 1)
					{
						eeprom_cle(r_sive_n+35);
					}
					else if(page_n.row == 2)
					{
						eeprom_cle(r_sive_n+40);
					}
					else if(page_n.row == 3)
					{
						eeprom_cle(r_sive_n+45);
					}
				}
				else if(page_n.page == 4)
				{
					page_n.page = 5;
				}
				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
			}
			else if(page_n.ts_ok_cnt > 4000)
			{
				if(page_n.page == 5)/*内部控制*/
				{
					if(page_n.ins_row == 0)
					{
						if(page_n.row == 0)
						{
							page_n.ins_row = 1;
						}
						else if(page_n.row == 1)
						{
							page_n.ins_row = 2;
						}
						else if(page_n.row == 2)
						{
							page_n.ins_row = 3;
						}
						else if(page_n.row == 3)
						{
							page_n.ins_row = 4;
						}
					}
					else
					{
						if(page_n.ins_row == 1)/*旋转*/
						{
							_Servo_C(page_n.dr_num,&Dr_Num_Save);/*旋转*/
						}
						else if(page_n.ins_row == 2)/*机械手出去*/
						{
							UART1_Send(R_TsBuffer,Drawer_out,page_n.rb_num);
						}
						else if(page_n.ins_row == 3)/*机械手回来*/
						{
							UART1_Send(R_TsBuffer,Drawer_back,page_n.rb_num);
						}
						else if(page_n.ins_row == 4)/*回零*/
						{
							Back_Zero(&Dr_Num_Save);
						}
						page_n.ins_row = 0;
					}
				}
				if(page_n.page == 4)/*设置*/
				{
					if(Encoder == 0)/*开关编码器*/
					{
						Encoder = 1;
						Eeprom_Write(5,Encoder);
					}
					else 
					{
						Encoder = 0;
						Eeprom_Write(5,Encoder);
					}
				}
				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
			}
			page_n.ts_ok_cnt = 0;
		}
		
		if(page_n.page == 5)
		{
			if(T2msFlg >= 400)
			{
				T2msFlg = 0;
				if(dis_play == 0)
				{
					dis_play = 1;
					if(page_n.ins_row == 1)
					{
						Display_LCD_String_XY(0,6,":",1);
						Write_LCD_Data(0x30+page_n.dr_num/10);
						Write_LCD_Data(0x30+page_n.dr_num%10);
					}
					else if(page_n.ins_row == 2)
					{
						Display_LCD_String_XY(1,6,":",1);
						Write_LCD_Data(0x30+page_n.rb_num/10);
						Write_LCD_Data(0x30+page_n.rb_num%10);
					}
					else if(page_n.ins_row == 3)
					{
						Display_LCD_String_XY(2,6,":",1);
						Write_LCD_Data(0x30+page_n.rb_num/10);
						Write_LCD_Data(0x30+page_n.rb_num%10);
					}
				}
				else
				{
					dis_play = 0;
					if(page_n.ins_row == 1)
					{
						Display_LCD_String_XY(0,6,":  ",1);
					}
					else if(page_n.ins_row == 2)
					{
						Display_LCD_String_XY(1,6,":  ",1);
					}
					else if(page_n.ins_row == 3)
					{
						Display_LCD_String_XY(2,6,":  ",1);
					}
				}
			}
		}
		//检测按钮是否按下
		if(jxs_out == 1)
		{
			if(bu_Flag == 1)
			{
				if(but_sw == 0)//按钮被按下
				{
					but_Flag = 1;//按钮按下
				}
			}
		}
		/*串口接收到命令*/
		if(c_ok_Flag == 1)
		{
			UART_interrupt(1,0);/*关闭串口1中断*/
			if(Com_Check(RsBuffer,addre))/*校验判断*/
			{
				/*发送校验成功*/
				UART3_Send(TsBuffer,CORRECT,ok);
				//delayms(10);//修改调试清晰点
				WDT();//清看门狗
				/*开始执行命令*/
				switch(RsBuffer[0])/*判断命令*/
				{
					u8 abs_num = 0;
					u8 i_count = 0;/*查询用*/
					u8 place_sta = 0;/*位置统计保存*/
					/*检测阻挡*/
					case Detection_barrier:
						Menu_Host(Detection_barrier,addre,RsBuffer,
												Dr_Num_Save,&page_n);/*显示*/
						Shield_sava(RsBuffer);
						if(Bar_Read(TsBuffer))/*检测阻挡*/
						{
							/*无阻挡*/
							UART3_Send(TsBuffer,Detection_barrier,ok);
							Menu_Host(Detection_barrier,0,
														RsBuffer,0,&page_n);/*显示*/
						}
						else
						{
							/*有阻挡，并返回阻挡值*/
							UART3_Send(TsBuffer,Detection_barrier,no);
							Menu_Host(Detection_barrier,hd_num,
														RsBuffer,1,&page_n);/*显示*/
						}
						break;
					/*检测机械手是否回来*/
					case rawer_back_sta:
						Shield_sava(RsBuffer);
						cheak_wait = 40;//快速检测
						place_sta = 0;
						for(i_count = 1;i_count < 11;i_count++)
						{
							rawer_back_judge(&rb_Flag,R_TsBuffer,R_RsBuffer,
														i_count,&Rc_ok_Flag,&place_sava);
							if(S_buf[i_count-1] == 1)
							{
								place_sta += place_sava;
								TsBuffer[i_count] = place_sava;
							}
							else
							{
								TsBuffer[i_count] = 0;
							}
						}
						if(place_sta == 0)
						{
							UART3_Send(TsBuffer,rawer_back_sta,ok);
						}
						else
						{
							UART3_Send(TsBuffer,rawer_back_sta,no);
						}
						break;
					/*检测重启*/
					case Reboot:
						/*返回正常，无重启*/
						UART3_Send(TsBuffer,Reboot,ok);
						break;
					/*回零*/
					case Back_zero:
						Menu_Host(Back_zero,addre,RsBuffer,
											Dr_Num_Save,&page_n);/*显示*/
						WDT();//清看门狗
						if(Bar_Read(TsBuffer))/*检测阻挡*/
						{
							place_sta = 0;
							/*
							for(i_count = 1;i_count < 11;i_count++)
							{
								rawer_back_judge(&rb_Flag,R_TsBuffer,R_RsBuffer,
															i_count,&Rc_ok_Flag,&place_sava);
								if(S_buf[i_count-1] == 1)
								{
									place_sta += place_sava;
								}
							}*/
							//if(place_sta == 0)
						//	{
								//检测是否成功回零
								if(Back_Zero(&Dr_Num_Save) == CORRECT)
								{
									UART3_Send(TsBuffer,Back_zero,ok);
								}
								else
								{
									//回零失败
									UART3_Send(TsBuffer,Back_zero,no);
								}
						//	}
						//	else
						//	{
							//	UART3_Send(TsBuffer,Back_zero,no);
							//}
						}
						else
						{
							UART3_Send(TsBuffer,Back_zero,no);
						}
						break;
					/*旋转位置*/
					case Motor_rotation:
						Menu_Host(Motor_rotation,addre,RsBuffer,
												Dr_Num_Save,&page_n);/*显示*/
						WDT();//清看门狗
						if(Bar_Read(TsBuffer))/*检测阻挡*/
						{
							place_sta = 0;
							/*
							for(i_count = 1;i_count < 11;i_count++)
							{
								rawer_back_judge(&rb_Flag,R_TsBuffer,R_RsBuffer,
															i_count,&Rc_ok_Flag,&place_sava);
								if(S_buf[i_count-1] == 1)
								{
									place_sta += place_sava;
								}
							}*/
							if(place_sta == 0)
							{
								abs_num = _Servo_C(RsBuffer[1],&Dr_Num_Save);/*旋转*/
								
								if(Encoder == 0)/*开启编码器*/	
								{
									if(abs_num > 0)
									{
										if ( abs(abs(Encoder_count/abs_num)-Encoder_hz) > 30  )
										{
											UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
											Menu_Host(3,addre,RsBuffer,
															156,&page_n);/*显示*/
										}
										else
										{
											UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
										}
									}
									else
									{
										UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
									}
								}
								else
								{
									UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
								}
							}
							else
							{
								UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
							}
						}
						else
						{
							UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
						}
						break;
					/*判断有误回单*/
					case Whether_receipt:
						if(hd_num >= 4)
						{
							/*没有回单*/
							UART3_Send(TsBuffer,Whether_receipt,no);
							Menu_Host(Whether_receipt,hd_num,
														RsBuffer,1,&page_n);/*显示*/
						}
						else
						{
							/*有回单*/
							UART3_Send(TsBuffer,Whether_receipt,ok);
							Menu_Host(Whether_receipt,hd_num,
														RsBuffer,0,&page_n);/*显示*/
						}
						break;
					/*按钮使能*/
					case Button_enabled:
						bu_Flag = 1;/*使能按钮*/
						UART3_Send(TsBuffer,Button_enabled,ok);
						break;
					/*按钮不使能*/
					case Button_not_enabled:
						bu_Flag = 0;/*不使能按钮*/
						UART3_Send(TsBuffer,Button_not_enabled,ok);
						break;
					/*按钮是否按下*/
					case Button_detection:
						if(but_Flag == 0)
						{
							/*按钮未按下*/
							UART3_Send(TsBuffer,Button_detection,no);
						}
						else
						{
							/*按钮按下*/
							UART3_Send(TsBuffer,Button_detection,ok);
						}
						break;
					/*机械手出去*/
					case Drawer_out:
						cheak_wait = 200;//快速检测
						Menu_Host(Drawer_out,addre,RsBuffer,
												Dr_Num_Save,&page_n);/*显示*/
						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
															RsBuffer,Drawer_out,&Rc_ok_Flag);
						rebot_dr = RsBuffer[1];
						eeprom_count(r_sive_n+((rebot_dr-1)*5));
						if(bu_Flag == 1)
						{
							but_led = 0;/*打开LED*/
						}
						jxs_out = 1;//机械手出去
						break;
					/*机械手回来*/
					case Drawer_back:
Drawer_back_1:
						cheak_wait = 200;//快速检测
						Menu_Host(Drawer_back,addre,RsBuffer,
												Dr_Num_Save,&page_n);/*显示*/
						R_TsBuffer[1] = rebot_dr;
						rb_Flag = 1;/*初始化状态标志位*/
						if(RsBuffer[2] == 0)//第一次拉回的时候才清楚回单值 避免失去回单 2015/7/32改  凌海滨
						{
							hd_num = 0;/*清除回单状态*/
							fr_Flag = 0;/*初始化回单标志位*/
						}
						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
												 RsBuffer,Drawer_back,&Rc_ok_Flag);									
						mirro = 0;
						rebot_dr = 0;
						but_led = 1;/*关闭led*/
						jxs_out = 0;//机械手回来
						but_Flag = 0;//清楚按钮按下
						break;
					/*机械手出去是否到位*/
					case Drawer_out_place:
						cheak_wait = 40;//快速检测
						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
												RsBuffer,Drawer_out_place,&Rc_ok_Flag);
						break;
					/*机械手回来是否到位*/
					case Drawer_back_place:
						cheak_wait = 40;//快速检测
						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
													RsBuffer,Drawer_back_place,&Rc_ok_Flag);
						break;
					/*询问机械手使用次数*/
					case ask_count:
						UART1_Send(R_TsBuffer,Check_num,RsBuffer[1]);
						UART_interrupt(0,1);/*使能串口1接收中断*/
						cheak_wait_count = 0;
						while((cheak_wait_count < 26000))
						{
							if(Rc_ok_Flag == 1)
							{
								TsBuffer[1] = R_RsBuffer[2];
								TsBuffer[2] = R_RsBuffer[3];
								TsBuffer[3] = R_RsBuffer[4];
								TsBuffer[4] = R_RsBuffer[5];
								TsBuffer[5] = R_RsBuffer[6];
								Rc_ok_Flag = 0;
								cheak_wait_count = 65534;
							}
							cheak_wait_count++;
						}
						UART3_Send(TsBuffer,ask_count,ok);
						break;
					case Check_num_zero:
						UART1_Send(R_TsBuffer,Check_num_zero,RsBuffer[1]);
						UART3_Send(TsBuffer,Check_num_zero,ok);
						break;
					case 0x48:
						UART1_Send(R_TsBuffer,0x48,Check_num_zero);
						break;
					case 0x49:
						UART1_Send(R_TsBuffer,0x49,Check_num_zero);
						break;
					/*不是有效的命令*/
					default:
						break;
				}
			}
			else
			{
				UART3_Send(TsBuffer,ERROR,no);/*校验错误*/
			}
			c_ok_Flag = 0;/*命令完成，开始接收下一个命令*/
			UART_interrupt(1,1);/*使能串口1中断*/
		}
		/*从机返回命令*/
		if(rebot_dr > 0)/*丛机机械手出来成功*/
		{
			UART_interrupt(0,1);/*使能串口1接收中断*/
			if(Rc_ok_Flag == 1)
			{
				if(R_RsBuffer[2] == 0x0a)
				{
					if(R_RsBuffer[1] == 0x09)
					{
						Rc_ok_Flag = 0;
						mirro = 1;
						goto Drawer_back_1;
					}
				}
			}
		}
		/*定时时间*/
		if(T1msFlg >= 400)
		{
			T1msFlg = 0;
			led_os = ~led_os;
		}
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
	if(Encoder_bz == 1)/*开启编码器*/	
	{
		if(Encoder == 0)
		{
			if(bu_Encoder == 0)
			{
				if(fr_Flag == 0)
				{
					fr_Flag = 1;
					Encoder_count++;
				}
			}
			else
			{
				fr_Flag = 0;
			}
		}
	}
	return;
}
/***************************************
说明: 串口1中断接收函数
***************************************/
u8 ua_count = 0;
@far @interrupt void UART1_Recv_IRQHandler (void)
{
	unsigned char ch;
	ch=UART1_DR;
	if( Rc_ok_Flag == 0 )
	{
		if(Rcom_Flag == 0)
		{
			if(ch == c_head)
			{
				Rcom_Flag = 1;
				Rcom_i = 0;
			}
		}
		else if(Rcom_Flag == 1)
		{
			R_RsBuffer[Rcom_i] = ch;
			if(Rcom_i == 7)
			{
				Rcom_i = 0;
				Rcom_Flag = 0;
				Rc_ok_Flag = 1;
				ua_count = 0;
			}
			else
			{
				Rcom_i++;
			}
		}
	}
	return;
}
/***************************************
说明: 串口3中断接收函数
***************************************/
@far @interrupt void UART3_Recv_IRQHandler (void)
{
	unsigned char ch;
	ch=UART3_DR;
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
		else if(com_Flag == 2)
		{
			RsBuffer[com_i] = ch;
			if(com_i == 13)
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
u8 ts1_count = 0;
u8 ts1_ok = 0;
@far @interrupt void UART1_Txcv_IRQHandler (void)
{
	u8 i;
	_asm("sim");//开中断，sim为关中断
	UART1_SR&= ~(1<<6);    //清除送完成状态位
	UART1_DR =  R_TsBuffer[ts1_count];
	if(ts1_count < 8)ts1_count++;
	else
	{
		ts1_count = 0;
		rs485_dr1 = 0;
		UART1_CR2 &= ~BIT(6);//开发送完成中?
		ts1_ok = 0;
	}
	//UART1_CR2 &= ~(1<<6);//关闭发送完成中断
	//for(i = 0;i < 5;i++)
	//{
	//		UART1_Sendint(R_TsBuffer[i]);
	//}
	_asm("rim");//开中断，sim为关中断
	return;
}
/***************************************
说明: 串口3发送中断函数
***************************************/
u8 ts3_count = 0;
u8 ts3_ok = 0;
@far @interrupt void UART3_Txcv_IRQHandler (void)
{
	u8 i;
	_asm("sim");//开中断，sim为关中断
	UART3_SR&= ~(1<<6);    //清除送完成状态位
	//UART3_CR2 &= ~(1<<6);//关闭发送完成中断
	UART3_DR = TsBuffer[ts3_count];
	if(ts3_count < 15)ts3_count++;
	else
	{
		ts3_count = 0;
		rs485_dr2 = 0;
		UART3_CR2 &= ~BIT(6);//开发送完成中?
		ts3_ok = 0;
	}
	//for(i = 0;i < 17;i++)
	//{
	//		UART3_Sendint(TsBuffer[i]);
	//}
	//UART3_Sendint(0xff);
	_asm("rim");//开中断，sim为关中断
	return;
}
/***************************************
说明: PWM溢出中断
***************************************/
@far @interrupt void TIM2_UPD_OVF_IRQHandler (void)
{
	TIM2_SR1 &= (~0x01);        //清除中断标志
	//pwm_cont++;
	return;
}
/*旋转控制变量区*/
extern volatile u8 k; 
extern volatile u8 up_or_down;           
extern volatile u8 half_over; 
extern volatile u8 direction;  
extern volatile u8 n_max;
extern volatile u16 ksteps;       
extern volatile u16 ksteps_inc; 
extern volatile u16 ksteps_save;
extern volatile u32 steps; 
extern volatile u32 steps_half; 
extern volatile u32 steps_count;  
extern volatile u32 steps_count2;  
extern volatile u32 steps_keep_count;
extern u16 timerlow[15];
#define moto_hz OPA3
/*旋转控制中断*/
@far @interrupt void TIM3_UPD_OVF_IRQHandler (void)
{
	_asm("sim");//开中断，sim为关中断
	TIM3_SR1 &= (~0x01);        //清除中断标志
	TIM3_ARRH=timerlow[k]>>8;           
	TIM3_ARRL=timerlow[k];	 //246
	WDT();//清看门狗
	if(up_or_down == 1)
	{
		ksteps--;
		steps_count+=1;
		steps_count2+=2;          
		if(steps_count>=steps_half)
		{
			half_over=1;
			ksteps=0;
		}
		moto_hz = !moto_hz;
	}
	if(up_or_down == 2)
	{
		steps_keep_count-=1;
		steps_count+=1;
		moto_hz = !moto_hz;
	}
	if(up_or_down == 3)
	{
		ksteps--;
		steps_count=steps_count+1;
		if(steps_count>=steps) ksteps=0;
		moto_hz = !moto_hz;
	}
	_asm("rim");//开中断，sim为关中断
}  