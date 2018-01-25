/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "uart.h"
#include "stime.h"

#define RS485_DR_1 PD_ODR_ODR7

static usart_tx_packet_obj draw_tx_packet;
static usart_rx_packet_obj draw_rx_packet;
static uint8_t rs485_address;

static uint8_t read_adr(void) {
    uint8_t address = 0;
    if(PC_IDR_IDR2) address = 10; 
    if(PC_IDR_IDR5) address = 9; 
    if(PD_IDR_IDR0) address = 8; 
    if(PD_IDR_IDR2) address = 7; 
    if(PD_IDR_IDR3) address = 6; 
    if(PD_IDR_IDR4) address = 5; 
    if(PC_IDR_IDR7) address = 4; 
    if(PC_IDR_IDR6) address = 3; 
    if(PC_IDR_IDR4) address = 2; 
    if(PC_IDR_IDR3) address = 1; 
    
    return address;
}

void usart_init(struct _usart_obj * usart) {
    /***485_PD6****/
    PD_DDR &= ~BIT(5);
    PD_CR1 |= BIT(5); 
    PD_CR2 &= ~BIT(5);
    /***485_PD5****/
    PD_DDR &= ~BIT(6);
    PD_CR1 |= BIT(6); 
    PD_CR2 &= ~BIT(6);
    /***485方向流控制——PD7****/
    PD_DDR |= BIT(7);
    PD_CR1 |= BIT(7);
    PD_CR2 |= BIT(7);
    
    /***读从机地址_PC2 PC1 PE5 PB0 PB1 PB2 PB3 PB6 PB7 PF4****/
    PC_DDR &= ~BIT(2);
    PC_CR1 |= BIT(2); 
    PC_CR2 &= ~BIT(2);
    
    PC_DDR &= ~BIT(5);
    PC_CR1 |= BIT(5); 
    PC_CR2 &= ~BIT(5);
    
    PD_DDR &= ~BIT(0);
    PD_CR1 |= BIT(0); 
    PD_CR2 &= ~BIT(0);
    
    PD_DDR &= ~BIT(2);
    PD_CR1 |= BIT(2); 
    PD_CR2 &= ~BIT(2);
    
    PD_DDR &= ~BIT(3);
    PD_CR1 |= BIT(3); 
    PD_CR2 &= ~BIT(3);
    
    PD_DDR &= ~BIT(4);
    PD_CR1 |= BIT(4); 
    PD_CR2 &= ~BIT(4);
    
    PC_DDR &= ~BIT(7);
    PC_CR1 |= BIT(7); 
    PC_CR2 &= ~BIT(7);
    
    PC_DDR &= ~BIT(6);
    PC_CR1 |= BIT(6); 
    PC_CR2 &= ~BIT(6);
    
    PC_DDR &= ~BIT(4);
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    PC_DDR &= ~BIT(3);
    PC_CR1 |= BIT(3); 
    PC_CR2 &= ~BIT(3);
    
    UART1_CR1=0x00;
    UART1_CR2=0x00;
    UART1_CR3=0x00; 
    UART1_BRR2=0x02;
    UART1_BRR1=0x68;
    UART1_CR2_REN=1;//使能接收
    UART1_CR2_RIEN=1;//打开接收中断
    RS485_DR_1 = 0; 
    
    rs485_address = read_adr();
}

void uart_send_draw(struct _usart_obj * usart,usart_tx_msg_obj msg) {
    if(msg.len+5 <= BEST_TX_PACK){
        draw_tx_packet.data[0] = 0x3a;
        draw_tx_packet.data[1] = msg.id;
        draw_tx_packet.data[2] = msg.len;
        draw_tx_packet.data[3] = msg.cmd;
        register int i = 0;
        for(i = 0;i < msg.len;i++) {
            draw_tx_packet.data[4+i] = msg.data[i];
        }
        draw_tx_packet.len = msg.len+6;
        draw_tx_packet.data[draw_tx_packet.len-2] = 0x00;
        for(i = 0;i < draw_tx_packet.len-2;i++) {
            draw_tx_packet.data[draw_tx_packet.len-2] += (uint8_t)draw_tx_packet.data[i];
        }
        draw_tx_packet.data[draw_tx_packet.len-1] = 0x0a;
        draw_tx_packet.flag = 0;
        draw_tx_packet.ts_flag = E_DISABLE;
        event_create(&draw_tx_packet.ts_flag,ET_ONCE,msg.call_back,null,null);
        UART1_CR2_TEN=1;//打开发送
        UART1_CR2_TIEN=1;//打开发送中断
        RS485_DR_1 = 1;
    }
}

void uart_receive_draw(struct _usart_obj * usart,void(*call_back)(void *)) {
    event_create(&draw_rx_packet.ts_flag,ET_ALWAYS,call_back,&draw_rx_packet,null);
}

static void draw_rx_overtime(void) {
    draw_tx_packet.flag = 0;
}

#pragma vector=UART1_R_RXNE_vector
__interrupt void UART1_RX_IRQHandler(void) {
    asm("sim");
    
    static uint8_t get_len = 0; /* 接收标记 */
    static uint8_t overtime_id = 0; /* 定时器id */
    if(UART1_SR_RXNE == 1) {
        uint8_t data = UART1_DR;
        switch(draw_rx_packet.flag) {
            case 0:{
                if(data == 0x3a) {
                    draw_rx_packet.flag = 1;
                    overtime_id = stime_create(80,ST_ONCE,draw_rx_overtime);
                }
            } break;
            case 1:{
                if(data == rs485_address) {
                    draw_rx_packet.flag = 2;
                } else {
                    draw_rx_packet.flag = 0;
                }
            } break;
            case 2:{
                draw_rx_packet.len = data;
                draw_rx_packet.flag = 3;
            } break;
            case 3:{
                draw_rx_packet.cmd = data;
                draw_rx_packet.flag = 4;
                get_len = 0;
            } break;
            case 4:{
                draw_rx_packet.data[get_len] = data;
                get_len++;
                if(draw_rx_packet.len+2 <= get_len) {
                    if(data == 0x0a) {
                        draw_rx_packet.ts_flag = E_ENABLE;
                    } else {
                        draw_rx_packet.ts_flag = E_DISABLE;
                    }
                    stime_delet(overtime_id);
                    draw_rx_packet.flag = 0;
                }
            } break;
        }
    }
    
    asm("rim");
}

uint8_t bTX_finished=0;

#pragma vector=UART1_T_TXE_vector
__interrupt void UART1_TX_IRQHandler(void) {
    asm("sim");
        
    if(bTX_finished==1 && UART1_SR_TC==1){
        bTX_finished=0;
        UART1_CR2_TIEN=0;//关闭发送中断
        UART1_CR2_TEN=0;//关闭发送
        RS485_DR_1 = 0;
    } else if(UART1_SR_TC==1) {
        if(draw_tx_packet.len > draw_tx_packet.flag) {
            UART1_DR =  draw_tx_packet.data[draw_tx_packet.flag];
            draw_tx_packet.flag++;
        } else {
            draw_tx_packet.flag = 0;
            bTX_finished = 1;
            draw_tx_packet.ts_flag = E_ENABLE;
        }
    }
    
    asm("rim");
}
