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
    uint8_t zero_flag;
    uint8_t zero_even_id;
    uint8_t zero_even_id2;
    void (*zero_call_back)(uint8_t flag);
}moto_obj;

static moto_obj moto;

static int setp_moto_num_to_setp(struct _setp_moto_obj * motox,uint16_t to_position) {
    int result_move = 0;
    uint16_t angle_now = motox->now_position;
    uint16_t angle_to = motox->stop_arr[to_position];
    moto.position_now = angle_to; /* 记录需要去的位置 */
    motox->now_position = moto.position_now;
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
    moto.zero_flag = 0;
}

static uint16_t dif_pos = 0;
static void speed_task(void) {
    int dif = moto.position_to;
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

/* 查找位置 */
static event_e reset_sign_read(void *p) {
    if(RESET_READ) {
        return E_ENABLE;
    } else {
        return E_DISABLE;
    }
} 

/* 找到位置 */
static void find_reset(void *p) {
    moto.zero_flag = 0;
    TIM3_CR1 = 0x00;
    moto.zero_flag = 0;
    event_delet("z_f_y");//moto.sleep_time_id);/* 删除走布时间 */
    if(moto.zero_call_back != null) { /* 完成回掉 */
        moto.zero_call_back(1);
    }
}
/* 120 布 没有找到位置错误 */
static void zero_back_error(void *p) {
    moto.zero_flag = 0;
    event_delet("z_f_s_b");//moto.zero_even_id); /* 删除寻找位置事件 */
    if(moto.zero_call_back != null) { /* 完成回掉 */
        moto.zero_call_back(0);
    }
}

static void zero_time(void * p) {
    TIM3_CR1 = 0x00;
    
    if(RESET_READ == SMG_OK) { /* 错误 */
        moto.zero_flag = 0;
        if(moto.zero_call_back != null) { /* 完成回掉 */
            moto.zero_call_back(0);
        }
    } else {
        moto.zero_even_id = event_create("z_f_y",null,
                     ET_CUSTOM,
                     find_reset,
                     null,
                     reset_sign_read);
        setp_moto_set_sleep(65000);
        moto.position_to = 350;/* 暂时100布 */
        moto.even_flag = E_DISABLE;
        moto.sleep_time_id = event_create("z_f_s_b",&moto.even_flag, /* 不一定会运行到 需要删除 */
                     ET_ONCE,
                     zero_back_error,
                     null,
                     null);
        MOTO_DR = 1;
        TIM3_CR1 = 0x01;
    }
}

static void speed_sub_task(void) {
    if(moto.sleep < 65000) {
        moto.sleep += 50;
        setp_moto_set_sleep(moto.sleep);
    } else {
        stime_delet(moto.sleep_time_id); /* 删除加速度时间 */
        zero_time(null); /* 减速完成 换向 */
    }
}

/* 大走找到位置 */
static void find_reset_big(void *p) {
    event_delet("z_z_b");//moto.zero_even_id2);
    stime_delet(moto.sleep_time_id); /* 删除加速度时间 */
    moto.position_to = 1000;
    moto.sleep_time_id = stime_create(5,ST_ALWAYS,speed_sub_task); /* 开始减速 */
}

int setp_moto_zero(struct _setp_moto_obj * motox,void (*call_back)(uint8_t flag)) {
    if(call_back != null) {
        moto.zero_call_back = call_back;
    }
    motox->now_position = 0x00;
    moto.zero_flag = 1;
    if(RESET_READ == SMG_OK) {
        setp_moto_set_sleep(65000);
        MOTO_DR = 0;
        TIM3_CR1 = 0x01;
        moto.position_to = 300;/* 暂时100布 */
        moto.even_flag = E_DISABLE;
        event_create("back_on_z",&moto.even_flag, /* 这个肯定会执行到的 */
                     ET_ONCE,
                     zero_time,
                     null,
                     null);
    } else {
        moto.position_to = 65535;//一圈的脉冲
        
        moto.zero_even_id = event_create("z_z_b",null,
                     ET_CUSTOM,
                     find_reset_big,
                     null,
                     reset_sign_read);
        
        moto.even_flag = E_DISABLE;
        moto.zero_even_id2 = event_create("z_f_s_b",&moto.even_flag, /* 不一定会运行到 需要删除 */
                     ET_ONCE,
                     zero_back_error,
                     null,
                     null);
        MOTO_DR = 0;
        dif_pos = moto.position_to/2;
        TIM3_CR1 = 0x01;
        moto.sleep = 65000;
        moto.sleep_time_id = stime_create(5,ST_ALWAYS,speed_task);
    }
    return SM_OK;
}

int setp_moto_rotate(struct _setp_moto_obj * moto_s,uint16_t to_position,void (call_back)(void *)) {
    if(moto.run_bit == E_DISABLE) {
        if(to_position > BEST_DRAW) {
            return SM_ERROR;
        }
        int need_num = setp_moto_num_to_setp(moto_s,to_position);
        if(need_num == 0) {
            if(call_back != null) {
                call_back(&moto.position_now);
            }
            return SM_OK;
        } else if(need_num > 0) {
            moto.run_bit = E_ENABLE;
            
            moto.even_flag = E_DISABLE;
            event_create("moto_ok",&moto.even_flag,
                         ET_ONCE,
                         call_back,
                         &moto.position_now,
                         null);
            
            MOTO_DR = 0;
            moto.position_to = need_num;
            dif_pos = moto.position_to/2;
            TIM3_CR1 = 0x01;
            moto.sleep = 65000;
            moto.sleep_time_id = stime_create(5,ST_ALWAYS,speed_task);
            return SM_WAIT;
        } else if(need_num < 0) {            
            moto.run_bit = E_ENABLE;
            
            moto.even_flag = E_DISABLE;
            event_create("moto_ok",&moto.even_flag,
                         ET_ONCE,
                         call_back,
                         &moto.position_now,
                         null);
            
            MOTO_DR = 1;
            moto.position_to = (0 - need_num);
            dif_pos = moto.position_to/2;
            TIM3_CR1 = 0x01;
            moto.sleep = 65000;
            moto.sleep_time_id = stime_create(5,ST_ALWAYS,speed_task);
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

    moto.position_to--;
    if(moto.position_to == 0) { /* 结束 */
        TIM3_CR1 = 0x00;
        if(moto.zero_flag == 0) {
            stime_delet(moto.sleep_time_id);
            moto.run_bit = E_DISABLE;
        } else {
            //moto.even_flag = E_ENABLE;
        }
        moto.even_flag = E_ENABLE;
    }
    asm("rim");
}
