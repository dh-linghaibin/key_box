/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "receipt.h"

#define pla_dc PA_ODR_ODR2

void receipt_init(void) {
    PB_DDR &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
    PB_CR1 |= ( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) ); 
    PB_CR2 &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
    PE_DDR &= ~( BIT(6)|BIT(7) );
    PE_CR1 |= ( BIT(6)|BIT(7) ); 
    PE_CR2 &= ~( BIT(6)|BIT(7) );
    /***电源24V使能按钮PC2****/
    PC_DDR |= BIT(2);
    PC_CR1 |= BIT(2); 
    PC_CR2 |= BIT(2);
}

receipt_bit_e receipt_get(uint8_t layer) {
    switch(layer) {
        case 0: {
            return PB_IDR_IDR7;
        } break;
        case 1: {
            return PB_IDR_IDR6;
        } break;
        case 2: {
            return PB_IDR_IDR5;
        } break;
        case 3: {
            return PB_IDR_IDR4;
        } break;
        case 4: {
            return PB_IDR_IDR3;
        } break;
        case 5: {
            return PB_IDR_IDR2;
        } break;
        case 6: {
            return PB_IDR_IDR1;
        } break;        
        case 7: {
            return PB_IDR_IDR0;
        } break;
        case 8: {
            return PE_IDR_IDR7;
        } break;
        case 9: {
            return PE_IDR_IDR6;
        } break;
    }
    return RB_NO_HAVE;
}
