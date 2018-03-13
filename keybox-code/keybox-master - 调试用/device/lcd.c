/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "lcd.h"
#include <stdio.h>
#include <string.h>

#define CS_H PE_ODR_ODR5=1 
#define CS_L PE_ODR_ODR5=0

uint8_t spi_write(uint8_t data) {
    uint8_t byte = 0; 
    while(!SPI_SR&0x02);
    SPI_DR = data; 
    while(!SPI_SR&0x02);
    SPI_DR = 0x00; 
    while(!SPI_SR&0x01); 
    byte = SPI_DR; 
    return byte;
}

void delay_ms(uint16_t ms) {						
    uint16_t i;
    while(ms--) {
        for(i=0;i<300;i++);
    }
}

void write_cmd(uint8_t cmd) {
    CS_H;
    spi_write(0xf8);
    spi_write(cmd & 0xf0);
    spi_write((cmd << 4) & 0xf0);
    delay_ms(2);
    CS_L;
}

void write_dat(uint8_t Dispdata)
{  
    CS_H;
    spi_write(0xfa);	
    spi_write(Dispdata & 0xf0);
    spi_write((Dispdata << 4) & 0xf0);
    delay_ms(2);
    CS_L;
}

void Draw_PM(void)
{
    uint8_t i,j,k;
    i = 0x80;            
    for(j = 0;j < 32;j++) {
        write_cmd(i++);
        delay_ms(12);
        write_cmd(0x80);
        delay_ms(12);
        for(k = 0;k < 16;k++) {
            write_dat(0xff);
        }
    }
    i = 0x80;
    for(j = 0;j < 32;j++) {
        write_cmd(i++);
        delay_ms(12);
        write_cmd(0x88);	
        delay_ms(12);
        for(k = 0;k < 16;k++) {
            write_dat(0xff);
        } 
    }  
}

void lcd_set_xy(uint8_t x,uint8_t y) {
    uint8_t pos;
    switch(x) {
        case 0: x=0x80;break;
        case 1: x=0x90;break;
        case 2: x=0x88;break;
        case 3: x=0x98;break;
    }
    pos=x+y;
    write_cmd(pos);
}

void lcd_show_string(struct _lcd_obj *lcd,uint8_t x,uint8_t y,uint8_t *p) {
    lcd_set_xy(x,y);
    for(;*p!='\0';p++) {
        write_dat(*p);
        delay_ms(5);
    }
}

void lcd_show_int(struct _lcd_obj *lcd,uint8_t x,uint8_t y,int num) {
    lcd_set_xy(x,y);
    int n, i = 0;
    char str[20], tmp[20];
    n = num % 10;
    while (n > 0) { /* 求长度 */
        tmp[i++] = n + '0';
        num = (num - n) / 10;
        n = num % 10;
    }
    tmp[i] = '\0';
    for (i=0; i <= strlen(tmp)-1; i++) {
        str[i] = tmp[strlen(tmp)-i-1];
    }
    str[i] = '\0';
    for(int i = 0;str[i]!='\0';i++) {
        write_dat(str[i]);
        delay_ms(5);
    }
}

void lcd_init(struct _lcd_obj *lcd) {
    PC_DDR |= ( BIT(6)|BIT(5) ); //6-SPI_MOSI，主设备输出从
    PC_CR1 |= ( BIT(6)|BIT(5) ); 
    PC_CR2 |= ( BIT(6)|BIT(5) );
    
    PE_DDR |= BIT(5);
    PE_CR1 |= BIT(5); 
    PE_CR2 |= BIT(5);
    
    SPI_CR1 = 0x04;
    SPI_CR2 = 0x03; 
    SPI_CRCPR = 0x07; 
    SPI_ICR = 0x00; 
    SPI_CR1 |= 0x40;
    
    delay_ms(800);
    write_cmd(0x30);  //30--基本指令动作
    delay_ms(15);
    write_cmd(0x0c);  //光标右移画面不动
    delay_ms(15);
    write_cmd(0x01);  //清屏
    delay_ms(15);              //清屏时间较长
    write_cmd(0x06);  //显示打开，光标开，反白关
    delay_ms(10);
    //lcd->show_string(lcd,0,0,"测试");
   ///lcd->show_int(lcd,0,0,133);
}

