/***********************************************************
* ����: ����STM8��Ƭ���Ļص������-�ӻ�
* ����: STVD MainFrame Version 3.6.5.2 CXSTM8
* ����: 2015-2-2 11:13:14
* ����: NULL
* �汾: 1.0
***********************************************************/
/***********************************************************
* �ĵ�: main.c
* ����: Haibin Ling
* ����: 1.
*       2.
*       3.
*       4.
*       5.
*       6.
*       7.
***********************************************************/
#include "type.h"
/**********************************************************/
/* �����������                                           */
/**********************************************************/
/*����ͨ�Ų㺯��*/
volatile u8 R_RsBuffer[R_MaxNumberofCom];//���ڻ�����
volatile u8 R_TsBuffer[R_MaxNumberofCom];
volatile _Bool c_ok_Flag = 0;/*����������ɱ�־λ*/
volatile u8 com_i = 0;/*�����������*/
volatile u16 addre = 0x01;/*��ַ*/
volatile u8 com_Flag = 0;/*���ڿ�ʼ���ܱ�־λ*/
volatile u8 r_Flag = 0;/*��е�ֳɹ�������־λ*/
volatile u8 r_num = 0;/*�����е��״̬*/
volatile u16 T1msFlg = 0;/*��ʱ���ۼӼ���*/
volatile u16 T2msFlg = 0;/*��ʱ���ۼӼ���*/
volatile u8 run_Falg = 0;/*����״̬��־*/
volatile u16 Duty_Val = 0;/*�����ƺ���ֵ*/
volatile u8 TS_count = 0;/**/
#define rs485_dr1 OPD7
#define back_seat IPC6/*������λ*/
#define out_seat	IPC5/*��ȥ��λ*/
		
/**********************************************************/
/* MAIN������                                             */
/**********************************************************/
main()
{
	BSP_Init();/*����ʼ��*/
	Eeprom_Init();/*����EEPROM*/
	UART1_Init();/*��ʼ��USART1*/
	Addr_Read(&addre);/*��ȡ��ַ*/
	_asm("rim");//���жϣ�simΪ���ж�
	//robot_mode(0);
	while (1)
	{
		
		/*�����Ʒ����ã���51-101��*/
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
		/*���ڷ���*/
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
					case Drawer_out:/*��е�ֳ�ȥ*/
						r_num = robot_mode(1);
						if(r_num == 0)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
							r_Flag = 1;/*��е�ֳɹ���ȥ�������������ƻ���*/
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
					case Drawer_out_place:/*��е�ֳ�ȥ�Ƿ�λ*/
						if(out_seat == 1)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
						}
						else 
						{
							UART1_Send(R_TsBuffer,0x02,addre);
						}
					break;
					case Drawer_back:/*��е�ֻ���*/
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
					case Drawer_back_place:/*��е�ֻ����Ƿ�λ*/
						if(back_seat == 1)
						{
							UART1_Send(R_TsBuffer,0x01,addre);
						}
						else
						{
							UART1_Send(R_TsBuffer,0x02,addre);
						}
					break;
					case Check_num://��ѯ��е��ʹ�ô���
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
		WDT();//�忴�Ź�
	}
}
/***************************************
˵��: TIM�жϺ�����1ms
***************************************/
@far @interrupt void TIM1_UPD_OVF_IRQHandler (void)
{
	TIM1_SR1 &= (~0x01);        //����жϱ�־
	T1msFlg++;
	T2msFlg++;
	return;
}
/***************************************
˵��: ����1�жϽ��պ���
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
˵��: ����1�����жϺ���
***************************************/
u8 fs_i = 0;
u8 fs_ok = 0;
@far @interrupt void UART1_Txcv_IRQHandler (void)
{
	_asm("sim");//���жϣ�simΪ���ж�
	//u8 i;
	UART1_SR &= ~(1<<6);    //��������״̬λ
	UART1_DR = R_TsBuffer[fs_i];
	if(fs_i < 8)fs_i++;
	else 
	{
		fs_i = 0;
		rs485_dr1 = 0;
		UART1_CR2 &= ~(1<<6);//�رշ�������ж�
		fs_ok = 0;
	}
	//for(i = 0;i < 5;i++)
	//{
		//	UART1_Sendint(R_TsBuffer[i]);
	//}
	_asm("rim");//���жϣ�simΪ���ж�
	return;
}