/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "iwdg.h"

void iwdg_init(struct _iwdg_obj * iwdg) {
    IWDG_KR = 0xCC;       //�������Ź�
    IWDG_KR = 0x55;       //���д����
    IWDG_PR = 0x06;       //256��Ƶ�����1.02��
    IWDG_RLR = 255;       //1020ms
    IWDG_KR = 0xAA;       //д����
}

void iwdg_wdt(struct _iwdg_obj * iwdg) {
    IWDG_KR = 0xAA;
}

