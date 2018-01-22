/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "lcd.h"

void led_init(void) {
    PC_DDR |= BIT(1);
    PC_CR1 |= BIT(1); 
    PC_CR2 |= BIT(1);
}

void led_taggle(void) {
    PC_ODR_ODR1=~PC_IDR_IDR1;
}
