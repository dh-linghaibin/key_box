/***********************************************************
* 文档: control.c
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#include "type.h"

/*按键定义*/
#define adr_4 IPC7	
#define adr_3 IPG0
#define adr_2 IPG1	
#define adr_1 IPE3
/*光耦阻挡检测IO口定义*/
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
#define b_sar IPC3 /*回零*/
#define moto_dr OPD2 /*电机方向*/
#define moto_hz OPA3 /*电机速度*/
#define buzzer OPA1	/*蜂鸣器*/

#define but_led OPD3/*led指示灯*/

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
volatile u32 result_move;      //将抽屉名义编号转化
/*步进电机运动参数*/
/*
const u16 Moto_Pwm[48] = {1250,1111,997,909,820,769,710,650,
620,588,580,526,500,476,454,434,
416,400,384,357,344,333,322,312,303,294,285,277,270,263,250,
243,238,232,227,222,217,212,208,204,200,196,192,188
,185};*/
/***************************************
函数: delayms
功能: 延时、等待
输入: ms延时时间设置
输出: 无
说明: 等待
***************************************/
void delayms(u16 ms)	
{						
	u16 i;
	while(ms--)
	{
		WDT();//清看门狗
		for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
	}
}
/***************************************
函数: delayus
功能: 延时、等待
输入: us延时时间设置
输出: 无
说明: 等待 注意：延时时间不精确
***************************************/
void delayus(u16 us) 	
{	
	while(us--);
}
/***************************************
函数: BSP_Init
功能: 底层接口初始化
输入: 无
输出: 无
说明: 对 底层 输入 输出 定时器  PWM 初始化
***************************************/

static u16 cabinet_angle = 0;

void BSP_Init(void)
{
	CLK_CKDIVR=0x00;//时钟预分频，默认8分配，0x18.16M-0x00；8M-0x08;4M-0x10;
	/***电机旋转_PA3****/
	PA_DDR |= BIT(3);
	PA_CR1 |= BIT(3); 
	PA_CR2 |= BIT(3);
	/***电机方向_PD2****/
	PD_DDR |= BIT(2);
	PD_CR1 |= BIT(2); 
	PD_CR2 |= BIT(2);
	/***进仓按钮_PD4****/
	PD_DDR &= ~BIT(4);
	PD_CR1 |= BIT(4); 
	PD_CR2 &= ~BIT(4);
	/***LED指示灯_PD3****/
	PD_DDR |= BIT(3);
	PD_CR1 |= BIT(3); 
	PD_CR2 |= BIT(3);
	/***回零信号_PC3****/
	PC_DDR &= ~BIT(3);
	PC_CR1 |= BIT(3); 
	PC_CR2 &= ~BIT(3);
	/***编码器信号_PC4****/
	PC_DDR &= ~BIT(4);
	PC_CR1 |= BIT(4); 
	PC_CR2 &= ~BIT(4);
	/***地址检测_PC7_PG0_PG1_PE3****/
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
	/***LCD操作按钮_PE0_PE1_PE2_PD0****/
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
	/***电源24V使能按钮PC2****/
	PC_DDR |= BIT(2);
	PC_CR1 |= BIT(2); 
	PC_CR2 |= BIT(2);
	/***运行指示灯PC1****/
	PC_DDR |= BIT(1);
	PC_CR1 |= BIT(1); 
	PC_CR2 |= BIT(1);
	/***蜂鸣器PA1****/
	PA_DDR |= BIT(1);
	PA_CR1 |= BIT(1); 
	PA_CR2 |= BIT(1);
	/***光耦检测PB0-7 PE6 PE7****/
	PB_DDR &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
	PB_CR1 |= ( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) ); 
	PB_CR2 &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
	PE_DDR &= ~( BIT(6)|BIT(7) );
	PE_CR1 |= ( BIT(6)|BIT(7) ); 
	PE_CR2 &= ~( BIT(6)|BIT(7) );
	/****使能门上光耦PA2****/
	PA_DDR |= BIT(2);
	PA_CR1 |= BIT(2); 
	PA_CR2 |= BIT(2);
	//定时器1设置，产生1ms一次的中断
	TIM1_PSCRH = 0X1F;
	TIM1_PSCRL = 0X3F;
	TIM1_ARRH = 0X00;
	TIM1_ARRL = 0X01;
	TIM1_IER = 0X01;
	TIM1_CR1 = 0X01;
	//定时器3设置，产生1ms一次的中断
	TIM3_PSCR  =0x00;  
	TIM3_EGR = 0x01; 
	TIM3_CNTRH = 0x0;          // Counter Starting Value;
	TIM3_CNTRL = 0x0;     
	TIM3_ARRH = 0X40;
	TIM3_ARRL = 0X01;
	TIM3_IER = 0X01;
	TIM3_CR1 = 0X00;
	
	/*设置看门狗*/
	IWDG_KR = 0xCC;       //启动看门狗
	IWDG_KR = 0x55;       //解除写保护
	IWDG_PR = 0x06;       //256分频，最高1.02秒
	IWDG_RLR = 255;       //1020ms
	IWDG_KR = 0xAA;       //写保护
	WDT();//清看门狗
	
	/*PWM初始化*/
	//TIM2_IER = 0x01;         /*PWM中断主要在这里进行调整*/
	///TIM2_CCMR3 = 0b01101000;  //pwm模式2
//	TIM2_CCER2 = 3;  //CC3引脚使能
//	TIM2_PSCR = 0x05;         //8^1 分频为1M 
//	TIM2_ARRH = 0x01;
//	TIM2_ARRL = 0x80;        //每500us中断一次1F4-2k,100-10k
	//TIM2_CCR3H = 0x00;
//	TIM2_CCR3L = 150;        //设置占空比，即计数器到多少后
//	TIM2_CR1 = 0x04;
	//TIM2_CR1 &= ~BIT(0);              //计数器使能，开始计数
	/*中断优先级设置*/
	ITC_SPR5 |= BIT(2)|BIT(3)|BIT(4)|BIT(5);
	ITC_SPR6 |= BIT(0)|BIT(1)|BIT(2)|BIT(3);
	ITC_SPR3 |= BIT(7);
	ITC_SPR3 &= ~BIT(6);
	ITC_SPR4 |= BIT(3);
	ITC_SPR4 &= ~BIT(2);
	
	pla_dc = 0;
	buzzer = 0;/*关闭蜂鸣器*/
	but_led = 1;/*关闭led*/
	_asm("rim");//开中断，sim为关中断
}
/***************************************
函数: Addr_Read
功能: 读取设备地址
输入: 地址保存变量地址
输出: 无
说明: 讲地址值 赋值给传入变量
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
volatile extern u16 Shield;/*保存屏蔽情况*/
volatile extern u8 S_buf[10];/*保存屏蔽情况*/
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
函数: Bar_Read
功能: 读取设置阻挡信息
输入: 设备阻挡保存变量地址
输出: 无
说明: 讲阻挡值 赋值给传入变量
***************************************/
u8 Bar_Read(u8 *Array)
{
	volatile u16 place = 0;/*先对数据清零*/
	pla_dc = 0;/*打开光耦电源*/
	delayms(5);/*等待稳定*/
	WDT();//清看门狗
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
	if(place == 0x3ff)/*检测有无阻挡，有则不关闭电源，一直到无阻挡*/
	{
		//pla_dc = 1;/*关闭光耦电源*/
		return 1;
	}
	return 0;
}
/***************************************
函数: Com_Check
功能: 校验输入
输入: 设备阻挡保存变量地址
输出: 无
说明: 讲阻挡值 赋值给传入变量
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
函数: Eeprom_Init
功能: 解锁EEprom 
输入: 无
输出: 无
说明: 只有解锁了EEPROM才可以操作
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
函数: Eeprom_Write
功能: 向对应地址写入数据
输入: 
输出: 无
说明: 
***************************************/
void Eeprom_Write(u8 addr,u8 dat)
{
	volatile u8 *p;
	p = (u8 *)(0x4000+addr);
	*p = dat;
	while(!(FLASH_IAPSR&0X40));
}
/***************************************
函数: Eeprom_Read
功能: 读取对应地址保存的变量
输入: 地址
输出: 无
说明: 
***************************************/
u8 Eeprom_Read(u8 addr)
{
	volatile u8 *p;
	p = (u8 *)(0x4000+addr);
	return *p;
}
/***************************************
函数: Moto_Hz
功能: 设置输出PWM值
输入: PWM值
输出: 无
说明: 
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
函数: Found_Receipt
功能: 回单检测
输入: 
输出: 无
说明:  
***************************************/
volatile u8 hd_num = 0; /*保存回单情况*/
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
函数: Back_Zero
功能: 电机回零
输入: PWM脉冲数
输出: 无    1500 1200 1000 900  800
说明: 起步频率为400HZ，最高到2700HZ   
***************************************/
u8 Back_Zero(u8 *Dr_Num_Save)
{
	u8 cheack_save = 0;//保存位置状态
	u16 stepes = 0;
	u16 stepes_2 = 0;
	moto_dr = 0;/*改变方向*/
	if(b_sar == 0)//不在零位
	{
		cheack_save ++;//不在零位
		while(b_sar == 0)
		{
			WDT();//清看门狗
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
	else//在零位
	{
		stepes = 200;
	}
	while(stepes)//在零位
	{
		WDT();//清看门狗
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
	WDT();//清看门狗
	moto_dr = 1;/*改变方向*/
	while(b_sar == 0)
	{
		cheack_save ++;//不在零位
		moto_hz = !moto_hz;
		delayus(2000);
		WDT();//清看门狗
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
		return ERROR;//回零有错误
	}
}
/***************************************
函数: Back_Zero
功能: 电机旋转
输入: PWM脉冲数
输出: 无
说明: 起步频率为400HZ，最高到2700HZ   
***************************************/
//以下变量用于步进电机运行控制
extern volatile _Bool Encoder_bz;
extern volatile u16 Encoder_count;/*编码器计数*/
volatile u16 timerlow[15]={20000,17500,16000,14500,13200,
12200,11300,10600,9900,9300,8900,8400,8000,7580,7300};
									//起步频率为400HZ  1.5
									//起步频率为400HZ，最高到2700HZ
static u16 stop_arr[52] = {
    //0,23,54,77,100,122,154,177,200,223,254,277,300,322,354,377,
    0,7,14,21,28,35,42,49,56,63,70,77,84,
	100,107,114,121,128,135,142,149,156,163,170,177,184,
	200,207,214,221,228,235,242,249,256,263,270,277,284,
	300,307,314,321,328,335,342,349,356,363,370,377,384
};
																		
u8 _Servo_C(u8 Dr_Num,u8 *Dr_Num_Save)//伺服电机控制
{
	
//	Encoder_count = 0;/*重新开始计数*/
//	if(Dr_Num == 0) return 0; //如果出现抽屉编号为0
 //	if(Dr_Num > 76) return 0; //大于76，则返回
 //	if(Dr_Num > 65) Dr_Num=Dr_Num+4;  
/*抽屉间隔算法，将抽屉的自然编码转换为步进函数可以接收的位置编码*/
// 	else if(Dr_Num > 46) Dr_Num=Dr_Num+3;
// 	else if(Dr_Num > 27) Dr_Num=Dr_Num+2;
// 	else if(Dr_Num > 8) Dr_Num=Dr_Num+1;
//	if(Dr_Num < *Dr_Num_Save)
//	{
//		if((*Dr_Num_Save-Dr_Num) <= (Total_Circle/2))
//		{
//			moto_dr = 1;/*改变方向*/
//			result_move = *Dr_Num_Save-Dr_Num;
//			*Dr_Num_Save=Dr_Num;
//		}
//		else
//		{
//			moto_dr = 0;/*改变方向*/
//			result_move=Total_Circle+Dr_Num-*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//	}
//	else if(Dr_Num>=*Dr_Num_Save)
//	{
//		if((Dr_Num-*Dr_Num_Save)<=(Total_Circle /2))
//		{
//			moto_dr = 0;/*改变方向*/
//			result_move=Dr_Num-*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//		else if((Dr_Num-*Dr_Num_Save)>(Total_Circle /2))
//		{
//			moto_dr = 1;/*改变方向*/
//			result_move=Total_Circle-Dr_Num+*Dr_Num_Save;
//			*Dr_Num_Save=Dr_Num;
//		}
//	}
//	WDT();//清看门狗
	//if(result_move == 0) return 0;
 	//steps = result_move* Average_Pulse *2;
	
	u16 angle = 0;//save Reaches the required angular position
    u16 result_move = 0;//需要旋转的角度值
	angle = stop_arr[tar_pos-1];
	if(cabinet_angle < angle)
	{
		if((angle-cabinet_angle) <= (Total_Circle/2))
		{
			moto_dr = 1;/*改变方向*/
			result_move = angle-cabinet_angle;
		}
		else
		{
			moto_dr = 0;/*改变方向*/
			result_move=Total_Circle+cabinet_angle-angle;
		}
	}
	
	else if(cabinet_angle>=angle)
	{
		if((cabinet_angle-angle)<=(Total_Circle /2))
		{
			moto_dr = 0;/*改变方向*/
			result_move=cabinet_angle-angle;
		}
		else if((cabinet_angle-angle)>(Total_Circle /2))
		{
			moto_dr = 1;/*改变方向*/
			result_move=Total_Circle-cabinet_angle+angle;
		}
	} 
	steps = result_move* Average_Pulse *2;
	
	//if(result_move == 0) return 0;
	if(steps == 0) return 0;

	
	
 	steps_half = steps/2;  
 	n_max = 14;               //最高运行速度档位设置，可独立修改  
 	ksteps_inc = 20;          //根据运行质量进行修改这两个参数
 	ksteps_save = 10;  
 	steps_count = 0;
 	steps_count2 = 0; 
 	up_or_down = 1;
 	half_over = 0; 
 	moto_hz = 0;
	Encoder_bz = 1;/*开启编码器*/	
 	TIM3_ARRH=timerlow[0]>>8;           
 	TIM3_ARRL=timerlow[0];	 //246
	TIM3_CR1 = 0X01; 
 	for(k=0;(half_over==0)&&(k<=n_max);k+=1)   
	{     
		ksteps_save=ksteps_save+ksteps_inc;
		ksteps=ksteps_save;     
		while(ksteps>0);  //加速阶段  
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
		ksteps=ksteps_save;	//减速阶段
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
	WDT();//清看门狗
	Encoder_bz = 0;/*开启编码器*/	
	/*保存需要旋转的位置*/
	//*Dr_Num_Save = Dr_Num;
	//Eeprom_Write(10,*Dr_Num_Save/10);
	//Eeprom_Write(11,*Dr_Num_Save%10);
	
	cabinet_angle = angle;
	EepromWrite(10,cabinet_angle);
	EepromWrite(11,cabinet_angle<<8);
	return result_move;
}
