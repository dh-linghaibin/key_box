/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "button.h"


void init(struct _button_obj *but) {
    PD_DDR &= ~BIT(4);
    PD_CR1 |= BIT(4); 
    PD_CR2 &= ~BIT(4);
}

void read(struct _button_obj *but,void(*call_back)(void)) {
    static uint16_t but_delay = 0;
    if(PD_IDR_IDR4 == 0) {
        if(but_delay < 4000) {
            if(but_delay == 4000) {
                but_delay++;
                call_back();
            }
        } else {
            but_delay++;
        }
    } else {
        but_delay = 0;
    }
}
