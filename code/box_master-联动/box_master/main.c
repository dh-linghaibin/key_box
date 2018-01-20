/** 工程: 基于STM8单片机的回单柜控制-主
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
u8 RsBuffer[MaxNumberofCom];//串口缓存区
u8 TsBuffer[MaxNumberofCom];
u8 R_RsBuffer[R_MaxNumberofCom];//从机串口缓存区
u8 R_TsBuffer[R_MaxNumberofCom];
_Bool c_ok_Flag = 0;/*串口命令完成标志位3*/
_Bool but_Flag = 0;/*按钮是否按下标志位*/
u8 rebot_dr = 0;/*机械手出来或进去1 出来*/
u8 com_i = 0;/*保存接收数据3*/
u8 addre = 0x01;/*地址*/
u8 com_Flag = 0;/*串口3开始接受标志位*/
u8 Rc_ok_Flag = 0;/*串口命令完成标志位1*/
u8 Rcom_i = 0;/*保存接收数据1*/
u8 Rcom_Flag = 0;/*串口1开始接受标志位*/
u8 SDr_Num_Save;/*保存选在柜子位置*/
u8 rb_Flag = 0;/*机械手运行状态标志位*/
u8 wr_new = 0;/*保存回单情况*/
u8 Dr_Num_Save = 0;/*保存旋转位置*/
u8 fr_Flag = 0;/*回单检测标志位*/
u8 bu_Flag = 0;/*按钮使能标志位*/
u8 mirro = 0;/*自动回来标志*/
u8 Encoder = 0;/*保存是否使用编码器*/
u8 place_sava = 0;/*保存机械手位置情况*/
u16 Shield = 0;/*保存屏蔽情况*/
u8 S_buf[10] = {1,1,1,1,1,1,1,1,1,1};/*保存屏蔽情况*/

u8 cmd_last = 0;//last cmd 上一次发送的是什么命令
u8 cmd_ok_flag = 0;//cmd is ok ? 上一次执行结果

_Bool Encoder_bz = 0;/*编码器标志位*/
_Bool dis_play = 0;/*显示*/
extern  u8 hd_num;/*回单*/
u16 Encoder_count = 0;/*编码器计数*/
_Bool jxs_out = 0;//机械手状态标志
u8 jxs_out_num = 0;//机械手出去位置
//0：回来
//1：出去
extern u8 cheak_wait;//重发等待时间

u16 cheak_wait_count = 0;//重发等待时间
static u8 led_ask = 0;

static u8 zs_falag = 0;//程序正在运行中
static u8 an_huqu = 0;//由于按钮按下导致的回去的标志位

void DelayMs(u16 ms);

extern u16 cheak_wait_2;

/*时间标志位*/
u16 T1msFlg;
u16 T2msFlg;

/*测试定义区*/
#define rs485_dr1 PA_ODR_ODR6
#define rs485_dr2 PD_ODR_ODR7

#define but_led PD_ODR_ODR3/*led指示灯*/
#define but_sw PD_IDR_IDR4/*进仓按钮*/

#define bu_Encoder PC_IDR_IDR4 /*编码器输入口*/

#define ts_up PE_IDR_IDR0
#define ts_next PE_IDR_IDR1
#define ts_ok PE_IDR_IDR2
#define ts_page PD_IDR_IDR0
#define pla_dc_jc PC_ODR_ODR2

page_num page_n;/*菜单结构体*/

/**********************************************************/
/* MAIN主程序                                             */
/**********************************************************/
int main(void)
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
    // Dr_Num_Save += Eeprom_Read(10)*10;
    // Dr_Num_Save += Eeprom_Read(11);
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
                    
                    RsBuffer[1] = jxs_out_num;
                    cheak_wait_2 = 400;//快速检测
                    Menu_Host(Drawer_back,addre,RsBuffer,
                              Dr_Num_Save,&page_n);/*显示*/
                    R_TsBuffer[1] = rebot_dr;
                    rb_Flag = 1;/*初始化状态标志位*/
                    
                    zs_falag = 1;
                    an_huqu = 1;

                    if(Drawer_cont_ls(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                      RsBuffer,Drawer_back,&Rc_ok_Flag) == 0) {
                                          mirro = 0;
                                          rebot_dr = 0;
                                          PD_ODR_ODR3 = 1;/*关闭led*/
                                          jxs_out = 0;//机械手回来
                                          but_Flag = 0;//清楚按钮按下
                                          zs_falag = 0;
                                      }
                }
            }
        }
        /*串口接收到命令*/
        if(c_ok_Flag == 1)
        {
            u8 abs_num = 0;
            u8 i_count = 0;/*查询用*/
            u8 place_sta = 0;/*位置统计保存*/
            
            UART_interrupt(1,0);/*关闭串口1中断*/
            
            if(Com_Check(RsBuffer,addre))/*校验判断*/
            {
                /*发送校验成功*/
                UART3_Send(TsBuffer,CORRECT,ok);
                //delayms(10);//修改调试清晰点
                WDT();//清看门狗
               
                c_ok_Flag = 0;/*命令完成，开始接收下一个命令*/
                UART_interrupt(1,1);/*使能串口1中断*/
                
                /*开始执行命令*/
                switch(RsBuffer[0])/*判断命令*/
                {
                    
                    /*检测阻挡*/
                    case Detection_barrier:
                    pla_dc_jc = 1;
                    delayms(1000);
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
                    pla_dc_jc = 0;
                    break;
                    /*检测机械手是否回来*/
                    case rawer_back_sta:
                    Shield_sava(RsBuffer);
                    cheak_wait = 40;//快速检测
                    place_sta = 0;
                    UART_interrupt(0,1);/*使能串口1接收中断*/
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
                    UART_interrupt(0,0);/*关闭串口1接收中断*/
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
                        WDT();//清看门狗
                        cmd_last = Back_zero;//记录命令
                        zs_falag = 1;
                        if(Back_Zero(&Dr_Num_Save) == 0X21)
                        {
                        	cmd_ok_flag = ok;
                            //UART3_Send(TsBuffer,Back_zero,ok);
                        }
                        else
                        {
                        	cmd_ok_flag = no;//记录命令状态
                            //回零失败
                            //UART3_Send(TsBuffer,Back_zero,no);
                        }
                         zs_falag = 0; 
                        Menu_Host(Back_zero,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*显示*/
                    break;
                    /*旋转位置*/
                    case Motor_rotation:
                        WDT();//清看门狗
                        zs_falag = 1;
                        cmd_last = Motor_rotation;//记录旋转命令
                        abs_num = _Servo_C(RsBuffer[1],&Dr_Num_Save);/*旋转*/
                        if(Encoder == 0)/*开启编码器*/	
                        {
                            if(abs_num > 0)
                            {
                                if ( abs(abs(Encoder_count/abs_num)-Encoder_hz) > 30  )
                                {
                                	cmd_ok_flag = no;//旋转命令
                                    //UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
                                    Menu_Host(3,addre,RsBuffer,
                                              156,&page_n);/*显示*/
                                }
                                else
                                {
                                	cmd_ok_flag = ok;		
                                    //UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
                                }
                            }
                            else
                            {
                            	cmd_ok_flag = ok;
                                //UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
                            }
                        }
                        else
                        {
                        	cmd_ok_flag = ok;//旋转命令
                            //UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
                        }
                        zs_falag = 0;
                        Menu_Host(Motor_rotation,addre,RsBuffer,Dr_Num_Save,&page_n);/*显示*/
                    break;
                    /*判断有误回单*/
                    case Whether_receipt:
                    
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
                        an_huqu = 0;//回来过就正常
                    
                        zs_falag = 1; 
                        cmd_last = Drawer_out;//命令记录
                        jxs_out_num = RsBuffer[1];
                        cheak_wait_2 = 400;//快速检测
                        Menu_Host(Drawer_out,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*显示*/
                        Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_out,&Rc_ok_Flag);
                        rebot_dr = RsBuffer[1];
                        eeprom_count(r_sive_n+((rebot_dr-1)*5));
                        bu_Flag = 1;
                        if(bu_Flag == 1)
                        {
                            PD_ODR_ODR3 = 0;/*打开LED*/
                        }
                        zs_falag = 0;
                        jxs_out = 1;//机械手出去
                    break;
                    /*机械手回来*/
                    case Drawer_back:
                        //Drawer_back_1:
                         an_huqu = 0;//回来过就正常
                    
                        zs_falag = 1;
                        cmd_last = Drawer_back;//
                        cheak_wait_2 = 400;//快速检测
                        Menu_Host(Drawer_back,addre,RsBuffer,
                                  Dr_Num_Save,&page_n);/*显示*/
                        R_TsBuffer[1] = rebot_dr;
                        rb_Flag = 1;/*初始化状态标志位*/
                        //                    if(RsBuffer[2] == 0)//第一次拉回的时候才清楚回单值 避免失去回单 2015/7/32改  凌海滨
                        //                    {
                        //                        hd_num = 0;/*清除回单状态*/
                        //                        fr_Flag = 0;/*初始化回单标志位*/
                        //                    }
                        Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_back,&Rc_ok_Flag);									
                        mirro = 0;
                        rebot_dr = 0;
                        PD_ODR_ODR3 = 1;/*关闭led*/
                        jxs_out = 0;//机械手回来
                        but_Flag = 0;//清楚按钮按下
                        zs_falag = 0;
                    break;
                    /*机械手出去是否到位*/
                    case Drawer_out_place:
                    cheak_wait_2 = 40;//快速检测
                    
                    if(an_huqu == 0) {
                        Drawer_cont_ask(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
                                    RsBuffer,Drawer_out_place,&Rc_ok_Flag);
                    } else {
                         UART3_Send(TsBuffer,Drawer_out_place,TRUE);
                    }
                    break;
                    /*机械手回来是否到位*/
                    case Drawer_back_place:
                    cheak_wait_2 = 40;//快速检测
                    Drawer_cont_ask(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,RsBuffer,Drawer_back_place,&Rc_ok_Flag);
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
                    case 0x48://开灯
	                    UART_interrupt(0,1);/*使能串口1接收中断*/
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
	                    UART_interrupt(0,0);/*关闭串口1接收中断*/
	                    if(led_ask == 10) {
	                        UART3_Send(TsBuffer,0x48,no);
	                    } else {
	                        UART3_Send(TsBuffer,0x48,ok);
	                    }
                    break;
                    case 0x49://关灯
	                    UART_interrupt(0,1);/*使能串口1接收中断*/
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
	                    UART_interrupt(0,0);/*关闭串口1接收中断*/
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
#pragma vector=0xD
__interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void)
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
#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void)
{
    u8 ch;
    ch=UART1_DR;
    /*等待数据接受完成*/
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
说明: 串口3中断接收函数
***************************************/
#pragma vector=0x17
__interrupt void UART3_RX_IRQHandler(void)
{
    u8 ch;
    asm("sim");//开中断，sim为关中断
    ch=UART3_DR;
    /*等待数据接受完成*/
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
                    if( zs_falag == 1) {//正在阻塞运行
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
    asm("rim");//开中断，sim为关中断
    return;
}
/***************************************
说明: 串口1发送中断函数
***************************************/
u8 ts1_count = 0;
u8 ts1_ok = 0;
#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void)
{
    asm("sim");//开中断，sim为关中断
    UART1_SR&= ~(1<<6);    //清除送完成状态位
    UART1_DR =  R_TsBuffer[ts1_count];
    if(ts1_count < 8) {
        ts1_count++;
    } else {
        ts1_count = 0;
        rs485_dr1 = 0;
        UART1_CR2 &= ~BIT(6);//开发送完成中?
        ts1_ok = 0;
    }
    asm("rim");//开中断，sim为关中断
    return;
}
/***************************************
说明: 串口3发送中断函数
***************************************/
u8 ts3_count = 0;
u8 ts3_ok = 0;
#pragma vector=0x16
__interrupt void UART3_TX_IRQHandler(void)
{
    asm("sim");//开中断，sim为关中断
    UART3_SR&= ~(1<<6);    //清除送完成状态位
    UART3_DR = TsBuffer[ts3_count];
    if(ts3_count < 15) {
        ts3_count++;
    } else {
        ts3_count = 0;
        rs485_dr2 = 0;
        UART3_CR2 &= ~BIT(6);//开发送完成中?
        ts3_ok = 0;
    }
    asm("rim");//开中断，sim为关中断
    return;
}
/***************************************
说明: PWM溢出中断
***************************************/
#pragma vector=0xF
__interrupt void TIM2_UPD_OVF_BRK_IRQHandler(void)
{
    TIM2_SR1 &= (~0x01);        //清除中断标志
    return;
}