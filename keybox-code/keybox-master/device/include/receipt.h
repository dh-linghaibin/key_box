/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _RECEIPT_H_
#define _RECEIPT_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"

typedef enum _receipt_bit_e{
    RB_HAVE = 1,
    RB_NO_HAVE = 0,
}receipt_bit_e;
 
typedef struct _receipt_bit_obj {
    receipt_bit_e layer1      : 1;
    receipt_bit_e layer2      : 1;
    receipt_bit_e layer3      : 1;
    receipt_bit_e layer4      : 1;
    receipt_bit_e layer5      : 1;
    receipt_bit_e layer6      : 1;
    receipt_bit_e layer7      : 1;
    receipt_bit_e layer8      : 1;
    
    receipt_bit_e layer9      : 1;
    receipt_bit_e layer10     : 1;
    receipt_bit_e layer11     : 1;
    receipt_bit_e layer12     : 1;
    receipt_bit_e layer13     : 1;
    receipt_bit_e layer14     : 1;
    receipt_bit_e layer15     : 1;
    receipt_bit_e layer16     : 1;
}receipt_bit_obj;

typedef struct _receipt_obj {
    receipt_bit_obj receipt_bit;
    void(*init)(struct _receipt_obj *);
   // void(*init)(struct _receipt_obj *);
}receipt_obj;

void receipt_init(void);
receipt_bit_e receipt_get(uint8_t layer);

#ifdef __cplusplus
}
#endif

#endif
