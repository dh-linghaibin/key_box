/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/
#include "stime.h"
#include "l_os.h"
#include "uart.h"
#include "event.h"
#include "led.h"
#include "voice.h"

void time(void) {
    stime_create(500,time);
    led_taggle();
}

uint8_t adr = 0;

void send_ok(void *);
void usart_callback(void) {
    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x01;
    msg.call_back = send_ok;
    uart_send_draw(msg);
}

int chaoshi_id = 0;

void send_ok(void * pd) {
    chaoshi_id = stime_create(200,usart_callback); /* 1S ³¬Ê±*/
}

void usart_callback2(void) {

}

void send_ok2(void * pd) {
    chaoshi_id = stime_create(5000,usart_callback2); /* 1S ³¬Ê±*/
}

void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
//    switch(dat->cmd) {
//        case 0x01: {
//            stime_delet(chaoshi_id);
//            usart_tx_msg_obj msg;
//            msg.id = 0x01;
//            msg.cmd = 0x02;
//            msg.len = 0x01;
//            msg.data[0] = 0x01;
//            msg.call_back = send_ok2;
//            uart_send_draw(msg);
//        } break;
//        case 0x02: {
//            stime_delet(chaoshi_id);
//        }
//    }
}

int main( void ) {
    stime_init();  
    event_init();
    
    led_init();
    voice_init();
    usart_init();
    uart_receive_draw(usart_draw_rec_callback);
    
    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x01;
    msg.call_back = send_ok;
    uart_send_draw(msg);
    
    stime_create(500,time);
    while(1) {
        stime_loop();
        event_loop();
    }
}


