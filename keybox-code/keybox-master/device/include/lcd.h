/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _LCD_H_
#define _LCD_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

typedef struct _lcd_obj {
    uint8_t x;
    uint8_t y;
}lcd_obj;

void lcd_init(void);

#ifdef __cplusplus
}
#endif

#endif
