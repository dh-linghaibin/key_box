/***********************************************************
* �ĵ�: main.h
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#ifndef MAIN_H_
#define MAIN_H_
#include "STM8S103K.h"
/*�������Ͷ���*/
typedef unsigned char    u8;
typedef unsigned int     u16;
typedef unsigned long    u32;
typedef signed char    s8;
typedef signed int     s16;
typedef signed long    s32;

#define BIT(x) (1 << (x))

#define WDT()	IWDG_KR = 0xAA
/*��������*/
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
#define Check_num					 0x46 //��ѯ��е��ʹ�ô���
#define Check_num_zero		 0x47 //��ѯ��е��ʹ�ô���
#define OPEN_LOGIHT				 0x48
#define ERROR							 0x44 //���л����С���ʾͨѶ����
#define TRUE               0x21
#define R_MaxNumberofCom     9//���ڻ�������
/*����Э��궨��*/
#define c_head 0x3a
#define c_last 0x0a

#endif

