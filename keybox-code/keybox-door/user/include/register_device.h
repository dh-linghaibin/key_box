/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _REGISTER_H_
#define _REGISTER_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "fsm.h"
#include "event.h"
    
void device_init(void);
void * device_get(const char * name);
    
#ifdef __cplusplus
}
#endif

#endif