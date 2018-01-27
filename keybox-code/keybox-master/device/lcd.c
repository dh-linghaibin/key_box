/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "lcd.h"

void lcd_init() {    
    SPI_CR1_SPE=0;//关闭SPI设备
    //设置串行波特率
    SPI_CR1_BR=0;//fmaster/2=1M
    //配置CPOL和CPHA，定义数据传输和串行时钟间的相位关系
    SPI_CR1_CPHA=0;//数据采样从第一个时钟边沿开始
    SPI_CR1_CPOL=0;//空闲状态时，SCK保持低电平 
    //定义帧格式
    SPI_CR1_LSBFIRST=0;//先发送MSB 
    //使能从设备管理//主模式需通过改变SSI位 来控制SPI_SEL
    SPI_CR2_SSM=1;//禁止软件从设备
    SPI_CR2_SSI=1;
    //主从设备模式选择
    SPI_CR1_MSTR=1;//作为主设备
    SPI_CR2_RXONLY=0;//全双工
    SPI_CR2_BDM=0;//选择单向数据模式
    SPI_CR1_SPE=1;//开启SPI设备
}

void spi_write(uint8_t address,uint8_t data) {
    uint8_t tmp;
    address |=0x20;
    SPI_DR=address;//写入需要操作的寄存器地址,
    while(!(SPI_SR_RXNE));
    tmp=SPI_DR;   //读取数据，仅仅是为了清除标志位
    while(!(SPI_SR_TXE));//等待发送寄存器为空
    SPI_DR=data;
    while(!(SPI_SR_TXE));
}

uint8_t spi_read(uint8_t address) {
    volatile uint8_t value=0;
    value=SPI_DR;//读一次，清除标志位
    while(!(SPI_SR_TXE));
    SPI_DR=address;//写入需要操作的寄存器地址,
    while(!(SPI_SR_RXNE));
    value=SPI_DR;
    while(!(SPI_SR_TXE));
    SPI_DR=0xFF;//写入一个无效值
    while(!(SPI_SR_RXNE));//准备读数据
    value=SPI_DR;
    return value;
}
