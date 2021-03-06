/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "stime.h"
#include <string.h>

static struct _stime_obj list_time[BEST_STIME];
static uint16_t timeslice = 0;

void stime_init(void) {
    register int i = 0;
    for(i = 0;i < BEST_STIME;i++) {
        list_time[i].is_enable = ST_DISABLE;
    }
    
    CLK_CKDIVR=0x00;
    TIM2_PSCR=0x04;//1/4prescale
    TIM2_ARRH=0x3;
    TIM2_ARRL=0xE8;
    TIM2_CNTRH=0x00;
    TIM2_CNTRL=0x00;
    TIM2_CR1=MASK_TIM2_CR1_ARPE|MASK_TIM2_CR1_CEN;
    TIM2_IER=0x01;
    asm("rim");
}

int stime_create(const char *name,
                 uint16_t sec,
                 stime_type_e type,
                 void (*time_up)(void)) {
    register uint8_t i = 0;
    
    for(i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_ENABLE) {
            if(strcmp(name,list_time[i].name) == 0) {
                list_time[i].time_up   = time_up;
                list_time[i].end_t     = sec;
                list_time[i].time      = sec;
                list_time[i].type      = type;
                list_time[i].is_enable = ST_ENABLE;
                list_time[i].name      = (char *)name;
                return i;
            }
        }
    }
    
    for(i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_DISABLE) {
            list_time[i].time_up   = time_up;
            list_time[i].end_t     = sec;
            list_time[i].time      = sec;
            list_time[i].type      = type;
            list_time[i].is_enable = ST_ENABLE;
            list_time[i].name      = (char *)name;
            return i;
        }
    }
    return -1;
}

int stime_delet(const char *name) {
    for(register uint8_t i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_ENABLE) {
            if(strcmp(name,list_time[i].name) == 0) {
                list_time[i].is_enable = ST_DISABLE;
                return i;
            }
        }
    }
    return -1;
}

void stime_loop(void) {
    register uint8_t i = 0;
    for(i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_ENABLE) {
            if(list_time[i].end_t == 0) {
                if(list_time[i].time_up != null) {
                    if(list_time[i].type == ST_ONCE) {
                        list_time[i].is_enable = ST_DISABLE;
                    } else {
                        list_time[i].end_t = list_time[i].time;
                    }
                    list_time[i].time_up();
                }
            }
        }
    }
}


#pragma vector=TIM2_OVR_UIF_vector
__interrupt void Tim2_Overflow(void) {
    asm("sim");
    
    TIM2_SR1=0;//清楚中断标志位
    timeslice++;
    register uint8_t i = 0;
    for(i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_ENABLE) {
            if(list_time[i].end_t > 0) {
               list_time[i].end_t--; 
            }
        }
    }
    
    asm("sim");
}

