/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _BUTTON_H_
#define _BUTTON_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"
    
typedef enum _button_e{
    B_UP = 0,
    B_DOWN,
}button_e;
    
typedef struct _button_obj {
    void (*init)(struct _button_obj *);
    void (*read)(struct _button_obj *,void(*call_back)(void *));
    void (*del_read)(struct _button_obj *);
}button_obj;

void init(struct _button_obj *);
void read(struct _button_obj *,void(*call_back)(void *));
void button_del_read(struct _button_obj * button);

#ifdef __cplusplus
}
#endif

#endif
