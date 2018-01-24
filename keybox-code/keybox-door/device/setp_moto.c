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

void setp_moto_init(void) {
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

static uint16_t sleep = 500;

void sleep_task(void) {
    if(sleep < 700)
    sleep += 5;
    setp_moto_set_sleep(sleep);
}

event_e open_sign_read(void * pd) {
    if(CLOSE_SIGNAL) {
        return E_ENABLE;
    } else {
        return E_DISABLE;
    }
} 

void open_call(void * pd) {
    setp_moto_set(SM_CLOSE);
    TIM1_CR1 = 0x00;
}

void setp_moto_open(void) {
    event_create(null,
                 ET_CUSTOM,
                 open_call,
                 null,
                 open_sign_read);
    
    setp_moto_set(SM_EN);
    TIM1_CR1 = 0x01;
    sleep = 500;
    stime_create(30,ST_ALWAYS,sleep_task);
}

#pragma vector=0xD
__interrupt void TIM1_UPD_OVF_TRG_BRK_IRQHandler(void) {
    TIM1_SR1 &= (~0x01);
    MOTO_STEP = ~MOTO_STEP;
}
