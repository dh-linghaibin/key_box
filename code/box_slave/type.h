/***********************************************************
* ÎÄµµ: type.h
* ×÷Õß: Haibin Ling
* ÃèÊö: 1.
*       2.
***********************************************************/
#ifndef TYPE_H_
#define TYPE_H_
#include "main.h"


void BSP_Init(void);
void Addr_Read(u16 *address);
void delayms(u16 ms); 

void UART1_Init(void);
void UART1_Sendint(u8 ch);
void UART1_Send(u8 *Array,u8 command,u8 situ);

u8 robot_mode(u8 mode);
void SetLed(u8 cmd);
void Eeprom_Init(void);
u8 Eeprom_Read(u8 addr);
void eeprom_count(u8 ad);
void Eeprom_Write(u8 addr,u8 dat);

#endif



