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

#include "iostm8s207m8.h"
#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

void led_init(void);
void led_taggle(void);

#ifdef __cplusplus
}
#endif

#endif
