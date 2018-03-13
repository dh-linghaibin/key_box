/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2018 linghaibin
 *
 */

#ifndef _DOOR_COUNT_H_
#define _DOOR_COUNT_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

void door_check_task(uint16_t rep,void(*check_ok_h)(void *));

#ifdef __cplusplus
}
#endif

#endif

