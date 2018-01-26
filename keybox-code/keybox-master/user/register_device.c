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
#include "voice.h"
#include "receipt.h"
#include "button.h"
#include "setp_moto.h"

usart_obj usart = {
    .init               = usart_init,
    .draw_send          = uart_send_draw,
    .receive_draw       = uart_receive_draw,
    .pc_send            = uart_send_pc,
    .receive_pc         = uart_receive_pc,
};

led_obj led = {
    .init       = led_init,
    .blank      = led_blank,
};

voice_obj voice = {
    .init       = voice_init,
    .set        = voice_set,
};

receipt_obj receipt = {
    .init       = receipt_init,
    .get        = receipt_get,       
};

button_obj button = {
    .init       = init,
    .read       = read,
};

setp_moto_obj setp_moto = {
    .init       = setp_moto_init,
    .rotate     = setp_moto_rotate,
};

void device_init(void) {
    usart.init(&usart);
    led.init(&led);
    voice.init(&voice);
    receipt.init(&receipt);
    button.init(&button);
    setp_moto.init(&setp_moto);
}

void * device_get(const char * name) {
    if(strcmp(name,"usart")==0) {
        return &usart;
    } else if(strcmp(name,"led")==0) {
        return &led;
    } else if(strcmp(name,"voice")==0) {
        return &voice;
    } else if(strcmp(name,"receipt")==0) {
        return &receipt;
    } else if(strcmp(name,"button")==0) {
        return &button;
    } else if(strcmp(name,"setp_moto")==0) {
        return &button;
    }
    return null;
}

