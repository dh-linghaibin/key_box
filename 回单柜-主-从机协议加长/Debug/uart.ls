   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3447                     ; 16 void UART1_Init(void)
3447                     ; 17 {
3449                     	switch	.text
3450  0000               _UART1_Init:
3454                     ; 19 	PA_DDR |= BIT(5);
3456  0000 721a5002      	bset	_PA_DDR,#5
3457                     ; 20 	PA_CR1 |= BIT(5); 
3459  0004 721a5003      	bset	_PA_CR1,#5
3460                     ; 21 	PA_CR2 |= BIT(5);
3462  0008 721a5004      	bset	_PA_CR2,#5
3463                     ; 23 	PA_DDR &= ~BIT(4);
3465  000c 72195002      	bres	_PA_DDR,#4
3466                     ; 24 	PA_CR1 |= BIT(4); 
3468  0010 72185003      	bset	_PA_CR1,#4
3469                     ; 25 	PA_CR2 &= ~BIT(4);
3471  0014 72195004      	bres	_PA_CR2,#4
3472                     ; 27 	PA_DDR |= BIT(6);
3474  0018 721c5002      	bset	_PA_DDR,#6
3475                     ; 28 	PA_CR1 |= BIT(6); 
3477  001c 721c5003      	bset	_PA_CR1,#6
3478                     ; 29 	PA_CR2 |= BIT(6);
3480  0020 721c5004      	bset	_PA_CR2,#6
3481                     ; 30 	rs485_dr1 = 0;
3483  0024 721d5000      	bres	_OPA6
3484                     ; 31 	UART1_CR1=0x00;
3486  0028 725f5234      	clr	_UART1_CR1
3487                     ; 32 	UART1_CR2=0x00;
3489  002c 725f5235      	clr	_UART1_CR2
3490                     ; 33 	UART1_CR3=0x00; 
3492  0030 725f5236      	clr	_UART1_CR3
3493                     ; 34 	UART1_BRR2=0x02;
3495  0034 35025233      	mov	_UART1_BRR2,#2
3496                     ; 35 	UART1_BRR1=0x68;
3498  0038 35685232      	mov	_UART1_BRR1,#104
3499                     ; 36 	UART1_CR2=0x2c;//ÔÊÐí½ÓÊÕ£¬·¢ËÍ£¬¿ª½ÓÊÕÖÐ¶Ï
3501  003c 352c5235      	mov	_UART1_CR2,#44
3502                     ; 37 	UART1_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖÐ¶Ï*/
3504  0040 72155235      	bres	_UART1_CR2,#2
3505                     ; 38 }
3508  0044 81            	ret
3544                     ; 45 void UART1_Sendint(unsigned char ch)
3544                     ; 46 {
3545                     	switch	.text
3546  0045               _UART1_Sendint:
3548  0045 88            	push	a
3549       00000000      OFST:	set	0
3552  0046               L5232:
3553                     ; 47   while((UART1_SR & 0x80) == 0x00);    // µÈ´ýÊý¾ÝµÄ´«ËÍ  
3555  0046 c65230        	ld	a,_UART1_SR
3556  0049 a580          	bcp	a,#128
3557  004b 27f9          	jreq	L5232
3558                     ; 48   UART1_DR = ch;                    
3560  004d 7b01          	ld	a,(OFST+1,sp)
3561  004f c75231        	ld	_UART1_DR,a
3562                     ; 49 }
3565  0052 84            	pop	a
3566  0053 81            	ret
3624                     ; 57 void UART1_Send(u8 *Array,u8 command,u8 situ)
3624                     ; 58 {
3625                     	switch	.text
3626  0054               _UART1_Send:
3628  0054 89            	pushw	x
3629       00000000      OFST:	set	0
3632  0055               L1632:
3633                     ; 61 	while(ts1_ok == 1);
3635  0055 b600          	ld	a,_ts1_ok
3636  0057 a101          	cp	a,#1
3637  0059 27fa          	jreq	L1632
3638                     ; 62 	UART1_SR&= ~BIT(6);  //Çå³ýËÍÍê³É×´Ì¬Î»
3640  005b 721d5230      	bres	_UART1_SR,#6
3641                     ; 63 	UART1_CR2 |= BIT(6);//¿ª·¢ËÍÍê³ÉÖÐ
3643  005f 721c5235      	bset	_UART1_CR2,#6
3644                     ; 64 	Array[0] = situ;
3646  0063 7b06          	ld	a,(OFST+6,sp)
3647  0065 1e01          	ldw	x,(OFST+1,sp)
3648  0067 f7            	ld	(x),a
3649                     ; 65 	Array[1] = command;
3651  0068 7b05          	ld	a,(OFST+5,sp)
3652  006a 1e01          	ldw	x,(OFST+1,sp)
3653  006c e701          	ld	(1,x),a
3654                     ; 66 	Array[7] = c_last;
3656  006e 1e01          	ldw	x,(OFST+1,sp)
3657  0070 a60a          	ld	a,#10
3658  0072 e707          	ld	(7,x),a
3659                     ; 67 	rs485_dr1 = 1;
3661  0074 721c5000      	bset	_OPA6
3662                     ; 68 	ts1_ok = 1;
3664  0078 35010000      	mov	_ts1_ok,#1
3665                     ; 69 	UART1_DR = c_head;
3667  007c 353a5231      	mov	_UART1_DR,#58
3668                     ; 70 }
3671  0080 85            	popw	x
3672  0081 81            	ret
3704                     ; 76 void UART3_Init(void)
3704                     ; 77 {
3705                     	switch	.text
3706  0082               _UART3_Init:
3710                     ; 79 	PD_DDR |= BIT(5);
3712  0082 721a5011      	bset	_PD_DDR,#5
3713                     ; 80 	PD_CR1 |= BIT(5); 
3715  0086 721a5012      	bset	_PD_CR1,#5
3716                     ; 81 	PD_CR2 |= BIT(5);
3718  008a 721a5013      	bset	_PD_CR2,#5
3719                     ; 83 	PD_DDR &= ~BIT(6);
3721  008e 721d5011      	bres	_PD_DDR,#6
3722                     ; 84 	PD_CR1 |= BIT(6); 
3724  0092 721c5012      	bset	_PD_CR1,#6
3725                     ; 85 	PD_CR2 &= ~BIT(6);
3727  0096 721d5013      	bres	_PD_CR2,#6
3728                     ; 87 	PD_DDR |= BIT(7);
3730  009a 721e5011      	bset	_PD_DDR,#7
3731                     ; 88 	PD_CR1 |= BIT(7); 
3733  009e 721e5012      	bset	_PD_CR1,#7
3734                     ; 89 	PD_CR2 |= BIT(7);
3736  00a2 721e5013      	bset	_PD_CR2,#7
3737                     ; 90 	rs485_dr2 = 0;
3739  00a6 721f500f      	bres	_OPD7
3740                     ; 91 	UART3_CR1=0x00;
3742  00aa 725f5244      	clr	_UART3_CR1
3743                     ; 92 	UART3_CR2=0x00;
3745  00ae 725f5245      	clr	_UART3_CR2
3746                     ; 93 	UART3_CR3=0x00; 
3748  00b2 725f5246      	clr	_UART3_CR3
3749                     ; 94 	UART3_BRR2=0x02;
3751  00b6 35025243      	mov	_UART3_BRR2,#2
3752                     ; 95 	UART3_BRR1=0x68;
3754  00ba 35685242      	mov	_UART3_BRR1,#104
3755                     ; 96 	UART3_CR2=0x2c;//ÔÊÐí½ÓÊÕ£¬·¢ËÍ£¬¿ª½ÓÊÕÖÐ¶Ï
3757  00be 352c5245      	mov	_UART3_CR2,#44
3758                     ; 97 }
3761  00c2 81            	ret
3798                     ; 104 void UART3_Sendint(unsigned char ch)
3798                     ; 105 {
3799                     	switch	.text
3800  00c3               _UART3_Sendint:
3802  00c3 88            	push	a
3803       00000000      OFST:	set	0
3806  00c4               L5142:
3807                     ; 106   while((UART3_SR & 0x80) == 0x00);    // µÈ´ýÊý¾ÝµÄ´«ËÍ  
3809  00c4 c65240        	ld	a,_UART3_SR
3810  00c7 a580          	bcp	a,#128
3811  00c9 27f9          	jreq	L5142
3812                     ; 107   UART3_DR = ch;   
3814  00cb 7b01          	ld	a,(OFST+1,sp)
3815  00cd c75241        	ld	_UART3_DR,a
3816                     ; 108 	delayus(100);	
3818  00d0 ae0064        	ldw	x,#100
3819  00d3 cd0000        	call	_delayus
3821                     ; 109 }
3824  00d6 84            	pop	a
3825  00d7 81            	ret
3870                     ; 116 void UART_interrupt(u8 uart,u8 mode)
3870                     ; 117 {
3871                     	switch	.text
3872  00d8               _UART_interrupt:
3874  00d8 89            	pushw	x
3875       00000000      OFST:	set	0
3878                     ; 118 	if(uart == 0)
3880  00d9 9e            	ld	a,xh
3881  00da 4d            	tnz	a
3882  00db 2616          	jrne	L3442
3883                     ; 120 		if(mode == 0)
3885  00dd 9f            	ld	a,xl
3886  00de 4d            	tnz	a
3887  00df 2606          	jrne	L5442
3888                     ; 122 			UART1_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖÐ¶Ï*/
3890  00e1 72155235      	bres	_UART1_CR2,#2
3892  00e5 2026          	jra	L3542
3893  00e7               L5442:
3894                     ; 124 		else if(mode == 1)
3896  00e7 7b02          	ld	a,(OFST+2,sp)
3897  00e9 a101          	cp	a,#1
3898  00eb 2620          	jrne	L3542
3899                     ; 126 			UART1_CR2 |= BIT(2);/*Ê¹ÄÜ½ÓÊÕÖÐ¶Ï*/
3901  00ed 72145235      	bset	_UART1_CR2,#2
3902  00f1 201a          	jra	L3542
3903  00f3               L3442:
3904                     ; 129 	else if(uart == 1)
3906  00f3 7b01          	ld	a,(OFST+1,sp)
3907  00f5 a101          	cp	a,#1
3908  00f7 2614          	jrne	L3542
3909                     ; 131 		if(mode == 0)
3911  00f9 0d02          	tnz	(OFST+2,sp)
3912  00fb 2606          	jrne	L7542
3913                     ; 133 			UART3_CR2 &= ~BIT(2);/*¹Ø±Õ½ÓÊÕÖÐ¶Ï*/
3915  00fd 72155245      	bres	_UART3_CR2,#2
3917  0101 200a          	jra	L3542
3918  0103               L7542:
3919                     ; 135 		else if(mode == 1)
3921  0103 7b02          	ld	a,(OFST+2,sp)
3922  0105 a101          	cp	a,#1
3923  0107 2604          	jrne	L3542
3924                     ; 137 			UART3_CR2 |= BIT(2);/*Ê¹ÄÜ½ÓÊÕÖÐ¶Ï*/
3926  0109 72145245      	bset	_UART3_CR2,#2
3927  010d               L3542:
3928                     ; 140 }
3931  010d 85            	popw	x
3932  010e 81            	ret
3999                     ; 148 void UART3_Send(u8 *Array,u8 command,u8 situ)
3999                     ; 149 {
4000                     	switch	.text
4001  010f               _UART3_Send:
4003  010f 89            	pushw	x
4004  0110 88            	push	a
4005       00000001      OFST:	set	1
4008  0111               L1252:
4009                     ; 152 	while(ts3_ok == 1);
4011  0111 b600          	ld	a,_ts3_ok
4012  0113 a101          	cp	a,#1
4013  0115 27fa          	jreq	L1252
4014                     ; 153 	UART3_SR&= ~BIT(6);  //Çå³ýËÍÍê³É×´Ì¬Î»
4016  0117 721d5240      	bres	_UART3_SR,#6
4017                     ; 154 	UART3_CR2 |= BIT(6);//¿ª·¢ËÍÍê³ÉÖÐ¶
4019  011b 721c5245      	bset	_UART3_CR2,#6
4020                     ; 155 	Array[14] = c_last;
4022  011f 1e02          	ldw	x,(OFST+1,sp)
4023  0121 a60a          	ld	a,#10
4024  0123 e70e          	ld	(14,x),a
4025                     ; 156 	Array[0] = command;
4027  0125 7b06          	ld	a,(OFST+5,sp)
4028  0127 1e02          	ldw	x,(OFST+1,sp)
4029  0129 f7            	ld	(x),a
4030                     ; 157 	Array[12] = Array[0];
4032  012a 1e02          	ldw	x,(OFST+1,sp)
4033  012c f6            	ld	a,(x)
4034  012d e70c          	ld	(12,x),a
4035                     ; 158 	if( (command == CORRECT)||(command == ERROR) )
4037  012f 7b06          	ld	a,(OFST+5,sp)
4038  0131 a188          	cp	a,#136
4039  0133 2706          	jreq	L7252
4041  0135 7b06          	ld	a,(OFST+5,sp)
4042  0137 a144          	cp	a,#68
4043  0139 2632          	jrne	L5252
4044  013b               L7252:
4045                     ; 160 		Array[12] = Array[0];
4047  013b 1e02          	ldw	x,(OFST+1,sp)
4048  013d f6            	ld	a,(x)
4049  013e e70c          	ld	(12,x),a
4050                     ; 161 		Array[13] = 0;
4052  0140 1e02          	ldw	x,(OFST+1,sp)
4053  0142 6f0d          	clr	(13,x)
4054                     ; 162 		for(i = 1;i < 12;i++)
4056  0144 a601          	ld	a,#1
4057  0146 6b01          	ld	(OFST+0,sp),a
4059  0148 200e          	jra	L5352
4060  014a               L1352:
4061                     ; 164 			Array[i] = 0x00;
4063  014a 7b02          	ld	a,(OFST+1,sp)
4064  014c 97            	ld	xl,a
4065  014d 7b03          	ld	a,(OFST+2,sp)
4066  014f 1b01          	add	a,(OFST+0,sp)
4067  0151 2401          	jrnc	L22
4068  0153 5c            	incw	x
4069  0154               L22:
4070  0154 02            	rlwa	x,a
4071  0155 7f            	clr	(x)
4072                     ; 162 		for(i = 1;i < 12;i++)
4074  0156 0c01          	inc	(OFST+0,sp)
4075  0158               L5352:
4078  0158 7b01          	ld	a,(OFST+0,sp)
4079  015a a10c          	cp	a,#12
4080  015c 25ec          	jrult	L1352
4082  015e               L1452:
4083                     ; 185 	rs485_dr2 = 1;
4085  015e 721e500f      	bset	_OPD7
4086                     ; 186 	ts3_ok = 1;
4088  0162 35010000      	mov	_ts3_ok,#1
4089                     ; 187 	UART3_DR = c_head;
4091  0166 353a5241      	mov	_UART3_DR,#58
4092                     ; 188 }
4095  016a 5b03          	addw	sp,#3
4096  016c 81            	ret
4097  016d               L5252:
4098                     ; 170 		for(i = 1;i < 12;i++)
4100  016d a601          	ld	a,#1
4101  016f 6b01          	ld	(OFST+0,sp),a
4103  0171 2016          	jra	L7452
4104  0173               L3452:
4105                     ; 172 			Array[13] += Array[i];
4107  0173 7b02          	ld	a,(OFST+1,sp)
4108  0175 97            	ld	xl,a
4109  0176 7b03          	ld	a,(OFST+2,sp)
4110  0178 1b01          	add	a,(OFST+0,sp)
4111  017a 2401          	jrnc	L42
4112  017c 5c            	incw	x
4113  017d               L42:
4114  017d 02            	rlwa	x,a
4115  017e 1602          	ldw	y,(OFST+1,sp)
4116  0180 90e60d        	ld	a,(13,y)
4117  0183 fb            	add	a,(x)
4118  0184 90e70d        	ld	(13,y),a
4119                     ; 170 		for(i = 1;i < 12;i++)
4121  0187 0c01          	inc	(OFST+0,sp)
4122  0189               L7452:
4125  0189 7b01          	ld	a,(OFST+0,sp)
4126  018b a10c          	cp	a,#12
4127  018d 25e4          	jrult	L3452
4128                     ; 174 		if(situ == ok)
4130  018f 7b07          	ld	a,(OFST+6,sp)
4131  0191 a101          	cp	a,#1
4132  0193 260c          	jrne	L3552
4133                     ; 176 			Array[0] = TRUE;
4135  0195 1e02          	ldw	x,(OFST+1,sp)
4136  0197 a621          	ld	a,#33
4137  0199 f7            	ld	(x),a
4138                     ; 177 			Array[12] = Array[0];
4140  019a 1e02          	ldw	x,(OFST+1,sp)
4141  019c f6            	ld	a,(x)
4142  019d e70c          	ld	(12,x),a
4144  019f 20bd          	jra	L1452
4145  01a1               L3552:
4146                     ; 181 			Array[0] = FALSE;
4148  01a1 1e02          	ldw	x,(OFST+1,sp)
4149  01a3 a622          	ld	a,#34
4150  01a5 f7            	ld	(x),a
4151                     ; 182 			Array[12] = Array[0];
4153  01a6 1e02          	ldw	x,(OFST+1,sp)
4154  01a8 f6            	ld	a,(x)
4155  01a9 e70c          	ld	(12,x),a
4156  01ab 20b1          	jra	L1452
4260                     ; 200 void Drawer_cont(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
4260                     ; 201 									u8 *ts,u8 *rs,u8 mode,u8 *ts_flag)
4260                     ; 202 {
4261                     	switch	.text
4262  01ad               _Drawer_cont:
4264  01ad 89            	pushw	x
4265       00000000      OFST:	set	0
4268                     ; 203 	*rb_Flag = 1;
4270  01ae a601          	ld	a,#1
4271  01b0 f7            	ld	(x),a
4272                     ; 204 	*ts_flag = 0;
4274  01b1 1e0e          	ldw	x,(OFST+14,sp)
4275  01b3 7f            	clr	(x)
4276                     ; 205 	T2msFlg = 0;
4278  01b4 5f            	clrw	x
4279  01b5 bf00          	ldw	_T2msFlg,x
4280                     ; 206 	UART_interrupt(0,1);/*Ê¹ÄÜ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4282  01b7 ae0001        	ldw	x,#1
4283  01ba 4f            	clr	a
4284  01bb 95            	ld	xh,a
4285  01bc cd00d8        	call	_UART_interrupt
4287                     ; 207 	UART1_Send(R_ts,mode,rs[1]);
4289  01bf 1e0b          	ldw	x,(OFST+11,sp)
4290  01c1 e601          	ld	a,(1,x)
4291  01c3 88            	push	a
4292  01c4 7b0e          	ld	a,(OFST+14,sp)
4293  01c6 88            	push	a
4294  01c7 1e07          	ldw	x,(OFST+7,sp)
4295  01c9 cd0054        	call	_UART1_Send
4297  01cc 85            	popw	x
4299  01cd ac110311      	jpf	L7262
4300  01d1               L5262:
4301                     ; 210 		WDT();//Çå¿´ÃÅ¹·
4303  01d1 35aa50e0      	mov	_IWDG_KR,#170
4304                     ; 211 		if(*ts_flag == 1)/*µÈ´ý·µ»ØÃüÁî*/
4306  01d5 1e0e          	ldw	x,(OFST+14,sp)
4307  01d7 f6            	ld	a,(x)
4308  01d8 a101          	cp	a,#1
4309  01da 2703          	jreq	L03
4310  01dc cc02c7        	jp	L3362
4311  01df               L03:
4312                     ; 213 			if(R_rs[7] == 0x0a)
4314  01df 1e07          	ldw	x,(OFST+7,sp)
4315  01e1 e607          	ld	a,(7,x)
4316  01e3 a10a          	cp	a,#10
4317  01e5 2703          	jreq	L23
4318  01e7 cc0288        	jp	L5362
4319  01ea               L23:
4320                     ; 215 				if(R_rs[1] == 0x01)/*Õý³£*/
4322  01ea 1e07          	ldw	x,(OFST+7,sp)
4323  01ec e601          	ld	a,(1,x)
4324  01ee a101          	cp	a,#1
4325  01f0 2626          	jrne	L7362
4326                     ; 217 					R_rs[1] = 0x00;
4328  01f2 1e07          	ldw	x,(OFST+7,sp)
4329  01f4 6f01          	clr	(1,x)
4330                     ; 218 					*rb_Flag = 0;
4332  01f6 1e01          	ldw	x,(OFST+1,sp)
4333  01f8 7f            	clr	(x)
4334                     ; 219 					*ts_flag = 0;
4336  01f9 1e0e          	ldw	x,(OFST+14,sp)
4337  01fb 7f            	clr	(x)
4338                     ; 220 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4340  01fc 5f            	clrw	x
4341  01fd 4f            	clr	a
4342  01fe 95            	ld	xh,a
4343  01ff cd00d8        	call	_UART_interrupt
4345                     ; 221 					if(mirro == 0)
4347  0202 3d00          	tnz	_mirro
4348  0204 2703          	jreq	L43
4349  0206 cc02c7        	jp	L3362
4350  0209               L43:
4351                     ; 223 						UART3_Send(ts,mode,ok);
4353  0209 4b01          	push	#1
4354  020b 7b0e          	ld	a,(OFST+14,sp)
4355  020d 88            	push	a
4356  020e 1e0b          	ldw	x,(OFST+11,sp)
4357  0210 cd010f        	call	_UART3_Send
4359  0213 85            	popw	x
4360  0214 acc702c7      	jpf	L3362
4361  0218               L7362:
4362                     ; 226 				else if(R_rs[1] == 0x02)/*¹ýÁ÷*/
4364  0218 1e07          	ldw	x,(OFST+7,sp)
4365  021a e601          	ld	a,(1,x)
4366  021c a102          	cp	a,#2
4367  021e 2626          	jrne	L5462
4368                     ; 228 					R_rs[1] = 0x00;
4370  0220 1e07          	ldw	x,(OFST+7,sp)
4371  0222 6f01          	clr	(1,x)
4372                     ; 229 					*rb_Flag = 0;
4374  0224 1e01          	ldw	x,(OFST+1,sp)
4375  0226 7f            	clr	(x)
4376                     ; 230 					*ts_flag = 0;
4378  0227 1e0e          	ldw	x,(OFST+14,sp)
4379  0229 7f            	clr	(x)
4380                     ; 231 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4382  022a 5f            	clrw	x
4383  022b 4f            	clr	a
4384  022c 95            	ld	xh,a
4385  022d cd00d8        	call	_UART_interrupt
4387                     ; 232 					if(mirro == 0)
4389  0230 3d00          	tnz	_mirro
4390  0232 2703          	jreq	L63
4391  0234 cc02c7        	jp	L3362
4392  0237               L63:
4393                     ; 234 						UART3_Send(ts,mode,no);
4395  0237 4b00          	push	#0
4396  0239 7b0e          	ld	a,(OFST+14,sp)
4397  023b 88            	push	a
4398  023c 1e0b          	ldw	x,(OFST+11,sp)
4399  023e cd010f        	call	_UART3_Send
4401  0241 85            	popw	x
4402  0242 acc702c7      	jpf	L3362
4403  0246               L5462:
4404                     ; 237 				else if(R_rs[1] == 0x03)/*±£ÏÕË¿*/
4406  0246 1e07          	ldw	x,(OFST+7,sp)
4407  0248 e601          	ld	a,(1,x)
4408  024a a103          	cp	a,#3
4409  024c 261d          	jrne	L3562
4410                     ; 239 					*rb_Flag = 0;
4412  024e 1e01          	ldw	x,(OFST+1,sp)
4413  0250 7f            	clr	(x)
4414                     ; 240 					*ts_flag = 0;
4416  0251 1e0e          	ldw	x,(OFST+14,sp)
4417  0253 7f            	clr	(x)
4418                     ; 241 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4420  0254 5f            	clrw	x
4421  0255 4f            	clr	a
4422  0256 95            	ld	xh,a
4423  0257 cd00d8        	call	_UART_interrupt
4425                     ; 242 					if(mirro == 0)
4427  025a 3d00          	tnz	_mirro
4428  025c 2669          	jrne	L3362
4429                     ; 244 						UART3_Send(ts,mode,no);
4431  025e 4b00          	push	#0
4432  0260 7b0e          	ld	a,(OFST+14,sp)
4433  0262 88            	push	a
4434  0263 1e0b          	ldw	x,(OFST+11,sp)
4435  0265 cd010f        	call	_UART3_Send
4437  0268 85            	popw	x
4438  0269 205c          	jra	L3362
4439  026b               L3562:
4440                     ; 249 					*rb_Flag = 0;
4442  026b 1e01          	ldw	x,(OFST+1,sp)
4443  026d 7f            	clr	(x)
4444                     ; 250 					*ts_flag = 0;
4446  026e 1e0e          	ldw	x,(OFST+14,sp)
4447  0270 7f            	clr	(x)
4448                     ; 251 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4450  0271 5f            	clrw	x
4451  0272 4f            	clr	a
4452  0273 95            	ld	xh,a
4453  0274 cd00d8        	call	_UART_interrupt
4455                     ; 252 					if(mirro == 0)
4457  0277 3d00          	tnz	_mirro
4458  0279 264c          	jrne	L3362
4459                     ; 254 						UART3_Send(ts,mode,no);
4461  027b 4b00          	push	#0
4462  027d 7b0e          	ld	a,(OFST+14,sp)
4463  027f 88            	push	a
4464  0280 1e0b          	ldw	x,(OFST+11,sp)
4465  0282 cd010f        	call	_UART3_Send
4467  0285 85            	popw	x
4468  0286 203f          	jra	L3362
4469  0288               L5362:
4470                     ; 260 				WDT();//Çå¿´ÃÅ¹·
4472  0288 35aa50e0      	mov	_IWDG_KR,#170
4473                     ; 261 				*ts_flag = 0;/*½ÓÊÕÃüÁîÍê³É£¬¿ÉÒÔÔÙ´Î½ÓÊÕ*/
4475  028c 1e0e          	ldw	x,(OFST+14,sp)
4476  028e 7f            	clr	(x)
4477                     ; 262 				if(T2msFlg > 2000)
4479  028f be00          	ldw	x,_T2msFlg
4480  0291 a307d1        	cpw	x,#2001
4481  0294 2531          	jrult	L3362
4482                     ; 264 					T2msFlg = 0;
4484  0296 5f            	clrw	x
4485  0297 bf00          	ldw	_T2msFlg,x
4486                     ; 265 					if(*rb_Flag == 1)
4488  0299 1e01          	ldw	x,(OFST+1,sp)
4489  029b f6            	ld	a,(x)
4490  029c a101          	cp	a,#1
4491  029e 2615          	jrne	L7662
4492                     ; 267 						*rb_Flag = 2;
4494  02a0 1e01          	ldw	x,(OFST+1,sp)
4495  02a2 a602          	ld	a,#2
4496  02a4 f7            	ld	(x),a
4497                     ; 268 						UART1_Send(R_ts,mode,rs[1]);
4499  02a5 1e0b          	ldw	x,(OFST+11,sp)
4500  02a7 e601          	ld	a,(1,x)
4501  02a9 88            	push	a
4502  02aa 7b0e          	ld	a,(OFST+14,sp)
4503  02ac 88            	push	a
4504  02ad 1e07          	ldw	x,(OFST+7,sp)
4505  02af cd0054        	call	_UART1_Send
4507  02b2 85            	popw	x
4509  02b3 2012          	jra	L3362
4510  02b5               L7662:
4511                     ; 272 						*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
4513  02b5 1e01          	ldw	x,(OFST+1,sp)
4514  02b7 7f            	clr	(x)
4515                     ; 273 						if(mirro == 0)
4517  02b8 3d00          	tnz	_mirro
4518  02ba 260b          	jrne	L3362
4519                     ; 275 							UART3_Send(ts,mode,no);
4521  02bc 4b00          	push	#0
4522  02be 7b0e          	ld	a,(OFST+14,sp)
4523  02c0 88            	push	a
4524  02c1 1e0b          	ldw	x,(OFST+11,sp)
4525  02c3 cd010f        	call	_UART3_Send
4527  02c6 85            	popw	x
4528  02c7               L3362:
4529                     ; 281 		if(T2msFlg > 2000)
4531  02c7 be00          	ldw	x,_T2msFlg
4532  02c9 a307d1        	cpw	x,#2001
4533  02cc 252d          	jrult	L5762
4534                     ; 283 			T2msFlg = 0;
4536  02ce 5f            	clrw	x
4537  02cf bf00          	ldw	_T2msFlg,x
4538                     ; 284 			if(*rb_Flag == 1)
4540  02d1 1e01          	ldw	x,(OFST+1,sp)
4541  02d3 f6            	ld	a,(x)
4542  02d4 a101          	cp	a,#1
4543  02d6 2615          	jrne	L7762
4544                     ; 286 				*rb_Flag = 2;
4546  02d8 1e01          	ldw	x,(OFST+1,sp)
4547  02da a602          	ld	a,#2
4548  02dc f7            	ld	(x),a
4549                     ; 287 				UART1_Send(R_ts,mode,rs[1]);
4551  02dd 1e0b          	ldw	x,(OFST+11,sp)
4552  02df e601          	ld	a,(1,x)
4553  02e1 88            	push	a
4554  02e2 7b0e          	ld	a,(OFST+14,sp)
4555  02e4 88            	push	a
4556  02e5 1e07          	ldw	x,(OFST+7,sp)
4557  02e7 cd0054        	call	_UART1_Send
4559  02ea 85            	popw	x
4561  02eb 200e          	jra	L5762
4562  02ed               L7762:
4563                     ; 291 				*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
4565  02ed 1e01          	ldw	x,(OFST+1,sp)
4566  02ef 7f            	clr	(x)
4567                     ; 292 				UART3_Send(ts,mode,no);
4569  02f0 4b00          	push	#0
4570  02f2 7b0e          	ld	a,(OFST+14,sp)
4571  02f4 88            	push	a
4572  02f5 1e0b          	ldw	x,(OFST+11,sp)
4573  02f7 cd010f        	call	_UART3_Send
4575  02fa 85            	popw	x
4576  02fb               L5762:
4577                     ; 295 		if(mode == Drawer_back)
4579  02fb 7b0d          	ld	a,(OFST+13,sp)
4580  02fd a116          	cp	a,#22
4581  02ff 2610          	jrne	L7262
4582                     ; 297 			Found_Receipt(RsBuffer,&wr_new,&fr_Flag);/*¼ì²â»Øµ¥*/
4584  0301 ae0000        	ldw	x,#_fr_Flag
4585  0304 89            	pushw	x
4586  0305 ae0000        	ldw	x,#_wr_new
4587  0308 89            	pushw	x
4588  0309 ae0000        	ldw	x,#_RsBuffer
4589  030c cd0000        	call	_Found_Receipt
4591  030f 5b04          	addw	sp,#4
4592  0311               L7262:
4593                     ; 208 	while(*rb_Flag > 0)
4595  0311 1e01          	ldw	x,(OFST+1,sp)
4596  0313 7d            	tnz	(x)
4597  0314 2703          	jreq	L04
4598  0316 cc01d1        	jp	L5262
4599  0319               L04:
4600                     ; 300 }
4603  0319 85            	popw	x
4604  031a 81            	ret
4607                     	bsct
4608  0000               _cheak_wait:
4609  0000 14            	dc.b	20
4696                     ; 305 void rawer_back_judge(u8 *rb_Flag,u8 *R_ts,u8 *R_rs,
4696                     ; 306 									u8 i,u8 *ts_flag,u8 *place_flag)
4696                     ; 307 {
4697                     	switch	.text
4698  031b               _rawer_back_judge:
4700  031b 89            	pushw	x
4701       00000000      OFST:	set	0
4704                     ; 308 	*rb_Flag = 1;
4706  031c a601          	ld	a,#1
4707  031e f7            	ld	(x),a
4708                     ; 309 	*ts_flag = 0;
4710  031f 1e0a          	ldw	x,(OFST+10,sp)
4711  0321 7f            	clr	(x)
4712                     ; 310 	T2msFlg = 0;
4714  0322 5f            	clrw	x
4715  0323 bf00          	ldw	_T2msFlg,x
4716                     ; 311 	UART_interrupt(0,1);/*Ê¹ÄÜ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4718  0325 ae0001        	ldw	x,#1
4719  0328 4f            	clr	a
4720  0329 95            	ld	xh,a
4721  032a cd00d8        	call	_UART_interrupt
4723                     ; 312 	UART1_Send(R_ts,Drawer_back_place,i);
4725  032d 7b09          	ld	a,(OFST+9,sp)
4726  032f 88            	push	a
4727  0330 4b17          	push	#23
4728  0332 1e07          	ldw	x,(OFST+7,sp)
4729  0334 cd0054        	call	_UART1_Send
4731  0337 85            	popw	x
4733  0338 ace603e6      	jpf	L1572
4734  033c               L7472:
4735                     ; 315 		WDT();//Çå¿´ÃÅ¹·
4737  033c 35aa50e0      	mov	_IWDG_KR,#170
4738                     ; 316 		if(*ts_flag == 1)/*µÈ´ý·µ»ØÃüÁî*/
4740  0340 1e0a          	ldw	x,(OFST+10,sp)
4741  0342 f6            	ld	a,(x)
4742  0343 a101          	cp	a,#1
4743  0345 266f          	jrne	L5572
4744                     ; 318 			if(R_rs[7] == 0x0a)
4746  0347 1e07          	ldw	x,(OFST+7,sp)
4747  0349 e607          	ld	a,(7,x)
4748  034b a10a          	cp	a,#10
4749  034d 2630          	jrne	L7572
4750                     ; 320 				if(R_rs[1] == 0x01)/*Õý³£*/
4752  034f 1e07          	ldw	x,(OFST+7,sp)
4753  0351 e601          	ld	a,(1,x)
4754  0353 a101          	cp	a,#1
4755  0355 2615          	jrne	L1672
4756                     ; 322 					R_rs[1] = 0x00;
4758  0357 1e07          	ldw	x,(OFST+7,sp)
4759  0359 6f01          	clr	(1,x)
4760                     ; 323 					*rb_Flag = 0;
4762  035b 1e01          	ldw	x,(OFST+1,sp)
4763  035d 7f            	clr	(x)
4764                     ; 324 					*ts_flag = 0;
4766  035e 1e0a          	ldw	x,(OFST+10,sp)
4767  0360 7f            	clr	(x)
4768                     ; 325 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4770  0361 5f            	clrw	x
4771  0362 4f            	clr	a
4772  0363 95            	ld	xh,a
4773  0364 cd00d8        	call	_UART_interrupt
4775                     ; 326 					*place_flag = 0;
4777  0367 1e0c          	ldw	x,(OFST+12,sp)
4778  0369 7f            	clr	(x)
4780  036a 204a          	jra	L5572
4781  036c               L1672:
4782                     ; 330 					*rb_Flag = 0;
4784  036c 1e01          	ldw	x,(OFST+1,sp)
4785  036e 7f            	clr	(x)
4786                     ; 331 					*ts_flag = 0;
4788  036f 1e0a          	ldw	x,(OFST+10,sp)
4789  0371 7f            	clr	(x)
4790                     ; 332 					UART_interrupt(0,0);/*¹Ø±Õ´®¿Ú1½ÓÊÕÖÐ¶Ï*/
4792  0372 5f            	clrw	x
4793  0373 4f            	clr	a
4794  0374 95            	ld	xh,a
4795  0375 cd00d8        	call	_UART_interrupt
4797                     ; 333 					*place_flag = 1;
4799  0378 1e0c          	ldw	x,(OFST+12,sp)
4800  037a a601          	ld	a,#1
4801  037c f7            	ld	(x),a
4802  037d 2037          	jra	L5572
4803  037f               L7572:
4804                     ; 338 				WDT();//Çå¿´ÃÅ¹·
4806  037f 35aa50e0      	mov	_IWDG_KR,#170
4807                     ; 339 				*ts_flag = 0;/*½ÓÊÕÃüÁîÍê³É£¬¿ÉÒÔÔÙ´Î½ÓÊÕ*/
4809  0383 1e0a          	ldw	x,(OFST+10,sp)
4810  0385 7f            	clr	(x)
4811                     ; 340 				if(T2msFlg > cheak_wait)//200
4813  0386 b600          	ld	a,_cheak_wait
4814  0388 5f            	clrw	x
4815  0389 97            	ld	xl,a
4816  038a bf00          	ldw	c_x,x
4817  038c be00          	ldw	x,_T2msFlg
4818  038e b300          	cpw	x,c_x
4819  0390 2324          	jrule	L5572
4820                     ; 342 					T2msFlg = 0;
4822  0392 5f            	clrw	x
4823  0393 bf00          	ldw	_T2msFlg,x
4824                     ; 343 					if(*rb_Flag == 1)
4826  0395 1e01          	ldw	x,(OFST+1,sp)
4827  0397 f6            	ld	a,(x)
4828  0398 a101          	cp	a,#1
4829  039a 2612          	jrne	L1772
4830                     ; 345 						*rb_Flag = 2;
4832  039c 1e01          	ldw	x,(OFST+1,sp)
4833  039e a602          	ld	a,#2
4834  03a0 f7            	ld	(x),a
4835                     ; 346 						UART1_Send(R_ts,Drawer_back_place,i);
4837  03a1 7b09          	ld	a,(OFST+9,sp)
4838  03a3 88            	push	a
4839  03a4 4b17          	push	#23
4840  03a6 1e07          	ldw	x,(OFST+7,sp)
4841  03a8 cd0054        	call	_UART1_Send
4843  03ab 85            	popw	x
4845  03ac 2008          	jra	L5572
4846  03ae               L1772:
4847                     ; 350 						*rb_Flag = 0;
4849  03ae 1e01          	ldw	x,(OFST+1,sp)
4850  03b0 7f            	clr	(x)
4851                     ; 351 						*place_flag = 1;
4853  03b1 1e0c          	ldw	x,(OFST+12,sp)
4854  03b3 a601          	ld	a,#1
4855  03b5 f7            	ld	(x),a
4856  03b6               L5572:
4857                     ; 356 		if(T2msFlg > cheak_wait)//200
4859  03b6 b600          	ld	a,_cheak_wait
4860  03b8 5f            	clrw	x
4861  03b9 97            	ld	xl,a
4862  03ba bf00          	ldw	c_x,x
4863  03bc be00          	ldw	x,_T2msFlg
4864  03be b300          	cpw	x,c_x
4865  03c0 2324          	jrule	L1572
4866                     ; 358 			T2msFlg = 0;
4868  03c2 5f            	clrw	x
4869  03c3 bf00          	ldw	_T2msFlg,x
4870                     ; 359 			if(*rb_Flag == 1)
4872  03c5 1e01          	ldw	x,(OFST+1,sp)
4873  03c7 f6            	ld	a,(x)
4874  03c8 a101          	cp	a,#1
4875  03ca 2612          	jrne	L7772
4876                     ; 361 				*rb_Flag = 2;
4878  03cc 1e01          	ldw	x,(OFST+1,sp)
4879  03ce a602          	ld	a,#2
4880  03d0 f7            	ld	(x),a
4881                     ; 362 				UART1_Send(R_ts,Drawer_back_place,i);
4883  03d1 7b09          	ld	a,(OFST+9,sp)
4884  03d3 88            	push	a
4885  03d4 4b17          	push	#23
4886  03d6 1e07          	ldw	x,(OFST+7,sp)
4887  03d8 cd0054        	call	_UART1_Send
4889  03db 85            	popw	x
4891  03dc 2008          	jra	L1572
4892  03de               L7772:
4893                     ; 366 				*rb_Flag = 0;/*·¢ËÍ²»³É¹¦£¬ÍË³ö*/
4895  03de 1e01          	ldw	x,(OFST+1,sp)
4896  03e0 7f            	clr	(x)
4897                     ; 367 				*place_flag = 1;
4899  03e1 1e0c          	ldw	x,(OFST+12,sp)
4900  03e3 a601          	ld	a,#1
4901  03e5 f7            	ld	(x),a
4902  03e6               L1572:
4903                     ; 313 	while(*rb_Flag > 0)
4905  03e6 1e01          	ldw	x,(OFST+1,sp)
4906  03e8 7d            	tnz	(x)
4907  03e9 2703          	jreq	L44
4908  03eb cc033c        	jp	L7472
4909  03ee               L44:
4910                     ; 371 }
4913  03ee 85            	popw	x
4914  03ef 81            	ret
4938                     	xdef	_cheak_wait
4939                     	xref.b	_mirro
4940                     	xref.b	_RsBuffer
4941                     	xref.b	_fr_Flag
4942                     	xref.b	_wr_new
4943                     	xref.b	_T2msFlg
4944                     	xref.b	_ts3_ok
4945                     	xref.b	_ts1_ok
4946                     	xdef	_rawer_back_judge
4947                     	xdef	_UART_interrupt
4948                     	xdef	_UART1_Send
4949                     	xdef	_UART1_Sendint
4950                     	xdef	_UART3_Send
4951                     	xdef	_UART3_Sendint
4952                     	xdef	_UART3_Init
4953                     	xdef	_UART1_Init
4954                     	xdef	_Drawer_cont
4955                     	xref	_Found_Receipt
4956                     	xref	_delayus
4957                     	xref.b	c_x
4976                     	end
