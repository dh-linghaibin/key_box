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
    receipt_bit_e layer[16];
}receipt_bit_obj;

typedef struct _receipt_obj {
    void (*init)(struct _receipt_obj *);
    void (*open)(struct _receipt_obj *);
    void (*get) (struct _receipt_obj *,uint8_t,void(*call_back)(void *));
}receipt_obj;

void receipt_init(struct _receipt_obj *);
void receipt_open(struct _receipt_obj * receipt);
void receipt_get(struct _receipt_obj *,
                 uint8_t layer,
                 void(*call_back)(void *));

#ifdef __cplusplus
}
#endif

#endif
