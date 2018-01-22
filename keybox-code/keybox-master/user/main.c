/*
* This file is part of the 
*
* Copyright (c) 2016-2017 linghaibin
*
*/
#include "stime.h"
#include "l_os.h"
#include "uart.h"

void time(void) {
    int i = 0;
    i++;
}

static unsigned char Task0Stack[100];
static unsigned char Task1Stack[100];
void task_led(void) {
    while(1) {
        PC_ODR_ODR1=~PC_IDR_IDR1;
        los_delay(200);
        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
//        los_delay(200);
        usart_tx_msg_obj msg;
        msg.id = 0x01;
        msg.cmd = 0x01;
        msg.len = 0x01;
        msg.data[0] = 0x01;
        uart_send_pc(msg);
    }
}
void task_led2(void) {
    while(1) {
        los_delay(20);
    }
}

int main( void ) {
    los_init();
    usart_init();
    PA_DDR |= BIT(1);
    PA_CR1 |= BIT(1); 
    PA_CR2 |= BIT(1);
    
    PC_DDR |= BIT(1);
    PC_CR1 |= BIT(1); 
    PC_CR2 |= BIT(1);
    
    PA_ODR_ODR1 = 0;/*¹Ø±Õ·äÃùÆ÷*/
    
    los_create(task_led,&Task0Stack[99],1);
    los_create(task_led2,&Task1Stack[99],2);  
    los_start();
    
    create_stime(5,time);
    while(1) {
        input_loop();
    }
}


