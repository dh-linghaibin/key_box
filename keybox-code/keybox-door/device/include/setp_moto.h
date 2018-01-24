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

typedef struct _setp_moto_obj {
    void (*init)(struct _setp_moto_obj *);
    void (*open)(struct _setp_moto_obj *);
    void (*close)(struct _setp_moto_obj *);
} setp_moto_obj;

void setp_moto_init(void);

#ifdef __cplusplus
}
#endif

#endif
