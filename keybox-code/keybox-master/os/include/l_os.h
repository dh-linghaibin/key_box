/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _L_OS_H_
#define _L_OS_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"

typedef struct _task_tcb_obj{
  uint16_t StackTop;
  uint8_t priority;
  uint8_t Remain_Time;
}task_tcb_obj;

void los_init(void);
void los_create(void (*function)(void),uint8_t* StackTop,uint8_t priority);
void los_delay(uint8_t time);
void los_start(void);

#ifdef __cplusplus
}
#endif

#endif