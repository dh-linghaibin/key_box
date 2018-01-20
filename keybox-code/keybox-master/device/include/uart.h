/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#ifndef _UART_H_
#define _UART_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "iostm8s207m8.h"
#include "stdint.h"
#include "fsm.h"

typedef struct _usart_obj {
	void    (*init)(struct _usart_obj* usart,uint32_t baud_rate);
	void    (*send)(struct _usart_obj* usart,uint8_t dat);
}usart_obj;

#ifdef __cplusplus
}
#endif

#endif

