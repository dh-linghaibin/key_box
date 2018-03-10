/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _IWDG_H_
#define _IWDG_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "fsm.h"
#include "event.h"
    
typedef struct _iwdg_obj {
    void (*init)(struct _iwdg_obj *);
    void (*wdt)(struct _iwdg_obj *);
} iwdg_obj;    

void iwdg_init(struct _iwdg_obj *);
void iwdg_wdt(struct _iwdg_obj *);

#ifdef __cplusplus
}
#endif

#endif