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

void led_task(void) {
    led_obj *led = device_get("led");
    led->blank(led);
}

void pc_sen_ack_ok(void *p) {

}

static void pc_sen_ack(void) {
    usart_tx_msg_obj msg;
    msg.cmd = 0x88;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    msg.call_back = pc_sen_ack_ok;
    usart_obj *usart = device_get("usart");
    usart->pc_send(usart,msg);
}

static void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x02: {
       
        } break;
        case 0x05: {
            usart_obj *usart = device_get("usart");
            usart_tx_msg_obj msg;
            for(register int i = 0;i < 10;i++) {
                msg.data[i] = 0;
            }
            if(dat->data[0] == 0) {  /* 关门成功 */
                msg.cmd = 0x21;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            } else {
                msg.cmd = 0x22;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            }
        } break;
        case 0x06: {
            usart_obj *usart = device_get("usart");
            usart_tx_msg_obj msg;
            for(register int i = 0;i < 10;i++) {
                msg.data[i] = 0;
            }
            if(dat->data[0] == 0) {  /* 关门成功 */
                msg.cmd = 0x21;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            } else {
                msg.cmd = 0x22;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            }
        } break;
        case 0x01: {
        
        } break;
    }
}

//旋转完成 回掉
static void moto_call_reset(uint8_t flag) {
    uint16_t position_to = 0x00;
    eprom_obj *eprom = device_get("eprom");
    eprom->write(eprom, EP_MOTO_POS, (uint8_t*)position_to,2);
}

usart_rx_packet_obj *pcdat;

//发送完成回掉
static void send_ask_open_ok(void *pd) {

}

//旋转完成
static void setp_moto_ok(void * p) {
    uint16_t *position_to = (uint16_t *)p;
    eprom_obj *eprom = device_get("eprom");
    eprom->write(eprom, EP_MOTO_POS, (uint8_t*)position_to,2);
    
    usart_tx_msg_obj msg;
    msg.id = pcdat->data[2];
    msg.cmd = 0x05; //开门
    msg.len = 0x00;
    msg.call_back = send_ask_open_ok;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

//检测阻挡 完成
static void door_check_ok(void *p) {
    uint16_t *check = (uint16_t *)p;
    if(*check == 0x0000) { //继续旋转
        usart_obj *usart = device_get("usart");
        usart->receive_draw(usart,usart_draw_rec_callback);   
        setp_moto_obj *setp_moto = device_get("setp_moto");
        setp_moto->rotate(setp_moto,pcdat->data[1],setp_moto_ok);
    } else { //返回错误
    
    }
}

void usart_pc_rec_callback(void *pd) {
    pcdat = (usart_rx_packet_obj *)pd;
    pc_sen_ack();
    switch(pcdat->cmd) {
        case 0x01: {
           //setp_moto_obj *setp_moto = device_get("setp_moto");
        } break;
        case RESET: { //回零
            setp_moto_obj *setp_moto = device_get("setp_moto");
            setp_moto->reset(setp_moto,moto_call_reset);
        } break;
        case OPEN_DRAW: { // 1 检查门有没有关上 2旋转 3开门
            door_check_task(door_check_ok);
        } break;
        case CLOSE_DRAW: {
            usart_obj *usart = device_get("usart");
            usart->receive_draw(usart,usart_draw_rec_callback);   
            usart_tx_msg_obj msg;
            msg.id = pcdat->data[2];
            msg.cmd = 0x06; //关门
            msg.len = 0x00;
            msg.call_back = send_ask_open_ok;
            usart->draw_send(usart,msg);
        } break;
    }
}

int main( void ) {
    stime_init();  
    event_init();
    device_init();
    //lcd_init();
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_draw_rec_callback);    
    usart->receive_pc(usart,usart_pc_rec_callback);
    
    setp_moto_obj *setp_moto = device_get("setp_moto");
    eprom_obj *eprom = device_get("eprom");
    eprom->read(eprom, EP_MOTO_POS, (uint8_t*)&setp_moto->now_position,2);
    
    //setp_moto->rotate(setp_moto,1,setp_moto_ok);
    //setp_moto->reset(setp_moto,moto_call_reset);
    //door_check_task(door_check_ok);
    
    stime_create(500,ST_ALWAYS,led_task); /* led线程 */       
    while(1) {
        stime_loop();
        event_loop();
    }
}


