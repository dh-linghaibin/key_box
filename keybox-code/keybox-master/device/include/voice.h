/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _VOICE_H_
#define _VOICE_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

typedef enum _voice_e {
    V_OPEN = 1,
    V_CLOSE = 0,
}voice_e;

typedef struct _voice_obj {
    void (*init)(struct _voice_obj *);
    void (*set)(struct _voice_obj *,voice_e);
} voice_obj;

void voice_init(struct _voice_obj * voice);
void voice_set(struct _voice_obj * voice,voice_e cmd);

#ifdef __cplusplus
}
#endif

#endif
