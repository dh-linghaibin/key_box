/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "register_device.h"
#include "stime.h"
#include "event.h"
#include "uart.h"
#include "led.h"
#include "light.h"
#include "setp_moto.h"
#include "iwdg.h"

void led_task(void) {
    led_obj *led = device_get("led");
    if(led->flash > 0) {
        led->flash--;
        led->tager(led);
    } else {
        led->set(led,LV_CLOSE);
    }
    iwdg_obj *iwdg = device_get("iwdg");
    iwdg->wdt(iwdg);
}

void ask_pos_task(void) {
    setp_moto_obj *moto = device_get("moto");
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x01;
    msg.len = 0x01;
    msg.call_back = null;
    msg.data[0] = moto->position(moto);
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void open_call(setp_moto_ask_e pd) {
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x02;
    msg.len = 0x01;
    msg.call_back = null;
    msg.data[0] = pd;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void close_call(setp_moto_ask_e pd) {
    light_obj *light = device_get("light");
    light->set(light,L_CLOSE);
    
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x03;
    msg.len = 0x01;
    msg.call_back = null;
    msg.data[0] = pd;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void open_call_light(setp_moto_ask_e pd) {
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x05;
    msg.len = 0x01;
    msg.call_back = null;
    msg.data[0] = pd;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void close_call_light(setp_moto_ask_e pd) {
    light_obj *light = device_get("light");
    light->set(light,L_CLOSE);
    
    usart_tx_msg_obj msg;
    msg.id = 0xff;
    msg.cmd = 0x06;
    msg.len = 0x01;
    msg.call_back = null;
    msg.data[0] = pd;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

void usart_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    led_obj *led = device_get("led");
    led->flash = dat->len + 2;
    switch(dat->cmd) {
        case 0x01: {
            stime_create(5,ST_ONCE,ask_pos_task);
        } break;
        case 0x02: {
            setp_moto_obj *moto = device_get("moto");
            moto->open(moto,open_call);
        } break;
        case 0x03: {
            setp_moto_obj *moto = device_get("moto");
            moto->close(moto,close_call);
        } break;
        case 0x04: {
            light_obj *light = device_get("light");
            if(dat->data[0]) {
                light->set(light,L_OPEN);
            } else {
                light->set(light,L_CLOSE);
            }
            usart_tx_msg_obj msg;
            msg.id = 0xff;
            msg.cmd = 0x04;
            msg.len = 0x00;
            msg.call_back = null;
            usart_obj *usart = device_get("usart");
            usart->draw_send(usart,msg);
        } break;
        case 0x05:{
            light_obj *light = device_get("light");
            light->set(light,L_OPEN);
            
            setp_moto_obj *moto = device_get("moto");
            moto->open(moto,open_call_light);
        } break;
        case 0x06:{
            setp_moto_obj *moto = device_get("moto");
            moto->close(moto,close_call_light);
        } break;
    }
}

int main( void ) {
    stime_init();  
    event_init();
    device_init();
    stime_create(500,ST_ALWAYS,led_task);
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_rec_callback);    
    
    led_obj *led = device_get("led");
    led->flash = 2;
    while(1) {
        stime_loop();
        event_loop();
    }
}
