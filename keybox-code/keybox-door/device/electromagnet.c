/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "electromagnet.h"


void lema_init(struct _elema_obj * elema) {
    /***ÕÕÃ÷µÆ****/
    PA_DDR |= BIT(2);
    PA_CR1 |= BIT(2); 
    PA_CR2 |= BIT(2);
    PA_ODR_ODR1 = E_LOCK;
}

void lema_set(struct _elema_obj * elema,elema_e cmd) {
    PA_ODR_ODR2 = cmd;
}


