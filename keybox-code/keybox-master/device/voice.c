/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "voice.h"

void voice_init() {
    PA_DDR |= BIT(1);
    PA_CR1 |= BIT(1); 
    PA_CR2 |= BIT(1);
    
    PA_ODR_ODR1 = 0;/*¹Ø±Õ·äÃùÆ÷*/
}

