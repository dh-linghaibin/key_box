/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _SETP_MOTO_H_
#define _SETP_MOTO_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"

typedef struct _setp_moto_obj {
    uint16_t now_position;
    uint16_t stop_arr[40];
    void (*init)(struct _setp_moto_obj *);
}setp_moto_obj;
    
#ifdef __cplusplus
}
#endif

#endif