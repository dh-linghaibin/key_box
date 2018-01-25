/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _LIGHT_H_
#define _LIGHT_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "fsm.h"
#include "event.h"

typedef enum _light_e{
    L_OPEN = 1,
    L_CLOSE = 0,
}light_e;
    
typedef struct _light_obj {
    void (*init)(struct _light_obj *);
    void (*set)(struct _light_obj *,light_e);
}light_obj;
    
void light_init(struct _light_obj * light);
void light_set(struct _light_obj * light,light_e cmd);

#ifdef __cplusplus
}
#endif

#endif
