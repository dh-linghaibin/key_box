/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "lcd.h"

void lcd_init() {    
    SPI_CR1_SPE=0;//�ر�SPI�豸
    //���ô��в�����
    SPI_CR1_BR=0;//fmaster/2=1M
    //����CPOL��CPHA���������ݴ���ʹ���ʱ�Ӽ����λ��ϵ
    SPI_CR1_CPHA=0;//���ݲ����ӵ�һ��ʱ�ӱ��ؿ�ʼ
    SPI_CR1_CPOL=0;//����״̬ʱ��SCK���ֵ͵�ƽ 
    //����֡��ʽ
    SPI_CR1_LSBFIRST=0;//�ȷ���MSB 
    //ʹ�ܴ��豸����//��ģʽ��ͨ���ı�SSIλ ������SPI_SEL
    SPI_CR2_SSM=1;//��ֹ������豸
    SPI_CR2_SSI=1;
    //�����豸ģʽѡ��
    SPI_CR1_MSTR=1;//��Ϊ���豸
    SPI_CR2_RXONLY=0;//ȫ˫��
    SPI_CR2_BDM=0;//ѡ��������ģʽ
    SPI_CR1_SPE=1;//����SPI�豸
}

void spi_write(uint8_t address,uint8_t data) {
    uint8_t tmp;
    address |=0x20;
    SPI_DR=address;//д����Ҫ�����ļĴ�����ַ,
    while(!(SPI_SR_RXNE));
    tmp=SPI_DR;   //��ȡ���ݣ�������Ϊ�������־λ
    while(!(SPI_SR_TXE));//�ȴ����ͼĴ���Ϊ��
    SPI_DR=data;
    while(!(SPI_SR_TXE));
}

uint8_t spi_read(uint8_t address) {
    volatile uint8_t value=0;
    value=SPI_DR;//��һ�Σ������־λ
    while(!(SPI_SR_TXE));
    SPI_DR=address;//д����Ҫ�����ļĴ�����ַ,
    while(!(SPI_SR_RXNE));
    value=SPI_DR;
    while(!(SPI_SR_TXE));
    SPI_DR=0xFF;//д��һ����Чֵ
    while(!(SPI_SR_RXNE));//׼��������
    value=SPI_DR;
    return value;
}
