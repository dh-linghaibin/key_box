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
#include "button.h"
#include "led.h"
#include "voice.h"
#include "eprom.h"
#include "setp_moto.h"
#include "lcd.h"
#include "door_count.h"
#include "open_draw.h"

static void led_task(void) {
    led_obj *led = device_get("led");
    led->blank(led);
}

static void pc_sen_ack_ok_l(void *p) {

}

static void usart_pc_rec_callback(void *pd) {
    usart_rx_packet_obj * pcdat = (usart_rx_packet_obj *)pd;
    usart_tx_msg_obj msg;
    msg.cmd = 0x88;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    msg.call_back = pc_sen_ack_ok_l;
    usart_obj *usart = device_get("usart");
    usart->pc_send(usart,msg);
    
    switch(pcdat->cmd) {
        case 0x01: {
         
        } break;
        case RESET: { //����
            int rep = pcdat->data[3];
            rep |= pcdat->data[4] << 8;
            draw_zero(rep);
        } break;
        case OPEN_DRAW: { // 1 �������û�й��� 2��ת 3����
            int rep = pcdat->data[3];
            rep |= pcdat->data[4] << 8;
            open_draw(pcdat->data[1],pcdat->data[2],rep);
        } break;
        case CLOSE_DRAW: {
            close_draw(pcdat->data[1],pcdat->data[2]);
        } break;
    }
}

void moto_call_reset(uint8_t flag) {

}

int main( void ) {
    stime_init();  
    event_init();
    device_init();
    
    usart_obj *usart = device_get("usart");
    usart->receive_pc(usart,usart_pc_rec_callback);
    
    setp_moto_obj *setp_moto = device_get("setp_moto");
    eprom_obj *eprom = device_get("eprom");
    eprom->read(eprom, EP_MOTO_POS, (uint8_t*)&setp_moto->now_position,2);
    
    lcd_obj *lcd = device_get("lcd");
    lcd->show_int(lcd,0,0,usart->get_id(usart));
    
    //setp_moto->rotate(setp_moto,1,setp_moto_ok);
    //setp_moto->reset(setp_moto,moto_call_reset);
    //door_check_task(door_check_ok);
    //open_draw(1,1);
    
    stime_create("led",500,ST_ALWAYS,led_task); /* led�߳� */       
    while(1) {
        stime_loop();
        event_loop();
    }
}


