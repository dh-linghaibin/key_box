/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "voice.h"

void voice_init(struct _voice_obj * voice) {
    PA_DDR |= BIT(1);
    PA_CR1 |= BIT(1); 
    PA_CR2 |= BIT(1);
    
    PA_ODR_ODR1 = V_CLOSE;
}

void voice_set(struct _voice_obj * voice,voice_e cmd) {
    PA_ODR_ODR1 = cmd;
}


