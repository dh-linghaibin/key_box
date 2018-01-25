/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "setp_moto.h"
#include "stime.h"
#include "event.h"

#define MOTO_STEP       PA_ODR_ODR3
#define MOTO_DIR        PB_ODR_ODR6
#define MOTO_SLEEP      PF_ODR_ODR4
#define MOTO_ABLE       PB_ODR_ODR3
#define MOTO_RESET      PB_ODR_ODR7
#define MOTO_EN         PB_DDR &= ~BIT(2);PB_CR1 &= ~BIT(2);PB_CR2 &= ~BIT(2)
#define MOTO_CLOSE      PB_DDR |= BIT(2);PB_CR1 |= BIT(2);PB_CR2 &= ~BIT(2);PB_ODR_ODR2 = 0

#define SIGNA_EN        PA_ODR_ODR1
#define CLOSE_SIGNAL    PE_IDR_IDR5/*回来限位*/
#define OPEN_SIGNAL	PB_IDR_IDR0/*出去限位*/

static uint16_t sleep = 500;
static void (*operation_call)(setp_moto_ask_e pd);
static uint8_t time_id = 0;
static uint8_t sleep_time_id = 0;
static uint8_t is_run = 0;

static void setp_moto_set(setp_moto_e set) {
    if(set == SM_EN) {
        MOTO_EN;
        MOTO_SLEEP  = 1;
        MOTO_ABLE   = 0;
        MOTO_RESET  = 1;
    } else {
        MOTO_CLOSE;
        MOTO_SLEEP  = 0;
        MOTO_ABLE   = 1;
        MOTO_RESET  = 0;
    }
}

static inline void setp_moto_set_sleep(uint16_t sleep) {
    TIM1_ARRH=sleep>>8;           
    TIM1_ARRL=sleep;
}

static event_e open_sign_read(void * pd) {
    if(OPEN_SIGNAL) {
        return E_ENABLE;
    } else {
        return E_DISABLE;
    }
} 

static event_e close_sign_read(void * pd) {
    if(CLOSE_SIGNAL) {
        return E_ENABLE;
    } else {
        return E_DISABLE;
    }
} 

void setp_moto_init(struct _setp_moto_obj * moto) {
    PA_DDR |= BIT(3);
    PA_CR1 |= BIT(3); 
    PA_CR2 |= BIT(3);
    
    PF_DDR |= BIT(4);
    PF_CR1 |= BIT(4); 
    PF_CR2 |= BIT(4);
    
    PB_DDR |= BIT(3);
    PB_CR1 |= BIT(3); 
    PB_CR2 |= BIT(3);
    
    PB_DDR |= BIT(7);
    PB_CR1 |= BIT(7); 
    PB_CR2 |= BIT(7);
    
    MOTO_CLOSE;
    
    PB_DDR |= BIT(6);
    PB_CR1 |= BIT(6); 
    PB_CR2 |= BIT(6);
    
    PE_DDR &= ~BIT(5);
    PE_CR1 |= BIT(5); 
    PE_CR2 &= ~BIT(5);
    
    PB_DDR &= ~BIT(0);
    PB_CR1 |= BIT(0); 
    PB_CR2 &= ~BIT(0);
    
    PA_DDR |= BIT(1);
    PA_CR1 |= BIT(1); 
    PA_CR2 |= BIT(1);
    
    TIM1_PSCRH = 0x0;
    TIM1_PSCRL = 15;
    TIM1_ARRH = 0x01;
    TIM1_ARRL = 0x64;
    TIM1_IER = 0x01;
    TIM1_CR1 = 0x00;
    
    setp_moto_set(SM_CLOSE);
    
    SIGNA_EN = 1;
}

static void sleep_task(void) {
    if(sleep < 700) sleep += 5; else stime_delet(sleep_time_id);
    setp_moto_set_sleep(sleep);
}

static void time_out(void) {
    is_run = 0;
    stime_delet(sleep_time_id);
    setp_moto_set(SM_CLOSE);
    TIM1_CR1 = 0x00;
    if(operation_call != null) {
        operation_call(SA_TIME_OUT);
    }
}

void out_call(void * pd) {
    is_run = 0;
    stime_delet(sleep_time_id);
    stime_delet(time_id);
    setp_moto_set(SM_CLOSE);
    TIM1_CR1 = 0x00;
    if(operation_call != null) {
        operation_call(SA_OK);
    }
}

void setp_moto_open(struct _setp_moto_obj * moto,void (*open_call)(setp_moto_ask_e pd)) {
    if(is_run == 0) {
        if(open_sign_read(null) == E_ENABLE) {
            if(open_call != null) {
                open_call(SA_OK);
            }
        } else {
            is_run = 1;
            operation_call = open_call;
            MOTO_DIR = 1;
            event_create(null,
                         ET_CUSTOM,
                         out_call,
                         moto,
                         open_sign_read);
            time_id = stime_create(2000,ST_ONCE,time_out);
            sleep_time_id = stime_create(30,ST_ALWAYS,sleep_task);
            setp_moto_set(SM_EN);
            TIM1_CR1 = 0x01;
            sleep = 500;
        }
    }
}

void setp_moto_close(struct _setp_moto_obj * moto,void (*close_call)(setp_moto_ask_e pd)) {
    if(is_run == 0) {
        if(close_sign_read(null) == E_ENABLE) {
            if(close_call != null) {
                close_call(SA_OK);
            }
        } else {
            is_run = 1;
            operation_call = close_call;
            MOTO_DIR = 0;
            event_create(null,
                         ET_CUSTOM,
                         out_call,
                         moto,
                         close_sign_read);
            time_id = stime_create(2000,ST_ONCE,time_out);
            sleep_time_id = stime_create(30,ST_ALWAYS,sleep_task);
            setp_moto_set(SM_EN);
            TIM1_CR1 = 0x01;
            sleep = 500;
        }
    }
}

setp_moto_pos_e setp_moto_position(struct _setp_moto_obj * moto) {
    setp_moto_pos_e pos;
    if(open_sign_read(null) == E_ENABLE) {
        pos = SP_OPEN;
    } else if(close_sign_read(null) == E_ENABLE) {
        pos = SP_CLOSE;
    } else {
        pos = SP_NO;
    }
    return pos;
}

#pragma vector=0xD
__interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) {
    TIM1_SR1 &= (~0x01);
    MOTO_STEP = ~MOTO_STEP;
}
