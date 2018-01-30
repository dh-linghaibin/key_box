/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _ELECTROMAGENET_H_
#define _ELECTROMAGENET_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "fsm.h"
#include "event.h"

typedef enum _elema_e{
    E_LOCK = 0,
    E_OPEN = 1,
}elema_e;
    
typedef struct _elema_obj {
    void (*init)(struct _elema_obj *);
    void (*set)(struct _elema_obj *,elema_e);
}elema_obj;
    
void lema_init(struct _elema_obj * elema);
void lema_set(struct _elema_obj * elema,elema_e cmd);

#ifdef __cplusplus
}
#endif

#endif
