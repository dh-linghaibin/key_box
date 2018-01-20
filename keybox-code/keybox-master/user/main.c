/*
 * This file is part of the 
 *
 * Copyright (c) 2016-2017 linghaibin
 *
 */
#include "stime.h"

void time(void) {
    int i = 0;
    i++;
}

int main( void )
{
    create_stime(5,time);
    while(1) {
        input_loop();
    }
}
