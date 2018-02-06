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

static uint8_t check_num = 1;
static uint8_t id = 0;
static void ack_out_time(void);

static void sart_draw_s(void *p) {
   id = stime_create(200,ST_ONCE,ack_out_time); /* ��ʱ��� */   
}

static void usart_draw_rec_callback_c(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    switch(dat->cmd) {
        case 0x01: { /* λ�÷��� */
            stime_delet(id);
            if(dat->data[0] == 1) {
                if(check_num < 10) {
                    check_num++;
                    usart_tx_msg_obj msg;
                    msg.id = check_num;
                    msg.cmd = 0x01; /* ��ѯλ�� */
                    msg.len = 0x00;
                    msg.call_back = sart_draw_s;
                    usart_obj *usart = device_get("usart");
                    usart->draw_send(usart,msg);
                } else { /* ���һ�μ�� */
                    
                }
            } else { /* ����λ�� */
                usart_tx_msg_obj msg;
                msg.id = check_num;
                msg.cmd = 0x03; /* ���� */
                msg.len = 0x00;
                msg.call_back = sart_draw_s;
                usart_obj *usart = device_get("usart");
                usart->draw_send(usart,msg);
            }
        } break;
        case 0x03: {
            if(dat->data[0] == 0) {  /* ���ųɹ� */
                if(check_num < 10) {
                    check_num++;
                    usart_tx_msg_obj msg;
                    msg.id = check_num;
                    msg.cmd = 0x01; /* ��ѯλ�� */
                    msg.len = 0x00;
                    msg.call_back = sart_draw_s;
                    usart_obj *usart = device_get("usart");
                    usart->draw_send(usart,msg);
                } else { /* ���һ�μ�� */
                    
                }
            } else { /* ����ʧ�� */
                usart_tx_msg_obj msg;
                msg.id = check_num;
                msg.cmd = 0x03; /* ���� */
                msg.len = 0x00;
                msg.call_back = sart_draw_s;
                usart_obj *usart = device_get("usart");
                usart->draw_send(usart,msg);
            }
        } break;
    }
}

static void ack_out_time(void) {   
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_draw_rec_callback_c);
    check_num = 1;
    usart_tx_msg_obj msg;
    msg.id = check_num;
    msg.cmd = 0x01; /* ��ѯλ�� */
    msg.len = 0x00;
    msg.call_back = sart_draw_s;
    usart->draw_send(usart,msg);
}

void door_check_task(void) {
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,usart_draw_rec_callback_c);
    check_num = 1;
    usart_tx_msg_obj msg;
    msg.id = check_num;
    msg.cmd = 0x01; /* ��ѯλ�� */
    msg.len = 0x00;
    msg.call_back = sart_draw_s;
    usart->draw_send(usart,msg);
}

