/*
* This file is part of the 
*
* Copyright (c) 2016-2018 linghaibin
*
*/

#include "door_count.h"
#include "stime.h"
#include "register_device.h"
#include "uart.h"
#include "event.h"
#include "led.h"
#include "voice.h"
#include "eprom.h"
#include "setp_moto.h"
#include "lcd.h"

#define BEST_DOOR_NUMBER 9

static void(*check_ok)(void *); //���ɹ��ص�
static uint16_t check_con = 0x00;

static uint8_t check_id = 1; //�豸��ַ 1 - 10
static uint8_t agan_id = 0;
static uint8_t agan_num = 0;
static uint16_t door_rep = 0;

static void send_ask_pos_time(void);
static void send_ask_close_time(void);
static void usart_draw_rec_callback_c(void *pd);
static void send_ask_pos(uint8_t d_id);

//��ѯλ�÷������ �ص�
static void send_ask_pos_ok(void *p) {
   stime_create("check_o",180,ST_ONCE,send_ask_pos_time); /* ��ʱ��� */   
}

static void send_ask_close_ok(void *p) {
   stime_create("check_o",4500,ST_ONCE,send_ask_close_time); /* ��ʱ��� */   
}

//��ѯλ�� ��ʱ�ط�
static void send_ask_pos_time(void) {   
    if(agan_id == check_id) {
        if(agan_num < 3) {
            agan_num++;
        } else {
            agan_num = 0;
            if(check_id < BEST_DOOR_NUMBER) {
                check_con |= ( 0x01 << (check_id-1) );
                check_id++;
            } else { /* ���һ�μ�� */
                if(check_ok != null) {
                    check_ok((void *)check_con);
                }
                return;
            }
        }
    } else {
        agan_id = check_id;
        agan_num = 0;
    }
    send_ask_pos(check_id);
}

//���� ��ʱ�ط�
static void send_ask_close_time(void) {  
    if(agan_id == check_id) {
        if(agan_num < 3) {
            agan_num++;
        } else {
            agan_num = 0;
            if(check_id < BEST_DOOR_NUMBER) {
                check_con |= ( 0x01 << (check_id-1) );
                check_id++;
            } else { /* ���һ�μ�� */
                if(check_ok != null) {
                    check_ok((void *)check_con);
                }
                return;
            }
        }
    } else {
        agan_id = check_id;
        agan_num = 1;
    }
    send_ask_pos(check_id);
}

uint8_t check_id_s = 0;

static void draw_check(void) {
    usart_obj *usart = device_get("usart"); //��ȡ����
    usart_tx_msg_obj msg;
    msg.id = check_id_s;
    msg.cmd = 0x01; /* ��ѯλ�� */
    msg.len = 0x00;
    msg.call_back = send_ask_pos_ok;
    usart->draw_send(usart,msg);
}

//��ѯλ��
static void send_ask_pos(uint8_t d_id) {
    check_id_s = d_id;
    uint8_t bit = ( ( door_rep >> (check_id_s-1) ) & 0x0001 );
    if(bit == 0x00) {
        stime_create("check",80,ST_ONCE,draw_check); /* ��ʱ��� */   
    } else {
        if(check_id_s == BEST_DOOR_NUMBER) {
            check_ok((void *)check_con);
        } else {
            send_ask_pos(d_id+1);
        }
    }
}

//�رճ���
static void send_ask_close(uint8_t d_id) {
    usart_tx_msg_obj msg;
    msg.id = d_id;
    msg.cmd = 0x03; /* ���� */
    msg.len = 0x00;
    msg.call_back = send_ask_close_ok;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

//���ջص�
static void usart_draw_rec_callback_c(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    stime_delet("check_o");
    switch(dat->cmd) {
        case 0x01: { /* λ�÷��� */
            if(dat->data[0] == 1) {
                if(check_id < BEST_DOOR_NUMBER) {
                    check_id++;
                    send_ask_pos(check_id);
                } else { /* ���һ�μ�� */
                    if(check_ok != null) {
                        check_ok((void *)check_con);
                    }
                }
            } else { /* ����λ�� */
               send_ask_close(check_id);
            }
        } break;
        case 0x03: {
            if(dat->data[0] == 0) {  /* ���ųɹ� */
                if(check_id < BEST_DOOR_NUMBER) {
                    check_id++;
                    send_ask_pos(check_id);
                } else { /* ���һ�μ�� */
                    if(check_ok != null) {
                        check_ok((void *)check_con);
                    }
                }
            } else { /* ����ʧ�� */
                send_ask_close(check_id);
            }
        } break;
        default : {
            send_ask_pos(check_id);
        } break;
    }
}

//��ʼ���ѭ��
void door_check_task(uint16_t rep,void(*check_ok_h)(void *)) {
    usart_obj *usart = device_get("usart"); //��ȡ����
    usart->receive_draw(usart,usart_draw_rec_callback_c); //���ûص�
    if(check_ok_h != null) {
        check_ok = check_ok_h;
    }
    door_rep = rep;
    check_id = 1;
    check_con = 0x00;
    send_ask_pos(check_id);
}

