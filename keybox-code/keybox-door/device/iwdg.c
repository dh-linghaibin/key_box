/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */

#include "iwdg.h"

void iwdg_init(struct _iwdg_obj * iwdg) {
    IWDG_KR = 0xCC;       //启动看门狗
    IWDG_KR = 0x55;       //解除写保护
    IWDG_PR = 0x06;       //256分频，最高1.02秒
    IWDG_RLR = 255;       //1020ms
    IWDG_KR = 0xAA;       //写保护
}

void iwdg_wdt(struct _iwdg_obj * iwdg) {
    IWDG_KR = 0xAA;
}

