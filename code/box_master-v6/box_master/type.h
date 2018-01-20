/***********************************************************
* 文档: type.h
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#ifndef TYPE_H_
#define TYPE_H_

#include "main.h"
/******串口层变量声明*****/

/*****lcd驱动函数定义*****/
void LCD12864_Init(void);
void LCD_Clear_TXT(void);
void LCD_Clear_BMP(void);
void Write_LCD_Data(u8 Dispdata);
void Disp_HZ(u8 X,const u8 * pt,u8 num);
void Display_LCD_String(u8 x,u8 *p,u8 time);
void Display_LCD_Num(u8 x,u16 num,u8 time);
void Draw_PM(const u8 *ptr);
void Display_LCD_String_XY(u8 x,u8 y,u8 *p,u8 time);
void Display_String(u8 *p,u8 time);
/*******控制层*****************/
void BSP_Init(void);
void delayms(u16 ms);
void delayus(u16 us);
void Shield_sava(u8 *Array);
void Addr_Read(u8 *address);
u8 Bar_Read(u8 *Array);
u8 Com_Check(u8 *place,u8 ad);
u8 Back_Zero(u8 *Dr_Num_Save);
void Moto_Hz(u32 hz);
u8 _Servo_C(u8 Dr_Num,u8 *Dr_Num_Save);
void Found_Receipt(u8 *Array_R,u8 *wr_Flag,u8 *sta_Flag);
void Drawer_cont(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                 u8 *ts,u8 *rs,u8 mode,u8 *ts_flag);
u8 Drawer_cont_ls(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                 u8 *ts,u8 *rs,u8 mode,u8 *ts_flag);
/*******内部EEPROM层*****************/
void Eeprom_Init(void);
void Eeprom_Write(u8 addr,u8 dat);
u8 Eeprom_Read(u8 addr);
/*串口通信层*/
void UART1_Init(void);
void UART3_Init(void);
void UART3_Sendint(unsigned char ch);
void UART3_Send(u8 *Array,u8 command,u8 situ);
void UART1_Sendint(unsigned char ch);
void UART1_Send(u8 *Array,u8 command,u8 situ);
void UART_interrupt(u8 uart,u8 mode);
void rawer_back_judge(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
                      u8 i,u8 *ts_flag,u8 *place_flag);
/*app应用层*/
void Menu_Host(u8 status,u8 address,u8 *Array_R,u8 dr_num,page_num *page_n);
void eeprom_count(u8 ad);
void eeprom_cle(u8 ad);
int abs(int x);

#define led_os PC_ODR_ODR1

#endif




