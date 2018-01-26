/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "setp_moto.h"
#include "stime.h"
#include "event.h"

#define ONE_SETP        400     //存放每层的抽屉数量的常量，实际抽屉数为76，该值考虑了四个柱子，用于计算
#define PULSE           35      //35单个抽屉脉冲当量175
#define RESET_READ      PC_IDR_IDR3 /*回零*/
#define MOTO_DR         PD_ODR_ODR2/*电机方向*/
#define MOTO_SETP       PA_ODR_ODR3 /*电机速度*/

typedef struct _moto_obj {
    uint16_t position_to;
    uint16_t position_now;
    uint16_t sleep;
    uint8_t even_flag;
    uint8_t run_bit;     
    uint8_t sleep_time_id;
}moto_obj;

static moto_obj moto;

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

static inline void setp_moto_set_sleep(uint16_t sleep) {
    TIM3_ARRH=sleep>>8;           
    TIM3_ARRL=sleep;
}

void setp_moto_init(struct _setp_moto_obj * motox) {
    PC_DDR &= ~BIT(3); /***回零信号_PC3****/
    PC_CR1 |= BIT(3); 
    PC_CR2 &= ~BIT(3);
    
    PC_DDR &= ~BIT(4); /***编码器信号_PC4****/
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    PA_DDR |= BIT(3);  /***电机旋转_PA3****/
    PA_CR1 |= BIT(3); 
    PA_CR2 |= BIT(3);
    
    PD_DDR |= BIT(2); /***电机方向_PD2****/
    PD_CR1 |= BIT(2); 
    PD_CR2 |= BIT(2);
    
    PC_DDR &= ~BIT(4);  /***编码器信号_PC4****/
    PC_CR1 |= BIT(4); 
    PC_CR2 &= ~BIT(4);
    
    TIM3_PSCR   = 0x00; /* 1ms */ 
    TIM3_EGR    = 0x01; 
    TIM3_CNTRH  = 0x0;
    TIM3_CNTRL  = 0x0;     
    TIM3_ARRH   = 0x40;
    TIM3_ARRL   = 0x01;
    TIM3_IER    = 0x01;
    TIM3_CR1    = 0x00;
    
    moto.run_bit = E_DISABLE;
    moto.even_flag = E_DISABLE;
}

static uint16_t dif_pos = 0;
static void speed_task(void) {
    int dif = moto.position_to - moto.position_now;
    if(dif > dif_pos) { /* 提速 */
        if(moto.sleep > 5000) {
            moto.sleep -= 50;
            setp_moto_set_sleep(moto.sleep);
        }
    } else if( (dif < dif_pos)  && (dif < 4300) ) { /* 降速  */ 
        if(moto.sleep < 65000) {
            moto.sleep += 50;
            setp_moto_set_sleep(moto.sleep);
        }
    }
}

int setp_moto_rotate(struct _setp_moto_obj * moto_s,uint16_t to_position,void (call_back)(void *)) {
    if(moto.run_bit == E_DISABLE) {
        if(to_position > BEST_DRAW) {
            return SM_ERROR;
        }
        int need_num = setp_moto_num_to_setp(moto_s,to_position);
        if(need_num == 0) {
            return SM_OK;
        } else if(need_num > 0) {
            moto.run_bit = E_ENABLE;
            
            moto.even_flag = E_DISABLE;
            event_create(&moto.even_flag,
                         ET_ONCE,
                         call_back,
                         null,
                         null);
            
            MOTO_DR = 0;
            moto.position_to = need_num;
            dif_pos = need_num/2;
            TIM3_CR1 = 0x01;
            moto.sleep_time_id = stime_create(10,ST_ALWAYS,speed_task);
            return SM_WAIT;
        } else if(need_num < 0) {
            moto.run_bit = E_ENABLE;
            
            moto.even_flag = E_DISABLE;
            event_create(&moto.even_flag,
                         ET_ONCE,
                         call_back,
                         null,
                         null);
            
            MOTO_DR = 1;
            moto.position_to = (need_num | 0x8000);
            dif_pos = need_num/2;
            TIM3_CR1 = 0x01;
            moto.sleep_time_id = stime_create(10,ST_ALWAYS,speed_task);
            return SM_WAIT;
        }
        return SM_ERROR;
    } else {
        return SM_ERROR;
    }
}

void setp_moto_test(void) {
    moto.position_to = 3000;
    dif_pos = moto.position_to/2;
    TIM3_CR1 = 0x01;
    moto.sleep = 65000;
    moto.sleep_time_id = stime_create(5,ST_ALWAYS,speed_task);
}

#pragma vector=0x11
__interrupt void TIM3_UPD_OVF_BRK_IRQHandler(void) {
    asm("sim");
    TIM3_SR1 &= (~0x01); 
    
    MOTO_SETP =!MOTO_SETP;
    moto.position_now++;
    
    if(moto.position_to == moto.position_now) { /* 结束 */
        TIM3_CR1 = 0x00;
        stime_delet(moto.sleep_time_id);
        moto.even_flag = E_ENABLE;
        moto.run_bit = E_DISABLE;
    }
    
    asm("rim");
}
