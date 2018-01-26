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
*  Object: ����ROM
*  ���룺 ��
*  ����� ��                                         
*  ��ע:  ��
********************************************************************************************************/
void Derive_FlashUNLock(void) {
    do
    {
        FLASH_DUKR = 0xae;                    // д���һ����Կ
        FLASH_DUKR = 0x56;                    // д��ڶ�����Կ
    } 
    while(!(FLASH_IAPSR&0X08));                      // �ȴ�����
}

/********************************************************************************************************
*  Function: Derive_EPWrite                                                                        
*  Object: дEEPROM
*  ���룺 ͷ��ַ(0~1535)  ����ָ��  ���ݳ�
*  ����� ��                                         
*  ��ע: 1.5K EEPROM  ���ܳ���
********************************************************************************************************/
void Derive_EPWrite(uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    //pָ��ָ��EEPROM ��Ӧ�ĵ�Ԫ
    p = (uint8_t*)0x4000 + Adr;   
    //����
    Derive_FlashUNLock();
    //д����
    for( ; Len > 0; Len--)
    {
        *p++ = *pData++;
        //�ȴ�д���
        while(!(FLASH_IAPSR&0X40)); 
    } 
    //����
    FLASH_IAPSR &= ~BIT(1);
}

/********************************************************************************************************
*  Function: Derive_EPRead                                                                         
*  Object: ��EEPROM
*  ���룺 ͷ��ַ(0~1535) ���ݴ��ָ�� ���ݳ�
*  ����� ��                                         
*  ��ע: 1.5K EEPROM
********************************************************************************************************/
void Derive_EPRead(uint16_t Adr, uint8_t *pData, uint16_t Len) {
    uint8_t *p;
    //pָ��ָ��EEPROM ��Ӧ�ĵ�Ԫ
    p = (uint8_t*)0x4000 + Adr; 
    //����
    Derive_FlashUNLock();
    //������
    for( ; Len > 0; Len--)
        *pData++ = *p++;
    //����EEPROM
    FLASH_IAPSR &= ~BIT(1);
}

