/***********************************************************
* �ĵ�: control.c
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#include "type.h"

/*��������*/
#define adr_4 PC_IDR_IDR7	
#define adr_3 PG_IDR_IDR0
#define adr_2 PG_IDR_IDR1	
#define adr_1 PE_IDR_IDR3
/*�����赲���IO�ڶ���*/
#define pla_0 PB_IDR_IDR7
#define pla_1 PB_IDR_IDR6
#define pla_2 PB_IDR_IDR5
#define pla_3 PB_IDR_IDR4
#define pla_4 PB_IDR_IDR3
#define pla_5 PB_IDR_IDR2
#define pla_6 PB_IDR_IDR1
#define pla_7 PB_IDR_IDR0
#define pla_8 PE_IDR_IDR7
#define pla_9 PE_IDR_IDR6
#define pla_dc PA_ODR_ODR2
#define pla_dc_jc PC_ODR_ODR2
/**/
#define b_sar PC_IDR_IDR3 /*����*/
#define moto_dr PD_ODR_ODR2      /*�������*/
#define moto_hz PA_ODR_ODR3 /*����ٶ�*/
#define buzzer PA_ODR_ODR1/*������*/

#define but_led PD_ODR_ODR3/*ledָʾ��*/

u8 k; 
u8 up_or_down;           
u8 half_over; 
u8 direction;  
u8 n_max;
u16 ksteps;       
u16 ksteps_inc; 
u16 ksteps_save;
u32 steps; 
u32 steps_half; 
u32 steps_count;  
u32 steps_count2;  
u32 steps_keep_count;
u32 result_move;      //������������ת��
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


/*
*time delay use count 
*Execution time: one ms
*Note:blocking program,imprecise
*/
void DelayMs(u16 ms)	
{						
    u16 i;
    while(ms--)
    {
        for(i=0;i<1125;i++);//2M crystal cycle 1us, i = 140; just 1ms, when 16M, i = 1125
    }
}
/*
*time delay use count 
*Execution time: one ms
*Note:blocking program,imprecise
*/
void DelayUs(u16 us) 	
{	
    while(us--);
}


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
    TIM3_ARRL = 0X01;//0x01
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
    
    pla_dc_jc = 1;
    pla_dc = 0;
    buzzer = 0;/*�رշ�����*/
    but_led = 1;/*�ر�led*/
    
    cabinet_angle = Eeprom_Read(11);
    cabinet_angle |= (Eeprom_Read(12)>>8);
    
    asm("rim");//���жϣ�simΪ���ж�
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
    u16 place = 0;/*�ȶ���������*/
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
    
    if( (check_1 == place[11])&&(check_2 == place[12])&&(place[13] == 0x0a) )
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
    u16 zero_setp = 500;
    //u16 stepes = 0;
    //u16 stepes_2 = 0;
    u16 time_count = 0;
    u16 time_speed_count = 0;
    u16 duozou = 0;
    u16 run_setp = 3000;//��ʼ�ܵ�����
    moto_dr = 0;/*�ı䷽��*/
    if(b_sar == 0)//������λ
    {
        cheack_save ++;//������λ
        while(b_sar == 0)
        {
            WDT();//�忴�Ź�
            if(time_count < run_setp) {
                time_count++;
            } else {
                time_count = 0;
                moto_hz = !moto_hz;
            }
            if(time_speed_count < 120) {
                time_speed_count++;
            } else {
                time_speed_count = 0;
                if(run_setp > 500) {
                    run_setp--;
                }
            }
        }
    }
    else//����λ
    {
        //stepes = 200;
        run_setp = 4000;
    }
    WDT();//�忴�Ź�
    while(run_setp < 5000)//����λ
    {
        static u16 de_bit = 0;
        WDT();//�忴�Ź�
        if(time_count < run_setp) {
            time_count++;
        } else {
            time_count = 0;
            moto_hz = !moto_hz;
        }
        if(time_speed_count < zero_setp) {
            time_speed_count++;
        } else {
            time_speed_count = 0;
            if(run_setp > 1000) {
                zero_setp = 350;
            }
            if(run_setp == 5900) {
                if(de_bit < 100) {
                    de_bit++;
                } else {
                    run_setp = 6001;
                }
            } else {
                run_setp++;
            }
        }
    }
    while(duozou < 500)
    {
        if(time_count < 5000) {
            time_count++;
        } else {
            time_count = 0;
            moto_hz = !moto_hz;
        }
        duozou++;
        WDT();//�忴�Ź�
    }
    DelayMs(1000);
    WDT();//�忴�Ź�
    moto_dr = 1;/*�ı䷽��*/
    while(b_sar == 0)
    {
        cheack_save ++;//������λ
        if(time_count < 5000) {
            time_count++;
        } else {
            time_count = 0;
            moto_hz = !moto_hz;
        }
        WDT();//�忴�Ź�
    }
    duozou = 0;
    while(duozou < 50)
    {
        if(time_count < 5000) {
            time_count++;
        } else {
            time_count = 0;
            moto_hz = !moto_hz;
        }
        duozou++;
        WDT();//�忴�Ź�
    }
    cabinet_angle = 0;
    Eeprom_Write(11,cabinet_angle);
    Eeprom_Write(12,cabinet_angle<<8);
    if(cheack_save > 0)
    {
        return 0X21;
    }
    else
    {
        return 0X22;//�����д���
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
extern  _Bool Encoder_bz;
extern  u16 Encoder_count;/*����������*/
//const u16 timerlow[15]={20000,17500,16000,14500,13200,
//12200,11300,10600,9900,9300,8900,8400,8000,7580,7300};
//volatile const u16 timerlow[40]={
//    60000,58000,56000,54000,52000,50000,48000,46000,44000,42000,
//    40000,38000,36000,34000,24000,23000,22000,21000,19000,17500,
//    16000,15000,14000,13000,11500,10500,9500,8500,7900,7400,
//    6800,6200,5900,5700,5600,5500,5300,5200,5100,5000,
//};
volatile const u16 timerlow[40]={
    65000,58000,56000,54000,52000,50000,48000,46000,44000,42000,
    40000,38000,36000,34000,24000,23000,22000,21000,19000,17500,
    16000,15000,15000,15000,15000,15000,15000,15000,15000,15000,
    15000,15000,15000,15000,15000,15000,15000,15000,15000,15000,
};
//��Ƶ��Ϊ400HZ  1.5
//��Ƶ��Ϊ400HZ����ߵ�2700HZ
static const u16 stop_arr[52] = {
    //0,23,54,77,100,122,154,177,200,223,254,277,300,322,354,377,
    0,7,14,21,28,35,42,49,56,63,70,77,84,
    100,107,114,121,128,135,142,149,156,163,170,177,184,
    200,207,214,221,228,235,242,249,256,263,270,277,284,
    300,307,314,321,328,335,342,349,356,363,370,377,384
};

u8 _Servo_C(u8 Dr_Num,u8 *Dr_Num_Save)//�ŷ��������
{
    u16 angle = 0;//save Reaches the required angular position
    u16 result_move = 0;//��Ҫ��ת�ĽǶ�ֵ
    u8 tar_pos = Dr_Num;
    angle = stop_arr[tar_pos-1];
    WDT();//�忴�Ź�
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
    Encoder_count = 0;//clear
    
    n_max = 38;               //��������ٶȵ�λ���ã��ɶ����޸�  
    ksteps_inc = 3;          //�����������������޸����������� 20
    ksteps_save = 2;        //10
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
    WDT();//�忴�Ź�
    Encoder_bz = 0;/*����������*/	
    /*������Ҫ��ת��λ��*/
    cabinet_angle = angle;
    Eeprom_Write(11,cabinet_angle);
    Eeprom_Write(12,cabinet_angle<<8);
    return result_move;
}

#pragma vector=0x11
__interrupt void TIM3_UPD_OVF_BRK_IRQHandler(void)
{
    asm("sim");//���жϣ�simΪ���ж�
    TIM3_SR1 &= (~0x01);        //����жϱ�־
    
    TIM3_ARRH=timerlow[k]>>8;           
    TIM3_ARRL=timerlow[k];	 //246
    WDT();//�忴�Ź�
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
        if(steps_count>=steps) 
        {
            ksteps=0;
        }
        moto_hz = !moto_hz;
    }
    asm("rim");//���жϣ�simΪ���ж�
}
