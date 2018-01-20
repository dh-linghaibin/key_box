   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3566                     ; 15 void UART1_Init(void)
3566                     ; 16 {
3568                     	switch	.text
3569  0000               _UART1_Init:
3573                     ; 18 	PD_DDR |= BIT(5);
3575  0000 721a5011      	bset	_PD_DDR,#5
3576                     ; 19 	PD_CR1 |= BIT(5); 
3578  0004 721a5012      	bset	_PD_CR1,#5
3579                     ; 20 	PD_CR2 |= BIT(5);
3581  0008 721a5013      	bset	_PD_CR2,#5
3582                     ; 22 	PD_DDR &= ~BIT(6);
3584  000c 721d5011      	bres	_PD_DDR,#6
3585                     ; 23 	PD_CR1 |= BIT(6); 
3587  0010 721c5012      	bset	_PD_CR1,#6
3588                     ; 24 	PD_CR2 &= ~BIT(6);
3590  0014 721d5013      	bres	_PD_CR2,#6
3591                     ; 26 	PD_DDR |= BIT(7);
3593  0018 721e5011      	bset	_PD_DDR,#7
3594                     ; 27 	PD_CR1 |= BIT(7);
3596  001c 721e5012      	bset	_PD_CR1,#7
3597                     ; 28 	PD_CR2 |= BIT(7);
3599  0020 721e5013      	bset	_PD_CR2,#7
3600                     ; 29 	rs485_dr1 = 0;
3602  0024 721f500f      	bres	_OPD7
3603                     ; 30 	UART1_CR1=0x00;
3605  0028 725f5234      	clr	_UART1_CR1
3606                     ; 31 	UART1_CR2=0x00;
3608  002c 725f5235      	clr	_UART1_CR2
3609                     ; 32 	UART1_CR3=0x00; 
3611  0030 725f5236      	clr	_UART1_CR3
3612                     ; 33 	UART1_BRR2=0x02;
3614  0034 35025233      	mov	_UART1_BRR2,#2
3615                     ; 34 	UART1_BRR1=0x68;
3617  0038 35685232      	mov	_UART1_BRR1,#104
3618                     ; 35 	UART1_CR2=0x2c;//允许接收，发送，开接收中断
3620  003c 352c5235      	mov	_UART1_CR2,#44
3621                     ; 36 }
3624  0040 81            	ret
3660                     ; 43 void UART1_Sendint(u8 ch)
3660                     ; 44 {
3661                     	switch	.text
3662  0041               _UART1_Sendint:
3664  0041 88            	push	a
3665       00000000      OFST:	set	0
3668  0042               L1042:
3669                     ; 45   while((UART1_SR & 0x80) == 0x00);    // 等待数据的传送  
3671  0042 c65230        	ld	a,_UART1_SR
3672  0045 a580          	bcp	a,#128
3673  0047 27f9          	jreq	L1042
3674                     ; 46   UART1_DR = ch;                     
3676  0049 7b01          	ld	a,(OFST+1,sp)
3677  004b c75231        	ld	_UART1_DR,a
3678                     ; 47 }
3681  004e 84            	pop	a
3682  004f 81            	ret
3740                     ; 55 void UART1_Send(u8 *Array,u8 command,u8 situ)
3740                     ; 56 {
3741                     	switch	.text
3742  0050               _UART1_Send:
3744  0050 89            	pushw	x
3745       00000000      OFST:	set	0
3748  0051               L5342:
3749                     ; 59 	while(fs_ok == 1);
3751  0051 b600          	ld	a,_fs_ok
3752  0053 a101          	cp	a,#1
3753  0055 27fa          	jreq	L5342
3754                     ; 60 	UART1_SR&= ~BIT(6);  
3756  0057 721d5230      	bres	_UART1_SR,#6
3757                     ; 61 	UART1_CR2 |= BIT(6);
3759  005b 721c5235      	bset	_UART1_CR2,#6
3760                     ; 62 	Array[0] = situ;
3762  005f 7b06          	ld	a,(OFST+6,sp)
3763  0061 1e01          	ldw	x,(OFST+1,sp)
3764  0063 f7            	ld	(x),a
3765                     ; 63 	Array[1] = command;
3767  0064 7b05          	ld	a,(OFST+5,sp)
3768  0066 1e01          	ldw	x,(OFST+1,sp)
3769  0068 e701          	ld	(1,x),a
3770                     ; 64 	Array[7] = c_last;
3772  006a 1e01          	ldw	x,(OFST+1,sp)
3773  006c a60a          	ld	a,#10
3774  006e e707          	ld	(7,x),a
3775                     ; 65 	rs485_dr1 = 1;
3777  0070 721e500f      	bset	_OPD7
3778                     ; 66 	fs_ok = 1;
3780  0074 35010000      	mov	_fs_ok,#1
3781                     ; 67 	UART1_DR = c_head;
3783  0078 353a5231      	mov	_UART1_DR,#58
3784                     ; 68 }
3787  007c 85            	popw	x
3788  007d 81            	ret
3801                     	xdef	_UART1_Send
3802                     	xref.b	_fs_ok
3803                     	xdef	_UART1_Sendint
3804                     	xdef	_UART1_Init
3823                     	end
