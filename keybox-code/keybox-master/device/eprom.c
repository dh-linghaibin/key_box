/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "eprom.h"

void eprom_read() {
    
}

/********************************************************************************************************
*  Function: Derive_FlashUNLock                                                                        
*  Object: 解锁ROM
*  输入： 无
*  输出： 无                                         
*  备注:  无
********************************************************************************************************/
void Derive_FlashUNLock(void) {
    do
    {
        FLASH_DUKR = 0xae;                    // 写入第一个密钥
        FLASH_DUKR = 0x56;                    // 写入第二个密钥
    } 
    while(!(FLASH_IAPSR&0X08));                      // 等待解锁
}

/********************************************************************************************************
*  Function: Derive_EPWrite                                                                        
*  Object: 写EEPROM
*  输入： 头地址(0~1535)  数据指针  数据长
*  输出： 无                                         
*  备注: 1.5K EEPROM  不能超过
********************************************************************************************************/
void Derive_EPWrite(uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    //p指针指向EEPROM 对应的单元
    p = (uint8_t*)0x4000 + Adr;   
    //解锁
    Derive_FlashUNLock();
    //写数据
    for( ; Len > 0; Len--)
    {
        *p++ = *pData++;
        //等待写完成
        while(!(FLASH_IAPSR&0X40)); 
    } 
    //加锁
    FLASH_IAPSR &= ~BIT(1);
}

/********************************************************************************************************
*  Function: Derive_EPRead                                                                         
*  Object: 读EEPROM
*  输入： 头地址(0~1535) 数据存放指针 数据长
*  输出： 无                                         
*  备注: 1.5K EEPROM
********************************************************************************************************/
void Derive_EPRead(uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    //p指针指向EEPROM 对应的单元
    p = (uint8_t*)0x4000 + Adr; 
    //解锁
    Derive_FlashUNLock();
    //读数据
    for( ; Len > 0; Len--)
        *pData++ = *p++;
    //加锁EEPROM
    FLASH_IAPSR &= ~BIT(1);
}

