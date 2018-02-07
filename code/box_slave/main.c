/***
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
u8 R_RsBuffer[R_MaxNumberofCom];//���ڻ�����
u8 R_TsBuffer[R_MaxNumberofCom];
_Bool c_ok_Flag = 0;/*����������ɱ�־λ*/
u8 com_i = 0;/*�����������*/
u16 addre = 0x01;/*��ַ*/
u8 com_Flag = 0;/*���ڿ�ʼ���ܱ�־λ*/
u8 r_Flag = 0;/*��е�ֳɹ�������־λ*/
u8 r_num = 0;/*�����е��״̬*/
u16 T1msFlg = 0;/*��ʱ���ۼӼ���*/
u16 T2msFlg = 0;/*��ʱ���ۼӼ���*/
u8 run_Falg = 0;/*����״̬��־*/
u16 Duty_Val = 0;/*�����ƺ���ֵ*/
u8 TS_count = 0;/**/

#define rs485_dr1 PD_ODR_ODR7
#define back_seat PE_IDR_IDR5/*������λ*/
#define out_seat  PB_IDR_IDR0/*��ȥ��λ*/

/**********************************************************/
/* MAIN������                                             */
/**********************************************************/
int main(void)
{
    //delayms(1000);
    CLK_CKDIVR=0x00;//ʱ��Ԥ��Ƶ��Ĭ��8���䣬0x18.16M-0x00��8M-0x08;4M-0x10;
    BSP_Init();/*����ʼ��*/
    Eeprom_Init();/*����EEPROM*/
    UART1_Init();/*��ʼ��USART1*/
    Addr_Read(&addre);/*��ȡ��ַ*/
    asm("rim");//���жϣ�simΪ���ж�
    //robot_mode(0);
    SetLed(0);
    while (1) {
        static u16 count = 0;
        if(count > 600) {
            count++;
        } else {
            static u8 dr = 0;
            count = 0;
            if(dr == 0) {
                dr = 1;
                //SetLed(0);
                PC_ODR_ODR1 = 0;
            } else {
                dr = 0;
               // SetLed(1);
                PC_ODR_ODR1 = 1;
            }
        }
        /*���ڷ���*/
        if(c_ok_Flag == 1) {
            r_Flag = 0;
            if(R_RsBuffer[6] == c_last) {
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
                        r_Flag = 1;/*��е�ֳɹ���ȥ�������������ƻ���*/
                        TS_count = 0;
                        delayms(20);
                        // robot_mode(0);
                    }
                    else if(r_num == 2)
                    {
                        UART1_Send(R_TsBuffer,0x03,addre);
                        r_Flag = 1;/*��е�ֳɹ���ȥ�������������ƻ���*/
                        TS_count = 0;
                        delayms(20);
                        //robot_mode(0);
                    }
                    eeprom_count(2);
                    break;
                    case Drawer_out_place:/*��е�ֳ�ȥ�Ƿ�λ*/
                        if(out_seat == 1) {
                            UART1_Send(R_TsBuffer,0x01,addre);
                        } else {
                            UART1_Send(R_TsBuffer,0x03,addre);
                        }
                    break;
                    case Drawer_back:/*��е�ֻ���*/
                        r_Flag = 0;
                        r_num = robot_mode(0);
                        if(r_num==0)
                        {
                            UART1_Send(R_TsBuffer,0x01,addre);
                            delayms(20);
                            //UART1_Send(R_TsBuffer,0x01,addre);
                            r_Flag = 0;
                        }
                        else if(r_num==1)
                        {
                            UART1_Send(R_TsBuffer,0x02,addre);
                            r_Flag = 0;
                        }
                        else if(r_num == 2)
                        {
                            UART1_Send(R_TsBuffer,0x03,addre);
                            r_Flag = 0;
                            delayms(500);
                            robot_mode(1);
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
                            UART1_Send(R_TsBuffer,0x03,addre);
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
                            UART1_Send(R_TsBuffer,OPEN_LOGIHT,addre);
                        } else {
                            SetLed(1);
                            UART1_Send(R_TsBuffer,OPEN_LOGIHT,addre);
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
˵��: ����1�����жϺ���
***************************************/
u8 fs_i = 0;
u8 fs_ok = 0;
#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void)
{
    asm("sim");//���жϣ�simΪ���ж�
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
    asm("rim");//���жϣ�simΪ���ж�
    return;
}

unsigned char ch;
#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void) {
    
    ch=UART1_DR;
    /*�ȴ����ݽ������*/
    while((UART1_SR & 0x80) == 0x00);
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