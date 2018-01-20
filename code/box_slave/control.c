/***********************************************************
* 文档: control.c
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#include "main.h"

#define sleep 200
#define sleep_count 50

/*地址IO口定义*/
#define adr_1 PC_IDR_IDR2	
#define adr_2 PC_IDR_IDR5
#define adr_3 PD_IDR_IDR0	
#define adr_4 PD_IDR_IDR2
#define adr_5 PD_IDR_IDR3	
#define adr_6 PD_IDR_IDR4
#define adr_7 PC_IDR_IDR7	
#define adr_8 PC_IDR_IDR6
#define adr_9 PC_IDR_IDR4	
#define adr_10 PC_IDR_IDR3	

/*输入信号IO口定义*/
#define en_seat		PA_ODR_ODR1
#define back_seat       PE_IDR_IDR5/*回来限位*/
#define out_seat	PB_IDR_IDR0/*出去限位*/

#define moto_step PA_ODR_ODR3
#define moto_dir  PB_ODR_ODR6
#define moto_en PB_DDR |= BIT(2);PB_CR1 |= BIT(2);PB_ODR_ODR2 = 0;
/*指示LED IO口定义*/
//#define os 		PB_ODR_ODR4
//#define c_led	PA_ODR_ODR3
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
        for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
        WDT();//清看门狗
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
    
    PB_DDR |= BIT(2);
    PB_CR1 |= BIT(2);
    PB_CR2 &= ~BIT(2);
    PB_ODR_ODR2 = 0;
    
    PB_DDR |= BIT(6);
    PB_CR1 |= BIT(6); 
    PB_CR2 |= BIT(6);
    
    PA_ODR_ODR3 = 1;
    PF_ODR_ODR4 = 1;
    PB_ODR_ODR3 = 0;
    PB_ODR_ODR7 = 1;
    PB_ODR_ODR6 = 1;	
    
    /***读从机地址_PC2 PC1 PE5 PB0 PB1 PB2 PB3 PB6 PB7 PF4****/
    PC_DDR &= ~BIT(2);
    PC_CR1 |= BIT(2); 
    PC_CR2 &= ~BIT(2);
    
    PC_DDR &= ~BIT(5);
    PC_CR1 |= BIT(5); 
    PC_CR2 &= ~BIT(5);
    
    PD_DDR &= ~BIT(0);
    PD_CR1 |= BIT(0); 
    PD_CR2 &= ~BIT(0);
    
    PD_DDR &= ~BIT(2);
    PD_CR1 |= BIT(2); 
    PD_CR2 &= ~BIT(2);
    
    PD_DDR &= ~BIT(3);
    PD_CR1 |= BIT(3); 
    PD_CR2 &= ~BIT(3);
    
    PD_DDR &= ~BIT(4);
    PD_CR1 |= BIT(4); 
    PD_CR2 &= ~BIT(4);
    
    PC_DDR &= ~BIT(7);
    PC_CR1 |= BIT(7); 
    PC_CR2 &= ~BIT(7);
    
    PC_DDR &= ~BIT(6);
    PC_CR1 |= BIT(6); 
    PC_CR2 &= ~BIT(6);
    
    PC_DDR &= ~BIT(4);
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    PC_DDR &= ~BIT(3);
    PC_CR1 |= BIT(3); 
    PC_CR2 &= ~BIT(3);
    
    
    /***出到位_PC5****/
    PE_DDR &= ~BIT(5);
    PE_CR1 |= BIT(5); 
    PE_CR2 &= ~BIT(5);
    /***入到位_PC6****/
    PB_DDR &= ~BIT(0);
    PB_CR1 |= BIT(0); 
    PB_CR2 &= ~BIT(0);
    
    PA_DDR |= BIT(1);
    PA_CR1 |= BIT(1); 
    PA_CR2 |= BIT(1);
    
    
    /***通讯指示灯PA3****/
    PC_DDR |= BIT(1);
    PC_CR1 |= BIT(1); 
    PC_CR2 |= BIT(1);
    
    
    /***照明灯****/
    PB_DDR |= BIT(1);
    PB_CR1 |= BIT(1); 
    PB_CR2 |= BIT(1);
    PB_ODR_ODR1 = 0;
    
    //定时器1设置，产生1ms一次的中断
    /*TIM1_PSCRH = 0X1F;
    TIM1_PSCRL = 0X3F;
    TIM1_ARRH = 0X00;
    TIM1_ARRL = 0X01;
    TIM1_IER = 0X01;
    TIM1_CR1 = 0X01;
    //PWM初始化
    TIM2_IER = 0x00;        // PWM中断主要在这里进行调整
    TIM2_CCMR3 = 0b01111000;  //pwm模式2
    TIM2_CCER2 = 1;  //CC3引脚使能
    TIM2_PSCR = 0x04;         //8^1 分频为1M 
    TIM2_ARRH = 0x01;
    TIM2_ARRL = 0xf3;        //每500us中断一次1F4-2k,100-10k
    TIM2_CCR3H = 0x00;
    TIM2_CCR3L = 0xf8;        //设置占空比，即计数器到多少后
    TIM2_CR1 |= BIT(0);              //计数器使能，开始计数
    */
    //r_enable = 1;/*关闭机械手*/
    //os = 1;
    /*设置看门狗*/
    IWDG_KR = 0xCC;       //启动看门狗
    IWDG_KR = 0x55;       //解除写保护
    IWDG_PR = 0x06;       //256分频，最高1.02秒
    IWDG_RLR = 255;       //1020ms
    IWDG_KR = 0xAA;       //写保护
    WDT();//清看门狗
    en_seat = 1;
}
/***************************************
函数: Addr_Read
功能: 读取设备地址
输入: 地址保存变量地址
输出: 无
说明: 讲地址值 赋值给传入变量
***************************************/
u16 moto_sleep = 0;
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
    
    u16 moto_sleep_count = 0;
    u16 best_setp = 0;
    
    u8 flag = 0;
    
    PB_DDR &= ~BIT(2);
    PB_CR1 &= ~BIT(2); 
    PB_CR2 &= ~BIT(2);
    
    moto_sleep = 1000;
    WDT();//清看门狗
    en_seat = 1;
    delayms(10);
    if(mode == 0) {
        if(back_seat == 1) {
            moto_en
            return 0x01;
        }
         moto_dir = 0;
    } else {
        if(out_seat == 1) {
            moto_en
            return 0x01;
        }
         moto_dir = 1;
    }
       
    while(moto_flag < 600) {
        if(moto_sleep_count < moto_sleep) {
            moto_sleep_count++;
        } else {
            static u8 dr = 0;
            moto_sleep_count = 0;
            if(dr == 0) {
                dr = 1;
                moto_step = 0;
            } else {
                dr = 0;
                moto_step = 1;
            }
            if(best_setp < 1800) {
                best_setp++;
            } else {
                moto_en
                    return 0x02;
            }
        }
        WDT();//清看门狗
        if(moto_flag_count < sleep_count) {
            moto_flag_count++;	
        } else {
            moto_flag_count = 0;
            if(moto_sleep > sleep) {
                moto_sleep--;
            }
            if(mode == 0) {
                flag = back_seat;
            } else {
                flag = out_seat;
            }
            if(flag == 1){
                if(moto_flag < 100) {
                    moto_flag++;
                } else {
                    moto_en
                        return 0x01;
                }
            } else {
                moto_flag = 0;
            }
        }
    }
    en_seat = 0;
    moto_en
    return 0x02;
}

void SetLed(u8 cmd) {
    PB_ODR_ODR1 = cmd;
}

#pragma vector=0xD
__interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void)
{
    TIM1_SR1 &= (~0x01);        //清除中断标志
    //    T1msFlg++;
    //    T2msFlg++;
    return;
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
                        /*99999为上限*/
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


