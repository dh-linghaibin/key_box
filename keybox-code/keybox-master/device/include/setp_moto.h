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
#include "event.h"

#define BEST_DRAW 52

typedef enum _setp_moto_gign_e{
    SMG_OK = 1,
    SMG_NO = 0,
}setp_moto_gign_e;
    
typedef enum _setp_moto_e{
    SM_OK = 1,
    SM_WAIT = 2,
    SM_ERROR = 0,
}setp_moto_e;
    
typedef struct _setp_moto_obj {
    uint16_t now_position;
    uint16_t *stop_arr;
    void (*init)(struct _setp_moto_obj *);
    int (*rotate)( struct _setp_moto_obj * moto_s,uint16_t to_position,void (call_back)(void *) );
    int (*reset)(struct _setp_moto_obj * motox,void (*call_back)(uint8_t flag));
} setp_moto_obj;
    
void setp_moto_init(struct _setp_moto_obj *);
int setp_moto_rotate( struct _setp_moto_obj * moto_s,uint16_t to_position,void (call_back)(void *) );
int setp_moto_zero(struct _setp_moto_obj * motox,void (*call_back)(uint8_t flag));

#ifdef __cplusplus
}
#endif

#endif