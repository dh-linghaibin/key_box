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

void send_ok(void * pd) {

}

static uint8_t light = 0;

void time(void) {
    led_taggle();
}

void opendoor(void) {
    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x06;
    msg.len = 0x00;
    msg.data[0] = light;
    msg.call_back = send_ok;
    uart_send_draw(msg);
}

void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x05: {
            stime_create(2000,ST_ONCE,opendoor);
        } break;
        case 0x06: {
            usart_tx_msg_obj msg;
            msg.id = 0x01;
            msg.cmd = 0x05;
            msg.len = 0x00;
            msg.data[0] = light;
            msg.call_back = send_ok;
            uart_send_draw(msg);
        }
    }
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
    msg.cmd = 0x05;
    msg.len = 0x00;
    msg.data[0] = light;
    msg.call_back = send_ok;
    uart_send_draw(msg);
    
    stime_create(5000,ST_ALWAYS,time);
    while(1) {
        stime_loop();
        event_loop();
    }
}


