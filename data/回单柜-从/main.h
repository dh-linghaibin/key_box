/***********************************************************
* 文档: main.h
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#ifndef MAIN_H_
#define MAIN_H_
#include "STM8S103K.h"
/*数据类型定义*/
typedef unsigned char    u8;
typedef unsigned int     u16;
typedef unsigned long    u32;
typedef signed char    s8;
typedef signed int     s16;
typedef signed long    s32;

#define BIT(x) (1 << (x))

#define WDT()	IWDG_KR = 0xAA
/*串口命令*/
#define Detection_barrier  0x24
#define Reboot             0x55
#define Back_zero          0x12
#define Motor_rotation     0x13
#define Drawer_out         0x14
#define Drawer_out_place	 0x15
#define Drawer_back        0x16
#define Drawer_back_place	 0x17
#define Whether_receipt    0x18
#define Button_enabled     0x21
#define Button_not_enabled 0x22
#define Button_detection 	 0x23
#define Check_num					 0x46 //查询机械手使用次数
#define Check_num_zero		 0x47 //查询机械手使用次数
#define OPEN_LOGIHT				 0x48
#define ERROR							 0x44 //上行或下行。表示通讯出错
#define TRUE               0x21
#define R_MaxNumberofCom     9//串口缓存数组
/*串口协议宏定义*/
#define c_head 0x3a
#define c_last 0x0a

#endif

