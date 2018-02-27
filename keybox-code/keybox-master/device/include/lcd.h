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
    void (*init)(struct _lcd_obj *lcd);
    void (*show_string)(struct _lcd_obj *lcd,uint8_t x,uint8_t y,uint8_t *p);
    void (*show_int)(struct _lcd_obj *lcd,uint8_t x,uint8_t y,int p);
}lcd_obj;

void lcd_init(struct _lcd_obj *lcd);
void lcd_show_string(struct _lcd_obj *lcd,uint8_t x,uint8_t y,uint8_t *p);
void lcd_show_int(struct _lcd_obj *lcd,uint8_t x,uint8_t y,int p);

#ifdef __cplusplus
}
#endif

#endif
