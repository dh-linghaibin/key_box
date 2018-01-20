/***********************************************************
* �ĵ�: control.c
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#include "type.h"

/*��������*/
#define adr_4 IPC7	
#define adr_3 IPG0
#define adr_2 IPG1	
#define adr_1 IPE3
/*�����赲���IO�ڶ���*/
#define pla_0 IPB7
#define pla_1 IPB6
#define pla_2 IPB5
#define pla_3 IPB4
#define pla_4 IPB3
#define pla_5 IPB2
#define pla_6 IPB1
#define pla_7 IPB0
#define pla_8 IPE7
#define pla_9 IPE6
#define pla_dc OPA2
/**/
#define b_sar IPC3 /*����*/
#define moto_dr OPD2 /*�������*/
#define moto_hz OPA3 /*����ٶ�*/
#define buzzer OPA1	/*������*/

#define but_led OPD3/*ledָʾ��*/

volatile u8 k; 
volatile u8 up_or_down;           
volatile u8 half_over; 
volatile u8 direction;  
volatile u8 n_max;
volatile u16 ksteps;       
volatile u16 ksteps_inc; 
volatile u16 ksteps_save;
volatile u32 steps; 
volatile u32 steps_half; 
volatile u32 steps_count;  
volatile u32 steps_count2;  
volatile u32 steps_keep_count;
volatile u32 result_move;      //������������ת��
/*��������˶�����*/
/*
const u16 Moto_Pwm[48] = {1250,1111,997,909,820,769,710,650,
620,588,580,526,500,476,454,434,
416,400,384,357,344,333,322,312,303,294,285,277,270,263,250,
243,238,232,227,222,217,212,208,204,200,196,192,188
,185};*/
/***************************************
����: delayms
����: ��ʱ���ȴ�
����: ms��ʱʱ������
���: ��
˵��: �ȴ�
***************************************/
void delayms(u16 ms)	
{						
	u16 i;
	while(ms--)
	{
		WDT();//�忴�Ź�
		for(i=0;i<1125;i++);//2M����һ����1us��i=140;�պ�1ms,16Mʱ��i=1125
	}
}
/***************************************
����: delayus
����: ��ʱ���ȴ�
����: us��ʱʱ������
���: ��
˵��: �ȴ� ע�⣺��ʱʱ�䲻��ȷ
***************************************/
void delayus(u16 us) 	
{	
	while(us--);
}
/***************************************
����: BSP_Init
����: �ײ�ӿڳ�ʼ��
����: ��
���: ��
˵��: �� �ײ� ���� ��� ��ʱ��  PWM ��ʼ��
***************************************/

static u16 cabinet_angle = 0;

void BSP_Init(void)
{
	CLK_CKDIVR=0x00;//ʱ��Ԥ��Ƶ��Ĭ��8���䣬0x18.16M-0x00��8M-0x08;4M-0x10;
	/***�����ת_PA3****/
	PA_DDR |= BIT(3);
	PA_CR1 |= BIT(3); 
	PA_CR2 |= BIT(3);
	/***�������_PD2****/
	PD_DDR |= BIT(2);
	PD_CR1 |= BIT(2); 
	PD_CR2 |= BIT(2);
	/***���ְ�ť_PD4****/
	PD_DDR &= ~BIT(4);
	PD_CR1 |= BIT(4); 
	PD_CR2 &= ~BIT(4);
	/***LEDָʾ��_PD3****/
	PD_DDR |= BIT(3);
	PD_CR1 |= BIT(3); 
	PD_CR2 |= BIT(3);
	/***�����ź�_PC3****/
	PC_DDR &= ~BIT(3);
	PC_CR1 |= BIT(3); 
	PC_CR2 &= ~BIT(3);
	/***�������ź�_PC4****/
	PC_DDR &= ~BIT(4);
	PC_CR1 |= BIT(4); 
	PC_CR2 &= ~BIT(4);
	/***��ַ���_PC7_PG0_PG1_PE3****/
	PC_DDR &= ~BIT(7);
	PC_CR1 |= BIT(7); 
	PC_CR2 &= ~BIT(7);
	PG_DDR &= ~BIT(0);
	PG_CR1 |= BIT(0); 
	PG_CR2 &= ~BIT(0);
	PG_DDR &= ~BIT(1);
	PG_CR1 |= BIT(1); 
	PG_CR2 &= ~BIT(1);
	PE_DDR &= ~BIT(3);
	PE_CR1 |= BIT(3); 
	PE_CR2 &= ~BIT(3);
	/***LCD������ť_PE0_PE1_PE2_PD0****/
	PE_DDR &= ~BIT(0);
	PE_CR1 |= BIT(0); 
	PE_CR2 &= ~BIT(0);
	PE_DDR &= ~BIT(1);
	PE_CR1 |= BIT(1); 
	PE_CR2 &= ~BIT(1);
	PE_DDR &= ~BIT(2);
	PE_CR1 |= BIT(2); 
	PE_CR2 &= ~BIT(2);
	PD_DDR &= ~BIT(0);
	PD_CR1 |= BIT(0); 
	PD_CR2 &= ~BIT(0);
	/***��Դ24Vʹ�ܰ�ťPC2****/
	PC_DDR |= BIT(2);
	PC_CR1 |= BIT(2); 
	PC_CR2 |= BIT(2);
	/***����ָʾ��PC1****/
	PC_DDR |= BIT(1);
	PC_CR1 |= BIT(1); 
	PC_CR2 |= BIT(1);
	/***������PA1****/
	PA_DDR |= BIT(1);
	PA_CR1 |= BIT(1); 
	PA_CR2 |= BIT(1);
	/***������PB0-7 PE6 PE7****/
	PB_DDR &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
	PB_CR1 |= ( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) ); 
	PB_CR2 &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
	PE_DDR &= ~( BIT(6)|BIT(7) );
	PE_CR1 |= ( BIT(6)|BIT(7) ); 
	PE_CR2 &= ~( BIT(6)|BIT(7) );
	/****ʹ�����Ϲ���PA2****/
	PA_DDR |= BIT(2);
	PA_CR1 |= BIT(2); 
	PA_CR2 |= BIT(2);
	//��ʱ��1���ã�����1msһ�ε��ж�
	TIM1_PSCRH = 0X1F;
	TIM1_PSCRL = 0X3F;
	TIM1_ARRH = 0X00;
	TIM1_ARRL = 0X01;
	TIM1_IER = 0X01;
	TIM1_CR1 = 0X01;
	//��ʱ��3���ã�����1msһ�ε��ж�
	TIM3_PSCR  =0x00;  
	TIM3_EGR = 0x01; 
	TIM3_CNTRH = 0x0;          // Counter Starting Value;
	TIM3_CNTRL = 0x0;     
	TIM3_ARRH = 0X40;
	TIM3_ARRL = 0X01;
	TIM3_IER = 0X01;
	TIM3_CR1 = 0X00;
	
	/*���ÿ��Ź�*/
	IWDG_KR = 0xCC;       //�������Ź�
	IWDG_KR = 0x55;       //���д����
	IWDG_PR = 0x06;       //256��Ƶ�����1.02��
	IWDG_RLR = 255;       //1020ms
	IWDG_KR = 0xAA;       //д����
	WDT();//�忴�Ź�
	
	/*PWM��ʼ��*/
	//TIM2_IER = 0x01;         /*PWM�ж���Ҫ��������е���*/
	///TIM2_CCMR3 = 0b01101000;  //pwmģʽ2
//	TIM2_CCER2 = 3;  //CC3����ʹ��
//	TIM2_PSCR = 0x05;         //8^1 ��ƵΪ1M 
//	TIM2_ARRH = 0x01;
//	TIM2_ARRL = 0x80;        //ÿ500us�ж�һ��1F4-2k,100-10k
	//TIM2_CCR3H = 0x00;
//	TIM2_CCR3L = 150;        //����ռ�ձȣ��������������ٺ�
//	TIM2_CR1 = 0x04;
	//TIM2_CR1 &= ~BIT(0);              //������ʹ�ܣ���ʼ����
	/*�ж����ȼ�����*/
	ITC_SPR5 |= BIT(2)|BIT(3)|BIT(4)|BIT(5);
	ITC_SPR6 |= BIT(0)|BIT(1)|BIT(2)|BIT(3);
	ITC_SPR3 |= BIT(7);
	ITC_SPR3 &= ~BIT(6);
	ITC_SPR4 |= BIT(3);
	ITC_SPR4 &= ~BIT(2);
	
	pla_dc = 0;
	buzzer = 0;/*�رշ�����*/
	but_led = 1;/*�ر�led*/
	_asm("rim");//���жϣ�simΪ���ж�
}
/***************************************
����: Addr_Read
����: ��ȡ�豸��ַ
����: ��ַ���������ַ
���: ��
˵��: ����ֵַ ��ֵ���������
***************************************/
void Addr_Read(u8 *address)
{
	*address = 0;
	if(adr_1 == 0)
	{
		*address |= BIT(0);
	}else
	{
		*address &= ~BIT(0);
	}
	if(adr_2 == 0)
	{
		*address |= BIT(1);
	}else
	{
		*address &= ~BIT(1);
	}
	if(adr_3 == 0)
	{
		*address |= BIT(2);
	}else
	{
		*address &= ~BIT(2);
	}
	if(adr_4 == 0)
	{
		*address |= BIT(3);
	}else
	{
		*address &= ~BIT(3);
	}
}
volatile extern u16 Shield;/*�����������*/
volatile extern u8 S_buf[10];/*�����������*/
void Shield_sava(u8 *Array)
{
	u8 i;
	Shield = 0x03ff;
	for(i = 1;i < 11;i++)
	{
		if(Array[i] == 0)
		{
			Shield &= (~BIT(i-1));
			S_buf[i-1] = 1;
		}
		else
		{
			S_buf[i-1] = 0;
		}
	}
}
/***************************************
����: Bar_Read
����: ��ȡ�����赲��Ϣ
����: �豸�赲���������ַ
���: ��
˵��: ���赲ֵ ��ֵ���������
***************************************/
u8 Bar_Read(u8 *Array)
{
	volatile u16 place = 0;/*�ȶ���������*/
	pla_dc = 0;/*�򿪹����Դ*/
	delayms(5);/*�ȴ��ȶ�*/
	WDT();//�忴�Ź�
	if(pla_0 == 0)
	{
		Array[1] = 0;
		place |= BIT(0);
	}
	else
	{
		Array[1] = 1;
		Array[1] = S_buf[0];
		place &= ~BIT(0);
	}
	if(pla_1 == 0)
	{
		Array[2] = 0;
		place |= BIT(1);
	}
	else
	{
		Array[2] = 1;
		Array[2] = S_buf[1];
		place &= ~BIT(1);
	}
	if(pla_2 == 0)
	{
		Array[3] = 0;
		place |= BIT(2);
	}
	else
	{
		Array[3] = 1;
		Array[3] = S_buf[2];
		place &= ~BIT(2);
	}
	if(pla_3 == 0)
	{
		Array[4] = 0;
		place |= BIT(3);
	}
	else
	{
		Array[4] = 1;
		Array[4] = S_buf[3];
		place &= ~BIT(3);
	}
	if(pla_4 == 0)
	{
		Array[5] = 0;
		place |= BIT(4);
	}
	else
	{
		Array[5] = 1;
		Array[5] = S_buf[4];
		place &= ~BIT(4);
	}
	if(pla_5 == 0)
	{
		Array[6] = 0;
		place |= BIT(5);
	}
	else
	{
		Array[6] = 1;
		Array[6] = S_buf[5];
		place &= ~BIT(5);
	}
	if(pla_6 == 0)
	{
		Array[7] = 0;
		place |= BIT(6);
	}
	else
	{
		Array[7] = 1;
		Array[7] = S_buf[6];
		place &= ~BIT(6);
	}
	if(pla_7 == 0)
	{
		Array[8] = 0;
		place |= BIT(7);
	}
	else
	{
		Array[8] = 1;
		Array[8] = S_buf[7];
		place &= ~BIT(7);
	}
	if(pla_8 == 0)
	{
		Array[9] = 0;
		place |= BIT(8);
	}
	else
	{
		Array[9] = 1;
		Array[9] = S_buf[8];
		place &= ~BIT(8);
	}
	if(pla_9 == 0)
	{
		Array[10] = 0;
		place |= BIT(9);
	}
	else
	{
		Array[10] = 1;
		Array[10] = S_buf[9];
		place &= ~BIT(9);
	}
	place |= Shield;
	if(place == 0x3ff)/*��������赲�����򲻹رյ�Դ��һֱ�����赲*/
	{
		//pla_dc = 1;/*�رչ����Դ*/
		return 1;
	}
	return 0;
}
/***************************************
����: Com_Check
����: У������
����: �豸�赲���������ַ
���: ��
˵��: ���赲ֵ ��ֵ���������
***************************************/
u8 Com_Check(u8 *place,u8 ad)
{
	volatile u8 check_1,check_2;
	check_1 = place[0]+ad;
	check_2 = place[1]+place[2]+place[3]+place[4]+place[5]+place[6]+
						place[7]+place[8]+place[9]+place[10];
	if( (check_1 == place[11])&(check_2 == place[12])&(place[13] == 0x0a) )
	{
		return 1;
	}
	return 0;
}
/***************************************
����: Eeprom_Init
����: ����EEprom 
����: ��
���: ��
˵��: ֻ�н�����EEPROM�ſ��Բ���
***************************************/
void Eeprom_Init(void)
{
	FLASH_CR1 = 0X00;
	FLASH_CR2 = 0X00;
	FLASH_NCR2 = 0XFF;
	FLASH_DUKR = 0XAE;
	FLASH_DUKR = 0X56;
	while(!(FLASH_IAPSR&0X08));
}
/***************************************
����: Eeprom_Write
����: ���Ӧ��ַд������
����: 
���: ��
˵��: 
***************************************/
void Eeprom_Write(u8 addr,u8 dat)
{
	volatile u8 *p;
	p = (u8 *)(0x4000+addr);
	*p = dat;
	while(!(FLASH_IAPSR&0X40));
}
/***************************************
����: Eeprom_Read
����: ��ȡ��Ӧ��ַ����ı���
����: ��ַ
���: ��
˵��: 
***************************************/
u8 Eeprom_Read(u8 addr)
{
	volatile u8 *p;
	p = (u8 *)(0x4000+addr);
	return *p;
}
/***************************************
����: Moto_Hz
����: �������PWMֵ
����: PWMֵ
���: ��
˵��: 
***************************************/
void Moto_Hz(u32 hz)
{
	volatile u8 i;
	volatile u16 j;
	i = (hz*9)/0xffff;
	j = (hz*9)%0xffff;
	TIM2_PSCR =  i;
	TIM2_ARRH = j>>8;
	TIM2_ARRL = j;
}
/***************************************
����: Found_Receipt
����: �ص����
����: 
���: ��
˵��:  
***************************************/
volatile u8 hd_num = 0; /*����ص����*/
void Found_Receipt(u8 *Array_R,u8 *wr_Flag,u8 *sta_Flag)
{
	if(Array_R[1] == 0x01)
	{
		if(pla_0 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x02)
	{
		if(pla_1 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x03)
	{
		if(pla_2 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x04)
	{
		if(pla_3 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x05)
	{
		if(pla_4 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x06)
	{
		if(pla_5 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x07)
	{
		if(pla_6 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x08)
	{
		if(pla_7 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x09)
	{
		if(pla_8 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
	else if(Array_R[1] == 0x0a)
	{
		if(pla_9 == 0)
		{
			if(*sta_Flag == 0)
			{
				*sta_Flag = 1;
				*wr_Flag ++;
				hd_num++;
			}
		}
		else
		{
			*sta_Flag = 0;
		}
	}
}
/***************************************
����: Back_Zero
����: �������
����: PWM������
���: ��    1500 1200 1000 900  800
˵��: ��Ƶ��Ϊ400HZ����ߵ�2700HZ   
***************************************/
u8 Back_Zero(u8 *Dr_Num_Save)
{
	u8 cheack_save = 0;//����λ��״̬
	u16 stepes = 0;
	u16 stepes_2 = 0;
	moto_dr = 0;/*�ı䷽��*/
	if(b_sar == 0)//������λ
	{
		cheack_save ++;//������λ
		while(b_sar == 0)
		{
			WDT();//�忴�Ź�
			if(stepes < 100)
			{
				moto_hz = !moto_hz;
				delayus(1500);
				stepes++;
			}
			else if(stepes < 200)
			{
				moto_hz = !moto_hz;
				delayus(1200);
				stepes++;
			}
			else if(stepes < 300)
			{
				moto_hz = !moto_hz;
				delayus(1100);
				stepes++;
			}
			else if(stepes < 400)
			{
				moto_hz = !moto_hz;
				delayus(1000);
				stepes++;
			}
			else if(stepes < 500)
			{
				moto_hz = !moto_hz;
				delayus(900);
				stepes++;
			}
			else if(stepes < 600)
			{
				moto_hz = !moto_hz;
				delayus(820);
				stepes++;
			}
			else
			{
				moto_hz = !moto_hz;
				delayus(640);
			}
		}
	}
	else//����λ
	{
		stepes = 200;
	}
	while(stepes)//����λ
	{
		WDT();//�忴�Ź�
		if(stepes > 600)
		{
			moto_hz = !moto_hz;
			delayus(750);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 550;
			}
		}
		else if(stepes > 500)
		{
			moto_hz = !moto_hz;
			delayus(900);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 450;
			}
		}
		else if(stepes > 400)
		{
			moto_hz = !moto_hz;
			delayus(1000);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 350;
			}
		}
		else if(stepes > 300)
		{
			moto_hz = !moto_hz;
			delayus(1100);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 250;
			}
		}
		else if(stepes > 200)
		{
			moto_hz = !moto_hz;
			delayus(1200);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 150;
			}
		}
		else if(stepes > 150)
		{
			moto_hz = !moto_hz;
			delayus(1500);
			stepes_2++;
			if(stepes_2 == 100)
			{
				stepes_2 = 0;
				stepes = 100;
			}
		}
		else
		{
			moto_hz = !moto_hz;
			delayus(2000);
			stepes_2++;
			if(stepes_2 == 500)
			{
				stepes_2 = 0;
				stepes = 0;
			}
		}
	}
	delayms(300);
	WDT();//�忴�Ź�
	moto_dr = 1;/*�ı䷽��*/
	while(b_sar == 0)
	{
		cheack_save ++;//������λ
		moto_hz = !moto_hz;
		delayus(2000);
		WDT();//�忴�Ź�
	}
	*Dr_Num_Save = 1;
	Eeprom_Write(10,*Dr_Num_Save/10);
	Eeprom_Write(11,*Dr_Num_Save%10);
	if(cheack_save > 0)
	{
		return CORRECT;
	}
	else
	{
		return ERROR;//�����д���
	}
}
/***************************************
����: Back_Zero
����: �����ת
����: PWM������
���: ��
˵��: ��Ƶ��Ϊ400HZ����ߵ�2700HZ   
***************************************/
//���±������ڲ���������п���
extern volatile _Bool Encoder_bz;
extern volatile u16 Encoder_count;/*����������*/
volatile u16 timerlow[15]={20000,17500,16000,14500,13200,
12200,11300,10600,9900,9300,8900,8400,8000,7580,7300};
									//��Ƶ��Ϊ400HZ  1.5
									//��Ƶ��Ϊ400HZ����ߵ�2700HZ
static u16 stop_arr[52] = {
    //0,23,54,77,100,122,154,177,200,223,254,277,300,322,354,377,
    0,7,14,21,28,35,42,49,56,63,70,77,84,
	100,107,114,121,128,135,142,149,156,163,170,177,184,
	200,207,214,221,228,235,242,249,256,263,270,277,284,
	300,307,314,321,328,335,342,349,356,363,370,377,384
};
																		
u8 _Servo_C(u8 Dr_Num,u8 *Dr_Num_Save)//�ŷ��������
{
	
//	Encoder_count = 0;/*���¿�ʼ����*/
//	if(Dr_Num == 0) return 0; //������ֳ�����Ϊ0
 //	if(Dr_Num > 76) return 0; //����76���򷵻�
 //	if(Dr_Num > 65) Dr_Num=Dr_Num+4;  
/*�������㷨�����������Ȼ����ת��Ϊ�����������Խ��յ�λ�ñ���*/
// 	else if(Dr_Num > 46) Dr_Num=Dr_Num+3;
// 	else if(Dr_Num > 27) Dr_Num=Dr_Num+2;
// 	else if(Dr_Num > 8) Dr_Num=Dr_Num+1;
//	if(Dr_Num < *Dr_Num_Save)
//	{
//		if((*Dr_Num_Save-Dr_Num) <= (Total_Circle/2))
//		{
//			moto_dr = 1;/*�ı䷽��*/
//			result_move = *Dr_Num_Save-Dr_Num;
//			*Dr_Num_Save=Dr_Num;
//		}
//		else
//		{
//			moto_dr = 0;/*�ı䷽��*/
//			result_move=Total_Circle+Dr_Num-*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//	}
//	else if(Dr_Num>=*Dr_Num_Save)
//	{
//		if((Dr_Num-*Dr_Num_Save)<=(Total_Circle /2))
//		{
//			moto_dr = 0;/*�ı䷽��*/
//			result_move=Dr_Num-*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//		else if((Dr_Num-*Dr_Num_Save)>(Total_Circle /2))
//		{
//			moto_dr = 1;/*�ı䷽��*/
//			result_move=Total_Circle-Dr_Num+*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//	}
//	WDT();//�忴�Ź�
	//if(result_move == 0) return 0;
 	//steps = result_move* Average_Pulse *2;
	
	u16 angle = 0;//save Reaches the required angular position
    u16 result_move = 0;//��Ҫ��ת�ĽǶ�ֵ
	angle = stop_arr[tar_pos-1];
	if(cabinet_angle < angle)
	{
		if((angle-cabinet_angle) <= (Total_Circle/2))
		{
			moto_dr = 1;/*�ı䷽��*/
			result_move = angle-cabinet_angle;
		}
		else
		{
			moto_dr = 0;/*�ı䷽��*/
			result_move=Total_Circle+cabinet_angle-angle;
		}
	}
	
	else if(cabinet_angle>=angle)
	{
		if((cabinet_angle-angle)<=(Total_Circle /2))
		{
			moto_dr = 0;/*�ı䷽��*/
			result_move=cabinet_angle-angle;
		}
		else if((cabinet_angle-angle)>(Total_Circle /2))
		{
			moto_dr = 1;/*�ı䷽��*/
			result_move=Total_Circle-cabinet_angle+angle;
		}
	} 
	steps = result_move* Average_Pulse *2;
	
	//if(result_move == 0) return 0;
	if(steps == 0) return 0;

	
	
 	steps_half = steps/2;  
 	n_max = 14;               //��������ٶȵ�λ���ã��ɶ����޸�  
 	ksteps_inc = 20;          //�����������������޸�����������
 	ksteps_save = 10;  
 	steps_count = 0;
 	steps_count2 = 0; 
 	up_or_down = 1;
 	half_over = 0; 
 	moto_hz = 0;
	Encoder_bz = 1;/*����������*/	
 	TIM3_ARRH=timerlow[0]>>8;           
 	TIM3_ARRL=timerlow[0];	 //246
	TIM3_CR1 = 0X01; 
 	for(k=0;(half_over==0)&&(k<=n_max);k+=1)   
	{     
		ksteps_save=ksteps_save+ksteps_inc;
		ksteps=ksteps_save;     
		while(ksteps>0);  //���ٽ׶�  
	}    
	k-=1;
	if(half_over==0)
	{
		up_or_down=2;
		steps_keep_count=steps-steps_count2;
		while(steps_keep_count);
	}                                             
	up_or_down=3;
 	for(;steps_count<steps;k-=1)
	{       
		ksteps_save=ksteps_save-ksteps_inc;
		ksteps=ksteps_save;	//���ٽ׶�
		if(k<1)
		{
			k=1;
			ksteps=7000;
		}
		while(ksteps>0);       
	}
	TIM3_CR1 = 0X00;
	moto_hz = 1;
	delayus(2);
	moto_hz = 0;
	delayus(2);
	WDT();//�忴�Ź�
	Encoder_bz = 0;/*����������*/	
	/*������Ҫ��ת��λ��*/
	//*Dr_Num_Save = Dr_Num;
	//Eeprom_Write(10,*Dr_Num_Save/10);
	//Eeprom_Write(11,*Dr_Num_Save%10);
	
	cabinet_angle = angle;
	EepromWrite(10,cabinet_angle);
	EepromWrite(11,cabinet_angle<<8);
	return result_move;
}
