/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "button.h"
#include "event.h"

void init(struct _button_obj *but) {
    PD_DDR &= ~BIT(4);
    PD_CR1 |= BIT(4); 
    PD_CR2 &= ~BIT(4);
   
    PD_DDR |= BIT(3); /* 进仓按钮 */
    PD_CR1 |= BIT(3); 
    PD_CR2 |= BIT(3);
    
    PD_ODR_ODR3  = 1; /* 关闭LED */
}

static event_e button_task(void * pd) {
    static uint16_t but_delay = 0;
    if(PD_IDR_IDR4 == 0) {
        if(but_delay >= 200) {
            if(but_delay == 200) {
                but_delay++;
                PD_ODR_ODR3  = 1;
                return E_ENABLE;
            }
        } else {
            but_delay++;
        }
    } else {
        but_delay = 0;
    }
    return E_DISABLE;
}

void read(struct _button_obj *but,void(*call_back)(void *)) {
    PD_ODR_ODR3  = 0;
    event_create("button",null,
             ET_CUSTOM,
             call_back,
             null,
             button_task);
}

void button_del_read(struct _button_obj * button) {
    event_delet("button");
    PD_ODR_ODR3  = 1; /* 关闭LED */
}
