/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _STIME_H_
#define _STIME_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"
    
typedef enum _stime_e{
    ST_ENABLE = 1,
    ST_DISABLE = 0,
}stime_e;

typedef struct _stime_obj {
    stime_e is_enable;
    uint16_t end_t;
    void (*time_up)(void);
}stime_obj;

int create_stime(uint8_t sec, void (*time_up)(void));
void input_loop(void);

#ifdef __cplusplus
}
#endif

#endif