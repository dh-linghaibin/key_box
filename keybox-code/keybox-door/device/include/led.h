/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _LED_H_
#define _LED_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "fsm.h"
#include "event.h"
    
typedef struct _led_obj {
    void (*init)(struct _led_obj *);
    void (*tager)(struct _led_obj *);
} led_obj;

void led_init(struct _led_obj * led);
void led_tager(struct _led_obj * led);
    
#ifdef __cplusplus
}
#endif

#endif
