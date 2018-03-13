/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "eprom.h"

static void eprom_un_luck(void) {
    do {
        FLASH_DUKR = 0xae;
        FLASH_DUKR = 0x56; 
    } while(!(FLASH_IAPSR&0X08));
}

static void eprom_luck(void) {
    FLASH_IAPSR &= ~BIT(1);
}

void eprom_init(struct _eprom_obj * eprom) {
    uint8_t flag = 0x00;
    eprom->read(eprom,EP_FLAG,&flag,1);
    if(flag != 0x55) { /* ∏Ò ΩªØ */
        uint8_t cla[1024];
        for(register int i = 0;i < 1024;i++) cla[i] = 0x00;
        eprom->write(eprom,EP_MOTO_POS,cla,1024);
        flag = 0x55;
        eprom->write(eprom,EP_FLAG,&flag,1);
    } 
}

void eprom_write(struct _eprom_obj * eprom,uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    p = (uint8_t*)0x4000 + Adr;   
    eprom_un_luck();
    for( ; Len > 0; Len--) {
        *p++ = *pData++;
        while(!(FLASH_IAPSR&0X40)); 
    } 
    eprom_luck();
}

void eprom_read(struct _eprom_obj * eprom,uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    p = (uint8_t*)0x4000 + Adr; 
    eprom_un_luck();
    for( ; Len > 0; Len--)
        *pData++ = *p++;
    eprom_luck();
}

