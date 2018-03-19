/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2018 linghaibin
 *
 */

#include "open_draw.h"
#include "stime.h"
#include "register_device.h"
#include "uart.h"
#include "event.h"
#include "led.h"
#include "voice.h"
#include "eprom.h"
#include "setp_moto.h"
#include "lcd.h"
#include "door_count.h"
#include "receipt.h"
#include "button.h"

static void door_check_ok(void *p);
static void usart_draw_rec_callback(void *pd);
static void setp_moto_ok(void * p);
static void send_ask_open_ok(void *pd);
static void open_out_time(void);
static void pc_sen_ack_ok(void *p);
static void button_click(void *p);

static void close_draw(uint8_t r_num,uint8_t draw_num) ;
static void close_draw_rec_callback(void *pd);
static void pc_sen_ack_ok(void *p);
static void close_draw_back(void *pd);
static void close_out_time(void);
static void close_pc_sen_ack_ok(void *p);
static void receipt_back(void *p);

static void door_check_ok_zero(void *p);
static void moto_call_reset(uint8_t flag);

static uint8_t need_r_num = 0;//��Ҫ�촫��λ��
static uint8_t need_draw_num = 0;//����λ��
static door_bit door_flag = D_OPEN;//���Ƿ�ر�
static uint8_t ask_rep = 0;//�Ƿ���Ҫ���ػص�

static uint8_t again_num = 0;/* �ط����� */

door_bit get_door_bit(void) {
    return door_flag;
}

//1 ���
void open_draw(uint8_t r_num,uint8_t draw_num,uint16_t rep) {
    door_flag = D_OPEN;
    
    need_r_num = r_num;
    need_draw_num = draw_num;
    
    button_obj *button = device_get("button");
    button->del_read(button);
    
    receipt_obj *receipt = device_get("receipt");
    receipt->open(receipt);
    
    door_check_task(rep,door_check_ok);
}

//2 �����ɻص�
static void door_check_ok(void *p) {
    uint16_t *check = (uint16_t *)p;
    if(check == 0x0000) { //������ת
        usart_obj *usart = device_get("usart");
        usart->receive_draw(usart,usart_draw_rec_callback);   
        setp_moto_obj *setp_moto = device_get("setp_moto");
        setp_moto->rotate(setp_moto,need_r_num,setp_moto_ok);
    } else { //���ش���
        usart_obj *usart = device_get("usart");
        usart_tx_msg_obj msg;
        for(register int i = 0;i < 10;i++) {
            msg.data[i] = 0;
        }
        msg.cmd = 0x22;
        
        msg.call_back = close_pc_sen_ack_ok;
        usart->pc_send(usart,msg);
    }
}

//3 ��ת��ɻص�
static void setp_moto_ok(void * p) {
    uint16_t *position_to = (uint16_t *)p;
    eprom_obj *eprom = device_get("eprom");
    eprom->write(eprom, EP_MOTO_POS, (uint8_t*)position_to,2);
    
    again_num = 0;
    usart_tx_msg_obj msg;
    msg.id = need_draw_num;
    msg.cmd = 0x05;
    msg.len = 0x00;
    msg.call_back = send_ask_open_ok;
    usart_obj *usart = device_get("usart");
    usart->draw_send(usart,msg);
}

//4-2 ������ɻص�
static void send_ask_open_ok(void *pd) {
    stime_create("check_o",2500,ST_ONCE,open_out_time); /* ��ʱ��� */ 
}

//4-2-1 ��ʱ �ط�
static void open_out_time(void) {
    if(again_num < 5) {
        again_num++;
        usart_tx_msg_obj msg;
        msg.id = need_draw_num;
        msg.cmd = 0x05;
        msg.len = 0x00;
        msg.call_back = send_ask_open_ok;
        usart_obj *usart = device_get("usart");
        usart->draw_send(usart,msg);
    } else {/* ͨѶ���� */
        again_num = 0;
        usart_obj *usart = device_get("usart");
        usart_tx_msg_obj msg;
        for(register int i = 0;i < 10;i++) {
            msg.data[i] = 0;
        }
        msg.cmd = 0x22;
        
        msg.call_back = close_pc_sen_ack_ok;
        usart->pc_send(usart,msg);
    }
}

//4-1 ������ɻص�
static void usart_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    stime_delet("check_o"); //ɾ����ʱ��
    switch(dat->cmd) {
        case 0x05: {
            usart_obj *usart = device_get("usart");
            usart_tx_msg_obj msg;
            for(register int i = 0;i < 10;i++) {
                msg.data[i] = 0;
            }
            if(dat->data[0] == 0) {  /* ���ųɹ� */
                msg.cmd = 0x21;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            } else {
                msg.cmd = 0x22;
                msg.call_back = pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            }
        } break;
        default: { //�����ط�
            usart_tx_msg_obj msg;
            msg.id = need_draw_num;
            msg.cmd = 0x05;
            msg.len = 0x00;
            msg.call_back = send_ask_open_ok;
            usart_obj *usart = device_get("usart");
            usart->draw_send(usart,msg);
        } break;
    }
}

//5 �������
static void pc_sen_ack_ok(void *p) {
    ask_rep = 0;
    button_obj *button = device_get("button");
    button->read(button,button_click);
}

//6 ��ⰸ��
static void button_click(void *p) {
    close_draw(need_r_num,need_draw_num);
}

/* ���Žӿ� */
void od_close_draw(uint8_t r_num,uint8_t draw_num) {
    ask_rep = 1;
    close_draw(r_num,draw_num);
}

// 1 ����
static void close_draw(uint8_t r_num,uint8_t draw_num) {
    button_obj *button = device_get("button");
    button->del_read(button);
    
    again_num = 0;
    
    need_r_num = r_num;
    need_draw_num = draw_num;
    usart_obj *usart = device_get("usart");
    usart->receive_draw(usart,close_draw_rec_callback);   
    usart_tx_msg_obj msg;
    msg.id = need_draw_num;
    msg.cmd = 0x06; //����
    msg.len = 0x00;
    msg.call_back = close_draw_back;
    usart->draw_send(usart,msg);
}

//2 �������
static void close_draw_back(void *pd) {
    stime_create("check_o",2500,ST_ONCE,close_out_time); /* ��ʱ��� */ 
}

//2-1 ��ʱ �ط�
static void close_out_time(void) {
    if(again_num < 5) {
        usart_tx_msg_obj msg;
        msg.id = need_draw_num;
        msg.cmd = 0x06;
        msg.len = 0x00;
        msg.call_back = close_draw_back;
        usart_obj *usart = device_get("usart");
        usart->draw_send(usart,msg);
    } else { //���ش���
        usart_obj *usart = device_get("usart");
        usart_tx_msg_obj msg;
        for(register int i = 0;i < 10;i++) {
            msg.data[i] = 0;
        }
        msg.cmd = 0x22;
        
        msg.call_back = close_pc_sen_ack_ok;
        usart->pc_send(usart,msg);
    }
}

//3 - ����
static void close_draw_rec_callback(void *pd) {
    usart_rx_packet_obj *dat = (usart_rx_packet_obj *)pd;
    stime_delet("check_o"); //ɾ����ʱ��
    switch(dat->cmd) {
        case 0x06: {
            usart_obj *usart = device_get("usart");
            usart_tx_msg_obj msg;
            for(register int i = 0;i < 10;i++) {
                msg.data[i] = 0;
            }
            if(dat->data[0] == 0) {  /* ���ųɹ� */                
                receipt_obj *receipt = device_get("receipt");
                receipt->get(receipt,need_draw_num,receipt_back);
            } else {
                msg.cmd = 0x22;
                msg.call_back = close_pc_sen_ack_ok;
                usart->pc_send(usart,msg);
            }
        } break;
        default: { //�����ط�
            usart_tx_msg_obj msg;
            msg.id = need_draw_num;
            msg.cmd = 0x06;
            msg.len = 0x00;
            msg.call_back = send_ask_open_ok;
            usart_obj *usart = device_get("usart");
            usart->draw_send(usart,msg);
        } break;
    }
}

//4 ��ѯ�ص�
static void receipt_back(void *p) {
    usart_obj *usart = device_get("usart");
    usart_tx_msg_obj msg;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    receipt_bit_obj *receipt_bit = ( receipt_bit_obj *)p;
    if(receipt_bit->layer[need_draw_num-1] == RB_HAVE) {
    //if(receipt_bit->layer[] == RB_HAVE) {
        msg.data[0] = 0;
        door_flag = D_CLOSE_NO;/* ���ųɹ�û�лص� */
    } else {
        msg.data[0] = 1;
        door_flag = D_CLOSE_HAVA;/* ���ųɹ��лص� */
    }
    msg.cmd = 0x21;
    msg.call_back = close_pc_sen_ack_ok;
    if(ask_rep == 1) { /* �Ƿ���Ҫ���� */
        usart->pc_send(usart,msg);
    }
}

//5 �������
static void close_pc_sen_ack_ok(void *p) {
    //stime_create("check_o2",1000,ST_ONCE,open_de);
    //open_draw(1,1);
}

//1 ���
void draw_zero(uint16_t rep) {
    button_obj *button = device_get("button");
    button->del_read(button);
    
    door_check_task(rep,door_check_ok_zero);
}

//2 �����ɻص�
static void door_check_ok_zero(void *p) {
    uint16_t *check = (uint16_t *)p;
    if(check == 0x0000) { //������ת
        usart_obj *usart = device_get("usart");
        usart->receive_draw(usart,usart_draw_rec_callback);   
        setp_moto_obj *setp_moto = device_get("setp_moto");
        setp_moto->reset(setp_moto,moto_call_reset);
    } else { //���ش���
        usart_obj *usart = device_get("usart");
        usart_tx_msg_obj msg;
        for(register int i = 0;i < 10;i++) {
            msg.data[i] = 0;
        }
        msg.cmd = 0x22;
        
        msg.call_back = close_pc_sen_ack_ok;
        usart->pc_send(usart,msg);
    }
}

//3 ����ص�
static void moto_call_reset(uint8_t flag) {
    
    usart_obj *usart = device_get("usart");
    usart_tx_msg_obj msg;
    for(register int i = 0;i < 10;i++) {
        msg.data[i] = 0;
    }
    if(flag == 0) {
        msg.cmd = 0x22;
    } else {
        msg.cmd = 0x21;
    }
    
    msg.call_back = close_pc_sen_ack_ok;
    usart->pc_send(usart,msg);
}


