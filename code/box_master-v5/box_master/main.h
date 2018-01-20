/***********************************************************
* �ĵ�: main.h
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#ifndef MAIN_H_
#define MAIN_H_

#include "iostm8s207m8.h"

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
#define Detection_barrier  0x24 /*����赲*/
#define rawer_back_sta		 0x25 /*����赲*/
#define Reboot             0x55	/*�������*/
#define Back_zero          0x12 /*����*/
#define Motor_rotation     0x13 /*��ת*/
#define Drawer_out         0x14 /*��е�ֳ�ȥ*/
#define Drawer_out_place	 0x15 /*��е�ֳ�ȥ��λ*/
#define Drawer_back        0x16 /*��е�ֻ���*/
#define Drawer_back_place	 0x17 /*��е�ֻ�����λ*/
#define Whether_receipt    0x18 /*���ص�*/
#define Button_enabled     0x21 /*����ʹ��*/
#define Button_not_enabled 0x22	/*����ʹ�ܹر�*/
#define Button_detection 	 0x23	/*��ť�Ƿ���*/
#define ask_count				 	 0x77	/*���ʹ�ô���*/
#define CORRECT						 0x88 //���л����С���ʾͨѶ�ɹ�
#define ERROR							 0x44 //���л����С���ʾͨѶ����
#define TRUE               0x21
#define FALSE 						 0x22
#define Check_num					 0x46 //��ѯ��е��ʹ�ô���
#define Check_num_zero		 0x47 //��ѯ��е��ʹ�ô���
/*�ڴ������С*/
#define MaxNumberofCom       16//���ڻ�������
#define R_MaxNumberofCom     8//���ڻ�������
/*����Э��궨��*/
#define c_head 0x3a
#define c_last 0x0a
/*Э������*/
#define ok 1
#define no 0
/*�����ת*/
#define Total_Circle 		400	//���ÿ��ĳ��������ĳ�����ʵ�ʳ�����Ϊ76����ֵ�������ĸ����ӣ����ڼ���
#define Average_Pulse		35	 //35�����������嵱��175
#define bz_wait 5
/*�˵��ṹ��*/
typedef struct page_num
{ 
 u8 page;/*ҳ��¼*/
 u8 row;/*�м�¼*/
 u8 ins_row;/*�ڲ�ҳ*/
 u8 dr_num;/*������ת��*/
 u8 rb_num;/*�����е�ֺ�*/
 u16 ts_next_cnt;
 u16 ts_up_cnt;
 u16 ts_ok_cnt;
 u16 ts_page_cnt;
}page_num;
/*��е�ִ���λ��*/
#define r_sive_n 15
/*������һ��������*/
#define Encoder_hz 62
#endif

