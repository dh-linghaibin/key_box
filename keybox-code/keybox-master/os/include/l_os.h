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


typedef struct{
  unsigned int StackTop;
  unsigned char priority;
  unsigned char Remain_Time;
  
} TCB_Task;

#ifdef __cplusplus
}
#endif

#endif