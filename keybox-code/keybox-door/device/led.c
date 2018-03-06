/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "led.h"

void led_init(struct _led_obj * led) {
    PC_DDR |= BIT(1);
    PC_CR1 |= BIT(1); 
    PC_CR2 |= BIT(1);
}

void led_tager(struct _led_obj * led) {
    PC_ODR_ODR1=~PC_IDR_IDR1;
}

void led_set(struct _led_obj * led,led_val val) {
    PC_ODR_ODR1 = val;
}
