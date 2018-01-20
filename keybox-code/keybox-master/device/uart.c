/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "uart.h"

#define UART1_DR PA_ODR_ODR6
#define UART2_DR PD_ODR_ODR7

void usart_init(struct _usart_obj* usart,uint32_t baud_rate) {
     /***485_PA4****/
    PA_DDR |= BIT(5);
    PA_CR1 |= BIT(5); 
    PA_CR2 |= BIT(5);
    /***485_PA5****/
    PA_DDR &= ~BIT(4);
    PA_CR1 |= BIT(4); 
    PA_CR2 &= ~BIT(4);
    /***485方向流控制_PA6****/
    PA_DDR |= BIT(6);
    PA_CR1 |= BIT(6); 
    PA_CR2 |= BIT(6);
    UART1_CR1=0x00;
    UART1_CR2=0x00;
    UART1_CR3=0x00; 
    UART1_BRR2=0x02;
    UART1_BRR1=0x68;
    UART1_CR2=0x2c;//允许接收，发送，开接收中断
    UART1_CR2 &= ~BIT(2);/*关闭接收中断*/
    
     /***485_PD5****/
    PD_DDR |= BIT(5);
    PD_CR1 |= BIT(5); 
    PD_CR2 |= BIT(5);
    /***485_PD6****/
    PD_DDR &= ~BIT(6);
    PD_CR1 |= BIT(6); 
    PD_CR2 &= ~BIT(6);
    /***485方向流控制_PD7****/
    PD_DDR |= BIT(7);
    PD_CR1 |= BIT(7); 
    PD_CR2 |= BIT(7);
    UART3_CR1=0x00;
    UART3_CR2=0x00;
    UART3_CR3=0x00; 
    UART3_BRR2=0x02;
    UART3_BRR1=0x68;
    UART3_CR2=0x2c;//允许接收，发送，开接收中断
    
    UART1_DR = 0;
    UART2_DR = 0;
}

#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void) {
    
}
#pragma vector=0x17
__interrupt void UART3_RX_IRQHandler(void) {
    
}

#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void) {
    
}
#pragma vector=0x16
__interrupt void UART3_TX_IRQHandler(void) {
    
}
