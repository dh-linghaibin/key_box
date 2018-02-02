/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _EPROM_H_
#define _EPROM_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include <assert.h>  
#include "fsm.h"

//    2K
    
typedef enum _eprom_e{
  EP_FLAG = 0x01,
  EP_MOTO_POS = 0x02,
} eprom_e;
    
typedef struct _eprom_obj {
    void (*init)(struct _eprom_obj *);
    void (*write)(struct _eprom_obj *,uint16_t Adr, uint8_t *pData, uint16_t Len);
    void (*read)(struct _eprom_obj *,uint16_t Adr, uint8_t *pData, uint16_t Len);
} eprom_obj;

void eprom_init(struct _eprom_obj * eprom);
void eprom_write(struct _eprom_obj * eprom,uint16_t Adr, uint8_t *pData, uint16_t Len);
void eprom_read(struct _eprom_obj * eprom,uint16_t Adr, uint8_t *pData, uint16_t Len);

#ifdef __cplusplus
}
#endif

#endif
