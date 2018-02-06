/*
* This file is part of the 
*
* Copyright (c) 2016-2018 linghaibin
*
*/

#include "stime.h"
#include "register_device.h"
#include "uart.h"
#include "event.h"
#include "led.h"
#include "voice.h"
#include "eprom.h"
#include "setp_moto.h"
#include "lcd.h"

void send_ok(void * pd) {
    
}

void led_task(void) {
    led_obj *led = device_get("led");
    led->blank(led);
    
    usart_obj *usart = device_get("usart");
    usart_tx_msg_obj msg;
    msg.id = 1;
    msg.cmd = 0x01; /* 查询位置 */
    msg.len = 0x00;
    msg.call_back = send_ok;
    usart->draw_send(usart,msg);
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

static void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x05: {
            stime_create(2000,ST_ONCE,opendoor);
        } break;
        case 0x06: {
            stime_create(500,ST_ONCE,opendoor2);
        } break;
        case 0x01: {
        
        } break;
    }
}

void setp_moto_ok(void * p);

int xxxx = 1;
void moto_agan(void) {
    xxxx++;
    setp_moto_obj *setp_moto = device_get("setp_moto");
    setp_moto->rotate(setp_moto,xxxx,setp_moto_ok);
}

void setp_moto_ok(void * p) {
    uint16_t *position_to = (uint16_t *)p;
    eprom_obj *eprom = device_get("eprom");
    eprom->write(eprom, EP_MOTO_POS, (uint8_t*)position_to,2);
    stime_create(2000,ST_ONCE,moto_agan);
}

void usart_pc_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x01: {
           setp_moto_obj *setp_moto = device_get("setp_moto");
        } break;
    }
}

void moto_call_reset(uint8_t flag) {
    uint16_t position_to = 0x00;
    eprom_obj *eprom = device_get("eprom");
    eprom->write(eprom, EP_MOTO_POS, (uint8_t*)position_to,2);
}

int main( void ) {
    stime_init();  
    event_init();
    device_init();
    //lcd_init();
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_draw_rec_callback);    
    usart->receive_pc(usart,usart_pc_rec_callback);
    
    eprom_obj *eprom = device_get("eprom");
    setp_moto_obj *setp_moto = device_get("setp_moto");
    eprom->read(eprom, EP_MOTO_POS, (uint8_t*)&setp_moto->now_position,2);
    
    //setp_moto->rotate(setp_moto,1,setp_moto_ok);
    //setp_moto->reset(setp_moto,moto_call_reset);
    door_check_task();
    
    //stime_create(1500,ST_ALWAYS,led_task); /* led线程 */       
    while(1) {
        stime_loop();
        event_loop();
    }
}


