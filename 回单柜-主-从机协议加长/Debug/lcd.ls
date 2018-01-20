   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3458                     ; 20 void delay_ms(u16 ms)	
3458                     ; 21 {						
3460                     	switch	.text
3461  0000               _delay_ms:
3463  0000 89            	pushw	x
3464  0001 89            	pushw	x
3465       00000002      OFST:	set	2
3468  0002 2011          	jra	L1232
3469  0004               L7132:
3470                     ; 25 		for(i=0;i<300;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
3472  0004 5f            	clrw	x
3473  0005 1f01          	ldw	(OFST-1,sp),x
3474  0007               L5232:
3478  0007 1e01          	ldw	x,(OFST-1,sp)
3479  0009 1c0001        	addw	x,#1
3480  000c 1f01          	ldw	(OFST-1,sp),x
3483  000e 1e01          	ldw	x,(OFST-1,sp)
3484  0010 a3012c        	cpw	x,#300
3485  0013 25f2          	jrult	L5232
3486  0015               L1232:
3487                     ; 23 	while(ms--)
3489  0015 1e03          	ldw	x,(OFST+1,sp)
3490  0017 1d0001        	subw	x,#1
3491  001a 1f03          	ldw	(OFST+1,sp),x
3492  001c 1c0001        	addw	x,#1
3493  001f a30000        	cpw	x,#0
3494  0022 26e0          	jrne	L7132
3495                     ; 27 }
3498  0024 5b04          	addw	sp,#4
3499  0026 81            	ret
3530                     ; 30 void LCD12864_Init(void)
3530                     ; 31 {
3531                     	switch	.text
3532  0027               _LCD12864_Init:
3536                     ; 33 		PC_DDR |= ( BIT(6)|BIT(5) ); //6-SPI_MOSI，主设备输出从
3538  0027 c6500c        	ld	a,_PC_DDR
3539  002a aa60          	or	a,#96
3540  002c c7500c        	ld	_PC_DDR,a
3541                     ; 34 		PC_CR1 |= ( BIT(6)|BIT(5) ); 
3543  002f c6500d        	ld	a,_PC_CR1
3544  0032 aa60          	or	a,#96
3545  0034 c7500d        	ld	_PC_CR1,a
3546                     ; 35 		PC_CR2 |= ( BIT(6)|BIT(5) );
3548  0037 c6500e        	ld	a,_PC_CR2
3549  003a aa60          	or	a,#96
3550  003c c7500e        	ld	_PC_CR2,a
3551                     ; 37 		PE_DDR |= BIT(5); //
3553  003f 721a5016      	bset	_PE_DDR,#5
3554                     ; 38 		PE_CR1 |= BIT(5); 
3556  0043 721a5017      	bset	_PE_CR1,#5
3557                     ; 39 		PE_CR2 |= BIT(5);
3559  0047 721a5018      	bset	_PE_CR2,#5
3560                     ; 41     delay_ms(250);
3562  004b ae00fa        	ldw	x,#250
3563  004e adb0          	call	_delay_ms
3565                     ; 42     Write_LCD_Command(0x30);  //30--基本指令动作
3567  0050 a630          	ld	a,#48
3568  0052 ad5b          	call	_Write_LCD_Command
3570                     ; 43     delay_ms(5);
3572  0054 ae0005        	ldw	x,#5
3573  0057 ada7          	call	_delay_ms
3575                     ; 44     Write_LCD_Command(0x0c);  //光标右移画面不动
3577  0059 a60c          	ld	a,#12
3578  005b ad52          	call	_Write_LCD_Command
3580                     ; 45     delay_ms(5);
3582  005d ae0005        	ldw	x,#5
3583  0060 ad9e          	call	_delay_ms
3585                     ; 46     Write_LCD_Command(0x01);  //清屏
3587  0062 a601          	ld	a,#1
3588  0064 ad49          	call	_Write_LCD_Command
3590                     ; 47     delay_ms(5);              //清屏时间较长
3592  0066 ae0005        	ldw	x,#5
3593  0069 ad95          	call	_delay_ms
3595                     ; 48     Write_LCD_Command(0x06);  //显示打开，光标开，反白关
3597  006b a606          	ld	a,#6
3598  006d ad40          	call	_Write_LCD_Command
3600                     ; 49     delay_ms(10);
3602  006f ae000a        	ldw	x,#10
3603  0072 ad8c          	call	_delay_ms
3605                     ; 50 }
3608  0074 81            	ret
3653                     ; 56 void Send_Byte(u8 zdata)
3653                     ; 57 {
3654                     	switch	.text
3655  0075               _Send_Byte:
3657  0075 88            	push	a
3658  0076 89            	pushw	x
3659       00000002      OFST:	set	2
3662                     ; 59   for(i=0; i<8; i++)
3664  0077 5f            	clrw	x
3665  0078 1f01          	ldw	(OFST-1,sp),x
3666  007a               L5632:
3667                     ; 62 	  if((zdata << i) & 0x80) 
3669  007a 7b03          	ld	a,(OFST+1,sp)
3670  007c 5f            	clrw	x
3671  007d 97            	ld	xl,a
3672  007e 7b02          	ld	a,(OFST+0,sp)
3673  0080 4d            	tnz	a
3674  0081 2704          	jreq	L21
3675  0083               L41:
3676  0083 58            	sllw	x
3677  0084 4a            	dec	a
3678  0085 26fc          	jrne	L41
3679  0087               L21:
3680  0087 01            	rrwa	x,a
3681  0088 a580          	bcp	a,#128
3682  008a 2706          	jreq	L3732
3683                     ; 63 	       SID_H;
3685  008c 721c500a      	bset	_OPC6
3687  0090 2004          	jra	L5732
3688  0092               L3732:
3689                     ; 65 	       SID_L;
3691  0092 721d500a      	bres	_OPC6
3692  0096               L5732:
3693                     ; 66 			SCLK_H;
3695  0096 721a500a      	bset	_OPC5
3696                     ; 67 			SCLK_L;
3698  009a 721b500a      	bres	_OPC5
3699                     ; 59   for(i=0; i<8; i++)
3701  009e 1e01          	ldw	x,(OFST-1,sp)
3702  00a0 1c0001        	addw	x,#1
3703  00a3 1f01          	ldw	(OFST-1,sp),x
3706  00a5 1e01          	ldw	x,(OFST-1,sp)
3707  00a7 a30008        	cpw	x,#8
3708  00aa 25ce          	jrult	L5632
3709                     ; 69 }
3712  00ac 5b03          	addw	sp,#3
3713  00ae 81            	ret
3750                     ; 75 void Write_LCD_Command(u8 cmdcode)
3750                     ; 76 {
3751                     	switch	.text
3752  00af               _Write_LCD_Command:
3754  00af 88            	push	a
3755       00000000      OFST:	set	0
3758                     ; 77    CS_H;
3760  00b0 721a5014      	bset	_OPE5
3761                     ; 78    Send_Byte(0xf8);
3763  00b4 a6f8          	ld	a,#248
3764  00b6 adbd          	call	_Send_Byte
3766                     ; 79    Send_Byte(cmdcode & 0xf0);
3768  00b8 7b01          	ld	a,(OFST+1,sp)
3769  00ba a4f0          	and	a,#240
3770  00bc adb7          	call	_Send_Byte
3772                     ; 80    Send_Byte((cmdcode << 4) & 0xf0);
3774  00be 7b01          	ld	a,(OFST+1,sp)
3775  00c0 97            	ld	xl,a
3776  00c1 a610          	ld	a,#16
3777  00c3 42            	mul	x,a
3778  00c4 9f            	ld	a,xl
3779  00c5 a4f0          	and	a,#240
3780  00c7 adac          	call	_Send_Byte
3782                     ; 81    delay_ms(2);
3784  00c9 ae0002        	ldw	x,#2
3785  00cc cd0000        	call	_delay_ms
3787                     ; 82    CS_L;
3789  00cf 721b5014      	bres	_OPE5
3790                     ; 83 }
3793  00d3 84            	pop	a
3794  00d4 81            	ret
3831                     ; 89 void Write_LCD_Data(u8 Dispdata)
3831                     ; 90 {  
3832                     	switch	.text
3833  00d5               _Write_LCD_Data:
3835  00d5 88            	push	a
3836       00000000      OFST:	set	0
3839                     ; 91   CS_H;
3841  00d6 721a5014      	bset	_OPE5
3842                     ; 92   Send_Byte(0xfa);	  //11111,RW(0),RS(1),0
3844  00da a6fa          	ld	a,#250
3845  00dc ad97          	call	_Send_Byte
3847                     ; 93   Send_Byte(Dispdata & 0xf0);
3849  00de 7b01          	ld	a,(OFST+1,sp)
3850  00e0 a4f0          	and	a,#240
3851  00e2 ad91          	call	_Send_Byte
3853                     ; 94   Send_Byte((Dispdata << 4) & 0xf0);
3855  00e4 7b01          	ld	a,(OFST+1,sp)
3856  00e6 97            	ld	xl,a
3857  00e7 a610          	ld	a,#16
3858  00e9 42            	mul	x,a
3859  00ea 9f            	ld	a,xl
3860  00eb a4f0          	and	a,#240
3861  00ed ad86          	call	_Send_Byte
3863                     ; 95   delay_ms(2);
3865  00ef ae0002        	ldw	x,#2
3866  00f2 cd0000        	call	_delay_ms
3868                     ; 96   CS_L;
3870  00f5 721b5014      	bres	_OPE5
3871                     ; 97 }
3874  00f9 84            	pop	a
3875  00fa 81            	ret
3911                     ; 103 void LCD_Clear_TXT(void)
3911                     ; 104 {
3912                     	switch	.text
3913  00fb               _LCD_Clear_TXT:
3915  00fb 88            	push	a
3916       00000001      OFST:	set	1
3919                     ; 106 		Write_LCD_Command(0x30);      //8BitMCU,基本指令集合
3921  00fc a630          	ld	a,#48
3922  00fe adaf          	call	_Write_LCD_Command
3924                     ; 107 		Write_LCD_Command(0x80);      //AC归起始位
3926  0100 a680          	ld	a,#128
3927  0102 adab          	call	_Write_LCD_Command
3929                     ; 108 		for(i=0;i<64;i++)
3931  0104 0f01          	clr	(OFST+0,sp)
3932  0106               L1542:
3933                     ; 110        Write_LCD_Data(0x20);
3935  0106 a620          	ld	a,#32
3936  0108 adcb          	call	_Write_LCD_Data
3938                     ; 108 		for(i=0;i<64;i++)
3940  010a 0c01          	inc	(OFST+0,sp)
3943  010c 7b01          	ld	a,(OFST+0,sp)
3944  010e a140          	cp	a,#64
3945  0110 25f4          	jrult	L1542
3946                     ; 112 }
3949  0112 84            	pop	a
3950  0113 81            	ret
4004                     ; 118 void LCD_Clear_BMP( void )
4004                     ; 119 {
4005                     	switch	.text
4006  0114               _LCD_Clear_BMP:
4008  0114 5203          	subw	sp,#3
4009       00000003      OFST:	set	3
4012                     ; 121 	Write_LCD_Command(0x34);        //打开扩展指令集
4014  0116 a634          	ld	a,#52
4015  0118 ad95          	call	_Write_LCD_Command
4017                     ; 122 	i = 0x80;            
4019  011a a680          	ld	a,#128
4020  011c 6b01          	ld	(OFST-2,sp),a
4021                     ; 123 	for(j = 0;j < 32;j++)
4023  011e 0f02          	clr	(OFST-1,sp)
4024  0120               L5052:
4025                     ; 125 		Write_LCD_Command(i++);
4027  0120 7b01          	ld	a,(OFST-2,sp)
4028  0122 0c01          	inc	(OFST-2,sp)
4029  0124 ad89          	call	_Write_LCD_Command
4031                     ; 126 		Write_LCD_Command(0x80);
4033  0126 a680          	ld	a,#128
4034  0128 ad85          	call	_Write_LCD_Command
4036                     ; 127 		for(k = 0;k < 16;k++)
4038  012a 0f03          	clr	(OFST+0,sp)
4039  012c               L3152:
4040                     ; 129 			Write_LCD_Data(0x00);
4042  012c 4f            	clr	a
4043  012d ada6          	call	_Write_LCD_Data
4045                     ; 127 		for(k = 0;k < 16;k++)
4047  012f 0c03          	inc	(OFST+0,sp)
4050  0131 7b03          	ld	a,(OFST+0,sp)
4051  0133 a110          	cp	a,#16
4052  0135 25f5          	jrult	L3152
4053                     ; 123 	for(j = 0;j < 32;j++)
4055  0137 0c02          	inc	(OFST-1,sp)
4058  0139 7b02          	ld	a,(OFST-1,sp)
4059  013b a120          	cp	a,#32
4060  013d 25e1          	jrult	L5052
4061                     ; 132 	i = 0x80;
4063  013f a680          	ld	a,#128
4064  0141 6b01          	ld	(OFST-2,sp),a
4065                     ; 133  	for(j = 0;j < 32;j++)
4067  0143 0f02          	clr	(OFST-1,sp)
4068  0145               L1252:
4069                     ; 135 		Write_LCD_Command(i++);
4071  0145 7b01          	ld	a,(OFST-2,sp)
4072  0147 0c01          	inc	(OFST-2,sp)
4073  0149 cd00af        	call	_Write_LCD_Command
4075                     ; 136 		Write_LCD_Command(0x88);	   
4077  014c a688          	ld	a,#136
4078  014e cd00af        	call	_Write_LCD_Command
4080                     ; 137 		for(k = 0;k < 16;k++)
4082  0151 0f03          	clr	(OFST+0,sp)
4083  0153               L7252:
4084                     ; 139 			Write_LCD_Data(0x00);
4086  0153 4f            	clr	a
4087  0154 cd00d5        	call	_Write_LCD_Data
4089                     ; 137 		for(k = 0;k < 16;k++)
4091  0157 0c03          	inc	(OFST+0,sp)
4094  0159 7b03          	ld	a,(OFST+0,sp)
4095  015b a110          	cp	a,#16
4096  015d 25f4          	jrult	L7252
4097                     ; 133  	for(j = 0;j < 32;j++)
4099  015f 0c02          	inc	(OFST-1,sp)
4102  0161 7b02          	ld	a,(OFST-1,sp)
4103  0163 a120          	cp	a,#32
4104  0165 25de          	jrult	L1252
4105                     ; 142 	Write_LCD_Command(0x36);        //打开绘图显示
4107  0167 a636          	ld	a,#54
4108  0169 cd00af        	call	_Write_LCD_Command
4110                     ; 143 	Write_LCD_Command(0x30);        //回到基本指令集
4112  016c a630          	ld	a,#48
4113  016e cd00af        	call	_Write_LCD_Command
4115                     ; 144 }
4118  0171 5b03          	addw	sp,#3
4119  0173 81            	ret
4172                     ; 150 void Display_LCD_Pos(u8 x,u8 y) 
4172                     ; 151 {
4173                     	switch	.text
4174  0174               _Display_LCD_Pos:
4176  0174 89            	pushw	x
4177  0175 88            	push	a
4178       00000001      OFST:	set	1
4181                     ; 153 	switch(x)
4183  0176 9e            	ld	a,xh
4185                     ; 158 		case 3: x=0x98;break;
4186  0177 4d            	tnz	a
4187  0178 270b          	jreq	L5352
4188  017a 4a            	dec	a
4189  017b 270e          	jreq	L7352
4190  017d 4a            	dec	a
4191  017e 2711          	jreq	L1452
4192  0180 4a            	dec	a
4193  0181 2714          	jreq	L3452
4194  0183 2016          	jra	L5752
4195  0185               L5352:
4196                     ; 155 		case 0: x=0x80;break;
4198  0185 a680          	ld	a,#128
4199  0187 6b02          	ld	(OFST+1,sp),a
4202  0189 2010          	jra	L5752
4203  018b               L7352:
4204                     ; 156 		case 1: x=0x90;break;
4206  018b a690          	ld	a,#144
4207  018d 6b02          	ld	(OFST+1,sp),a
4210  018f 200a          	jra	L5752
4211  0191               L1452:
4212                     ; 157 		case 2: x=0x88;break;
4214  0191 a688          	ld	a,#136
4215  0193 6b02          	ld	(OFST+1,sp),a
4218  0195 2004          	jra	L5752
4219  0197               L3452:
4220                     ; 158 		case 3: x=0x98;break;
4222  0197 a698          	ld	a,#152
4223  0199 6b02          	ld	(OFST+1,sp),a
4226  019b               L5752:
4227                     ; 160 	pos=x+y;
4229  019b 7b02          	ld	a,(OFST+1,sp)
4230  019d 1b03          	add	a,(OFST+2,sp)
4231  019f 6b01          	ld	(OFST+0,sp),a
4232                     ; 161 	Write_LCD_Command(pos);
4234  01a1 7b01          	ld	a,(OFST+0,sp)
4235  01a3 cd00af        	call	_Write_LCD_Command
4237                     ; 162 }
4240  01a6 5b03          	addw	sp,#3
4241  01a8 81            	ret
4314                     ; 171 void Disp_HZ(u8 X,const u8 * pt,u8 num)
4314                     ; 172 {
4315                     	switch	.text
4316  01a9               _Disp_HZ:
4318  01a9 88            	push	a
4319  01aa 88            	push	a
4320       00000001      OFST:	set	1
4323                     ; 174 	if (X==0) {addr=0x80;}
4325  01ab 4d            	tnz	a
4326  01ac 2606          	jrne	L5362
4329  01ae a680          	ld	a,#128
4330  01b0 6b01          	ld	(OFST+0,sp),a
4332  01b2 2022          	jra	L7362
4333  01b4               L5362:
4334                     ; 175 	else if (X==1) {addr=0x90;}
4336  01b4 7b02          	ld	a,(OFST+1,sp)
4337  01b6 a101          	cp	a,#1
4338  01b8 2606          	jrne	L1462
4341  01ba a690          	ld	a,#144
4342  01bc 6b01          	ld	(OFST+0,sp),a
4344  01be 2016          	jra	L7362
4345  01c0               L1462:
4346                     ; 176 	else if (X==2) {addr=0x88;}
4348  01c0 7b02          	ld	a,(OFST+1,sp)
4349  01c2 a102          	cp	a,#2
4350  01c4 2606          	jrne	L5462
4353  01c6 a688          	ld	a,#136
4354  01c8 6b01          	ld	(OFST+0,sp),a
4356  01ca 200a          	jra	L7362
4357  01cc               L5462:
4358                     ; 177 	else if (X==3) {addr=0x98;}
4360  01cc 7b02          	ld	a,(OFST+1,sp)
4361  01ce a103          	cp	a,#3
4362  01d0 2604          	jrne	L7362
4365  01d2 a698          	ld	a,#152
4366  01d4 6b01          	ld	(OFST+0,sp),a
4367  01d6               L7362:
4368                     ; 178 	Write_LCD_Command(addr); 
4370  01d6 7b01          	ld	a,(OFST+0,sp)
4371  01d8 cd00af        	call	_Write_LCD_Command
4373                     ; 179 	for(i = 0;i < (num*2);i++) 
4375  01db 0f01          	clr	(OFST+0,sp)
4377  01dd 2010          	jra	L7562
4378  01df               L3562:
4379                     ; 180      Write_LCD_Data(*(pt++)); 
4381  01df 1e05          	ldw	x,(OFST+4,sp)
4382  01e1 1c0001        	addw	x,#1
4383  01e4 1f05          	ldw	(OFST+4,sp),x
4384  01e6 1d0001        	subw	x,#1
4385  01e9 f6            	ld	a,(x)
4386  01ea cd00d5        	call	_Write_LCD_Data
4388                     ; 179 	for(i = 0;i < (num*2);i++) 
4390  01ed 0c01          	inc	(OFST+0,sp)
4391  01ef               L7562:
4394  01ef 9c            	rvf
4395  01f0 7b07          	ld	a,(OFST+6,sp)
4396  01f2 5f            	clrw	x
4397  01f3 97            	ld	xl,a
4398  01f4 58            	sllw	x
4399  01f5 7b01          	ld	a,(OFST+0,sp)
4400  01f7 905f          	clrw	y
4401  01f9 9097          	ld	yl,a
4402  01fb 90bf01        	ldw	c_y+1,y
4403  01fe b301          	cpw	x,c_y+1
4404  0200 2cdd          	jrsgt	L3562
4405                     ; 181 } 
4408  0202 85            	popw	x
4409  0203 81            	ret
4474                     ; 187 void Display_LCD_String(u8 x,u8 *p,u8 time)
4474                     ; 188 {
4475                     	switch	.text
4476  0204               _Display_LCD_String:
4478  0204 88            	push	a
4479  0205 88            	push	a
4480       00000001      OFST:	set	1
4483                     ; 190 	switch(x)
4486                     ; 195 		case 3: addr=0x98;break;
4487  0206 4d            	tnz	a
4488  0207 270b          	jreq	L3662
4489  0209 4a            	dec	a
4490  020a 270e          	jreq	L5662
4491  020c 4a            	dec	a
4492  020d 2711          	jreq	L7662
4493  020f 4a            	dec	a
4494  0210 2714          	jreq	L1762
4495  0212 2016          	jra	L7272
4496  0214               L3662:
4497                     ; 192 		case 0: addr=0x80;break;
4499  0214 a680          	ld	a,#128
4500  0216 6b01          	ld	(OFST+0,sp),a
4503  0218 2010          	jra	L7272
4504  021a               L5662:
4505                     ; 193 		case 1: addr=0x90;break;
4507  021a a690          	ld	a,#144
4508  021c 6b01          	ld	(OFST+0,sp),a
4511  021e 200a          	jra	L7272
4512  0220               L7662:
4513                     ; 194 		case 2: addr=0x88;break;
4515  0220 a688          	ld	a,#136
4516  0222 6b01          	ld	(OFST+0,sp),a
4519  0224 2004          	jra	L7272
4520  0226               L1762:
4521                     ; 195 		case 3: addr=0x98;break;
4523  0226 a698          	ld	a,#152
4524  0228 6b01          	ld	(OFST+0,sp),a
4527  022a               L7272:
4528                     ; 197 	Write_LCD_Command(addr);
4530  022a 7b01          	ld	a,(OFST+0,sp)
4531  022c cd00af        	call	_Write_LCD_Command
4534  022f 2014          	jra	L5372
4535  0231               L1372:
4536                     ; 200 		Write_LCD_Data(*p);
4538  0231 1e05          	ldw	x,(OFST+4,sp)
4539  0233 f6            	ld	a,(x)
4540  0234 cd00d5        	call	_Write_LCD_Data
4542                     ; 201 		delay_ms(time);
4544  0237 7b07          	ld	a,(OFST+6,sp)
4545  0239 5f            	clrw	x
4546  023a 97            	ld	xl,a
4547  023b cd0000        	call	_delay_ms
4549                     ; 198 	for(;*p!='\0';p++)
4551  023e 1e05          	ldw	x,(OFST+4,sp)
4552  0240 1c0001        	addw	x,#1
4553  0243 1f05          	ldw	(OFST+4,sp),x
4554  0245               L5372:
4557  0245 1e05          	ldw	x,(OFST+4,sp)
4558  0247 7d            	tnz	(x)
4559  0248 26e7          	jrne	L1372
4560                     ; 203 }
4563  024a 85            	popw	x
4564  024b 81            	ret
4630                     ; 209 void Display_LCD_String_XY(u8 x,u8 y,u8 *p,u8 time)
4630                     ; 210 {
4631                     	switch	.text
4632  024c               _Display_LCD_String_XY:
4634  024c 89            	pushw	x
4635       00000000      OFST:	set	0
4638                     ; 211 	Display_LCD_Pos(x,y);
4640  024d 9f            	ld	a,xl
4641  024e 97            	ld	xl,a
4642  024f 7b01          	ld	a,(OFST+1,sp)
4643  0251 95            	ld	xh,a
4644  0252 cd0174        	call	_Display_LCD_Pos
4647  0255 2014          	jra	L7772
4648  0257               L3772:
4649                     ; 214 		Write_LCD_Data(*p);
4651  0257 1e05          	ldw	x,(OFST+5,sp)
4652  0259 f6            	ld	a,(x)
4653  025a cd00d5        	call	_Write_LCD_Data
4655                     ; 215 		delay_ms(time);
4657  025d 7b07          	ld	a,(OFST+7,sp)
4658  025f 5f            	clrw	x
4659  0260 97            	ld	xl,a
4660  0261 cd0000        	call	_delay_ms
4662                     ; 212 	for(;*p!='\0';p++)
4664  0264 1e05          	ldw	x,(OFST+5,sp)
4665  0266 1c0001        	addw	x,#1
4666  0269 1f05          	ldw	(OFST+5,sp),x
4667  026b               L7772:
4670  026b 1e05          	ldw	x,(OFST+5,sp)
4671  026d 7d            	tnz	(x)
4672  026e 26e7          	jrne	L3772
4673                     ; 217 }
4676  0270 85            	popw	x
4677  0271 81            	ret
4723                     ; 223 void Display_String(u8 *p,u8 time)
4723                     ; 224 {
4724                     	switch	.text
4725  0272               _Display_String:
4727  0272 89            	pushw	x
4728       00000000      OFST:	set	0
4731  0273 2014          	jra	L1303
4732  0275               L5203:
4733                     ; 227 		Write_LCD_Data(*p);
4735  0275 1e01          	ldw	x,(OFST+1,sp)
4736  0277 f6            	ld	a,(x)
4737  0278 cd00d5        	call	_Write_LCD_Data
4739                     ; 228 		delay_ms(time);
4741  027b 7b05          	ld	a,(OFST+5,sp)
4742  027d 5f            	clrw	x
4743  027e 97            	ld	xl,a
4744  027f cd0000        	call	_delay_ms
4746                     ; 225 	for(;*p!='\0';p++)
4748  0282 1e01          	ldw	x,(OFST+1,sp)
4749  0284 1c0001        	addw	x,#1
4750  0287 1f01          	ldw	(OFST+1,sp),x
4751  0289               L1303:
4754  0289 1e01          	ldw	x,(OFST+1,sp)
4755  028b 7d            	tnz	(x)
4756  028c 26e7          	jrne	L5203
4757                     ; 230 }
4760  028e 85            	popw	x
4761  028f 81            	ret
4825                     ; 236 void Display_LCD_Num(u8 x,u16 num,u8 time)
4825                     ; 237 {
4826                     	switch	.text
4827  0290               _Display_LCD_Num:
4829  0290 88            	push	a
4830  0291 88            	push	a
4831       00000001      OFST:	set	1
4834                     ; 239 	switch(x)
4837                     ; 245 		case 4: addr=0x00;break;
4838  0292 4d            	tnz	a
4839  0293 270e          	jreq	L5303
4840  0295 4a            	dec	a
4841  0296 2711          	jreq	L7303
4842  0298 4a            	dec	a
4843  0299 2714          	jreq	L1403
4844  029b 4a            	dec	a
4845  029c 2717          	jreq	L3403
4846  029e 4a            	dec	a
4847  029f 271a          	jreq	L5403
4848  02a1 201a          	jra	L3013
4849  02a3               L5303:
4850                     ; 241 		case 0: addr=0x80;break;
4852  02a3 a680          	ld	a,#128
4853  02a5 6b01          	ld	(OFST+0,sp),a
4856  02a7 2014          	jra	L3013
4857  02a9               L7303:
4858                     ; 242 		case 1: addr=0x90;break;
4860  02a9 a690          	ld	a,#144
4861  02ab 6b01          	ld	(OFST+0,sp),a
4864  02ad 200e          	jra	L3013
4865  02af               L1403:
4866                     ; 243 		case 2: addr=0x88;break;
4868  02af a688          	ld	a,#136
4869  02b1 6b01          	ld	(OFST+0,sp),a
4872  02b3 2008          	jra	L3013
4873  02b5               L3403:
4874                     ; 244 		case 3: addr=0x98;break;
4876  02b5 a698          	ld	a,#152
4877  02b7 6b01          	ld	(OFST+0,sp),a
4880  02b9 2002          	jra	L3013
4881  02bb               L5403:
4882                     ; 245 		case 4: addr=0x00;break;
4884  02bb 0f01          	clr	(OFST+0,sp)
4887  02bd               L3013:
4888                     ; 247 	if(addr != 0x00)
4890  02bd 0d01          	tnz	(OFST+0,sp)
4891  02bf 2705          	jreq	L5013
4892                     ; 249 		Write_LCD_Command(addr);
4894  02c1 7b01          	ld	a,(OFST+0,sp)
4895  02c3 cd00af        	call	_Write_LCD_Command
4897  02c6               L5013:
4898                     ; 251 		Write_LCD_Data(0x30+num/10000);
4900  02c6 1e05          	ldw	x,(OFST+4,sp)
4901  02c8 90ae2710      	ldw	y,#10000
4902  02cc 65            	divw	x,y
4903  02cd 1c0030        	addw	x,#48
4904  02d0 9f            	ld	a,xl
4905  02d1 cd00d5        	call	_Write_LCD_Data
4907                     ; 252 		Write_LCD_Data(0x30+num/1000%10);
4909  02d4 1e05          	ldw	x,(OFST+4,sp)
4910  02d6 90ae03e8      	ldw	y,#1000
4911  02da 65            	divw	x,y
4912  02db a60a          	ld	a,#10
4913  02dd 62            	div	x,a
4914  02de 5f            	clrw	x
4915  02df 97            	ld	xl,a
4916  02e0 9f            	ld	a,xl
4917  02e1 ab30          	add	a,#48
4918  02e3 cd00d5        	call	_Write_LCD_Data
4920                     ; 253 		Write_LCD_Data(0x30+num/100%10);
4922  02e6 1e05          	ldw	x,(OFST+4,sp)
4923  02e8 a664          	ld	a,#100
4924  02ea 62            	div	x,a
4925  02eb a60a          	ld	a,#10
4926  02ed 62            	div	x,a
4927  02ee 5f            	clrw	x
4928  02ef 97            	ld	xl,a
4929  02f0 9f            	ld	a,xl
4930  02f1 ab30          	add	a,#48
4931  02f3 cd00d5        	call	_Write_LCD_Data
4933                     ; 254 		Write_LCD_Data(0x30+num/10%10);
4935  02f6 1e05          	ldw	x,(OFST+4,sp)
4936  02f8 a60a          	ld	a,#10
4937  02fa 62            	div	x,a
4938  02fb a60a          	ld	a,#10
4939  02fd 62            	div	x,a
4940  02fe 5f            	clrw	x
4941  02ff 97            	ld	xl,a
4942  0300 9f            	ld	a,xl
4943  0301 ab30          	add	a,#48
4944  0303 cd00d5        	call	_Write_LCD_Data
4946                     ; 255 		Write_LCD_Data(0x30+num%10);
4948  0306 1e05          	ldw	x,(OFST+4,sp)
4949  0308 a60a          	ld	a,#10
4950  030a 62            	div	x,a
4951  030b 5f            	clrw	x
4952  030c 97            	ld	xl,a
4953  030d 9f            	ld	a,xl
4954  030e ab30          	add	a,#48
4955  0310 cd00d5        	call	_Write_LCD_Data
4957                     ; 256 		delay_ms(time);
4959  0313 7b07          	ld	a,(OFST+6,sp)
4960  0315 5f            	clrw	x
4961  0316 97            	ld	xl,a
4962  0317 cd0000        	call	_delay_ms
4964                     ; 257 }
4967  031a 85            	popw	x
4968  031b 81            	ret
5032                     ; 264 void Draw_PM(const u8 *ptr)
5032                     ; 265 {
5033                     	switch	.text
5034  031c               _Draw_PM:
5036  031c 89            	pushw	x
5037  031d 5203          	subw	sp,#3
5038       00000003      OFST:	set	3
5041                     ; 267 	Write_LCD_Command(0x34);        //打开扩展指令集
5043  031f a634          	ld	a,#52
5044  0321 cd00af        	call	_Write_LCD_Command
5046                     ; 268 	i = 0x80;            
5048  0324 a680          	ld	a,#128
5049  0326 6b01          	ld	(OFST-2,sp),a
5050                     ; 269 	for(j = 0;j < 32;j++)
5052  0328 0f02          	clr	(OFST-1,sp)
5053  032a               L1413:
5054                     ; 271 		Write_LCD_Command(i++);
5056  032a 7b01          	ld	a,(OFST-2,sp)
5057  032c 0c01          	inc	(OFST-2,sp)
5058  032e cd00af        	call	_Write_LCD_Command
5060                     ; 272 		Write_LCD_Command(0x80);
5062  0331 a680          	ld	a,#128
5063  0333 cd00af        	call	_Write_LCD_Command
5065                     ; 273 		for(k = 0;k < 16;k++)
5067  0336 0f03          	clr	(OFST+0,sp)
5068  0338               L7413:
5069                     ; 275 			Write_LCD_Data(*ptr++);
5071  0338 1e04          	ldw	x,(OFST+1,sp)
5072  033a 1c0001        	addw	x,#1
5073  033d 1f04          	ldw	(OFST+1,sp),x
5074  033f 1d0001        	subw	x,#1
5075  0342 f6            	ld	a,(x)
5076  0343 cd00d5        	call	_Write_LCD_Data
5078                     ; 273 		for(k = 0;k < 16;k++)
5080  0346 0c03          	inc	(OFST+0,sp)
5083  0348 7b03          	ld	a,(OFST+0,sp)
5084  034a a110          	cp	a,#16
5085  034c 25ea          	jrult	L7413
5086                     ; 269 	for(j = 0;j < 32;j++)
5088  034e 0c02          	inc	(OFST-1,sp)
5091  0350 7b02          	ld	a,(OFST-1,sp)
5092  0352 a120          	cp	a,#32
5093  0354 25d4          	jrult	L1413
5094                     ; 278 	i = 0x80;
5096  0356 a680          	ld	a,#128
5097  0358 6b01          	ld	(OFST-2,sp),a
5098                     ; 279  	for(j = 0;j < 32;j++)
5100  035a 0f02          	clr	(OFST-1,sp)
5101  035c               L5513:
5102                     ; 281 		Write_LCD_Command(i++);
5104  035c 7b01          	ld	a,(OFST-2,sp)
5105  035e 0c01          	inc	(OFST-2,sp)
5106  0360 cd00af        	call	_Write_LCD_Command
5108                     ; 282 		Write_LCD_Command(0x88);	   
5110  0363 a688          	ld	a,#136
5111  0365 cd00af        	call	_Write_LCD_Command
5113                     ; 283 		for(k = 0;k < 16;k++)
5115  0368 0f03          	clr	(OFST+0,sp)
5116  036a               L3613:
5117                     ; 285 			Write_LCD_Data(*ptr++);
5119  036a 1e04          	ldw	x,(OFST+1,sp)
5120  036c 1c0001        	addw	x,#1
5121  036f 1f04          	ldw	(OFST+1,sp),x
5122  0371 1d0001        	subw	x,#1
5123  0374 f6            	ld	a,(x)
5124  0375 cd00d5        	call	_Write_LCD_Data
5126                     ; 283 		for(k = 0;k < 16;k++)
5128  0378 0c03          	inc	(OFST+0,sp)
5131  037a 7b03          	ld	a,(OFST+0,sp)
5132  037c a110          	cp	a,#16
5133  037e 25ea          	jrult	L3613
5134                     ; 279  	for(j = 0;j < 32;j++)
5136  0380 0c02          	inc	(OFST-1,sp)
5139  0382 7b02          	ld	a,(OFST-1,sp)
5140  0384 a120          	cp	a,#32
5141  0386 25d4          	jrult	L5513
5142                     ; 288 	Write_LCD_Command(0x36);        //打开绘图显示
5144  0388 a636          	ld	a,#54
5145  038a cd00af        	call	_Write_LCD_Command
5147                     ; 289 	Write_LCD_Command(0x30);        //回到基本指令集
5149  038d a630          	ld	a,#48
5150  038f cd00af        	call	_Write_LCD_Command
5152                     ; 290 }
5155  0392 5b05          	addw	sp,#5
5156  0394 81            	ret
5159                     .const:	section	.text
5160  0000               _jm_a:
5161  0000 ff            	dc.b	255
5162  0001 ff            	dc.b	255
5163  0002 ff            	dc.b	255
5164  0003 ff            	dc.b	255
5165  0004 ff            	dc.b	255
5166  0005 ff            	dc.b	255
5167  0006 ff            	dc.b	255
5168  0007 ff            	dc.b	255
5169  0008 ff            	dc.b	255
5170  0009 ff            	dc.b	255
5171  000a ff            	dc.b	255
5172  000b ff            	dc.b	255
5173  000c ff            	dc.b	255
5174  000d ff            	dc.b	255
5175  000e ff            	dc.b	255
5176  000f ff            	dc.b	255
5177  0010 ff            	dc.b	255
5178  0011 ff            	dc.b	255
5179  0012 ff            	dc.b	255
5180  0013 ff            	dc.b	255
5181  0014 ff            	dc.b	255
5182  0015 ff            	dc.b	255
5183  0016 ff            	dc.b	255
5184  0017 ff            	dc.b	255
5185  0018 ff            	dc.b	255
5186  0019 ff            	dc.b	255
5187  001a ff            	dc.b	255
5188  001b ff            	dc.b	255
5189  001c ff            	dc.b	255
5190  001d ff            	dc.b	255
5191  001e ff            	dc.b	255
5192  001f ff            	dc.b	255
5193  0020 ff            	dc.b	255
5194  0021 ff            	dc.b	255
5195  0022 ff            	dc.b	255
5196  0023 ff            	dc.b	255
5197  0024 ff            	dc.b	255
5198  0025 ff            	dc.b	255
5199  0026 ff            	dc.b	255
5200  0027 ff            	dc.b	255
5201  0028 ff            	dc.b	255
5202  0029 ff            	dc.b	255
5203  002a ff            	dc.b	255
5204  002b ff            	dc.b	255
5205  002c ff            	dc.b	255
5206  002d ff            	dc.b	255
5207  002e ff            	dc.b	255
5208  002f ff            	dc.b	255
5209  0030 ff            	dc.b	255
5210  0031 ff            	dc.b	255
5211  0032 ff            	dc.b	255
5212  0033 ff            	dc.b	255
5213  0034 ff            	dc.b	255
5214  0035 ff            	dc.b	255
5215  0036 ff            	dc.b	255
5216  0037 ff            	dc.b	255
5217  0038 ff            	dc.b	255
5218  0039 ff            	dc.b	255
5219  003a ff            	dc.b	255
5220  003b ff            	dc.b	255
5221  003c ff            	dc.b	255
5222  003d ff            	dc.b	255
5223  003e ff            	dc.b	255
5224  003f ff            	dc.b	255
5225  0040 ff            	dc.b	255
5226  0041 ff            	dc.b	255
5227  0042 ff            	dc.b	255
5228  0043 ff            	dc.b	255
5229  0044 ff            	dc.b	255
5230  0045 ff            	dc.b	255
5231  0046 ff            	dc.b	255
5232  0047 ff            	dc.b	255
5233  0048 ff            	dc.b	255
5234  0049 ff            	dc.b	255
5235  004a ff            	dc.b	255
5236  004b ff            	dc.b	255
5237  004c ff            	dc.b	255
5238  004d ff            	dc.b	255
5239  004e ff            	dc.b	255
5240  004f ff            	dc.b	255
5241  0050 ff            	dc.b	255
5242  0051 ff            	dc.b	255
5243  0052 ff            	dc.b	255
5244  0053 ff            	dc.b	255
5245  0054 ff            	dc.b	255
5246  0055 ff            	dc.b	255
5247  0056 ff            	dc.b	255
5248  0057 ff            	dc.b	255
5249  0058 ff            	dc.b	255
5250  0059 ff            	dc.b	255
5251  005a ff            	dc.b	255
5252  005b ff            	dc.b	255
5253  005c ff            	dc.b	255
5254  005d ff            	dc.b	255
5255  005e ff            	dc.b	255
5256  005f ff            	dc.b	255
5257  0060 ff            	dc.b	255
5258  0061 ff            	dc.b	255
5259  0062 ff            	dc.b	255
5260  0063 ff            	dc.b	255
5261  0064 ff            	dc.b	255
5262  0065 ff            	dc.b	255
5263  0066 ff            	dc.b	255
5264  0067 ff            	dc.b	255
5265  0068 ff            	dc.b	255
5266  0069 ff            	dc.b	255
5267  006a ff            	dc.b	255
5268  006b ff            	dc.b	255
5269  006c ff            	dc.b	255
5270  006d ff            	dc.b	255
5271  006e ff            	dc.b	255
5272  006f ff            	dc.b	255
5273  0070 ff            	dc.b	255
5274  0071 ff            	dc.b	255
5275  0072 ff            	dc.b	255
5276  0073 ff            	dc.b	255
5277  0074 ff            	dc.b	255
5278  0075 ff            	dc.b	255
5279  0076 ff            	dc.b	255
5280  0077 ff            	dc.b	255
5281  0078 ff            	dc.b	255
5282  0079 ff            	dc.b	255
5283  007a ff            	dc.b	255
5284  007b ff            	dc.b	255
5285  007c ff            	dc.b	255
5286  007d ff            	dc.b	255
5287  007e ff            	dc.b	255
5288  007f ff            	dc.b	255
5289  0080 ff            	dc.b	255
5290  0081 ff            	dc.b	255
5291  0082 ff            	dc.b	255
5292  0083 ff            	dc.b	255
5293  0084 ff            	dc.b	255
5294  0085 ff            	dc.b	255
5295  0086 ff            	dc.b	255
5296  0087 ff            	dc.b	255
5297  0088 ff            	dc.b	255
5298  0089 ff            	dc.b	255
5299  008a ff            	dc.b	255
5300  008b ff            	dc.b	255
5301  008c ff            	dc.b	255
5302  008d ff            	dc.b	255
5303  008e ff            	dc.b	255
5304  008f ff            	dc.b	255
5305  0090 ff            	dc.b	255
5306  0091 ff            	dc.b	255
5307  0092 ff            	dc.b	255
5308  0093 ff            	dc.b	255
5309  0094 ff            	dc.b	255
5310  0095 ff            	dc.b	255
5311  0096 ff            	dc.b	255
5312  0097 ff            	dc.b	255
5313  0098 ff            	dc.b	255
5314  0099 ff            	dc.b	255
5315  009a ff            	dc.b	255
5316  009b ff            	dc.b	255
5317  009c ff            	dc.b	255
5318  009d ff            	dc.b	255
5319  009e ff            	dc.b	255
5320  009f ff            	dc.b	255
5321  00a0 ff            	dc.b	255
5322  00a1 ff            	dc.b	255
5323  00a2 ff            	dc.b	255
5324  00a3 ff            	dc.b	255
5325  00a4 ff            	dc.b	255
5326  00a5 ff            	dc.b	255
5327  00a6 ff            	dc.b	255
5328  00a7 ff            	dc.b	255
5329  00a8 ff            	dc.b	255
5330  00a9 fc            	dc.b	252
5331  00aa ff            	dc.b	255
5332  00ab ff            	dc.b	255
5333  00ac ff            	dc.b	255
5334  00ad ff            	dc.b	255
5335  00ae ff            	dc.b	255
5336  00af ff            	dc.b	255
5337  00b0 ff            	dc.b	255
5338  00b1 ff            	dc.b	255
5339  00b2 ff            	dc.b	255
5340  00b3 ff            	dc.b	255
5341  00b4 ff            	dc.b	255
5342  00b5 ff            	dc.b	255
5343  00b6 ff            	dc.b	255
5344  00b7 f1            	dc.b	241
5345  00b8 ff            	dc.b	255
5346  00b9 f8            	dc.b	248
5347  00ba 7f            	dc.b	127
5348  00bb ff            	dc.b	255
5349  00bc ff            	dc.b	255
5350  00bd ff            	dc.b	255
5351  00be ff            	dc.b	255
5352  00bf ff            	dc.b	255
5353  00c0 ff            	dc.b	255
5354  00c1 ff            	dc.b	255
5355  00c2 ff            	dc.b	255
5356  00c3 ff            	dc.b	255
5357  00c4 ff            	dc.b	255
5358  00c5 ff            	dc.b	255
5359  00c6 ff            	dc.b	255
5360  00c7 c0            	dc.b	192
5361  00c8 7f            	dc.b	127
5362  00c9 f4            	dc.b	244
5363  00ca bf            	dc.b	191
5364  00cb ff            	dc.b	255
5365  00cc ff            	dc.b	255
5366  00cd ff            	dc.b	255
5367  00ce ff            	dc.b	255
5368  00cf ff            	dc.b	255
5369  00d0 ff            	dc.b	255
5370  00d1 ff            	dc.b	255
5371  00d2 ff            	dc.b	255
5372  00d3 ff            	dc.b	255
5373  00d4 ff            	dc.b	255
5374  00d5 ff            	dc.b	255
5375  00d6 ff            	dc.b	255
5376  00d7 00            	dc.b	0
5377  00d8 1f            	dc.b	31
5378  00d9 f0            	dc.b	240
5379  00da bf            	dc.b	191
5380  00db ff            	dc.b	255
5381  00dc ff            	dc.b	255
5382  00dd ff            	dc.b	255
5383  00de ff            	dc.b	255
5384  00df ff            	dc.b	255
5385  00e0 ff            	dc.b	255
5386  00e1 ff            	dc.b	255
5387  00e2 ff            	dc.b	255
5388  00e3 ff            	dc.b	255
5389  00e4 ff            	dc.b	255
5390  00e5 ff            	dc.b	255
5391  00e6 fc            	dc.b	252
5392  00e7 00            	dc.b	0
5393  00e8 07            	dc.b	7
5394  00e9 f8            	dc.b	248
5395  00ea 7f            	dc.b	127
5396  00eb ff            	dc.b	255
5397  00ec ff            	dc.b	255
5398  00ed ff            	dc.b	255
5399  00ee ff            	dc.b	255
5400  00ef ff            	dc.b	255
5401  00f0 ff            	dc.b	255
5402  00f1 ff            	dc.b	255
5403  00f2 ff            	dc.b	255
5404  00f3 ff            	dc.b	255
5405  00f4 ff            	dc.b	255
5406  00f5 ff            	dc.b	255
5407  00f6 f0            	dc.b	240
5408  00f7 00            	dc.b	0
5409  00f8 01            	dc.b	1
5410  00f9 ff            	dc.b	255
5411  00fa ff            	dc.b	255
5412  00fb ff            	dc.b	255
5413  00fc ff            	dc.b	255
5414  00fd ff            	dc.b	255
5415  00fe ff            	dc.b	255
5416  00ff ff            	dc.b	255
5417  0100 ff            	dc.b	255
5418  0101 ff            	dc.b	255
5419  0102 ff            	dc.b	255
5420  0103 ff            	dc.b	255
5421  0104 ff            	dc.b	255
5422  0105 ff            	dc.b	255
5423  0106 c0            	dc.b	192
5424  0107 00            	dc.b	0
5425  0108 00            	dc.b	0
5426  0109 7f            	dc.b	127
5427  010a ff            	dc.b	255
5428  010b ff            	dc.b	255
5429  010c ff            	dc.b	255
5430  010d ff            	dc.b	255
5431  010e ff            	dc.b	255
5432  010f ff            	dc.b	255
5433  0110 ff            	dc.b	255
5434  0111 ff            	dc.b	255
5435  0112 ff            	dc.b	255
5436  0113 ff            	dc.b	255
5437  0114 ff            	dc.b	255
5438  0115 ff            	dc.b	255
5439  0116 00            	dc.b	0
5440  0117 00            	dc.b	0
5441  0118 00            	dc.b	0
5442  0119 1f            	dc.b	31
5443  011a ff            	dc.b	255
5444  011b ff            	dc.b	255
5445  011c ff            	dc.b	255
5446  011d ff            	dc.b	255
5447  011e ff            	dc.b	255
5448  011f ff            	dc.b	255
5449  0120 ff            	dc.b	255
5450  0121 ff            	dc.b	255
5451  0122 ff            	dc.b	255
5452  0123 ff            	dc.b	255
5453  0124 ff            	dc.b	255
5454  0125 fe            	dc.b	254
5455  0126 00            	dc.b	0
5456  0127 00            	dc.b	0
5457  0128 00            	dc.b	0
5458  0129 0f            	dc.b	15
5459  012a ff            	dc.b	255
5460  012b ff            	dc.b	255
5461  012c ff            	dc.b	255
5462  012d ff            	dc.b	255
5463  012e ff            	dc.b	255
5464  012f ff            	dc.b	255
5465  0130 ff            	dc.b	255
5466  0131 ff            	dc.b	255
5467  0132 ff            	dc.b	255
5468  0133 ff            	dc.b	255
5469  0134 ff            	dc.b	255
5470  0135 fc            	dc.b	252
5471  0136 80            	dc.b	128
5472  0137 00            	dc.b	0
5473  0138 00            	dc.b	0
5474  0139 27            	dc.b	39
5475  013a ff            	dc.b	255
5476  013b ff            	dc.b	255
5477  013c ff            	dc.b	255
5478  013d ff            	dc.b	255
5479  013e ff            	dc.b	255
5480  013f ff            	dc.b	255
5481  0140 ff            	dc.b	255
5482  0141 ff            	dc.b	255
5483  0142 ff            	dc.b	255
5484  0143 ff            	dc.b	255
5485  0144 ff            	dc.b	255
5486  0145 fc            	dc.b	252
5487  0146 20            	dc.b	32
5488  0147 00            	dc.b	0
5489  0148 00            	dc.b	0
5490  0149 07            	dc.b	7
5491  014a ff            	dc.b	255
5492  014b ff            	dc.b	255
5493  014c ff            	dc.b	255
5494  014d ff            	dc.b	255
5495  014e ff            	dc.b	255
5496  014f ff            	dc.b	255
5497  0150 ff            	dc.b	255
5498  0151 ff            	dc.b	255
5499  0152 ff            	dc.b	255
5500  0153 ff            	dc.b	255
5501  0154 ff            	dc.b	255
5502  0155 fc            	dc.b	252
5503  0156 08            	dc.b	8
5504  0157 00            	dc.b	0
5505  0158 02            	dc.b	2
5506  0159 27            	dc.b	39
5507  015a ff            	dc.b	255
5508  015b ff            	dc.b	255
5509  015c ff            	dc.b	255
5510  015d ff            	dc.b	255
5511  015e ff            	dc.b	255
5512  015f ff            	dc.b	255
5513  0160 ff            	dc.b	255
5514  0161 ff            	dc.b	255
5515  0162 ff            	dc.b	255
5516  0163 ff            	dc.b	255
5517  0164 ff            	dc.b	255
5518  0165 fc            	dc.b	252
5519  0166 02            	dc.b	2
5520  0167 00            	dc.b	0
5521  0168 00            	dc.b	0
5522  0169 67            	dc.b	103
5523  016a ff            	dc.b	255
5524  016b ff            	dc.b	255
5525  016c ff            	dc.b	255
5526  016d ff            	dc.b	255
5527  016e ff            	dc.b	255
5528  016f ff            	dc.b	255
5529  0170 ff            	dc.b	255
5530  0171 ff            	dc.b	255
5531  0172 ff            	dc.b	255
5532  0173 ff            	dc.b	255
5533  0174 ff            	dc.b	255
5534  0175 fc            	dc.b	252
5535  0176 01            	dc.b	1
5536  0177 00            	dc.b	0
5537  0178 11            	dc.b	17
5538  0179 e7            	dc.b	231
5539  017a ff            	dc.b	255
5540  017b ff            	dc.b	255
5541  017c ff            	dc.b	255
5542  017d ff            	dc.b	255
5543  017e ff            	dc.b	255
5544  017f ff            	dc.b	255
5545  0180 ff            	dc.b	255
5546  0181 ff            	dc.b	255
5547  0182 ff            	dc.b	255
5548  0183 ff            	dc.b	255
5549  0184 ff            	dc.b	255
5550  0185 fc            	dc.b	252
5551  0186 00            	dc.b	0
5552  0187 4e            	dc.b	78
5553  0188 43            	dc.b	67
5554  0189 e7            	dc.b	231
5555  018a ff            	dc.b	255
5556  018b ff            	dc.b	255
5557  018c ff            	dc.b	255
5558  018d ff            	dc.b	255
5559  018e ff            	dc.b	255
5560  018f ff            	dc.b	255
5561  0190 ff            	dc.b	255
5562  0191 ff            	dc.b	255
5563  0192 ff            	dc.b	255
5564  0193 ff            	dc.b	255
5565  0194 ff            	dc.b	255
5566  0195 fc            	dc.b	252
5567  0196 00            	dc.b	0
5568  0197 1f            	dc.b	31
5569  0198 03            	dc.b	3
5570  0199 e7            	dc.b	231
5571  019a ff            	dc.b	255
5572  019b ff            	dc.b	255
5573  019c ff            	dc.b	255
5574  019d ff            	dc.b	255
5575  019e ff            	dc.b	255
5576  019f ff            	dc.b	255
5577  01a0 ff            	dc.b	255
5578  01a1 ff            	dc.b	255
5579  01a2 ff            	dc.b	255
5580  01a3 ff            	dc.b	255
5581  01a4 ff            	dc.b	255
5582  01a5 fc            	dc.b	252
5583  01a6 00            	dc.b	0
5584  01a7 04            	dc.b	4
5585  01a8 67            	dc.b	103
5586  01a9 e7            	dc.b	231
5587  01aa ff            	dc.b	255
5588  01ab ff            	dc.b	255
5589  01ac ff            	dc.b	255
5590  01ad ff            	dc.b	255
5591  01ae ff            	dc.b	255
5592  01af ff            	dc.b	255
5593  01b0 ff            	dc.b	255
5594  01b1 ff            	dc.b	255
5595  01b2 ff            	dc.b	255
5596  01b3 ff            	dc.b	255
5597  01b4 ff            	dc.b	255
5598  01b5 fc            	dc.b	252
5599  01b6 80            	dc.b	128
5600  01b7 60            	dc.b	96
5601  01b8 ef            	dc.b	239
5602  01b9 e7            	dc.b	231
5603  01ba ff            	dc.b	255
5604  01bb ff            	dc.b	255
5605  01bc ff            	dc.b	255
5606  01bd ff            	dc.b	255
5607  01be ff            	dc.b	255
5608  01bf ff            	dc.b	255
5609  01c0 ff            	dc.b	255
5610  01c1 ff            	dc.b	255
5611  01c2 ff            	dc.b	255
5612  01c3 ff            	dc.b	255
5613  01c4 ff            	dc.b	255
5614  01c5 fc            	dc.b	252
5615  01c6 e0            	dc.b	224
5616  01c7 71            	dc.b	113
5617  01c8 fd            	dc.b	253
5618  01c9 e7            	dc.b	231
5619  01ca ff            	dc.b	255
5620  01cb ff            	dc.b	255
5621  01cc ff            	dc.b	255
5622  01cd ff            	dc.b	255
5623  01ce ff            	dc.b	255
5624  01cf ff            	dc.b	255
5625  01d0 ff            	dc.b	255
5626  01d1 ff            	dc.b	255
5627  01d2 ff            	dc.b	255
5628  01d3 ff            	dc.b	255
5629  01d4 ff            	dc.b	255
5630  01d5 fc            	dc.b	252
5631  01d6 e0            	dc.b	224
5632  01d7 71            	dc.b	113
5633  01d8 d9            	dc.b	217
5634  01d9 e7            	dc.b	231
5635  01da ff            	dc.b	255
5636  01db ff            	dc.b	255
5637  01dc ff            	dc.b	255
5638  01dd ff            	dc.b	255
5639  01de ff            	dc.b	255
5640  01df ff            	dc.b	255
5641  01e0 ff            	dc.b	255
5642  01e1 ff            	dc.b	255
5643  01e2 ff            	dc.b	255
5644  01e3 ff            	dc.b	255
5645  01e4 ff            	dc.b	255
5646  01e5 fc            	dc.b	252
5647  01e6 e0            	dc.b	224
5648  01e7 71            	dc.b	113
5649  01e8 c9            	dc.b	201
5650  01e9 e7            	dc.b	231
5651  01ea ff            	dc.b	255
5652  01eb ff            	dc.b	255
5653  01ec ff            	dc.b	255
5654  01ed ff            	dc.b	255
5655  01ee ff            	dc.b	255
5656  01ef ff            	dc.b	255
5657  01f0 ff            	dc.b	255
5658  01f1 ff            	dc.b	255
5659  01f2 ff            	dc.b	255
5660  01f3 ff            	dc.b	255
5661  01f4 ff            	dc.b	255
5662  01f5 fc            	dc.b	252
5663  01f6 f0            	dc.b	240
5664  01f7 71            	dc.b	113
5665  01f8 c1            	dc.b	193
5666  01f9 e7            	dc.b	231
5667  01fa ff            	dc.b	255
5668  01fb ff            	dc.b	255
5669  01fc ff            	dc.b	255
5670  01fd ff            	dc.b	255
5671  01fe ff            	dc.b	255
5672  01ff ff            	dc.b	255
5673  0200 ff            	dc.b	255
5674  0201 ff            	dc.b	255
5675  0202 ff            	dc.b	255
5676  0203 ff            	dc.b	255
5677  0204 ff            	dc.b	255
5678  0205 fe            	dc.b	254
5679  0206 3c            	dc.b	60
5680  0207 71            	dc.b	113
5681  0208 c1            	dc.b	193
5682  0209 8f            	dc.b	143
5683  020a ff            	dc.b	255
5684  020b ff            	dc.b	255
5685  020c ff            	dc.b	255
5686  020d ff            	dc.b	255
5687  020e ff            	dc.b	255
5688  020f ff            	dc.b	255
5689  0210 ff            	dc.b	255
5690  0211 ff            	dc.b	255
5691  0212 ff            	dc.b	255
5692  0213 ff            	dc.b	255
5693  0214 ff            	dc.b	255
5694  0215 ff            	dc.b	255
5695  0216 8f            	dc.b	143
5696  0217 71            	dc.b	113
5697  0218 c1            	dc.b	193
5698  0219 3f            	dc.b	63
5699  021a ff            	dc.b	255
5700  021b ff            	dc.b	255
5701  021c ff            	dc.b	255
5702  021d ff            	dc.b	255
5703  021e ff            	dc.b	255
5704  021f ff            	dc.b	255
5705  0220 ff            	dc.b	255
5706  0221 ff            	dc.b	255
5707  0222 ff            	dc.b	255
5708  0223 ff            	dc.b	255
5709  0224 ff            	dc.b	255
5710  0225 ff            	dc.b	255
5711  0226 e3            	dc.b	227
5712  0227 f1            	dc.b	241
5713  0228 c0            	dc.b	192
5714  0229 ff            	dc.b	255
5715  022a ff            	dc.b	255
5716  022b ff            	dc.b	255
5717  022c ff            	dc.b	255
5718  022d ff            	dc.b	255
5719  022e ff            	dc.b	255
5720  022f ff            	dc.b	255
5721  0230 ff            	dc.b	255
5722  0231 ff            	dc.b	255
5723  0232 ff            	dc.b	255
5724  0233 ff            	dc.b	255
5725  0234 ff            	dc.b	255
5726  0235 ff            	dc.b	255
5727  0236 f8            	dc.b	248
5728  0237 f1            	dc.b	241
5729  0238 c3            	dc.b	195
5730  0239 ff            	dc.b	255
5731  023a ff            	dc.b	255
5732  023b ff            	dc.b	255
5733  023c ff            	dc.b	255
5734  023d ff            	dc.b	255
5735  023e ff            	dc.b	255
5736  023f ff            	dc.b	255
5737  0240 ff            	dc.b	255
5738  0241 ff            	dc.b	255
5739  0242 ff            	dc.b	255
5740  0243 ff            	dc.b	255
5741  0244 ff            	dc.b	255
5742  0245 ff            	dc.b	255
5743  0246 fe            	dc.b	254
5744  0247 31            	dc.b	49
5745  0248 cf            	dc.b	207
5746  0249 ff            	dc.b	255
5747  024a ff            	dc.b	255
5748  024b ff            	dc.b	255
5749  024c ff            	dc.b	255
5750  024d ff            	dc.b	255
5751  024e ff            	dc.b	255
5752  024f ff            	dc.b	255
5753  0250 ff            	dc.b	255
5754  0251 ff            	dc.b	255
5755  0252 ff            	dc.b	255
5756  0253 ff            	dc.b	255
5757  0254 ff            	dc.b	255
5758  0255 ff            	dc.b	255
5759  0256 ff            	dc.b	255
5760  0257 81            	dc.b	129
5761  0258 3f            	dc.b	63
5762  0259 ff            	dc.b	255
5763  025a ff            	dc.b	255
5764  025b ff            	dc.b	255
5765  025c ff            	dc.b	255
5766  025d ff            	dc.b	255
5767  025e ff            	dc.b	255
5768  025f ff            	dc.b	255
5769  0260 ff            	dc.b	255
5770  0261 ff            	dc.b	255
5771  0262 ff            	dc.b	255
5772  0263 ff            	dc.b	255
5773  0264 ff            	dc.b	255
5774  0265 ff            	dc.b	255
5775  0266 ff            	dc.b	255
5776  0267 c0            	dc.b	192
5777  0268 ff            	dc.b	255
5778  0269 ff            	dc.b	255
5779  026a ff            	dc.b	255
5780  026b ff            	dc.b	255
5781  026c ff            	dc.b	255
5782  026d ff            	dc.b	255
5783  026e ff            	dc.b	255
5784  026f ff            	dc.b	255
5785  0270 ff            	dc.b	255
5786  0271 ff            	dc.b	255
5787  0272 ff            	dc.b	255
5788  0273 ff            	dc.b	255
5789  0274 ff            	dc.b	255
5790  0275 ff            	dc.b	255
5791  0276 ff            	dc.b	255
5792  0277 f1            	dc.b	241
5793  0278 ff            	dc.b	255
5794  0279 ff            	dc.b	255
5795  027a ff            	dc.b	255
5796  027b ff            	dc.b	255
5797  027c ff            	dc.b	255
5798  027d ff            	dc.b	255
5799  027e ff            	dc.b	255
5800  027f ff            	dc.b	255
5801  0280 ff            	dc.b	255
5802  0281 ff            	dc.b	255
5803  0282 ff            	dc.b	255
5804  0283 ff            	dc.b	255
5805  0284 ff            	dc.b	255
5806  0285 ff            	dc.b	255
5807  0286 ff            	dc.b	255
5808  0287 ff            	dc.b	255
5809  0288 ff            	dc.b	255
5810  0289 ff            	dc.b	255
5811  028a ff            	dc.b	255
5812  028b ff            	dc.b	255
5813  028c ff            	dc.b	255
5814  028d ff            	dc.b	255
5815  028e ff            	dc.b	255
5816  028f ff            	dc.b	255
5817  0290 ff            	dc.b	255
5818  0291 ff            	dc.b	255
5819  0292 ff            	dc.b	255
5820  0293 ff            	dc.b	255
5821  0294 ff            	dc.b	255
5822  0295 ff            	dc.b	255
5823  0296 ff            	dc.b	255
5824  0297 ff            	dc.b	255
5825  0298 ff            	dc.b	255
5826  0299 ff            	dc.b	255
5827  029a ff            	dc.b	255
5828  029b ff            	dc.b	255
5829  029c ff            	dc.b	255
5830  029d ff            	dc.b	255
5831  029e ff            	dc.b	255
5832  029f ff            	dc.b	255
5833  02a0 ff            	dc.b	255
5834  02a1 ff            	dc.b	255
5835  02a2 ff            	dc.b	255
5836  02a3 ff            	dc.b	255
5837  02a4 ff            	dc.b	255
5838  02a5 ff            	dc.b	255
5839  02a6 ff            	dc.b	255
5840  02a7 ff            	dc.b	255
5841  02a8 ff            	dc.b	255
5842  02a9 ff            	dc.b	255
5843  02aa ff            	dc.b	255
5844  02ab ff            	dc.b	255
5845  02ac ff            	dc.b	255
5846  02ad ff            	dc.b	255
5847  02ae ff            	dc.b	255
5848  02af ff            	dc.b	255
5849  02b0 ff            	dc.b	255
5850  02b1 ff            	dc.b	255
5851  02b2 ff            	dc.b	255
5852  02b3 ff            	dc.b	255
5853  02b4 ff            	dc.b	255
5854  02b5 ff            	dc.b	255
5855  02b6 ff            	dc.b	255
5856  02b7 ff            	dc.b	255
5857  02b8 ff            	dc.b	255
5858  02b9 ff            	dc.b	255
5859  02ba ff            	dc.b	255
5860  02bb ff            	dc.b	255
5861  02bc ff            	dc.b	255
5862  02bd ff            	dc.b	255
5863  02be ff            	dc.b	255
5864  02bf ff            	dc.b	255
5865  02c0 ff            	dc.b	255
5866  02c1 ff            	dc.b	255
5867  02c2 ff            	dc.b	255
5868  02c3 ff            	dc.b	255
5869  02c4 ff            	dc.b	255
5870  02c5 fc            	dc.b	252
5871  02c6 cc            	dc.b	204
5872  02c7 08            	dc.b	8
5873  02c8 e3            	dc.b	227
5874  02c9 c7            	dc.b	199
5875  02ca ff            	dc.b	255
5876  02cb ff            	dc.b	255
5877  02cc ff            	dc.b	255
5878  02cd ff            	dc.b	255
5879  02ce ff            	dc.b	255
5880  02cf ff            	dc.b	255
5881  02d0 ff            	dc.b	255
5882  02d1 ff            	dc.b	255
5883  02d2 ff            	dc.b	255
5884  02d3 ff            	dc.b	255
5885  02d4 ff            	dc.b	255
5886  02d5 fc            	dc.b	252
5887  02d6 cc            	dc.b	204
5888  02d7 f8            	dc.b	248
5889  02d8 63            	dc.b	99
5890  02d9 83            	dc.b	131
5891  02da ff            	dc.b	255
5892  02db ff            	dc.b	255
5893  02dc ff            	dc.b	255
5894  02dd ff            	dc.b	255
5895  02de ff            	dc.b	255
5896  02df ff            	dc.b	255
5897  02e0 ff            	dc.b	255
5898  02e1 ff            	dc.b	255
5899  02e2 ff            	dc.b	255
5900  02e3 ff            	dc.b	255
5901  02e4 ff            	dc.b	255
5902  02e5 fc            	dc.b	252
5903  02e6 cc            	dc.b	204
5904  02e7 19            	dc.b	25
5905  02e8 03            	dc.b	3
5906  02e9 93            	dc.b	147
5907  02ea ff            	dc.b	255
5908  02eb ff            	dc.b	255
5909  02ec ff            	dc.b	255
5910  02ed ff            	dc.b	255
5911  02ee ff            	dc.b	255
5912  02ef ff            	dc.b	255
5913  02f0 ff            	dc.b	255
5914  02f1 ff            	dc.b	255
5915  02f2 ff            	dc.b	255
5916  02f3 ff            	dc.b	255
5917  02f4 ff            	dc.b	255
5918  02f5 f0            	dc.b	240
5919  02f6 cc            	dc.b	204
5920  02f7 09            	dc.b	9
5921  02f8 13            	dc.b	19
5922  02f9 01            	dc.b	1
5923  02fa ff            	dc.b	255
5924  02fb ff            	dc.b	255
5925  02fc ff            	dc.b	255
5926  02fd ff            	dc.b	255
5927  02fe ff            	dc.b	255
5928  02ff ff            	dc.b	255
5929  0300 ff            	dc.b	255
5930  0301 ff            	dc.b	255
5931  0302 ff            	dc.b	255
5932  0303 ff            	dc.b	255
5933  0304 ff            	dc.b	255
5934  0305 f3            	dc.b	243
5935  0306 df            	dc.b	223
5936  0307 1d            	dc.b	29
5937  0308 fb            	dc.b	251
5938  0309 7d            	dc.b	125
5939  030a ff            	dc.b	255
5940  030b ff            	dc.b	255
5941  030c ff            	dc.b	255
5942  030d ff            	dc.b	255
5943  030e ff            	dc.b	255
5944  030f ff            	dc.b	255
5945  0310 ff            	dc.b	255
5946  0311 ff            	dc.b	255
5947  0312 ff            	dc.b	255
5948  0313 ff            	dc.b	255
5949  0314 ff            	dc.b	255
5950  0315 ff            	dc.b	255
5951  0316 ff            	dc.b	255
5952  0317 ff            	dc.b	255
5953  0318 ff            	dc.b	255
5954  0319 ff            	dc.b	255
5955  031a ff            	dc.b	255
5956  031b ff            	dc.b	255
5957  031c ff            	dc.b	255
5958  031d ff            	dc.b	255
5959  031e ff            	dc.b	255
5960  031f ff            	dc.b	255
5961  0320 ff            	dc.b	255
5962  0321 ff            	dc.b	255
5963  0322 ff            	dc.b	255
5964  0323 ff            	dc.b	255
5965  0324 ff            	dc.b	255
5966  0325 ff            	dc.b	255
5967  0326 ff            	dc.b	255
5968  0327 ff            	dc.b	255
5969  0328 ff            	dc.b	255
5970  0329 ff            	dc.b	255
5971  032a ff            	dc.b	255
5972  032b ff            	dc.b	255
5973  032c ff            	dc.b	255
5974  032d ff            	dc.b	255
5975  032e ff            	dc.b	255
5976  032f ff            	dc.b	255
5977  0330 ff            	dc.b	255
5978  0331 ff            	dc.b	255
5979  0332 ff            	dc.b	255
5980  0333 ff            	dc.b	255
5981  0334 ff            	dc.b	255
5982  0335 ff            	dc.b	255
5983  0336 ff            	dc.b	255
5984  0337 ff            	dc.b	255
5985  0338 ff            	dc.b	255
5986  0339 ff            	dc.b	255
5987  033a ff            	dc.b	255
5988  033b ff            	dc.b	255
5989  033c ff            	dc.b	255
5990  033d ff            	dc.b	255
5991  033e ff            	dc.b	255
5992  033f ff            	dc.b	255
5993  0340 ff            	dc.b	255
5994  0341 ff            	dc.b	255
5995  0342 ff            	dc.b	255
5996  0343 ff            	dc.b	255
5997  0344 ff            	dc.b	255
5998  0345 ff            	dc.b	255
5999  0346 ff            	dc.b	255
6000  0347 ff            	dc.b	255
6001  0348 ff            	dc.b	255
6002  0349 ff            	dc.b	255
6003  034a ff            	dc.b	255
6004  034b ff            	dc.b	255
6005  034c ff            	dc.b	255
6006  034d ff            	dc.b	255
6007  034e ff            	dc.b	255
6008  034f ff            	dc.b	255
6009  0350 ff            	dc.b	255
6010  0351 ff            	dc.b	255
6011  0352 ff            	dc.b	255
6012  0353 ff            	dc.b	255
6013  0354 ff            	dc.b	255
6014  0355 ff            	dc.b	255
6015  0356 ff            	dc.b	255
6016  0357 ff            	dc.b	255
6017  0358 ff            	dc.b	255
6018  0359 ff            	dc.b	255
6019  035a ff            	dc.b	255
6020  035b ff            	dc.b	255
6021  035c ff            	dc.b	255
6022  035d ff            	dc.b	255
6023  035e ff            	dc.b	255
6024  035f ff            	dc.b	255
6025  0360 ff            	dc.b	255
6026  0361 ff            	dc.b	255
6027  0362 ff            	dc.b	255
6028  0363 ff            	dc.b	255
6029  0364 ff            	dc.b	255
6030  0365 ff            	dc.b	255
6031  0366 ff            	dc.b	255
6032  0367 ff            	dc.b	255
6033  0368 ff            	dc.b	255
6034  0369 ff            	dc.b	255
6035  036a ff            	dc.b	255
6036  036b ff            	dc.b	255
6037  036c ff            	dc.b	255
6038  036d ff            	dc.b	255
6039  036e ff            	dc.b	255
6040  036f ff            	dc.b	255
6041  0370 ff            	dc.b	255
6042  0371 ff            	dc.b	255
6043  0372 ff            	dc.b	255
6044  0373 ff            	dc.b	255
6045  0374 ff            	dc.b	255
6046  0375 ff            	dc.b	255
6047  0376 ff            	dc.b	255
6048  0377 ff            	dc.b	255
6049  0378 ff            	dc.b	255
6050  0379 ff            	dc.b	255
6051  037a ff            	dc.b	255
6052  037b ff            	dc.b	255
6053  037c ff            	dc.b	255
6054  037d ff            	dc.b	255
6055  037e ff            	dc.b	255
6056  037f ff            	dc.b	255
6057  0380 ff            	dc.b	255
6058  0381 ff            	dc.b	255
6059  0382 ff            	dc.b	255
6060  0383 ff            	dc.b	255
6061  0384 ff            	dc.b	255
6062  0385 ff            	dc.b	255
6063  0386 ff            	dc.b	255
6064  0387 ff            	dc.b	255
6065  0388 ff            	dc.b	255
6066  0389 ff            	dc.b	255
6067  038a ff            	dc.b	255
6068  038b ff            	dc.b	255
6069  038c ff            	dc.b	255
6070  038d ff            	dc.b	255
6071  038e ff            	dc.b	255
6072  038f ff            	dc.b	255
6073  0390 ff            	dc.b	255
6074  0391 ff            	dc.b	255
6075  0392 ff            	dc.b	255
6076  0393 ff            	dc.b	255
6077  0394 ff            	dc.b	255
6078  0395 ff            	dc.b	255
6079  0396 ff            	dc.b	255
6080  0397 ff            	dc.b	255
6081  0398 ff            	dc.b	255
6082  0399 ff            	dc.b	255
6083  039a ff            	dc.b	255
6084  039b ff            	dc.b	255
6085  039c ff            	dc.b	255
6086  039d ff            	dc.b	255
6087  039e ff            	dc.b	255
6088  039f ff            	dc.b	255
6089  03a0 ff            	dc.b	255
6090  03a1 ff            	dc.b	255
6091  03a2 ff            	dc.b	255
6092  03a3 ff            	dc.b	255
6093  03a4 ff            	dc.b	255
6094  03a5 ff            	dc.b	255
6095  03a6 ff            	dc.b	255
6096  03a7 ff            	dc.b	255
6097  03a8 ff            	dc.b	255
6098  03a9 ff            	dc.b	255
6099  03aa ff            	dc.b	255
6100  03ab ff            	dc.b	255
6101  03ac ff            	dc.b	255
6102  03ad ff            	dc.b	255
6103  03ae ff            	dc.b	255
6104  03af ff            	dc.b	255
6105  03b0 ff            	dc.b	255
6106  03b1 ff            	dc.b	255
6107  03b2 ff            	dc.b	255
6108  03b3 ff            	dc.b	255
6109  03b4 ff            	dc.b	255
6110  03b5 ff            	dc.b	255
6111  03b6 ff            	dc.b	255
6112  03b7 ff            	dc.b	255
6113  03b8 ff            	dc.b	255
6114  03b9 ff            	dc.b	255
6115  03ba ff            	dc.b	255
6116  03bb ff            	dc.b	255
6117  03bc ff            	dc.b	255
6118  03bd ff            	dc.b	255
6119  03be ff            	dc.b	255
6120  03bf ff            	dc.b	255
6121  03c0 ff            	dc.b	255
6122  03c1 ff            	dc.b	255
6123  03c2 ff            	dc.b	255
6124  03c3 ff            	dc.b	255
6125  03c4 ff            	dc.b	255
6126  03c5 ff            	dc.b	255
6127  03c6 ff            	dc.b	255
6128  03c7 ff            	dc.b	255
6129  03c8 ff            	dc.b	255
6130  03c9 ff            	dc.b	255
6131  03ca ff            	dc.b	255
6132  03cb ff            	dc.b	255
6133  03cc ff            	dc.b	255
6134  03cd ff            	dc.b	255
6135  03ce ff            	dc.b	255
6136  03cf ff            	dc.b	255
6137  03d0 ff            	dc.b	255
6138  03d1 ff            	dc.b	255
6139  03d2 ff            	dc.b	255
6140  03d3 ff            	dc.b	255
6141  03d4 ff            	dc.b	255
6142  03d5 ff            	dc.b	255
6143  03d6 ff            	dc.b	255
6144  03d7 ff            	dc.b	255
6145  03d8 ff            	dc.b	255
6146  03d9 ff            	dc.b	255
6147  03da ff            	dc.b	255
6148  03db ff            	dc.b	255
6149  03dc ff            	dc.b	255
6150  03dd ff            	dc.b	255
6151  03de ff            	dc.b	255
6152  03df ff            	dc.b	255
6153  03e0 ff            	dc.b	255
6154  03e1 ff            	dc.b	255
6155  03e2 ff            	dc.b	255
6156  03e3 ff            	dc.b	255
6157  03e4 ff            	dc.b	255
6158  03e5 ff            	dc.b	255
6159  03e6 ff            	dc.b	255
6160  03e7 ff            	dc.b	255
6161  03e8 ff            	dc.b	255
6162  03e9 ff            	dc.b	255
6163  03ea ff            	dc.b	255
6164  03eb ff            	dc.b	255
6165  03ec ff            	dc.b	255
6166  03ed ff            	dc.b	255
6167  03ee ff            	dc.b	255
6168  03ef ff            	dc.b	255
6169  03f0 ff            	dc.b	255
6170  03f1 ff            	dc.b	255
6171  03f2 ff            	dc.b	255
6172  03f3 ff            	dc.b	255
6173  03f4 ff            	dc.b	255
6174  03f5 ff            	dc.b	255
6175  03f6 ff            	dc.b	255
6176  03f7 ff            	dc.b	255
6177  03f8 ff            	dc.b	255
6178  03f9 ff            	dc.b	255
6179  03fa ff            	dc.b	255
6180  03fb ff            	dc.b	255
6181  03fc ff            	dc.b	255
6182  03fd ff            	dc.b	255
6183  03fe ff            	dc.b	255
6184  03ff ff            	dc.b	255
6207                     	xdef	_jm_a
6208                     	xdef	_Draw_PM
6209                     	xdef	_Display_LCD_Num
6210                     	xdef	_Display_String
6211                     	xdef	_Display_LCD_String_XY
6212                     	xdef	_Display_LCD_String
6213                     	xdef	_Disp_HZ
6214                     	xdef	_Display_LCD_Pos
6215                     	xdef	_LCD_Clear_BMP
6216                     	xdef	_LCD_Clear_TXT
6217                     	xdef	_Write_LCD_Data
6218                     	xdef	_Send_Byte
6219                     	xdef	_LCD12864_Init
6220                     	xdef	_delay_ms
6221                     	xdef	_Write_LCD_Command
6222                     	xref.b	c_y
6241                     	end
