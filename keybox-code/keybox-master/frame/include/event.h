/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _EVENT_H_
#define _EVENT_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

typedef enum _event_e{
    E_ENABLE    = 1,
    E_DISABLE   = 0,
    E_ERROR     = -1,
}event_e;
    
typedef struct _event_obj {
    event_e is_enable;
    uint8_t *flag_addr;
    void(*call_back)(void *);
}event_obj;

void event_init(void);
int event_create(uint8_t *flag_addr,void(*call_back)(void *));
int event_delet(int id);
void event_loop(void);

#ifdef __cplusplus
}
#endif

#endif
