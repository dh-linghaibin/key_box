/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "stime.h"

#define BEST_STIME 30
static struct _stime_obj list_time[BEST_STIME];
static uint16_t timeslice = 0;

int create_stime(uint8_t sec, void (*time_up)(void)) {
    register uint8_t i = 0;
    for(i = 0;i < BEST_STIME;i++) {
        if(list_time[i].is_enable == ST_DISABLE) {
            list_time[i].time_up = time_up;
            list_time[i].end_t = timeslice+sec*60;
            list_time[i].is_enable = ST_ENABLE;
            return i;
        }
    }
    return -1;
}

void input_loop(void) {
    static uint16_t loop = 0;
    if(loop < 500) {
        loop++;
    } else {
        loop = 0;
        if(timeslice < 65000) timeslice++; else timeslice = 0;
        register uint8_t i = 0;
        for(i = 0;i < BEST_STIME;i++) {
            if(list_time[i].is_enable == ST_ENABLE) {
                if(list_time[i].end_t == timeslice) {
                    if(list_time[i].time_up != null) {
                        list_time[i].is_enable = ST_DISABLE;
                        list_time[i].time_up();
                    }
                }
            }
        }
    }
}