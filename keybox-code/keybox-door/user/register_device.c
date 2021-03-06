/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/

#include "register_device.h"
#include "string.h"
#include "uart.h"
#include "led.h"
#include "light.h"
#include "setp_moto.h"
#include "electromagnet.h"
#include "iwdg.h"

static usart_obj usart = {
    .init               = usart_init,
    .draw_send          = uart_send_draw,
    .receive_draw       = uart_receive_draw,
};

static led_obj led = {
    .init       = led_init,
    .tager      = led_tager,
    .set        = led_set,
};

static light_obj light = {
    .init       = light_init,
    .set        = light_set,
    .flash      = light_flash,
};

static setp_moto_obj moto = {
    .init       = setp_moto_init,
    .open       = setp_moto_open,
    .close      = setp_moto_close,
    .position   = setp_moto_position,
};

static elema_obj elema = {
    .init       = lema_init,
    .set        = lema_set,
};

static iwdg_obj iwdg = {
    .init       = iwdg_init,
    .wdt        = iwdg_wdt,
};


void device_init(void) {
    light.init(&light);
    moto.init(&moto);
    led.init(&led);
    usart.init(&usart);
    elema.init(&elema);
    iwdg.init(&iwdg);
}

void * device_get(const char * name) {
    if(strcmp(name,"usart")==0) {
        return &usart;
    } else if(strcmp(name,"led")==0) {
        return &led;
    } else if(strcmp(name,"light")==0) {
        return &light;
    } else if(strcmp(name,"moto")==0) {
        return &moto;
    } else if(strcmp(name,"elema")==0) {
        return &elema;
    } else if(strcmp(name,"iwdg")==0) {
        return &iwdg;
    }
    return null;
}

