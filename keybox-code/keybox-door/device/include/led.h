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
    
typedef enum _led_val {
    LV_OPEN = 1,
    LV_CLOSE = 0,
} led_val;
    
typedef struct _led_obj {
    uint8_t flash;
    void (*init)(struct _led_obj *);
    void (*tager)(struct _led_obj *);
    void (*set)(struct _led_obj *,led_val);
} led_obj;

void led_init(struct _led_obj * led);
void led_tager(struct _led_obj * led);
void led_set(struct _led_obj *,led_val);
    
#ifdef __cplusplus
}
#endif

#endif
