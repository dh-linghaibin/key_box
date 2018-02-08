/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "uart.h"
#include "stime.h"

#define RS485_DR_1 PA_ODR_ODR6
#define RS485_DR_3 PD_ODR_ODR7

static usart_tx_packet_obj draw_tx_packet;
static usart_tx_packet_obj pc_tx_packet;

static usart_rx_packet_obj draw_rx_packet;
static usart_rx_packet_obj pc_rx_packet;

static uint8_t rs485_address;

static uint8_t read_adr(void) {
    uint8_t address = 0;

    if(PE_IDR_IDR3) address &= ~BIT(0); else address |= BIT(0);
    if(PG_IDR_IDR1) address &= ~BIT(1); else address |= BIT(1);
    if(PG_IDR_IDR0) address &= ~BIT(2); else address |= BIT(2);
    if(PC_IDR_IDR7) address &= ~BIT(3); else address |= BIT(3);
    
    return address;
}

void usart_init(struct _usart_obj * uart) {
     /***485_PA4****/
   PA_DDR &= ~BIT(5);
    PA_CR1 |= BIT(5); 
    PA_CR2 &= ~BIT(5);
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
    
    UART1_CR2_REN=1;//使能接收
    UART1_CR2_RIEN=1;//打开接收中断
    
     /***485_PD5****/
    PD_DDR &= ~BIT(5);
    PD_CR1 |= BIT(5); 
    PD_CR2 &= ~BIT(5);
    /***485_PD6****/
    PD_DDR &= ~BIT(6);
    PD_CR1 |= BIT(6); 
    PD_CR2 &= ~BIT(6);
    /***485方向流控制_PD7****/
    PD_DDR |= BIT(7);
    PD_CR1 |= BIT(7); 
    PD_CR2 |= BIT(7);
     /***地址检测_PC7_PG0_PG1_PE3****/
    PC_DDR &= ~BIT(7);
    PC_CR1 |= BIT(7); 
    PC_CR2 &= ~BIT(7);
    PG_DDR &= ~BIT(0);
    PG_CR1 |= BIT(0); 
    PG_CR2 &= ~BIT(0);
    PG_DDR &= ~BIT(1);
    PG_CR1 |= BIT(1); 
    PG_CR2 &= ~BIT(1);
    PE_DDR &= ~BIT(3);
    PE_CR1 |= BIT(3); 
    PE_CR2 &= ~BIT(3);
    
    UART3_CR1=0x00;
    UART3_CR2=0x00;
    UART3_CR3=0x00; 
    UART3_BRR2=0x02;
    UART3_BRR1=0x68;

    UART3_CR2_REN=1;//使能接收
    UART3_CR2_RIEN=1;//打开接收中断
    
    RS485_DR_1 = 0;
    RS485_DR_3 = 0;
    
    rs485_address = read_adr();
    
    draw_tx_packet.flag = 0;
    pc_tx_packet.flag = 0;
}

void uart_send_draw(struct _usart_obj * uart,
                    usart_tx_msg_obj msg) {
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
        event_create("s_s_d",&draw_tx_packet.ts_flag,
                     ET_ONCE,
                     msg.call_back,
                     null,
                     null);
        UART1_CR2_TEN=1;//打开发送
        UART1_CR2_TIEN=1;//打开发送中断
        RS485_DR_1 = 1;
    }
}

void uart_send_pc(struct _usart_obj * uart,
                  usart_tx_msg_obj msg) {
    pc_tx_packet.data[0] = 0x3a;
//        pc_tx_packet.data[1] = msg.id;
//        pc_tx_packet.data[2] = msg.len;
    pc_tx_packet.data[1] = msg.cmd;
    for(register int i = 0;i < 9;i++) {
        pc_tx_packet.data[2+i] = msg.data[i];
    }
    pc_tx_packet.data[13] = ( pc_tx_packet.data[1] +  pc_tx_packet.data[2]);
    for(int i = 3;i < 13;i++) {
         pc_tx_packet.data[14] +=  pc_tx_packet.data[i];
    }
    pc_tx_packet.data[15] = 0x0a;
    
    pc_tx_packet.len = 16;
//        register int i = 0;
//        for(i = 0;i < msg.len;i++) {
//            pc_tx_packet.data[4+i] = msg.data[i];
//        }
//        pc_tx_packet.len = msg.len+6;
//        pc_tx_packet.data[pc_tx_packet.len-2] = 0x00;
//        for(i = 0;i < pc_tx_packet.len-2;i++) {
//            pc_tx_packet.data[pc_tx_packet.len-2] += (uint8_t)pc_tx_packet.data[i];
//        }
//        pc_tx_packet.data[pc_tx_packet.len-1] = 0x0a;
    pc_tx_packet.flag = 0;
    pc_tx_packet.ts_flag = E_DISABLE;
    event_create("s_s_p",&pc_tx_packet.ts_flag,
                 ET_ONCE,
                 msg.call_back,
                 null,
                 null);
    UART3_CR2_TEN=1;//打开发送
    UART3_CR2_TIEN=1;//打开发送中断
    RS485_DR_3 = 1;
}

void uart_receive_draw(struct _usart_obj * uart,
                       void(*call_back)(void *)) {
    event_create("u_r_d",&draw_rx_packet.ts_flag,
                 ET_ALWAYS,
                 call_back,
                 &draw_rx_packet,
                 null);
}

void uart_receive_pc(struct _usart_obj * uart,
                     void(*call_back)(void *)) {
    event_create("u_r_p",&pc_rx_packet.ts_flag,
                 ET_ALWAYS,
                 call_back,
                 &pc_rx_packet,
                 null);
}

static void pc_rx_overtime(void) {
    pc_rx_packet.flag = 0;
}

static void draw_rx_overtime(void) {
    draw_tx_packet.flag = 0;
}

#pragma vector=0x14
__interrupt void UART1_RX_IRQHandler(void) {
    static uint8_t get_len = 0; /* 接收标记 */
    if(UART1_SR_RXNE == 1) {
        uint8_t data = UART1_DR;
        switch(draw_rx_packet.flag) {
            case 0:{
                if(data == 0x3a) {
                    draw_rx_packet.flag = 1;
                    stime_create("u1_c",80,ST_ONCE,draw_rx_overtime);
                }
            } break;
            case 1:{
                if(data == 0xff) {
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
                    stime_delet("u1_c");
                    draw_rx_packet.flag = 0;
                }
            } break;
        }
    }
}

#pragma vector=0x17
__interrupt void UART3_RX_IRQHandler(void) {
    static uint8_t get_len = 0; /* 接收标记 */
    if(UART3_SR_RXNE == 1) {
        uint8_t data = UART3_DR;
        switch(pc_rx_packet.flag) {
            case 0:{
                if(data == 0x3a) {
                    pc_rx_packet.flag = 1;
                    stime_create("u3_c",80,ST_ONCE,pc_rx_overtime);
                }
                pc_rx_packet.ts_flag = E_DISABLE;
            } break;
            case 1:{
                if(data == rs485_address) {
                    pc_rx_packet.len = 12;
                    get_len = 0;
                    pc_rx_packet.flag = 4; //4
                } else {
                    pc_rx_packet.flag = 0;
                }
            } break;
            case 2:{
                pc_rx_packet.len = data;
                pc_rx_packet.flag = 3;
            } break;
            case 3:{
                pc_rx_packet.cmd = data;
                pc_rx_packet.flag = 4;
                get_len = 0;
            } break;
            case 4:{
                pc_rx_packet.data[get_len] = data;
                get_len++;
                if(pc_rx_packet.len+2 <= get_len) {
                    pc_rx_packet.cmd = pc_rx_packet.data[0];//获取命令
                    if(data == 0x0a) {
                        pc_rx_packet.ts_flag = E_ENABLE;
                    } else {
                        pc_rx_packet.ts_flag = E_DISABLE;
                    }
                    stime_delet("u3_c");
                    pc_rx_packet.flag = 0;
                }
            } break;
        }
    }
}

#pragma vector=0x13
__interrupt void UART1_TX_IRQHandler(void) {
    static uint8_t bTX_finished=0;
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
}
#pragma vector=0x16
__interrupt void UART3_TX_IRQHandler(void) {
    static uint8_t bTX_finished=0;
    if(bTX_finished==1 && UART3_SR_TC==1){
        bTX_finished=0;
        UART3_CR2_TIEN=0;//关闭发送中断
        UART3_CR2_TEN=0;//关闭发送
        RS485_DR_3 = 0;
    } else if(UART3_SR_TC==1) {
        if(pc_tx_packet.len > pc_tx_packet.flag) {
            UART3_DR =  pc_tx_packet.data[pc_tx_packet.flag];
            pc_tx_packet.flag++;
        } else {
            pc_tx_packet.flag = 0;
            bTX_finished = 1;
            pc_tx_packet.ts_flag = E_ENABLE;
        }
    }
}
