/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2018 linghaibin
 *
 */

#ifndef _OPEN_DRAW_H_
#define _OPEN_DRAW_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <assert.h>  
#include "fsm.h"

void open_draw(uint8_t r_num,uint8_t draw_num);
void close_draw(uint8_t r_num,uint8_t draw_num);

#ifdef __cplusplus
}
#endif

#endif