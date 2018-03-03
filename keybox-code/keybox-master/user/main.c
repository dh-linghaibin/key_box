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
#include "receipt.h"

//4 查询回单
static void receipt_back(void *p);

static void led_task(void) {
    led_obj *led = device_get("led");
    led->blank(led);
}

static void pc_sen_ack_ok(void *p) {

}

/* 发送完成回调 */
static usart_rx_packet_obj spcdat;
static void pc_sen_ack_ok_l(void *p) {
    switch(spcdat.cmd) {
        case 0x01: {
         
        } break;
        case RESET: { //回零
            int rep = spcdat.data[3];
            rep |= spcdat.data[4] << 8;
            draw_zero(rep);
        } break;
        case OPEN_DRAW: { // 1 检查门有没有关上 2旋转 3开门
            int rep = spcdat.data[3];
            rep |= spcdat.data[4] << 8;
            open_draw(spcdat.data[1],spcdat.data[2],rep);
        } break;
        case CLOSE_DRAW: {
            close_draw(spcdat.data[1],spcdat.data[2]);
        } break;
        case BUTTON_ASK: {
            usart_obj *usart = device_get("usart");
            usart_tx_msg_obj msg;
            for(register int i = 0;i < 10;i++) {
                msg.data[i] = 0;
            }
            msg.data[0] = get_door_bit();
            msg.cmd = 0x21;
            msg.call_back = pc_sen_ack_ok;
            usart->pc_send(usart,msg);
        } break;
        case RECEIPT_CHECK: {
            receipt_obj *receipt = device_get("receipt");
            receipt->get(receipt,spcdat.data[0],receipt_back);
        } break;
    }
}

//4 查询回单
static void receipt_back(void *p) {
    usart_obj *usart = device_get("usart");
    usart_tx_msg_obj msg;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    receipt_bit_obj *receipt_bit = ( receipt_bit_obj *)p;
    if(receipt_bit->layer[spcdat.data[0]-1] == RB_HAVE) {
        msg.data[0] = 0;
    } else {
        msg.data[0] = 1;
    }
    msg.cmd = RECEIPT_CHECK;
    msg.call_back = pc_sen_ack_ok;
    usart->pc_send(usart,msg);
}

/* 接收到命令 */
static void usart_pc_rec_callback(void *pd) {
    usart_rx_packet_obj * pcdat = (usart_rx_packet_obj *)pd;
    spcdat = *pcdat;
    usart_tx_msg_obj msg;
    msg.cmd = 0x88;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    msg.call_back = pc_sen_ack_ok_l;
    usart_obj *usart = device_get("usart");
    usart->pc_send(usart,msg);
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
    
    stime_create("led",500,ST_ALWAYS,led_task); /* led线程 */       
    while(1) {
        stime_loop();
        event_loop();
    }
}


