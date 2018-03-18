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
#include "eprom.h"
#include "lcd.h"
#include "iwdg.h"

static usart_obj usart = {
    .init               = usart_init,
    .draw_send          = uart_send_draw,
    .receive_draw       = uart_receive_draw,
    .pc_send            = uart_send_pc,
    .receive_pc         = uart_receive_pc,
    .get_id             = uart_get_id,
};

static led_obj led = {
    .init       = led_init,
    .blank      = led_blank,
};

static voice_obj voice = {
    .init       = voice_init,
    .set        = voice_set,
};

static receipt_obj receipt = {
    .init       = receipt_init,
    .open       = receipt_open,
    .get        = receipt_get,       
};

static button_obj button = {
    .init       = init,
    .read       = read,
    .del_read   = button_del_read,
};

static const uint16_t draw_pos[52] = {
    0,7,14,21,28,35,42,49,56,63,70,77,84,
    100,107,114,121,128,135,142,149,156,163,170,177,184,
    200,207,214,221,228,235,242,249,256,263,270,277,284,
    300,307,314,321,328,335,342,349,356,363,370,377,384
};
static setp_moto_obj setp_moto = {
    .stop_arr   = (uint16_t *)draw_pos,
    .init       = setp_moto_init,
    .rotate     = setp_moto_rotate,
    .reset      = setp_moto_zero,
};

static eprom_obj eprom = {
    .init       = eprom_init,
    .write      = eprom_write,
    .read       = eprom_read,
};

static lcd_obj lcd = {
    .init       = lcd_init,
    .show_string = lcd_show_string,
    .show_int   = lcd_show_int,
};


static iwdg_obj iwdg = {
    .init       = iwdg_init,
    .wdt        = iwdg_wdt,
};


void device_init(void) {
    usart.init(&usart);
    led.init(&led);
    voice.init(&voice);
    receipt.init(&receipt);
    button.init(&button);
    setp_moto.init(&setp_moto);
    eprom.init(&eprom);
    lcd.init(&lcd);
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
        return &setp_moto;
    } else if(strcmp(name,"eprom")==0) {
        return &eprom;
    } else if(strcmp(name,"lcd")==0) {
        return &lcd;
    } else if(strcmp(name,"iwdg")==0) {
        return &iwdg;
    }
    return null;
}

