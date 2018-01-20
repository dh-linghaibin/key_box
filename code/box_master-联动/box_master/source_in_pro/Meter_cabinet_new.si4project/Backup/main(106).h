/***********************************************************
* 文档: main.h
* 作者: Haibin Ling
* 描述: 1.
*       2.
***********************************************************/
#ifndef MAIN_H_
#define MAIN_H_

#include "iostm8s207m8.h"

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
#define Detection_barrier  0x24 /*检测阻挡*/
#define rawer_back_sta		 0x25 /*检测阻挡*/
#define Reboot             0x55	/*检测重启*/
#define Back_zero          0x12 /*回零*/
#define Motor_rotation     0x13 /*旋转*/
#define Drawer_out         0x14 /*机械手出去*/
#define Drawer_out_place	 0x15 /*机械手出去到位*/
#define Drawer_back        0x16 /*机械手回来*/
#define Drawer_back_place	 0x17 /*机械手回来到位*/
#define Whether_receipt    0x18 /*检测回单*/
#define Button_enabled     0x21 /*按键使能*/
#define Button_not_enabled 0x22	/*按键使能关闭*/
#define Button_detection 	 0x23	/*按钮是否按下*/
#define ask_count				 	 0x77	/*检查使用次数*/
#define CORRECT						 0x88 //上行或下行。表示通讯成功
#define ERROR							 0x44 //上行或下行。表示通讯出错
#define TRUE               0x21
#define FALSE 						 0x22
#define Check_num					 0x46 //查询机械手使用次数
#define Check_num_zero		 0x47 //查询机械手使用次数
/*内存申请大小*/
#define MaxNumberofCom       16//串口缓存数组
#define R_MaxNumberofCom     8//串口缓存数组
/*串口协议宏定义*/
#define c_head 0x3a
#define c_last 0x0a
/*协议命令*/
#define ok 1
#define no 0
/*电机旋转*/
#define Total_Circle 		400	//存放每层的抽屉数量的常量，实际抽屉数为76，该值考虑了四个柱子，用于计算
#define Average_Pulse		35	 //35单个抽屉脉冲当量175
#define bz_wait 5
/*菜单结构体*/
typedef struct page_num
{ 
 u8 page;/*页记录*/
 u8 row;/*行记录*/
 u8 ins_row;/*内部页*/
 u8 dr_num;/*保存旋转量*/
 u8 rb_num;/*保存机械手号*/
 u16 ts_next_cnt;
 u16 ts_up_cnt;
 u16 ts_ok_cnt;
 u16 ts_page_cnt;
}page_num;
/*机械手储存位置*/
#define r_sive_n 15
/*编码器一个脉冲数*/
#define Encoder_hz 62
#endif

