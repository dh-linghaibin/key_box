/** ����: ����STM8��Ƭ���Ļص������-��
* ����: STVD MainFrame Version 3.6.5.2 CXSTM8
* ����: 2015-1-30 09:57:14
* ����: NULL
* �汾: 1.0
***********************************************************/
/***********************************************************
* �ĵ�: main.c
* ����: Haibin Ling
* ����: 1���ڽ��ռ��
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
/* �����������                                           */
/**********************************************************/
extern const u8 jm_a[1024];/*��������*/
/*����ͨ�Ų㺯��*/
u8 RsBuffer[MaxNumberofCom];//���ڻ�����
u8 TsBuffer[MaxNumberofCom];
u8 R_RsBuffer[R_MaxNumberofCom];//�ӻ����ڻ�����
u8 R_TsBuffer[R_MaxNumberofCom];
_Bool c_ok_Flag = 0;/*����������ɱ�־λ3*/
_Bool but_Flag = 0;/*��ť�Ƿ��±�־λ*/
u8 rebot_dr = 0;/*��е�ֳ������ȥ1 ����*/
u8 com_i = 0;/*�����������3*/
u8 addre = 0x01;/*��ַ*/
u8 com_Flag = 0;/*����3��ʼ���ܱ�־λ*/
u8 Rc_ok_Flag = 0;/*����������ɱ�־λ1*/
u8 Rcom_i = 0;/*�����������1*/
u8 Rcom_Flag = 0;/*����1��ʼ���ܱ�־λ*/
u8 SDr_Num_Save;/*����ѡ�ڹ���λ��*/
u8 rb_Flag = 0;/*��е������״̬��־λ*/
u8 wr_new = 0;/*����ص����*/
u8 Dr_Num_Save = 0;/*������תλ��*/
u8 fr_Flag = 0;/*�ص�����־λ*/
u8 bu_Flag = 0;/*��ťʹ�ܱ�־λ*/
u8 mirro = 0;/*�Զ�������־*/
u8 Encoder = 0;/*�����Ƿ�ʹ�ñ�����*/
u8 place_sava = 0;/*�����е��λ�����*/
u16 Shield = 0;/*�����������*/
u8 S_buf[10] = {1,1,1,1,1,1,1,1,1,1};/*�����������*/

u8 cmd_last = 0;//last cmd ��һ�η��͵���ʲô����
u8 cmd_ok_flag = 0;//cmd is ok ? ��һ��ִ�н��

_Bool Encoder_bz = 0;/*��������־λ*/
_Bool dis_play = 0;/*��ʾ*/
extern  u8 hd_num;/*�ص�*/
u16 Encoder_count = 0;/*����������*/
_Bool jxs_out = 0;//��е��״̬��־
u8 jxs_out_num = 0;//��е�ֳ�ȥλ��
//0������
//1����ȥ
extern u8 cheak_wait;//�ط��ȴ�ʱ��

u16 cheak_wait_count = 0;//�ط��ȴ�ʱ��
static u8 led_ask = 0;

static u8 zs_falag = 0;//��������������
static u8 an_huqu = 0;//���ڰ�ť���µ��µĻ�ȥ�ı�־λ

void DelayMs(u16 ms);

extern u16 cheak_wait_2;

/*ʱ���־λ*/
u16 T1msFlg;
u16 T2msFlg;

/*���Զ�����*/
#define rs485_dr1 PA_ODR_ODR6
#define rs485_dr2 PD_ODR_ODR7

#define but_led PD_ODR_ODR3/*ledָʾ��*/
#define but_sw PD_IDR_IDR4/*���ְ�ť*/

#define bu_Encoder PC_IDR_IDR4 /*�����������*/

#define ts_up PE_IDR_IDR0
#define ts_next PE_IDR_IDR1
#define ts_ok PE_IDR_IDR2
#define ts_page PD_IDR_IDR0
#define pla_dc_jc PC_ODR_ODR2

page_num page_n;/*�˵��ṹ��*/

/**********************************************************/
/* MAIN������                                             */
/**********************************************************/
int main(void)
{
    BSP_Init();
    UART1_Init();
    UART3_Init();
    Eeprom_Init();/*eeprom����*/
    LCD12864_Init();//12864��ʼ��
    Draw_PM(jm_a);
    delayms(1000);
    LCD_Clear_BMP();
    Addr_Read(&addre);
    /*��ȡ�������תλ��*/
    // Dr_Num_Save += Eeprom_Read(10)*10;
    // Dr_Num_Save += Eeprom_Read(11);
    Encoder = Eeprom_Read(5);
    
    page_n.dr_num = 1;
    page_n.rb_num = 1;
    Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
    while (1)
    {
        WDT();//�忴�Ź�
        /*��ҳ*/
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
        /*�Ӱ���*/
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
                        if(page_n.dr_num < 52)
                        {
                            page_n.dr_num ++;
                        } else {
                            page_n.dr_num = 1;
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
        /*������*/
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
                        } else {
                            page_n.dr_num = 52;
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
        /*OK����*/
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
                if(page_n.page == 5)/*�ڲ�����*/
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
                        if(page_n.ins_row == 1)/*��ת*/
                        {
                            _Servo_C(page_n.dr_num,&Dr_Num_Save);/*��ת*/
                        }
                        else if(page_n.ins_row == 2)/*��е�ֳ�ȥ*/
                        {
                            UART1_Send(R_TsBuffer,Drawer_out,page_n.rb_num);
                        }
                        else if(page_n.ins_row == 3)/*��е�ֻ���*/
                        {
                            UART1_Send(R_TsBuffer,Drawer_back,page_n.rb_num);
                        }
                        else if(page_n.ins_row == 4)/*����*/
                        {
                            Back_Zero(&Dr_Num_Save);
                        }
                        page_n.ins_row = 0;
                    }
                }
                if(page_n.page == 4)/*����*/
                {
                    if(Encoder == 0)/*���ر�����*/
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
        //��ⰴť�Ƿ���
        if(jxs_out == 1)
        {
            if(bu_Flag == 1)
            {
                if(but_sw == 0)//��ť������
                {
                    but_Flag = 1;//��ť����
                    
                    RsBuffer[1] = jxs_out_num;
                    cheak_wait_2 = 400;//���ټ��
                    Menu_Host(Drawer_back,addre,RsBuffer,
                              Dr_Num_Save,&page_n);/*��ʾ*/
                    R_TsBuffer[1] = rebot_dr;
                    rb_Flag = 1;/*��ʼ��״̬��־λ*/
                    
                    zs_falag = 1;
                    an_huqu = 1;

                    if(Drawer_cont_ls(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                      RsBuffer,Drawer_back,&Rc_ok_Flag) == 0) {
                                          mirro = 0;
                                          rebot_dr = 0;
                                          PD_ODR_ODR3 = 1;/*�ر�led*/
                                          jxs_out = 0;//��е�ֻ���
                                          but_Flag = 0;//�����ť����
                                          zs_falag = 0;
                                      }
                }
            }
        }
        /*���ڽ��յ�����*/
        if(c_ok_Flag == 1)
        {
            u8 abs_num = 0;
            u8 i_count = 0;/*��ѯ��*/
            u8 place_sta = 0;/*λ��ͳ�Ʊ���*/
            
            UART_interrupt(1,0);/*�رմ���1�ж�*/
            
            if(Com_Check(RsBuffer,addre))/*У���ж�*/
            {
                /*����У��ɹ�*/
                UART3_Send(TsBuffer,CORRECT,ok);
                //delayms(10);//�޸ĵ���������
                WDT();//�忴�Ź�
               
                c_ok_Flag = 0;/*������ɣ���ʼ������һ������*/
                UART_interrupt(1,1);/*ʹ�ܴ���1�ж�*/
                
                /*��ʼִ������*/
                switch(RsBuffer[0])/*�ж�����*/
                {
                    
                    /*����赲*/
                    case Detection_barrier:
                    pla_dc_jc = 1;
                    delayms(1000);
                    Menu_Host(Detection_barrier,addre,RsBuffer,
                              Dr_Num_Save,&page_n);/*��ʾ*/
                    Shield_sava(RsBuffer);
                    if(Bar_Read(TsBuffer))/*����赲*/
                    {
                        /*���赲*/
                        UART3_Send(TsBuffer,Detection_barrier,ok);
                        Menu_Host(Detection_barrier,0,
                                  RsBuffer,0,&page_n);/*��ʾ*/
                    }
                    else
                    {
                        /*���赲���������赲ֵ*/
                        UART3_Send(TsBuffer,Detection_barrier,no);
                        Menu_Host(Detection_barrier,hd_num,
                                  RsBuffer,1,&page_n);/*��ʾ*/
                    }
                    pla_dc_jc = 0;
                    break;
                    /*����е���Ƿ����*/
                    case rawer_back_sta:
                    Shield_sava(RsBuffer);
                    cheak_wait = 40;//���ټ��
                    place_sta = 0;
                    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
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
                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
                    if(place_sta == 0)
                    {
                        UART3_Send(TsBuffer,rawer_back_sta,ok);
                    }
                    else
                    {
                        UART3_Send(TsBuffer,rawer_back_sta,no);
                    }
                    break;
                    /*�������*/
                    case Reboot:
                    /*����������������*/
                    UART3_Send(TsBuffer,Reboot,ok);
                    break;
                    /*����*/
                    case Back_zero:
                        WDT();//�忴�Ź�
                        cmd_last = Back_zero;//��¼����
                        zs_falag = 1;
                        if(Back_Zero(&Dr_Num_Save) == 0X21)
                        {
                        	cmd_ok_flag = ok;
                            //UART3_Send(TsBuffer,Back_zero,ok);
                        }
                        else
                        {
                        	cmd_ok_flag = no;//��¼����״̬
                            //����ʧ��
                            //UART3_Send(TsBuffer,Back_zero,no);
                        }
                         zs_falag = 0; 
                        Menu_Host(Back_zero,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*��ʾ*/
                    break;
                    /*��תλ��*/
                    case Motor_rotation:
                        WDT();//�忴�Ź�
                        zs_falag = 1;
                        cmd_last = Motor_rotation;//��¼��ת����
                        abs_num = _Servo_C(RsBuffer[1],&Dr_Num_Save);/*��ת*/
                        if(Encoder == 0)/*����������*/	
                        {
                            if(abs_num > 0)
                            {
                                if ( abs(abs(Encoder_count/abs_num)-Encoder_hz) > 30  )
                                {
                                	cmd_ok_flag = no;//��ת����
                                    //UART3_Send(TsBuffer,Motor_rotation,no);/*������*/
                                    Menu_Host(3,addre,RsBuffer,
                                              156,&page_n);/*��ʾ*/
                                }
                                else
                                {
                                	cmd_ok_flag = ok;		
                                    //UART3_Send(TsBuffer,Motor_rotation,ok);/*������*/
                                }
                            }
                            else
                            {
                            	cmd_ok_flag = ok;
                                //UART3_Send(TsBuffer,Motor_rotation,ok);/*������*/
                            }
                        }
                        else
                        {
                        	cmd_ok_flag = ok;//��ת����
                            //UART3_Send(TsBuffer,Motor_rotation,ok);/*������*/
                        }
                        zs_falag = 0;
                        Menu_Host(Motor_rotation,addre,RsBuffer,Dr_Num_Save,&page_n);/*��ʾ*/
                    break;
                    /*�ж�����ص�*/
                    case Whether_receipt:
                    
                    break;
                    /*��ťʹ��*/
                    case Button_enabled:
                        bu_Flag = 1;/*ʹ�ܰ�ť*/
                        UART3_Send(TsBuffer,Button_enabled,ok);
                    break;
                    /*��ť��ʹ��*/
                    case Button_not_enabled:
                        bu_Flag = 0;/*��ʹ�ܰ�ť*/
                        UART3_Send(TsBuffer,Button_not_enabled,ok);
                    break;
                    /*��ť�Ƿ���*/
                    case Button_detection:
                        if(but_Flag == 0)
                        {
                            /*��ťδ����*/
                            UART3_Send(TsBuffer,Button_detection,no);
                        }
                        else
                        {
                            /*��ť����*/
                            UART3_Send(TsBuffer,Button_detection,ok);
                        }
                    break;
                    /*��е�ֳ�ȥ*/
                    case Drawer_out:
                        an_huqu = 0;//������������
                    
                        zs_falag = 1; 
                        cmd_last = Drawer_out;//�����¼
                        jxs_out_num = RsBuffer[1];
                        cheak_wait_2 = 400;//���ټ��
                        Menu_Host(Drawer_out,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*��ʾ*/
                        Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_out,&Rc_ok_Flag);
                        rebot_dr = RsBuffer[1];
                        eeprom_count(r_sive_n+((rebot_dr-1)*5));
                        bu_Flag = 1;
                        if(bu_Flag == 1)
                        {
                            PD_ODR_ODR3 = 0;/*��LED*/
                        }
                        zs_falag = 0;
                        jxs_out = 1;//��е�ֳ�ȥ
                    break;
                    /*��е�ֻ���*/
                    case Drawer_back:
                        //Drawer_back_1:
                         an_huqu = 0;//������������
                    
                        zs_falag = 1;
                        cmd_last = Drawer_back;//
                        cheak_wait_2 = 400;//���ټ��
                        Menu_Host(Drawer_back,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*��ʾ*/
                        R_TsBuffer[1] = rebot_dr;
                        rb_Flag = 1;/*��ʼ��״̬��־λ*/
                        //                    if(RsBuffer[2] == 0)//��һ�����ص�ʱ�������ص�ֵ ����ʧȥ�ص� 2015/7/32��  �躣��
                        //                    {
                        //                        hd_num = 0;/*����ص�״̬*/
                        //                        fr_Flag = 0;/*��ʼ���ص���־λ*/
                        //                    }
                        Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_back,&Rc_ok_Flag);									
                        mirro = 0;
                        rebot_dr = 0;
                        PD_ODR_ODR3 = 1;/*�ر�led*/
                        jxs_out = 0;//��е�ֻ���
                        but_Flag = 0;//�����ť����
                        zs_falag = 0;
                    break;
                    /*��е�ֳ�ȥ�Ƿ�λ*/
                    case Drawer_out_place:
                    cheak_wait_2 = 40;//���ټ��
                    
                    if(an_huqu == 0) {
                        Drawer_cont_ask(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_out_place,&Rc_ok_Flag);
                    } else {
                         UART3_Send(TsBuffer,Drawer_out_place,TRUE);
                    }
                    break;
                    /*��е�ֻ����Ƿ�λ*/
                    case Drawer_back_place:
                    cheak_wait_2 = 40;//���ټ��
                    Drawer_cont_ask(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,RsBuffer,Drawer_back_place,&Rc_ok_Flag);
                    break;
                    /*ѯ�ʻ�е��ʹ�ô���*/
                    case ask_count:
                    UART1_Send(R_TsBuffer,Check_num,RsBuffer[1]);
                    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
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
                    case 0x48://����
	                    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
	                    R_TsBuffer[2] = 0x01;
	                    Rc_ok_Flag = 0;
	                    led_ask = 0;
	                    while(Rc_ok_Flag == 0) {
	                        UART1_Send(R_TsBuffer,0x48,RsBuffer[1]);
	                        DelayMs(50);
	                        if(led_ask < 5) {
	                            led_ask++;
	                        } else {
	                            led_ask = 10;
	                            break;
	                        }
	                    }
	                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
	                    if(led_ask == 10) {
	                        UART3_Send(TsBuffer,0x48,no);
	                    } else {
	                        UART3_Send(TsBuffer,0x48,ok);
	                    }
                    break;
                    case 0x49://�ص�
	                    UART_interrupt(0,1);/*ʹ�ܴ���1�����ж�*/
	                    R_TsBuffer[2] = 0x00;
	                    Rc_ok_Flag = 0; 
	                    led_ask = 0;
	                    while(Rc_ok_Flag == 0) {
	                        UART1_Send(R_TsBuffer,0x48,RsBuffer[1]);
	                        DelayMs(50);
	                        if(led_ask < 5) {
	                            led_ask++;
	                        } else {
	                            led_ask = 10;
	                            break;
	                        }
	                    }
	                    UART_interrupt(0,0);/*�رմ���1�����ж�*/
	                    if(led_ask == 10) {
	                        UART3_Send(TsBuffer,0x49,no);
	                    } else {
	                        UART3_Send(TsBuffer,0x49,ok);
	                    }
                    break;
                    case Back_zero_ask:
                            if(cmd_last == Back_zero) {
                                    UART3_Send(TsBuffer,Back_zero_ask,cmd_ok_flag);
                            } else {
                                    UART3_Send(TsBuffer,Back_zero_ask,no);
                            }	
                    break;	
                    case Motor_rotation_ask:
                            if(cmd_last == Motor_rotation) {
                                    UART3_Send(TsBuffer,Motor_rotation_ask,cmd_ok_flag);
                            } else {
                                    UART3_Send(TsBuffer,Motor_rotation_ask,no);
                            }	
                    break;	
                    case Drawer_out_ask:
                            if(cmd_last == Drawer_out) {
                                    UART3_Send(TsBuffer,Drawer_out_ask,cmd_ok_flag);
                            } else {
                                    UART3_Send(TsBuffer,Drawer_out_ask,no);
                            }	
                    break;	
                    case Drawer_back_ask:
                            if(cmd_last == Drawer_back) {
                                    UART3_Send(TsBuffer,Drawer_back_ask,cmd_ok_flag);
                            } else {
                                    UART3_Send(TsBuffer,Drawer_back_ask,no);
                            }	
                    break;		
                    /*������Ч������*/
                    default:
                    break;
                }
            }
            else
            {
                UART3_Send(TsBuffer,ERROR,no);/*У�����*/
            }
            c_ok_Flag = 0;/*������ɣ���ʼ������һ������*/
            UART_interrupt(1,1);/*ʹ�ܴ���1�ж�*/
        }
        /*��ʱʱ��*/
        if(T1msFlg >= 400)
        {
            T1msFlg = 0;
            led_os = ~led_os;
        }
    }
}
/***************************************
˵��: TIM�жϺ�����1ms
***************************************/
#pragma vector=0xD
__interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void)
{
    TIM1_SR1 &= (~0x01);        //����жϱ�־
    T1msFlg++;
    T2msFlg++;
    if(Encoder_bz == 1)/*����������*/	
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
˵��: ����1�жϽ��պ���
***************************************/
u8 ua_count = 0;
#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void)
{
    u8 ch;
    ch=UART1_DR;
    /*�ȴ����ݽ������*/
    while((UART1_SR & 0x80) == 0x00);
    if( Rc_ok_Flag == 0 ) {
        if(Rcom_Flag == 0) {
            if(ch == c_head) {
                Rcom_Flag = 1;
                Rcom_i = 0;
            }
        } else if(Rcom_Flag == 1) {
            R_RsBuffer[Rcom_i] = ch;
            if(Rcom_i == 7) {
                if(R_RsBuffer[7] == 0x0a) {
                    Rc_ok_Flag = 1;
                } else {
                    Rc_ok_Flag = 0;
                }
                Rcom_i = 0;
                Rcom_Flag = 0;
                ua_count = 0;
            } else {
                Rcom_i++;
            }
        }
    }
    return;
}
/***************************************
˵��: ����3�жϽ��պ���
***************************************/
#pragma vector=0x17
__interrupt void UART3_RX_IRQHandler(void)
{
    u8 ch;
    asm("sim");//���жϣ�simΪ���ж�
    ch=UART3_DR;
    /*�ȴ����ݽ������*/
    while((UART3_SR & 0x80) == 0x00);
    if(c_ok_Flag == 0) {
        if(com_Flag == 0) {
            if(ch == c_head) {
                com_Flag = 1;
                com_i = 0;
            }
        } else if(com_Flag == 1) {
            if(addre == ch) {
                com_Flag = 2;
            } else {
                com_Flag = 0;
            }
        } else if(com_Flag == 2) {
            RsBuffer[com_i] = ch;
            if(com_i == 13) {
                if(RsBuffer[com_i] == 0x0a) {
                    if( zs_falag == 1) {//������������
                        //UART3_Send(TsBuffer,CORRECT,ok);
                        UART3_Send(TsBuffer,Back_zero,no);
                    } else {
                        c_ok_Flag = 1;
                    }
                } else {
                    c_ok_Flag = 0;
                }
                com_i = 0;
                com_Flag = 0;
            } else {
                com_i++;
            }
        }
    }
    asm("rim");//���жϣ�simΪ���ж�
    return;
}
/***************************************
˵��: ����1�����жϺ���
***************************************/
u8 ts1_count = 0;
u8 ts1_ok = 0;
#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void)
{
    asm("sim");//���жϣ�simΪ���ж�
    UART1_SR&= ~(1<<6);    //��������״̬λ
    UART1_DR =  R_TsBuffer[ts1_count];
    if(ts1_count < 8) {
        ts1_count++;
    } else {
        ts1_count = 0;
        rs485_dr1 = 0;
        UART1_CR2 &= ~BIT(6);//�����������?
        ts1_ok = 0;
    }
    asm("rim");//���жϣ�simΪ���ж�
    return;
}
/***************************************
˵��: ����3�����жϺ���
***************************************/
u8 ts3_count = 0;
u8 ts3_ok = 0;
#pragma vector=0x16
__interrupt void UART3_TX_IRQHandler(void)
{
    asm("sim");//���жϣ�simΪ���ж�
    UART3_SR&= ~(1<<6);    //��������״̬λ
    UART3_DR = TsBuffer[ts3_count];
    if(ts3_count < 15) {
        ts3_count++;
    } else {
        ts3_count = 0;
        rs485_dr2 = 0;
        UART3_CR2 &= ~BIT(6);//�����������?
        ts3_ok = 0;
    }
    asm("rim");//���жϣ�simΪ���ж�
    return;
}
/***************************************
˵��: PWM����ж�
***************************************/
#pragma vector=0xF
__interrupt void TIM2_UPD_OVF_BRK_IRQHandler(void)
{
    TIM2_SR1 &= (~0x01);        //����жϱ�־
    return;
}