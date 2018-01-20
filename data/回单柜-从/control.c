/***********************************************************
* �ĵ�: control.c
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#include "main.h"
/*��ַIO�ڶ���*/
#define adr_1 IPC2	
#define adr_2 IPC5
#define adr_3 IPD0	
#define adr_4 IPD2
#define adr_5 IPD3	
#define adr_6 IPD4
#define adr_7 IPC7	
#define adr_8 IPC6
#define adr_9 IPC4	
#define adr_10 IPC3	

/*�����ź�IO�ڶ���*/
#define en_seat		OPA1
#define back_seat IPE5/*������λ*/
#define out_seat	IPB0/*��ȥ��λ*/

#define moto_step OPA3
#define moto_dir  OPB6
/*ָʾLED IO�ڶ���*/
//#define os 		OPB4
//#define c_led	OPA3
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
		for(i=0;i<1125;i++);//2M����һ����1us��i=140;�պ�1ms,16Mʱ��i=1125
		WDT();//�忴�Ź�
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
void BSP_Init(void)
{
	CLK_CKDIVR=0x00;

	
	PA_DDR |= BIT(3);
	PA_CR1 |= BIT(3); 
	PA_CR2 |= BIT(3);
	
	PF_DDR |= BIT(4);
	PF_CR1 |= BIT(4); 
	PF_CR2 |= BIT(4);
	
	PB_DDR |= BIT(3);
	PB_CR1 |= BIT(3); 
	PB_CR2 |= BIT(3);
	
	PB_DDR |= BIT(7);
	PB_CR1 |= BIT(7); 
	PB_CR2 |= BIT(7);
	
	PB_DDR &= ~BIT(2);
	PB_CR1 &= ~BIT(2); 
	PB_CR2 &= ~BIT(2);

	PB_DDR |= BIT(6);
	PB_CR1 |= BIT(6); 
	PB_CR2 |= BIT(6);
	
	OPA3 = 1;
	OPF4 = 1;
	OPB3 = 0;
	OPB7 = 1;
	OPB6 = 1;	
	
	/***���ӻ���ַ_PC2 PC1 PE5 PB0 PB1 PB2 PB3 PB6 PB7 PF4****/
	PC_DDR &= ~BIT(2);
	PC_CR1 &= ~BIT(2); 
	PC_CR2 &= ~BIT(2);
	
	PC_DDR &= ~BIT(5);
	PC_CR1 &= ~BIT(5); 
	PC_CR2 &= ~BIT(5);
	
	PD_DDR &= ~BIT(0);
	PD_CR1 &= ~BIT(0); 
	PD_CR2 &= ~BIT(0);
	
	PD_DDR &= ~BIT(2);
	PD_CR1 &= ~BIT(2); 
	PD_CR2 &= ~BIT(2);
	
	PD_DDR &= ~BIT(3);
	PD_CR1 &= ~BIT(3); 
	PD_CR2 &= ~BIT(3);
	
	PD_DDR &= ~BIT(4);
	PD_CR1 &= ~BIT(4); 
	PD_CR2 &= ~BIT(4);
	
	PC_DDR &= ~BIT(7);
	PC_CR1 &= ~BIT(7); 
	PC_CR2 &= ~BIT(7);
	
	PC_DDR &= ~BIT(6);
	PC_CR1 &= ~BIT(6); 
	PC_CR2 &= ~BIT(6);
	
	PC_DDR &= ~BIT(4);
	PC_CR1 &= ~BIT(4); 
	PC_CR2 &= ~BIT(4);
	
	PC_DDR &= ~BIT(3);
	PC_CR1 &= ~BIT(3); 
	PC_CR2 &= ~BIT(3);
	
	
	/***����λ_PC5****/
	PE_DDR &= ~BIT(5);
	PE_CR1 |= BIT(5); 
	PE_CR2 &= ~BIT(5);
	/***�뵽λ_PC6****/
	PB_DDR &= ~BIT(0);
	PB_CR1 |= BIT(0); 
	PB_CR2 &= ~BIT(0);
	
	PA_DDR |= BIT(1);
	PA_CR1 |= BIT(1); 
	PA_CR2 |= BIT(1);
	
	
	/***ͨѶָʾ��PA3****/
	PC_DDR |= BIT(1);
	PC_CR1 |= BIT(1); 
	PC_CR2 |= BIT(1);
	
	
	/***������****/
	PB_DDR |= BIT(1);
	PB_CR1 |= BIT(1); 
	PB_CR2 |= BIT(1);
	OPB1 = 0;
	/*
	//��ʱ��1���ã�����1msһ�ε��ж�
	TIM1_PSCRH = 0X1F;
	TIM1_PSCRL = 0X3F;
	TIM1_ARRH = 0X00;
	TIM1_ARRL = 0X01;
	TIM1_IER = 0X01;
	TIM1_CR1 = 0X01;
		//PWM��ʼ��
	TIM2_IER = 0x00;        // PWM�ж���Ҫ��������е���
	TIM2_CCMR3 = 0b01111000;  //pwmģʽ2
	TIM2_CCER2 = 1;  //CC3����ʹ��
	TIM2_PSCR = 0x04;         //8^1 ��ƵΪ1M 
	TIM2_ARRH = 0x01;
	TIM2_ARRL = 0xf3;        //ÿ500us�ж�һ��1F4-2k,100-10k
	TIM2_CCR3H = 0x00;
	TIM2_CCR3L = 0xf8;        //����ռ�ձȣ��������������ٺ�
	TIM2_CR1 |= BIT(0);              //������ʹ�ܣ���ʼ����
	*/
	//r_enable = 1;/*�رջ�е��*/
	//os = 1;
	/*���ÿ��Ź�*/
	IWDG_KR = 0xCC;       //�������Ź�
	IWDG_KR = 0x55;       //���д����
	IWDG_PR = 0x06;       //256��Ƶ�����1.02��
	IWDG_RLR = 255;       //1020ms
	IWDG_KR = 0xAA;       //д����
	WDT();//�忴�Ź�
}
/***************************************
����: Addr_Read
����: ��ȡ�豸��ַ
����: ��ַ���������ַ
���: ��
˵��: ����ֵַ ��ֵ���������
***************************************/
void Addr_Read(u16 *address)
{
	*address = 0;
	if(adr_1 == 0)
	{
		*address = 1;
	}
	if(adr_2 == 0)
	{
		*address = 2;
	}
	if(adr_3 == 0)
	{
		*address = 3;
	}
	if(adr_4 == 0)
	{
		*address = 4;
	}
	if(adr_5 == 0)
	{
		*address = 5;
	}
	if(adr_6 == 0)
	{
		*address = 6;
	}
	if(adr_7 == 0)
	{
		*address = 7;
	}
	if(adr_8 == 0)
	{
		*address = 8;
	}
	if(adr_9 == 0)
	{
		*address = 9;
	}
	if(adr_10 == 0)
	{
		*address = 10;
	}
}
u8 robot_mode(u8 mode) {
	u16 moto_flag_count = 0;
	u16 moto_flag = 0;
	u16 moto_sleep = 0;
	
	moto_sleep = 1000;
	WDT();//�忴�Ź�
	en_seat = 1;
	delayms(10);
	if(mode == 0) {
		if(back_seat == 1) {
			return 0x01;
		} else {
			moto_dir = 0;
			while(moto_flag < 600) {
				moto_step = 0;
				delayus(moto_sleep);
				moto_step = 1;
				delayus(moto_sleep);
				WDT();//�忴�Ź�
				if(back_seat == 1){
					if(moto_flag < 2000) {
						moto_flag++;
					} else {
						return 0x44;
					}
				} else {
					moto_flag = 0;
				}
				if(moto_flag_count < 1) {
					moto_flag_count++;	
				} else {
					moto_flag_count = 0;
					if(moto_sleep > 250) {
						moto_sleep--;
					}
				}
			}
			en_seat = 0;
			return 0x02;
		}
	} else {
		if(out_seat == 1) {
			return 0x01;
		} else {
			moto_dir = 1;
			while(moto_flag < 600) {
				moto_step = 0;
				delayus(moto_sleep);
				moto_step = 1;
				delayus(moto_sleep);
				WDT();//�忴�Ź�
				if(out_seat == 1){
					if(moto_flag < 2000) {
						moto_flag++;
					} else {
						return 0x44;
					}
				} else {
					moto_flag = 0;
				}
				if(moto_flag_count < 1) {
					moto_flag_count++;	
				} else {
					moto_flag_count = 0;
					if(moto_sleep > 250) {
						moto_sleep--;
					}
				}
			}
			en_seat = 0;
			return 0x02;
		}
	}
	return 0;
}

void SetLed(u8 cmd) {
	OPB1 = cmd;
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

void eeprom_count(u8 ad)
{
	u8 i = Eeprom_Read(ad);
	if(i == 9)
	{
		Eeprom_Write(ad,0);
		i = Eeprom_Read(ad+1);
		if(i == 9)
		{
			Eeprom_Write(ad+1,0);
			i = Eeprom_Read(ad+2);
			if(i == 9)
			{
				Eeprom_Write(ad+2,0);
				i = Eeprom_Read(ad+3);
				if(i == 9)
				{
					Eeprom_Write(ad+3,0);
					i = Eeprom_Read(ad+4);
					if(i == 9)
					{
						/*99999Ϊ����*/
					}
					else
					{
						i++;
						Eeprom_Write(ad+4,i);
					}
				}
				else
				{
					i++;
					Eeprom_Write(ad+3,i);
				}
			}
			else
			{
				i++;
				Eeprom_Write(ad+2,i);
			}
		}
		else
		{
			i++;
			Eeprom_Write(ad+1,i);
		}
	}
	else
	{
		i++;
		Eeprom_Write(ad,i);
	}
}


