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
    msg.id = adr;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.data[0] = 0x01;
    msg.data[1] = 0xf1;
    msg.call_back = send_ok;
    uart_send_pc(msg);
    adr++;
}
void send_ok(void * pd) {
    stime_create(5000,usart_callback);
}

int rec_i = 0;

void usart_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x01: {
            rec_i++;
        } break;
    }
}

int main( void ) {
    stime_init();  
    event_init();
    
    led_init();
    voice_init();
    usart_init();
    uart_receive_pc(usart_rec_callback);
//    usart_tx_msg_obj msg;
//    msg.id = 0x01;
//    msg.cmd = 0x01;
//    msg.len = 0x01;
//    msg.data[0] = 0x01;
//    msg.call_back = send_ok;
//    uart_send_pc(msg);
    
    stime_create(5,time);
    while(1) {
        stime_loop();
        event_loop();
    }
}


