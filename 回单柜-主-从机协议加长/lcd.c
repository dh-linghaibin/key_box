/***********************************************************
* 文档: lcd.c
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#include "main.h"

/*****驱动io口定义******/
#define CS_H OPE5=1      //Pe5 CS
#define CS_L OPE5=0
#define SID_H OPC6=1     //Pc6 SID
#define SID_L OPC6=0
#define SCLK_H OPC5=1   //Pc5 SCLK
#define SCLK_L OPC5=0

/***驱动函数声明，不对外开放****/
void Write_LCD_Command(u8 cmdcode);
/********延时ms,us子程序*********/
void delay_ms(u16 ms)	
{						
	u16 i;
	while(ms--)
	{
		for(i=0;i<300;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
	}
}

/********延时ms,us子程序*********/
void LCD12864_Init(void)
{
		//PC口设置
		PC_DDR |= ( BIT(6)|BIT(5) ); //6-SPI_MOSI，主设备输出从
		PC_CR1 |= ( BIT(6)|BIT(5) ); 
		PC_CR2 |= ( BIT(6)|BIT(5) );
		//PE口设置
		PE_DDR |= BIT(5); //
		PE_CR1 |= BIT(5); 
		PE_CR2 |= BIT(5);
/*--------------------LCD基本指令-----------------------*/
    delay_ms(250);
    Write_LCD_Command(0x30);  //30--基本指令动作
    delay_ms(5);
    Write_LCD_Command(0x0c);  //光标右移画面不动
    delay_ms(5);
    Write_LCD_Command(0x01);  //清屏
    delay_ms(5);              //清屏时间较长
    Write_LCD_Command(0x06);  //显示打开，光标开，反白关
    delay_ms(10);
}
/*********************************************************
函数名:Send_Byte()
返回值：无
功  能:	写数据到LCD
*********************************************************/
void Send_Byte(u8 zdata)
{
  u16 i;
  for(i=0; i<8; i++)
    {
  
	  if((zdata << i) & 0x80) 
	       SID_H;
	  else   
	       SID_L;
			SCLK_H;
			SCLK_L;
	  }
}
/*********************************************************
函数名: Write_LCD_Command()
返回值：无
功  能:	写命令到LCD
*********************************************************/
void Write_LCD_Command(u8 cmdcode)
{
   CS_H;
   Send_Byte(0xf8);
   Send_Byte(cmdcode & 0xf0);
   Send_Byte((cmdcode << 4) & 0xf0);
   delay_ms(2);
   CS_L;
}
/*********************************************************
函数名: Write_LCD_Data()
返回值：无
功  能:	写显示内容到LCD
*********************************************************/
void Write_LCD_Data(u8 Dispdata)
{  
  CS_H;
  Send_Byte(0xfa);	  //11111,RW(0),RS(1),0
  Send_Byte(Dispdata & 0xf0);
  Send_Byte((Dispdata << 4) & 0xf0);
  delay_ms(2);
  CS_L;
}
/*********************************************************
函数名: LCD_Clear_Txt
返回值：无
功  能:	文本区清除
*********************************************************/
void LCD_Clear_TXT(void)
{
		u8 i;
		Write_LCD_Command(0x30);      //8BitMCU,基本指令集合
		Write_LCD_Command(0x80);      //AC归起始位
		for(i=0;i<64;i++)
	  {
       Write_LCD_Data(0x20);
	  }
}
/*********************************************************
函数名: LCD_Clear_BMP
返回值：无
功  能:	图片区清除
*********************************************************/
void LCD_Clear_BMP( void )
{
	u8 i,j,k;
	Write_LCD_Command(0x34);        //打开扩展指令集
	i = 0x80;            
	for(j = 0;j < 32;j++)
	{
		Write_LCD_Command(i++);
		Write_LCD_Command(0x80);
		for(k = 0;k < 16;k++)
		{
			Write_LCD_Data(0x00);
		}
	}
	i = 0x80;
 	for(j = 0;j < 32;j++)
	{
		Write_LCD_Command(i++);
		Write_LCD_Command(0x88);	   
		for(k = 0;k < 16;k++)
		{
			Write_LCD_Data(0x00);
		} 
	}  
	Write_LCD_Command(0x36);        //打开绘图显示
	Write_LCD_Command(0x30);        //回到基本指令集
}
/*********************************************************
函数名: Display_LCD_Pos
返回值：无
功  能:设置显示位置
*********************************************************/
void Display_LCD_Pos(u8 x,u8 y) 
{
	u8 pos;
	switch(x)
	{
		case 0: x=0x80;break;
		case 1: x=0x90;break;
		case 2: x=0x88;break;
		case 3: x=0x98;break;
	}
	pos=x+y;
	Write_LCD_Command(pos);
}
/******************************************
函数名称：Disp_HZ
功    能：控制液晶显示汉字
参    数：addr--显示位置的首地址
          pt--指向显示数据的指针
          num--显示字符个数
返回值  ：无
********************************************/
void Disp_HZ(u8 X,const u8 * pt,u8 num)
{
	u8 i,addr;
	if (X==0) {addr=0x80;}
	else if (X==1) {addr=0x90;}
	else if (X==2) {addr=0x88;}
	else if (X==3) {addr=0x98;}
	Write_LCD_Command(addr); 
	for(i = 0;i < (num*2);i++) 
     Write_LCD_Data(*(pt++)); 
} 
/*********************************************************
函数名:Display_LCD_String()
返回值：无
功  能:显示字符串
*********************************************************/
void Display_LCD_String(u8 x,u8 *p,u8 time)
{
	u8 i,addr;
	switch(x)
	{
		case 0: addr=0x80;break;
		case 1: addr=0x90;break;
		case 2: addr=0x88;break;
		case 3: addr=0x98;break;
	}
	Write_LCD_Command(addr);
	for(;*p!='\0';p++)
	{
		Write_LCD_Data(*p);
		delay_ms(time);
	}
}
/*********************************************************
函数名:Display_LCD_String()
返回值：无
功  能:显示字符串
*********************************************************/
void Display_LCD_String_XY(u8 x,u8 y,u8 *p,u8 time)
{
	Display_LCD_Pos(x,y);
	for(;*p!='\0';p++)
	{
		Write_LCD_Data(*p);
		delay_ms(time);
	}
}
/*********************************************************
函数名:Display_LCD_String()
返回值：无
功  能:显示字符串
*********************************************************/
void Display_String(u8 *p,u8 time)
{
	for(;*p!='\0';p++)
	{
		Write_LCD_Data(*p);
		delay_ms(time);
	}
}
/*********************************************************
函数名:Display_LCD_Num()
返回值：无
功  能:显示数字
*********************************************************/
void Display_LCD_Num(u8 x,u16 num,u8 time)
{
	u8 i,addr;
	switch(x)
	{
		case 0: addr=0x80;break;
		case 1: addr=0x90;break;
		case 2: addr=0x88;break;
		case 3: addr=0x98;break;
		case 4: addr=0x00;break;
	}
	if(addr != 0x00)
	{
		Write_LCD_Command(addr);
	}
		Write_LCD_Data(0x30+num/10000);
		Write_LCD_Data(0x30+num/1000%10);
		Write_LCD_Data(0x30+num/100%10);
		Write_LCD_Data(0x30+num/10%10);
		Write_LCD_Data(0x30+num%10);
		delay_ms(time);
}
/*******************************************
函数名称:Draw_PM
功    能:在整个液晶屏幕上画图
参    数:图片头指针
返回值  :无
********************************************/
void Draw_PM(const u8 *ptr)
{
	u8 i,j,k;
	Write_LCD_Command(0x34);        //打开扩展指令集
	i = 0x80;            
	for(j = 0;j < 32;j++)
	{
		Write_LCD_Command(i++);
		Write_LCD_Command(0x80);
		for(k = 0;k < 16;k++)
		{
			Write_LCD_Data(*ptr++);
		}
	}
	i = 0x80;
 	for(j = 0;j < 32;j++)
	{
		Write_LCD_Command(i++);
		Write_LCD_Command(0x88);	   
		for(k = 0;k < 16;k++)
		{
			Write_LCD_Data(*ptr++);
		} 
	}  
	Write_LCD_Command(0x36);        //打开绘图显示
	Write_LCD_Command(0x30);        //回到基本指令集
}
const u8 jm_a[1024] = {
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF1,0xFF,0xF8,0x7F,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xC0,0x7F,0xF4,0xBF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,0x1F,0xF0,0xBF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x00,0x07,0xF8,0x7F,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF0,0x00,0x01,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xC0,0x00,0x00,0x7F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x00,0x00,0x00,0x1F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0x00,0x00,0x00,0x0F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x80,0x00,0x00,0x27,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x20,0x00,0x00,0x07,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x08,0x00,0x02,0x27,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x02,0x00,0x00,0x67,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x01,0x00,0x11,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x00,0x4E,0x43,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x00,0x1F,0x03,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x00,0x04,0x67,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0x80,0x60,0xEF,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xE0,0x71,0xFD,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xE0,0x71,0xD9,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xE0,0x71,0xC9,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xF0,0x71,0xC1,0xE7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0x3C,0x71,0xC1,0x8F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x8F,0x71,0xC1,0x3F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xE3,0xF1,0xC0,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF8,0xF1,0xC3,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFE,0x31,0xCF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0x81,0x3F,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xC0,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xF1,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xCC,0x08,0xE3,0xC7,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xCC,0xF8,0x63,0x83,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFC,0xCC,0x19,0x03,0x93,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xF0,0xCC,0x09,0x13,0x01,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xF3,0xDF,0x1D,0xFB,0x7D,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
};
