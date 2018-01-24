/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/
#include "stime.h"
#include "event.h"
#include "uart.h"
#include "led.h"
#include "light.h"

void led_task(void) {
    led_tager();
}

void send_ok(void * pd);
void usart_callback(void) {
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x01;
    msg.call_back = send_ok;
    uart_send_draw(msg);
}

int chaoshi_id = 0;

void send_ok(void * pd) {
    chaoshi_id = stime_create(10,ST_ONCE,usart_callback); /* 1S ³¬Ê±*/
}

void send_task(void) {
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x55;
    uart_send_draw(msg);
}

void usart_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x01: {
            stime_create(60,ST_ONCE,send_task);
        } break;
        case 0x02: {
//            setp_moto_open();
//            usart_tx_msg_obj msg;
//            msg.id = 0xff;
//            msg.cmd = 0x02;
//            msg.len = 0x01;
//            msg.data[0] = 0x55;
//            uart_send_draw(msg);
        } break;
    }
}

int main( void ) {
    stime_init();  
    event_init();
    
    light_init();
    led_init();
    
    usart_init();
    uart_receive_draw(usart_rec_callback);
    
    stime_create(500,ST_ALWAYS,led_task);
    
    setp_moto_init();
    //setp_moto_open();
    
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x55;
    msg.call_back = send_ok;
    uart_send_draw(msg);
    
    while(1) {
        stime_loop();
        event_loop();
    }
}
