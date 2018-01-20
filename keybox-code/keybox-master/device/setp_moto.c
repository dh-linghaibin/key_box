/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "setp_moto.h"

#define ONE_SETP        400     //���ÿ��ĳ��������ĳ�����ʵ�ʳ�����Ϊ76����ֵ�������ĸ����ӣ����ڼ���
#define PULSE           35      //35�����������嵱��175
#define RESET_READ      PC_IDR_IDR3 /*����*/
#define MOTO_DR         PD_ODR_ODR2/*�������*/
#define MOTO_SETP       PA_ODR_ODR3 /*����ٶ�*/

static int setp_moto_num_to_setp(struct _setp_moto_obj * moto,uint16_t to_position) {
    int result_move = 0;
    uint16_t angle_now = moto->stop_arr[moto->now_position-1];
    uint16_t angle_to = moto->stop_arr[to_position-1];
    if(angle_now < angle_to) {
        if((angle_to-angle_now) <= (ONE_SETP/2)) {
            result_move = angle_to-angle_now;
        } else {
            result_move=ONE_SETP+angle_now-angle_to;
            result_move = 0-result_move;
        }
    } else if(angle_now>=angle_to) {
        if((angle_now-angle_to)<=(ONE_SETP /2)) {
            result_move=angle_now-angle_to;
            result_move = 0-result_move;
        } else if((angle_now-angle_to)>(ONE_SETP /2)) {
            result_move=ONE_SETP-angle_now+angle_to;
        }
    } 
    return result_move* PULSE *2;
}

void setp_moto_init(struct _setp_moto_obj * moto) {
    PC_DDR &= ~BIT(3); /***�����ź�_PC3****/
    PC_CR1 |= BIT(3); 
    PC_CR2 &= ~BIT(3);
    
    PC_DDR &= ~BIT(4); /***�������ź�_PC4****/
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    PA_DDR |= BIT(3);  /***�����ת_PA3****/
    PA_CR1 |= BIT(3); 
    PA_CR2 |= BIT(3);
    
    PD_DDR |= BIT(2); /***�������_PD2****/
    PD_CR1 |= BIT(2); 
    PD_CR2 |= BIT(2);
    
    PC_DDR &= ~BIT(4);  /***�������ź�_PC4****/
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    TIM3_PSCR  =0x00; /* 1ms */ 
    TIM3_EGR = 0x01; 
    TIM3_CNTRH = 0x0;
    TIM3_CNTRL = 0x0;     
    TIM3_ARRH = 0X40;
    TIM3_ARRL = 0X01;
    TIM3_IER = 0X01;
    TIM3_CR1 = 0X00;
}

void(*complete)(void);

static uint16_t position_to;
static uint16_t position_now;

#pragma vector=0x11
__interrupt void TIM3_UPD_OVF_BRK_IRQHandler(void) {
    asm("sim");
    TIM3_SR1 &= (~0x01); 
    
    MOTO_SETP =!MOTO_SETP;
    position_now++;
    
    if((position_to - position_now) > 500) { /* ���� */
//        TIM3_ARRH=timerlow[k]>>8;           
//        TIM3_ARRL=timerlow[k];
    } else if((position_to - position_now) < 500) { /* ���� */
        
    } else if(position_to == position_now) { /* ���� */
        complete(); /* �ص� */
    }
    
    asm("rim");
}
