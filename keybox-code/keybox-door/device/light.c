/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "light.h"


void light_init(struct _light_obj * light) {
    /***ÕÕÃ÷µÆ****/
    PB_DDR |= BIT(1);
    PB_CR1 |= BIT(1); 
    PB_CR2 |= BIT(1);
    PB_ODR_ODR1 = 0;
}

void light_set(struct _light_obj * light,light_e cmd) {
    PB_ODR_ODR1 = cmd;
}


