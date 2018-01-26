/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/
#include "stime.h"
#include "register_device.h"
#include "uart.h"
#include "event.h"
#include "led.h"
#include "voice.h"

void send_ok(void * pd) {
    
}

void led_task(void) {
    led_obj *led = device_get("led");
    led->blank(led);
}

void opendoor(void) {
    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x06;
    msg.len = 0x00;
    msg.call_back = send_ok;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void opendoor2(void) {
    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x05;
    msg.len = 0x00;
    msg.call_back = send_ok;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x05: {
            stime_create(2000,ST_ONCE,opendoor);
        } break;
        case 0x06: {
            stime_create(500,ST_ONCE,opendoor2);
        }
    }
}

int main( void ) {
    stime_init();  
    event_init();
    device_init();
    
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_draw_rec_callback);    

    usart_tx_msg_obj msg;
    msg.id = 0x01;
    msg.cmd = 0x05;
    msg.len = 0x00;
    msg.call_back = send_ok;
    usart->draw_send(usart,msg);
    
    setp_moto_init();
    setp_moto_test();
    
    stime_create(500,ST_ALWAYS,led_task);
    
    while(1) {
        stime_loop();
        event_loop();
    }
}


