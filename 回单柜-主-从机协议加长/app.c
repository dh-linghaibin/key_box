/***********************************************************
* �ĵ�: app.c
* ����: Haibin Ling
* ����: 1.
*       2.
***********************************************************/
#include "type.h"

#define ts_ok IPE2
extern volatile u8 Encoder;
void Menu_Host(u8 status,u8 address,u8 *Array_R,u8 dr_num,page_num *page_n)
{
	/*��ʾ����״̬*/
	if(page_n->page == 0)
	{
		switch(status)
		{
			case Back_zero: 
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				Display_LCD_String_XY(1,1,"  ��ǰλ��:",1);
				Write_LCD_Data(0x30+dr_num/10);
				Write_LCD_Data(0x30+dr_num%10);
				Display_LCD_String_XY(2,1,"  ��תλ��:01 ",1);
				
				Display_LCD_String_XY(1,1,"  ����λ��:",1);
				Write_LCD_Data(0x30+Array_R[1]/10);
				Write_LCD_Data(0x30+Array_R[1]%10);
			break;
			case Motor_rotation:
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"ת",1);
				Display_LCD_String_XY(0,1,"              ",1);
				Display_LCD_String_XY(1,1,"  ��ǰλ��:",1);
				Write_LCD_Data(0x30+dr_num/10);
				Write_LCD_Data(0x30+dr_num%10);
				
				Display_LCD_String_XY(2,1,"  ��תλ��:",1);
				Write_LCD_Data(0x30+Array_R[1]/10);
				Write_LCD_Data(0x30+Array_R[1]%10);
				break;
			case 2: 
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				
				Display_LCD_String_XY(0,1,"  �ȴ���������",1);
				Display_LCD_String_XY(1,1,"              ",1);
				Display_LCD_String_XY(1,1,"  ����λ��:",1);
				Write_LCD_Data(0x30+Array_R[1]/10);
				Write_LCD_Data(0x30+Array_R[1]%10);
				
				
				Display_LCD_String_XY(2,1,"  ��ǰλ��:",1);
				Write_LCD_Data(0x30+dr_num/10);
				Write_LCD_Data(0x30+dr_num%10);
				
				Display_LCD_String_XY(3,1,"  �������:",1);
				Write_LCD_Data(0x30+address/10);
				Write_LCD_Data(0x30+address%10);
				break;
			case 3:
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				
				if(dr_num == 156)
				{
					Display_LCD_String_XY(0,1,"  �������쳣",1);
				}
				
				break;
			case Whether_receipt: /*���ص�*/
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				if(dr_num == 0)
				{
					Display_LCD_String_XY(1,1,"  �лص�:  ",1);
				}
				else
				{
					Display_LCD_String_XY(1,1,"  �޻ص�:  ",1);
				}
				Write_LCD_Data(0x30+address/10);
				Write_LCD_Data(0x30+address%10);
			break;
			case Detection_barrier:
				Display_LCD_String_XY(0,0,"��",1);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				Display_LCD_String_XY(3,0,"��",1);
				if(dr_num == 0)
				{
					Display_LCD_String_XY(1,1,"  ���赲���� ",1);
				}
				else
				{
					Display_LCD_String_XY(1,1,"  ���赲�쳣 ",1);
				}
				break;
			case Drawer_out: 
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				Display_LCD_String_XY(0,7,"  ",1);
				Display_LCD_String_XY(0,1,"  ��ǰλ��:",1);
				Write_LCD_Data(0x30+dr_num/10);
				Write_LCD_Data(0x30+dr_num%10);
				
				Display_LCD_String_XY(1,1,"  ����λ��:",1);
				Write_LCD_Data(0x30+Array_R[1]/10);
				Write_LCD_Data(0x30+Array_R[1]%10);
				break;
			case Drawer_back: 
				Display_LCD_String_XY(0,0,"  ",0);
				Display_LCD_String_XY(3,0,"  ",0);
				Display_LCD_String_XY(1,0,"��",1);
				Display_LCD_String_XY(2,0,"��",1);
				Display_LCD_String_XY(0,7,"  ",1);
				Display_LCD_String_XY(0,1,"  ��ǰλ��:",1);
				Write_LCD_Data(0x30+dr_num/10);
				Write_LCD_Data(0x30+dr_num%10);
				
				Display_LCD_String_XY(1,1,"  ����λ��:",1);
				Write_LCD_Data(0x30+Array_R[1]/10);
				Write_LCD_Data(0x30+Array_R[1]%10);
				break;
			default:;
		}
	}
	else if(page_n->page == 1)
	{
		Display_LCD_String_XY(0,6,"    ",0);
			Display_LCD_String_XY(1,6,"    ",0);
			Display_LCD_String_XY(2,6,"    ",0);
			Display_LCD_String_XY(3,6,"    ",0);
		
			Display_LCD_String_XY(0,0,"��",0);
			Display_LCD_String_XY(1,0,"е",0);
			Display_LCD_String_XY(2,0,"��",0);
			Display_LCD_String_XY(3,0,"1 ", 0);
			
			Display_LCD_String_XY(0,1,"  ��е��ʹ����",1);
			Display_LCD_String_XY(1,1,"  ����ok����  ",1);
			
			Display_LCD_String_XY(2,1,"  ",1);
			Display_LCD_String_XY(3,1,"  ",1);
			
			Display_LCD_String_XY(2,2,"R1:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+1));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+2));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+3));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+4));
			Display_LCD_String_XY(3,2,"R2:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+5));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+6));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+7));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+8));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+9));
			if(page_n->row == 0)
			{
				Display_LCD_String_XY(2,1,"��",1);
			}
			else
			{
				Display_LCD_String_XY(3,1,"��",1);
			}
		}
	else if(page_n->page == 2)
	{
			Display_LCD_String_XY(0,6,"    ",0);
			Display_LCD_String_XY(1,6,"    ",0);
			Display_LCD_String_XY(2,6,"    ",0);
			Display_LCD_String_XY(3,6,"    ",0);
		
			Display_LCD_String_XY(0,0,"��",0);
			Display_LCD_String_XY(1,0,"е",0);
			Display_LCD_String_XY(2,0,"��",0);
			Display_LCD_String_XY(3,0,"2 ", 0);
			
			Display_LCD_String_XY(0,1,"  ",1);
			Display_LCD_String_XY(1,1,"  ",1);
			Display_LCD_String_XY(2,1,"  ",1);
			Display_LCD_String_XY(3,1,"  ",1);
			
			Display_LCD_String_XY(0,2,"R3:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+14));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+13));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+12));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+11));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+10));
			Display_LCD_String_XY(1,2,"R4:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+19));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+18));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+17));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+15));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+16));
			Display_LCD_String_XY(2,2,"R5:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+24));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+23));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+22));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+21));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+20));
			Display_LCD_String_XY(3,2,"R6:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+29));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+28));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+27));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+26));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+25));
			if(page_n->row == 0)
			{
				Display_LCD_String_XY(0,1,"��",1);
			}
			else if(page_n->row == 1)
			{
				Display_LCD_String_XY(1,1,"��",1);
			}
			else if(page_n->row == 2)
			{
				Display_LCD_String_XY(2,1,"��",1);
			}
			else if(page_n->row == 3)
			{
				Display_LCD_String_XY(3,1,"��",1);
			}
	}
	else if(page_n->page == 3)
	{
		Display_LCD_String_XY(0,6,"    ",0);
		Display_LCD_String_XY(1,6,"    ",0);
		Display_LCD_String_XY(2,6,"    ",0);
		Display_LCD_String_XY(3,6,"    ",0);
		
		Display_LCD_String_XY(0,0,"��",0);
		Display_LCD_String_XY(1,0,"е",0);
		Display_LCD_String_XY(2,0,"��",0);
		Display_LCD_String_XY(3,0,"3 ", 0);
		
		Display_LCD_String_XY(0,1,"  ",1);
		Display_LCD_String_XY(1,1,"  ",1);
		Display_LCD_String_XY(2,1,"  ",1);
		Display_LCD_String_XY(3,1,"  ",1);
		
		Display_LCD_String_XY(0,2,"R7:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+34));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+33));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+32));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+31));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+30));
		Display_LCD_String_XY(1,2,"R8:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+39));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+38));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+37));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+36));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+35));
		Display_LCD_String_XY(2,2,"R9:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+44));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+43));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+42));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+41));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+40));
		Display_LCD_String_XY(3,2,"R10:",1);
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+49));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+48));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+47));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+46));
			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+45));
			if(page_n->row == 0)
			{
				Display_LCD_String_XY(0,1,"��",1);
			}
			else if(page_n->row == 1)
			{
				Display_LCD_String_XY(1,1,"��",1);
			}
			else if(page_n->row == 2)
			{
				Display_LCD_String_XY(2,1,"��",1);
			}
			else if(page_n->row == 3)
			{
				Display_LCD_String_XY(3,1,"��",1);
			}
	}
	else if(page_n->page == 4)
	{
		Display_LCD_String_XY(0,0,"  ",0);
		Display_LCD_String_XY(1,0,"��",0);
		Display_LCD_String_XY(2,0,"��",0);
		Display_LCD_String_XY(3,0,"  ",0);
		
		Display_LCD_String_XY(0,1,"  ������: ",1);
		if(Encoder == 0)
		{
			Display_LCD_String_XY(0,6,"�� ",1);
		}
		else
		{
			Display_LCD_String_XY(0,6,"�� ",1);
		}
		Display_LCD_String_XY(1,1,"  ����汾:V6L",1);
		Display_LCD_String_XY(2,1,"  Ӳ���汾:V5L",1);
		Display_LCD_String_XY(3,1,"  ����:15-8-2",1);
		Display_LCD_String_XY(0,1,"��",1);
	}
	else if(page_n->page == 5)/*�ڲ���Ȩ�޲�����ͨ�����²���*/
	{
		Display_LCD_String_XY(0,0,"��",0);
		Display_LCD_String_XY(1,0,"��",0);
		Display_LCD_String_XY(2,0,"ģ",0);
		Display_LCD_String_XY(3,0,"ʽ", 0);
		
		Display_LCD_String_XY(0,1,"  ��תλ��:",1);
		Write_LCD_Data(0x30+page_n->dr_num/10);
		Write_LCD_Data(0x30+page_n->dr_num%10);
		Display_LCD_String_XY(1,1,"  �������:",1);
		Write_LCD_Data(0x30+page_n->rb_num/10);
		Write_LCD_Data(0x30+page_n->rb_num%10);
		Display_LCD_String_XY(2,1,"  �������:",1);
		Write_LCD_Data(0x30+page_n->rb_num/10);
		Write_LCD_Data(0x30+page_n->rb_num%10);
		Display_LCD_String_XY(3,1,"  �ص���λ   ",1);
	//	Write_LCD_Data(0x30+page_n->rb_num/10);
	//	Write_LCD_Data(0x30+page_n->rb_num%10);
		if(page_n->ins_row == 0)
		{
			if(page_n->row == 0)
			{
				Display_LCD_String_XY(0,1,"��",1);
			}
			else if(page_n->row == 1)
			{
				Display_LCD_String_XY(1,1,"��",1);
			}
			else if(page_n->row == 2)
			{
				Display_LCD_String_XY(2,1,"��",1);
			}
			else if(page_n->row == 3)
			{
				Display_LCD_String_XY(3,1,"��",1);
			}
		}
		else if(page_n->ins_row == 1)
		{
			Display_LCD_String_XY(0,1,"��",1);
		}
		else if(page_n->ins_row == 2)
		{
			Display_LCD_String_XY(1,1,"��",1);
		}
		else if(page_n->ins_row == 3)
		{
			Display_LCD_String_XY(2,1,"��",1);
		}
		else if(page_n->ins_row == 4)
		{
			Display_LCD_String_XY(3,1,"��",1);
		}
	}
}

void eeprom_count(u8 ad)
{
	u8 i = Eeprom_Read(ad);
	if(i == 9)
	{
		Eeprom_Write(ad,0);
		i = Eeprom_Read(ad+1);
		if(i == 9)
		{
			Eeprom_Write(ad+1,0);
			i = Eeprom_Read(ad+2);
			if(i == 9)
			{
				Eeprom_Write(ad+2,0);
				i = Eeprom_Read(ad+3);
				if(i == 9)
				{
					Eeprom_Write(ad+3,0);
					i = Eeprom_Read(ad+4);
					if(i == 9)
					{
						/*99999Ϊ����*/
					}
					else
					{
						i++;
						Eeprom_Write(ad+4,i);
					}
				}
				else
				{
					i++;
					Eeprom_Write(ad+3,i);
				}
			}
			else
			{
				i++;
				Eeprom_Write(ad+2,i);
			}
		}
		else
		{
			i++;
			Eeprom_Write(ad+1,i);
		}
	}
	else
	{
		i++;
		Eeprom_Write(ad,i);
	}
}

void eeprom_cle(u8 ad)
{
	Eeprom_Write(ad,0);
	Eeprom_Write(ad+1,0);
	Eeprom_Write(ad+2,0);
	Eeprom_Write(ad+3,0);
	Eeprom_Write(ad+4,0);
}

int abs(int x)
{
	if (x < 0)
	return x * -1;
	else
	return x;
}



