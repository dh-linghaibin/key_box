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

#include "stdint.h"
#include "fsm.h"
#include "event.h"
    
typedef enum _setp_moto_e {
    SM_EN = 0,
    SM_CLOSE = 1,
} setp_moto_e;

typedef enum _setp_moto_ask_e {
    SA_OK = 0,
    SA_TIME_OUT = 1,
} setp_moto_ask_e;

typedef enum _setp_moto_pos_e {
    SP_OPEN = 0,
    SP_CLOSE = 1,
    SP_NO =2,
} setp_moto_pos_e;

typedef struct _setp_moto_obj {
    void (*init)(struct _setp_moto_obj *);
    void (*open)(struct _setp_moto_obj *,void (*open_call)(setp_moto_ask_e pd));
    void (*close)(struct _setp_moto_obj *,void (*close_call)(setp_moto_ask_e pd));
    setp_moto_pos_e (*position)(struct _setp_moto_obj *);
} setp_moto_obj;

void setp_moto_init(struct _setp_moto_obj * moto);
void setp_moto_open(struct _setp_moto_obj * moto,void (*open_call)(setp_moto_ask_e pd));
void setp_moto_close(struct _setp_moto_obj * moto,void (*close_call)(setp_moto_ask_e pd));
setp_moto_pos_e setp_moto_position(struct _setp_moto_obj * moto);

#ifdef __cplusplus
}
#endif

#endif
