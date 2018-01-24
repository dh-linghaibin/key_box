/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _UART_H_
#define _UART_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"
#include "event.h"

typedef enum _usart_e{
    U_UART1 = 0,
    U_UART3 = 1,
}usart_e;

typedef enum _usart_packet_e{
    UP_OK = 0,
    UP_WAIT = 1,
}usart_packet_e;

#define BEST_TX_PACK 20

typedef struct _rs485_adr_obj {
    uint8_t ad1 : 1;
    uint8_t ad2 : 1;
    uint8_t ad3 : 1;
    uint8_t ad4 : 1;
    uint8_t ad5 : 1;
    uint8_t ad6 : 1;
    uint8_t ad7 : 1;
    uint8_t ad8 : 1;
}rs485_adr_obj;

typedef struct _usart_tx_msg_obj {
    uint8_t id;
    uint8_t len;
    uint8_t cmd;
    uint8_t data[BEST_TX_PACK];
    void(*call_back)(void *);
}usart_tx_msg_obj;

typedef struct _usart_tx_packet_obj {
    uint8_t ts_flag;
    uint8_t flag;
    uint8_t len;
    uint8_t data[BEST_TX_PACK];
}usart_tx_packet_obj;

typedef struct _usart_rx_packet_obj {
    uint8_t ts_flag;
    uint8_t flag;
    uint8_t len;
    uint8_t cmd;
    uint8_t data[BEST_TX_PACK];
}usart_rx_packet_obj;

typedef struct _usart_obj {
    usart_e name;
    int baud_rate;
}usart_obj;

void usart_init(void);
void uart_send_pc(usart_tx_msg_obj msg);
void uart_receive_pc(void(*call_back)(void *));

void uart_send_draw(usart_tx_msg_obj msg);
void uart_receive_draw(void(*call_back)(void *));

#ifdef __cplusplus
}
#endif

#endif

