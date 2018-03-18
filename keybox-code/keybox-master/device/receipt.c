/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "receipt.h"
#include "stime.h"

static receipt_bit_e receipt_read_bit(uint8_t layer);
#define REC PC_ODR_ODR2
static void(*receipt_call_back)(void *);
static uint8_t is_run = 0;

void receipt_init(struct _receipt_obj * receipt) {
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
    
    PC_ODR_ODR2 = 0;//0
}

void receipt_open(struct _receipt_obj * receipt) {
    PC_ODR_ODR2 = 1;
}

static receipt_bit_e receipt_read_bit(uint8_t layer) {
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

static void receipt_read_call_back(void) {
    receipt_bit_obj receipt_bit;
    register int i = 0;
    for(i = 0; i < 10; i++) {
        receipt_bit.layer[i] = receipt_read_bit(i);
    }
    PC_ODR_ODR2 = 0;
    is_run = 0;
    if(receipt_call_back != null) {
        receipt_call_back(&receipt_bit);
    }
}

void receipt_get(struct _receipt_obj * receipt,
                 uint8_t layer,
                 void(*call_back)(void *)) {
    if(is_run == 0) {
        receipt_call_back = call_back;
        if(stime_create("re_j",50,ST_ONCE,receipt_read_call_back) > 0) {
            PC_ODR_ODR2 = 1;
            is_run = 1;
        }
    }
}
