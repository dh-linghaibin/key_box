/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "uart.h"

#define RS485_DR_1 PA_ODR_ODR6
#define RS485_DR_3 PD_ODR_ODR7

static usart_tx_packet_obj draw_tx_packet;
static usart_tx_packet_obj pc_tx_packet;

void usart_init(void) {
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
    
    RS485_DR_1 = 0;
    RS485_DR_3 = 0;
    
    draw_tx_packet.flag = 0;
    pc_tx_packet.flag = 0;
}

void uart_send_draw(usart_tx_msg_obj msg) {
    if(msg.len+4 <= BEST_TX_PACK){
        draw_tx_packet.data[0] = msg.id;
        draw_tx_packet.data[1] = msg.len;
        draw_tx_packet.data[2] = msg.cmd;
        register int i = 0;
        for(i = 0;i < msg.len;i++) {
            draw_tx_packet.data[3+i] = msg.data[i];
        }
        draw_tx_packet.len = msg.len+4;
        draw_tx_packet.data[draw_tx_packet.len-1] = 0x00;
        for(i = 0;i < msg.len-2;i++) {
            draw_tx_packet.data[draw_tx_packet.len-1] += (uint8_t)draw_tx_packet.data[i];
        }
        draw_tx_packet.data[draw_tx_packet.len] = 0x0a;
        UART1_SR&= ~BIT(6); 
        UART1_CR2 |= BIT(6);
        RS485_DR_1 = 1;
        UART1_DR = 0x3a;
    }
}

void uart_send_pc(usart_tx_msg_obj msg) {
    if(msg.len+5 <= BEST_TX_PACK){
        pc_tx_packet.data[0] = msg.id;
        pc_tx_packet.data[1] = msg.len;
        pc_tx_packet.data[2] = msg.cmd;
        register int i = 0;
        for(i = 0;i < msg.len;i++) {
            pc_tx_packet.data[3+i] = msg.data[i];
        }
        pc_tx_packet.len = msg.len+5;
        pc_tx_packet.data[pc_tx_packet.len-2] = 0x00;
        for(i = 0;i < pc_tx_packet.len-2;i++) {
            pc_tx_packet.data[pc_tx_packet.len-2] += (uint8_t)pc_tx_packet.data[i];
        }
        pc_tx_packet.data[pc_tx_packet.len-1] = 0x0a;
        pc_tx_packet.flag = 0;
        UART3_SR&= ~BIT(6); 
        UART3_CR2 |= BIT(6);
        RS485_DR_3 = 1;
        UART3_DR = 0x3a;
    }
}

#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void) {
  
}
#pragma vector=0x17
__interrupt void UART3_RX_IRQHandler(void) {
    
}

#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void) {
    asm("sim");
    
    UART1_SR &= ~(1<<6);
    if(draw_tx_packet.len > draw_tx_packet.flag) {
        UART1_DR =  draw_tx_packet.data[draw_tx_packet.flag];
        draw_tx_packet.flag++;
    } else {
        draw_tx_packet.flag = 0;
        RS485_DR_1 = 0;
        UART1_CR2 &= ~BIT(6);
    }
    
    asm("rim");
}
#pragma vector=0x16
__interrupt void UART3_TX_IRQHandler(void) {
    asm("sim");
    
    UART3_SR &= ~(1<<6);
    if(pc_tx_packet.len > pc_tx_packet.flag) {
        UART3_DR =  pc_tx_packet.data[pc_tx_packet.flag];
        pc_tx_packet.flag++;
    } else {
        pc_tx_packet.flag = 0;
        RS485_DR_3 = 0;
        UART3_CR2 &= ~BIT(6);
    }
    
    asm("rim");
}
