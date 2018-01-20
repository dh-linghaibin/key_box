/***********************************************************
* ÎÄµµ: uart.c
* ×÷Õß: Haibin Ling
* ÃèÊö: 1.´®¿Ú1³õÊ¼»¯£¬´®¿Ú1·¢ËÍº¯Êı
*       2.´®¿Ú3³õÊ¼»¯£¬´®¿Ú3·¢ËÍº¯Êı
***********************************************************/
#include "type.h"

#define rs485_dr1 OPA6
#define rs485_dr2 OPD7
/*****************************
º¯ÊıÃû: UART1_Init()
·µ»ØÖµ£ºÎŞ
¹¦  ÄÜ:	³õÊ¼»¯´®¿Ú1 ²¨ÌØÂÊÉèÖÃÎª9600  ¿ªÖĞ¶Ï
*****************************/
void UART1_Init(void)
{
		/***485_PA4****/
	PA_DDR |= BIT(5);
	PA_CR1 |= BIT(5); 
	PA_CR2 |= BIT(5);
	/***485_PA5****/
	PA_DDR &= ~BIT(4);
	PA_CR1 |= BIT(4); 
	PA_CR2 &= ~BIT(4);
	/***485·½ÏòÁ÷¿ØÖÆ_PA6****/
	PA_DDR |= BIT(6);
	PA_CR1 |= BIT(6); 
	PA_CR2 |= BIT(6);
	rs485_dr1 = 0;
	UART1_CR1=0x00;
	UART1_CR2=0x00;
	UART1_CR3=0x00; 
	UART1_BRR2=0x02;
	UART1_BRR1=0x68;
	UART1_CR2=0x2c;//ÔÊĞí½ÓÊÕ£¬·¢ËÍ£¬¿ª½ÓÊÕÖĞ¶Ï
	UART1_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖĞ¶Ï*/
}
/*****************************
º¯ÊıÃû: UART1_Sendint(unsigned char ch)
·µ»ØÖµ£ºÎŞ
ÊäÈëÖµ£ºĞèÒª·¢ËÍµÄ×Ö½Ú
¹¦  ÄÜ:	·¢ËÍ×Ö½ÚµÄ´®¿Ú1
*****************************/
void UART1_Sendint(unsigned char ch)
{
  while((UART1_SR & 0x80) == 0x00);    // µÈ´ıÊı¾İµÄ´«ËÍ  
  UART1_DR = ch;                    
}
/*****************************
º¯ÊıÃû: UART1_Send
·µ»ØÖµ£ºÎŞ
ÊäÈëÖµ£º½ÓÊÕÊı×é  ÃüÁî ³É¹¦Óë·ñ
¹¦  ÄÜ:	·¢ËÍ×Ö½ÚµÄ´®¿Ú1
*****************************/
extern u8 ts1_ok;
void UART1_Send(u8 *Array,u8 command,u8 situ)
{
	volatile u8 i;
	//while( (UART1_SR&(1<<6)) )/*µÈ´ı·¢ËÍÍê±Ï*/
	while(ts1_ok == 1);
	UART1_SR&= ~BIT(6);  //Çå³ıËÍÍê³É×´Ì¬Î»
	UART1_CR2 |= BIT(6);//¿ª·¢ËÍÍê³ÉÖĞ
	Array[0] = situ;
	Array[1] = command;
	Array[7] = c_last;
	rs485_dr1 = 1;
	ts1_ok = 1;
	UART1_DR = c_head;
}
/*****************************
º¯ÊıÃû: UART3_Init()
·µ»ØÖµ£ºÎŞ
¹¦  ÄÜ:	³õÊ¼»¯´®¿Ú3 ²¨ÌØÂÊÉèÖÃÎª9600  ¿ªÖĞ¶Ï
*****************************/
void UART3_Init(void)
{
		/***485_PD5****/
	PD_DDR |= BIT(5);
	PD_CR1 |= BIT(5); 
	PD_CR2 |= BIT(5);
	/***485_PD6****/
	PD_DDR &= ~BIT(6);
	PD_CR1 |= BIT(6); 
	PD_CR2 &= ~BIT(6);
	/***485·½ÏòÁ÷¿ØÖÆ_PD7****/
	PD_DDR |= BIT(7);
	PD_CR1 |= BIT(7); 
	PD_CR2 |= BIT(7);
	rs485_dr2 = 0;
	UART3_CR1=0x00;
	UART3_CR2=0x00;
	UART3_CR3=0x00; 
	UART3_BRR2=0x02;
	UART3_BRR1=0x68;
	UART3_CR2=0x2c;//ÔÊĞí½ÓÊÕ£¬·¢ËÍ£¬¿ª½ÓÊÕÖĞ¶Ï
}
/*****************************
º¯ÊıÃû: UART3_Sendint(unsigned char ch)
·µ»ØÖµ£ºÎŞ
ÊäÈëÖµ£ºĞèÒª·¢ËÍµÄ×Ö½Ú
¹¦  ÄÜ:	·¢ËÍ×Ö½ÚµÄ´®3
*****************************/
void UART3_Sendint(unsigned char ch)
{
  while((UART3_SR & 0x80) == 0x00);    // µÈ´ıÊı¾İµÄ´«ËÍ  
  UART3_DR = ch;   
	delayus(100);	
}
/*****************************
º¯ÊıÃû: void UART_interrupt(u8 uart,u8 mode)
·µ»ØÖµ£ºÎŞ
ÊäÈëÖµ£º0-´®¿Ú1 1-´®¿Ú3  0-¹Ø½ÓÖĞ¶Ï 1-¿ª½ÓÊÕÖĞ¶Ï
¹¦  ÄÜ:	¿ª¹ØÖĞ¶Ï 
*****************************/
void UART_interrupt(u8 uart,u8 mode)
{
	if(uart == 0)
	{
		if(mode == 0)
		{
			UART1_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖĞ¶Ï*/
		}
		else if(mode == 1)
		{
			UART1_CR2 |= BIT(2);/*Ê¹ÄÜ½ÓÊÕÖĞ¶Ï*/
		}
	}
	else if(uart == 1)
	{
		if(mode == 0)
		{
			UART3_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖĞ¶Ï*/
		}
		else if(mode == 1)
		{
			UART3_CR2 |= BIT(2);/*Ê¹ÄÜ½ÓÊÕÖĞ¶Ï*/
		}
	}
}
/*****************************
º¯ÊıÃû: UART3_Send
·µ»ØÖµ£ºÎŞ
ÊäÈëÖµ£º½ÓÊÕÊı×é  ÃüÁî ³É¹¦Óë·ñ
¹¦  ÄÜ:	·¢ËÍ×Ö½ÚµÄ´®3
*****************************/
extern u8 ts3_ok;
void UART3_Send(u8 *Array,u8 command,u8 situ)
{
	volatile u8 i;
	//while( (UART3_SR&(1<<6)) )/*µÈ´ı·¢ËÍÍê±Ï*/
	while(ts3_ok == 1);
	UART3_SR&= ~BIT(6);  //Çå³ıËÍÍê³É×´Ì¬Î»
	UART3_CR2 |= BIT(6);//¿ª·¢ËÍÍê³ÉÖĞ¶
	Array[14] = c_last;
	Array[0] = command;
	Array[12] = Array[0];
	if( (command == CORRECT)||(command == ERROR) )
	{
		Array[12] = Array[0];
		Array[13] = 0;
		for(i = 1;i < 12;i++)
		{
			Array[i] = 0x00;
		}
	}
	else
	{
		/*ÀÛ¼ÓĞ£Ñé*/
		for(i = 1;i < 12;i++)
		{
			Array[13] += Array[i];
		}
		if(situ == ok)
		{
			Array[0] = TRUE;
			Array[12] = Array[0];
		}
		else
		{
			Array[0] = FALSE;
			Array[12] = Array[0];
		}
	}
	rs485_dr2 = 1;
	ts3_ok = 1;
	UART3_DR = c_head;
}
/*****************************
º¯ÊıÃû: UART1_Init()
·µ»ØÖµ£ºÎŞ
¹¦  ÄÜ:	³õÊ¼»¯´®¿Ú1 ²¨ÌØÂÊÉèÖÃÎª9600  ¿ªÖĞ¶Ï
*****************************/
extern volatile u16 T2msFlg;
extern volatile u8 wr_new;/*±£´æ»Øµ¥Çé¿ö*/
extern volatile u8 fr_Flag;/*»Øµ¥¼ì²â±êÖ¾Î»*/
extern volatile u8 RsBuffer[MaxNumberofCom];//´®¿Ú»º´æÇø
extern volatile u8 mirro;/*×Ô¶¯»ØÀ´±êÖ¾*/
/*ÔËĞĞ±êÖ¾   ´Ó·¢ËÍ»º´æ ´Ó½ÓÊÕ»º´æ  Ö÷·¢ËÍ»º´æ Ö÷½ÓÊÕ»º´æ Ä£Ê½ ´Ó»ú½ÓÊÕÍê³É±êÖ¾*/
void Drawer_cont(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
									u8 *ts,u8 *rs,u8 mode,u8 *ts_flag)
{
	*rb_Flag = 1;
	*ts_flag = 0;
	T2msFlg = 0;
	UART_interrupt(0,1);/*Ê¹ÄÜ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
	UART1_Send(R_ts,mode,rs[1]);
	while(*rb_Flag > 0)
	{
		WDT();//Çå¿´ÃÅ¹·
		if(*ts_flag == 1)/*µÈ´ı·µ»ØÃüÁî*/
		{
			if(R_rs[7] == 0x0a)
			{
				if(R_rs[1] == 0x01)/*Õı³£*/
				{
					R_rs[1] = 0x00;
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					if(mirro == 0)
					{
						UART3_Send(ts,mode,ok);
					}
				}
				else if(R_rs[1] == 0x02)/*¹ıÁ÷*/
				{
					R_rs[1] = 0x00;
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					if(mirro == 0)
					{
						UART3_Send(ts,mode,no);
					}
				}
				else if(R_rs[1] == 0x03)/*±£ÏÕË¿*/
				{
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					if(mirro == 0)
					{
						UART3_Send(ts,mode,no);
					}
				}
				else
				{
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					if(mirro == 0)
					{
						UART3_Send(ts,mode,no);
					}
				}
			}
			else
			{
				WDT();//Çå¿´ÃÅ¹·
				*ts_flag = 0;/*½ÓÊÕÃüÁîÍê³É£¬¿ÉÒÔÔÙ´Î½ÓÊÕ*/
				if(T2msFlg > 2000)
				{
					T2msFlg = 0;
					if(*rb_Flag == 1)
					{
						*rb_Flag = 2;
						UART1_Send(R_ts,mode,rs[1]);
					}
					else
					{
						*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
						if(mirro == 0)
						{
							UART3_Send(ts,mode,no);
						}
					}
				}
			}
		}
		if(T2msFlg > 2000)
		{
			T2msFlg = 0;
			if(*rb_Flag == 1)
			{
				*rb_Flag = 2;
				UART1_Send(R_ts,mode,rs[1]);
			}
			else
			{
				*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
				UART3_Send(ts,mode,no);
			}
		}
		if(mode == Drawer_back)
		{
			Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*¼ì²â»Øµ¥*/
		}
	}
}
/********************
¼ì²â×èµ²Ê¹ÓÃ£¬·¢ËÍÃüÁîÅĞ¶Ï×èµ²Çé¿ö
*********************/
u8 cheak_wait = 20;//ÖØ·¢µÈ´ıÊ±¼ä
void rawer_back_judge(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
									u8 i,u8 *ts_flag,u8 *place_flag)
{
	*rb_Flag = 1;
	*ts_flag = 0;
	T2msFlg = 0;
	UART_interrupt(0,1);/*Ê¹ÄÜ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
	UART1_Send(R_ts,Drawer_back_place,i);
	while(*rb_Flag > 0)
	{
		WDT();//Çå¿´ÃÅ¹·
		if(*ts_flag == 1)/*µÈ´ı·µ»ØÃüÁî*/
		{
			if(R_rs[7] == 0x0a)
			{
				if(R_rs[1] == 0x01)/*Õı³£*/
				{
					R_rs[1] = 0x00;
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					*place_flag = 0;
				}/*Î´µ½Î»*/
				else
				{
					*rb_Flag = 0;
					*ts_flag = 0;
					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖĞ¶Ï*/
					*place_flag = 1;
				}
			}
			else
			{
				WDT();//Çå¿´ÃÅ¹·
				*ts_flag = 0;/*½ÓÊÕÃüÁîÍê³É£¬¿ÉÒÔÔÙ´Î½ÓÊÕ*/
				if(T2msFlg > cheak_wait)//200
				{
					T2msFlg = 0;
					if(*rb_Flag == 1)
					{
						*rb_Flag = 2;
						UART1_Send(R_ts,Drawer_back_place,i);
					}
					else/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
					{
						*rb_Flag = 0;
						*place_flag = 1;
					}
				}
			}
		}
		if(T2msFlg > cheak_wait)//200
		{
			T2msFlg = 0;
			if(*rb_Flag == 1)
			{
				*rb_Flag = 2;
				UART1_Send(R_ts,Drawer_back_place,i);
			}
			else
			{
				*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
				*place_flag = 1;
			}
		}
	}
}

