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

typedef enum _door_bit {
    D_OPEN = 0,
    D_CLOSE_NO = 1,
    D_CLOSE_HAVA = 2,
} door_bit;
    
void open_draw(uint8_t r_num,uint8_t draw_num,uint16_t rep);
void close_draw(uint8_t r_num,uint8_t draw_num);
void draw_zero(uint16_t rep);
door_bit get_door_bit(void);

#ifdef __cplusplus
}
#endif

#endif