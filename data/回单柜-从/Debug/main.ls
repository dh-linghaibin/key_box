   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3518                     .bit:	section	.data,bit
3519  0000               _c_ok_Flag:
3520  0000 00            	dc.b	0
3521                     	bsct
3522  0000               _com_i:
3523  0000 00            	dc.b	0
3524  0001               _addre:
3525  0001 0001          	dc.w	1
3526  0003               _com_Flag:
3527  0003 00            	dc.b	0
3528  0004               _r_Flag:
3529  0004 00            	dc.b	0
3530  0005               _r_num:
3531  0005 00            	dc.b	0
3532  0006               _T1msFlg:
3533  0006 0000          	dc.w	0
3534  0008               _T2msFlg:
3535  0008 0000          	dc.w	0
3536  000a               _run_Falg:
3537  000a 00            	dc.b	0
3538  000b               _Duty_Val:
3539  000b 0000          	dc.w	0
3540  000d               _TS_count:
3541  000d 00            	dc.b	0
3607                     ; 44 main()
3607                     ; 45 {
3609                     	switch	.text
3610  0000               _main:
3614                     ; 46 	BSP_Init();/*板层初始化*/
3616  0000 cd0000        	call	_BSP_Init
3618                     ; 47 	Eeprom_Init();/*解锁EEPROM*/
3620  0003 cd0000        	call	_Eeprom_Init
3622                     ; 48 	UART1_Init();/*初始化USART1*/
3624  0006 cd0000        	call	_UART1_Init
3626                     ; 49 	Addr_Read(&addre);/*读取地址*/
3628  0009 ae0001        	ldw	x,#_addre
3629  000c cd0000        	call	_Addr_Read
3631                     ; 50 	_asm("rim");//开中断，sim为关中断
3634  000f 9a            rim
3636  0010               L1042:
3637                     ; 56 		if(run_Falg == 0)
3639  0010 3d0a          	tnz	_run_Falg
3640  0012 2623          	jrne	L5042
3641                     ; 58 			if(Duty_Val < 499)
3643  0014 be0b          	ldw	x,_Duty_Val
3644  0016 a301f3        	cpw	x,#499
3645  0019 2413          	jruge	L7042
3646                     ; 60 				if(T1msFlg >= 2)
3648  001b be06          	ldw	x,_T1msFlg
3649  001d a30002        	cpw	x,#2
3650  0020 255d          	jrult	L5142
3651                     ; 62 					T1msFlg = 0;
3653  0022 5f            	clrw	x
3654  0023 bf06          	ldw	_T1msFlg,x
3655                     ; 63 					Duty_Val++;
3657  0025 be0b          	ldw	x,_Duty_Val
3658  0027 1c0001        	addw	x,#1
3659  002a bf0b          	ldw	_Duty_Val,x
3660  002c 2051          	jra	L5142
3661  002e               L7042:
3662                     ; 70 				run_Falg = 1;
3664  002e 3501000a      	mov	_run_Falg,#1
3665                     ; 71 				T1msFlg = 0;
3667  0032 5f            	clrw	x
3668  0033 bf06          	ldw	_T1msFlg,x
3669  0035 2048          	jra	L5142
3670  0037               L5042:
3671                     ; 74 		else if(run_Falg == 1)
3673  0037 b60a          	ld	a,_run_Falg
3674  0039 a101          	cp	a,#1
3675  003b 260d          	jrne	L7142
3676                     ; 76 			if(T1msFlg >= 100)
3678  003d be06          	ldw	x,_T1msFlg
3679  003f a30064        	cpw	x,#100
3680  0042 253b          	jrult	L5142
3681                     ; 78 				run_Falg = 2;
3683  0044 3502000a      	mov	_run_Falg,#2
3684  0048 2035          	jra	L5142
3685  004a               L7142:
3686                     ; 81 		else if(run_Falg == 2)
3688  004a b60a          	ld	a,_run_Falg
3689  004c a102          	cp	a,#2
3690  004e 2620          	jrne	L5242
3691                     ; 83 			if(Duty_Val > 0)
3693  0050 be0b          	ldw	x,_Duty_Val
3694  0052 2713          	jreq	L7242
3695                     ; 85 				if(T1msFlg >= 2)
3697  0054 be06          	ldw	x,_T1msFlg
3698  0056 a30002        	cpw	x,#2
3699  0059 2524          	jrult	L5142
3700                     ; 87 					T1msFlg = 0;
3702  005b 5f            	clrw	x
3703  005c bf06          	ldw	_T1msFlg,x
3704                     ; 88 					Duty_Val--;
3706  005e be0b          	ldw	x,_Duty_Val
3707  0060 1d0001        	subw	x,#1
3708  0063 bf0b          	ldw	_Duty_Val,x
3709  0065 2018          	jra	L5142
3710  0067               L7242:
3711                     ; 95 				run_Falg = 3;
3713  0067 3503000a      	mov	_run_Falg,#3
3714                     ; 96 				T1msFlg = 0;
3716  006b 5f            	clrw	x
3717  006c bf06          	ldw	_T1msFlg,x
3718  006e 200f          	jra	L5142
3719  0070               L5242:
3720                     ; 99 		else if(run_Falg == 3)
3722  0070 b60a          	ld	a,_run_Falg
3723  0072 a103          	cp	a,#3
3724  0074 2609          	jrne	L5142
3725                     ; 101 			if(T1msFlg >= 400)
3727  0076 be06          	ldw	x,_T1msFlg
3728  0078 a30190        	cpw	x,#400
3729  007b 2502          	jrult	L5142
3730                     ; 103 				run_Falg = 0;
3732  007d 3f0a          	clr	_run_Falg
3733  007f               L5142:
3734                     ; 107 		if(c_ok_Flag == 1)
3736                     	btst	_c_ok_Flag
3737  0084 2503          	jrult	L6
3738  0086 cc0245        	jp	L3442
3739  0089               L6:
3740                     ; 109 			r_Flag = 0;
3742  0089 3f04          	clr	_r_Flag
3743                     ; 110 			if(R_RsBuffer[6] == c_last)
3745  008b b60f          	ld	a,_R_RsBuffer+6
3746  008d a10a          	cp	a,#10
3747  008f 2703          	jreq	L01
3748  0091 cc0235        	jp	L5442
3749  0094               L01:
3750                     ; 114 				R_TsBuffer[1] = 0x00;
3752  0094 3f01          	clr	_R_TsBuffer+1
3753                     ; 115 				R_TsBuffer[2] = 0x00;
3755  0096 3f02          	clr	_R_TsBuffer+2
3756                     ; 116 				R_TsBuffer[3] = 0x00;
3758  0098 3f03          	clr	_R_TsBuffer+3
3759                     ; 117 				R_TsBuffer[4] = 0x00;
3761  009a 3f04          	clr	_R_TsBuffer+4
3762                     ; 118 				R_TsBuffer[5] = 0x00;
3764  009c 3f05          	clr	_R_TsBuffer+5
3765                     ; 119 				switch(R_RsBuffer[0])
3767  009e b609          	ld	a,_R_RsBuffer
3769                     ; 206 					break;
3770  00a0 a014          	sub	a,#20
3771  00a2 2735          	jreq	L3432
3772  00a4 4a            	dec	a
3773  00a5 2603cc0131    	jreq	L5432
3774  00aa 4a            	dec	a
3775  00ab 2603          	jrne	L21
3776  00ad cc0158        	jp	L7432
3777  00b0               L21:
3778  00b0 4a            	dec	a
3779  00b1 2603          	jrne	L41
3780  00b3 cc01a8        	jp	L1532
3781  00b6               L41:
3782  00b6 a02f          	sub	a,#47
3783  00b8 2603          	jrne	L61
3784  00ba cc01cc        	jp	L3532
3785  00bd               L61:
3786  00bd 4a            	dec	a
3787  00be 2603          	jrne	L02
3788  00c0 cc01fd        	jp	L5532
3789  00c3               L02:
3790  00c3 4a            	dec	a
3791  00c4 2603          	jrne	L22
3792  00c6 cc0222        	jp	L7532
3793  00c9               L22:
3794  00c9               L1632:
3795                     ; 204 					default:
3795                     ; 205 					UART1_Send(R_TsBuffer,ERROR,addre);
3797  00c9 3b0002        	push	_addre+1
3798  00cc 4b44          	push	#68
3799  00ce ae0000        	ldw	x,#_R_TsBuffer
3800  00d1 cd0000        	call	_UART1_Send
3802  00d4 85            	popw	x
3803                     ; 206 					break;
3805  00d5 ac410241      	jpf	L3152
3806  00d9               L3432:
3807                     ; 121 					case Drawer_out:/*机械手出去*/
3807                     ; 122 						r_num = robot_mode(1);
3809  00d9 a601          	ld	a,#1
3810  00db cd0000        	call	_robot_mode
3812  00de b705          	ld	_r_num,a
3813                     ; 123 						if(r_num == 0)
3815  00e0 3d05          	tnz	_r_num
3816  00e2 261a          	jrne	L3542
3817                     ; 125 							UART1_Send(R_TsBuffer,0x01,addre);
3819  00e4 3b0002        	push	_addre+1
3820  00e7 4b01          	push	#1
3821  00e9 ae0000        	ldw	x,#_R_TsBuffer
3822  00ec cd0000        	call	_UART1_Send
3824  00ef 85            	popw	x
3825                     ; 126 							r_Flag = 1;/*机械手成功出去，这样可以手推回来*/
3827  00f0 35010004      	mov	_r_Flag,#1
3828                     ; 127 							TS_count = 0;
3830  00f4 3f0d          	clr	_TS_count
3831                     ; 128 							delayms(20);
3833  00f6 ae0014        	ldw	x,#20
3834  00f9 cd0000        	call	_delayms
3837  00fc 202a          	jra	L5542
3838  00fe               L3542:
3839                     ; 130 						else if(r_num == 1)
3841  00fe b605          	ld	a,_r_num
3842  0100 a101          	cp	a,#1
3843  0102 2612          	jrne	L7542
3844                     ; 132 							UART1_Send(R_TsBuffer,0x02,addre);
3846  0104 3b0002        	push	_addre+1
3847  0107 4b02          	push	#2
3848  0109 ae0000        	ldw	x,#_R_TsBuffer
3849  010c cd0000        	call	_UART1_Send
3851  010f 85            	popw	x
3852                     ; 133 							robot_mode(0);
3854  0110 4f            	clr	a
3855  0111 cd0000        	call	_robot_mode
3858  0114 2012          	jra	L5542
3859  0116               L7542:
3860                     ; 135 						else if(r_num == 2)
3862  0116 b605          	ld	a,_r_num
3863  0118 a102          	cp	a,#2
3864  011a 260c          	jrne	L5542
3865                     ; 137 							UART1_Send(R_TsBuffer,0x03,addre);
3867  011c 3b0002        	push	_addre+1
3868  011f 4b03          	push	#3
3869  0121 ae0000        	ldw	x,#_R_TsBuffer
3870  0124 cd0000        	call	_UART1_Send
3872  0127 85            	popw	x
3873  0128               L5542:
3874                     ; 140 						eeprom_count(2);
3876  0128 a602          	ld	a,#2
3877  012a cd0000        	call	_eeprom_count
3879                     ; 141 					break;
3881  012d ac410241      	jpf	L3152
3882  0131               L5432:
3883                     ; 142 					case Drawer_out_place:/*机械手出去是否到位*/
3883                     ; 143 						if(out_seat == 1)
3885                     	btst	_IPC5
3886  0136 2410          	jruge	L5642
3887                     ; 145 							UART1_Send(R_TsBuffer,0x01,addre);
3889  0138 3b0002        	push	_addre+1
3890  013b 4b01          	push	#1
3891  013d ae0000        	ldw	x,#_R_TsBuffer
3892  0140 cd0000        	call	_UART1_Send
3894  0143 85            	popw	x
3896  0144 ac410241      	jpf	L3152
3897  0148               L5642:
3898                     ; 149 							UART1_Send(R_TsBuffer,0x02,addre);
3900  0148 3b0002        	push	_addre+1
3901  014b 4b02          	push	#2
3902  014d ae0000        	ldw	x,#_R_TsBuffer
3903  0150 cd0000        	call	_UART1_Send
3905  0153 85            	popw	x
3906  0154 ac410241      	jpf	L3152
3907  0158               L7432:
3908                     ; 152 					case Drawer_back:/*机械手回来*/
3908                     ; 153 						r_Flag = 0;
3910  0158 3f04          	clr	_r_Flag
3911                     ; 154 						r_num = robot_mode(0);
3913  015a 4f            	clr	a
3914  015b cd0000        	call	_robot_mode
3916  015e b705          	ld	_r_num,a
3917                     ; 155 						if(r_num==0)
3919  0160 3d05          	tnz	_r_num
3920  0162 2610          	jrne	L1742
3921                     ; 157 							UART1_Send(R_TsBuffer,0x01,addre);
3923  0164 3b0002        	push	_addre+1
3924  0167 4b01          	push	#1
3925  0169 ae0000        	ldw	x,#_R_TsBuffer
3926  016c cd0000        	call	_UART1_Send
3928  016f 85            	popw	x
3929                     ; 158 							r_Flag = 0;
3931  0170 3f04          	clr	_r_Flag
3933  0172 202b          	jra	L3742
3934  0174               L1742:
3935                     ; 160 						else if(r_num==1)
3937  0174 b605          	ld	a,_r_num
3938  0176 a101          	cp	a,#1
3939  0178 2613          	jrne	L5742
3940                     ; 162 							UART1_Send(R_TsBuffer,0x02,addre);
3942  017a 3b0002        	push	_addre+1
3943  017d 4b02          	push	#2
3944  017f ae0000        	ldw	x,#_R_TsBuffer
3945  0182 cd0000        	call	_UART1_Send
3947  0185 85            	popw	x
3948                     ; 163 							robot_mode(1);
3950  0186 a601          	ld	a,#1
3951  0188 cd0000        	call	_robot_mode
3954  018b 2012          	jra	L3742
3955  018d               L5742:
3956                     ; 165 						else if(r_num == 2)
3958  018d b605          	ld	a,_r_num
3959  018f a102          	cp	a,#2
3960  0191 260c          	jrne	L3742
3961                     ; 167 							UART1_Send(R_TsBuffer,0x03,addre);
3963  0193 3b0002        	push	_addre+1
3964  0196 4b03          	push	#3
3965  0198 ae0000        	ldw	x,#_R_TsBuffer
3966  019b cd0000        	call	_UART1_Send
3968  019e 85            	popw	x
3969  019f               L3742:
3970                     ; 170 						eeprom_count(2);
3972  019f a602          	ld	a,#2
3973  01a1 cd0000        	call	_eeprom_count
3975                     ; 171 					break;
3977  01a4 ac410241      	jpf	L3152
3978  01a8               L1532:
3979                     ; 172 					case Drawer_back_place:/*机械手回来是否到位*/
3979                     ; 173 						if(back_seat == 1)
3981                     	btst	_IPC6
3982  01ad 240f          	jruge	L3052
3983                     ; 175 							UART1_Send(R_TsBuffer,0x01,addre);
3985  01af 3b0002        	push	_addre+1
3986  01b2 4b01          	push	#1
3987  01b4 ae0000        	ldw	x,#_R_TsBuffer
3988  01b7 cd0000        	call	_UART1_Send
3990  01ba 85            	popw	x
3992  01bb cc0241        	jra	L3152
3993  01be               L3052:
3994                     ; 179 							UART1_Send(R_TsBuffer,0x02,addre);
3996  01be 3b0002        	push	_addre+1
3997  01c1 4b02          	push	#2
3998  01c3 ae0000        	ldw	x,#_R_TsBuffer
3999  01c6 cd0000        	call	_UART1_Send
4001  01c9 85            	popw	x
4002  01ca 2075          	jra	L3152
4003  01cc               L3532:
4004                     ; 182 					case Check_num://查询机械手使用次数
4004                     ; 183 						R_TsBuffer[2] = Eeprom_Read(2);
4006  01cc a602          	ld	a,#2
4007  01ce cd0000        	call	_Eeprom_Read
4009  01d1 b702          	ld	_R_TsBuffer+2,a
4010                     ; 184 						R_TsBuffer[3] = Eeprom_Read(3);
4012  01d3 a603          	ld	a,#3
4013  01d5 cd0000        	call	_Eeprom_Read
4015  01d8 b703          	ld	_R_TsBuffer+3,a
4016                     ; 185 						R_TsBuffer[4] = Eeprom_Read(4);
4018  01da a604          	ld	a,#4
4019  01dc cd0000        	call	_Eeprom_Read
4021  01df b704          	ld	_R_TsBuffer+4,a
4022                     ; 186 						R_TsBuffer[5] = Eeprom_Read(5);
4024  01e1 a605          	ld	a,#5
4025  01e3 cd0000        	call	_Eeprom_Read
4027  01e6 b705          	ld	_R_TsBuffer+5,a
4028                     ; 187 						R_TsBuffer[6] = Eeprom_Read(6);
4030  01e8 a606          	ld	a,#6
4031  01ea cd0000        	call	_Eeprom_Read
4033  01ed b706          	ld	_R_TsBuffer+6,a
4034                     ; 188 						UART1_Send(R_TsBuffer,0x01,addre);
4036  01ef 3b0002        	push	_addre+1
4037  01f2 4b01          	push	#1
4038  01f4 ae0000        	ldw	x,#_R_TsBuffer
4039  01f7 cd0000        	call	_UART1_Send
4041  01fa 85            	popw	x
4042                     ; 189 					break;
4044  01fb 2044          	jra	L3152
4045  01fd               L5532:
4046                     ; 190 					case Check_num_zero:
4046                     ; 191 						Eeprom_Write(2,0);
4048  01fd 5f            	clrw	x
4049  01fe a602          	ld	a,#2
4050  0200 95            	ld	xh,a
4051  0201 cd0000        	call	_Eeprom_Write
4053                     ; 192 						Eeprom_Write(3,0);
4055  0204 5f            	clrw	x
4056  0205 a603          	ld	a,#3
4057  0207 95            	ld	xh,a
4058  0208 cd0000        	call	_Eeprom_Write
4060                     ; 193 						Eeprom_Write(4,0);
4062  020b 5f            	clrw	x
4063  020c a604          	ld	a,#4
4064  020e 95            	ld	xh,a
4065  020f cd0000        	call	_Eeprom_Write
4067                     ; 194 						Eeprom_Write(5,0);
4069  0212 5f            	clrw	x
4070  0213 a605          	ld	a,#5
4071  0215 95            	ld	xh,a
4072  0216 cd0000        	call	_Eeprom_Write
4074                     ; 195 						Eeprom_Write(6,0);
4076  0219 5f            	clrw	x
4077  021a a606          	ld	a,#6
4078  021c 95            	ld	xh,a
4079  021d cd0000        	call	_Eeprom_Write
4081                     ; 196 					break;
4083  0220 201f          	jra	L3152
4084  0222               L7532:
4085                     ; 197 					case OPEN_LOGIHT:
4085                     ; 198 						if(R_RsBuffer[1] == 0) {
4087  0222 3d0a          	tnz	_R_RsBuffer+1
4088  0224 2606          	jrne	L7052
4089                     ; 199 							SetLed(0);
4091  0226 4f            	clr	a
4092  0227 cd0000        	call	_SetLed
4095  022a 2015          	jra	L3152
4096  022c               L7052:
4097                     ; 201 							SetLed(1);
4099  022c a601          	ld	a,#1
4100  022e cd0000        	call	_SetLed
4102  0231 200e          	jra	L3152
4103  0233               L1542:
4104                     ; 206 					break;
4105  0233 200c          	jra	L3152
4106  0235               L5442:
4107                     ; 211 				UART1_Send(R_TsBuffer,ERROR,addre);
4109  0235 3b0002        	push	_addre+1
4110  0238 4b44          	push	#68
4111  023a ae0000        	ldw	x,#_R_TsBuffer
4112  023d cd0000        	call	_UART1_Send
4114  0240 85            	popw	x
4115  0241               L3152:
4116                     ; 213 			c_ok_Flag = 0;
4118  0241 72110000      	bres	_c_ok_Flag
4119  0245               L3442:
4120                     ; 215 		WDT();//清看门狗
4122  0245 35aa50e0      	mov	_IWDG_KR,#170
4124  0249 ac100010      	jpf	L1042
4151                     ; 221 @far @interrupt void TIM1_UPD_OVF_IRQHandler (void)
4151                     ; 222 {
4153                     	switch	.text
4154  024d               f_TIM1_UPD_OVF_IRQHandler:
4158                     ; 223 	TIM1_SR1 &= (~0x01);        //清除中断标志
4160  024d 72115255      	bres	_TIM1_SR1,#0
4161                     ; 224 	T1msFlg++;
4163  0251 be06          	ldw	x,_T1msFlg
4164  0253 1c0001        	addw	x,#1
4165  0256 bf06          	ldw	_T1msFlg,x
4166                     ; 225 	T2msFlg++;
4168  0258 be08          	ldw	x,_T2msFlg
4169  025a 1c0001        	addw	x,#1
4170  025d bf08          	ldw	_T2msFlg,x
4171                     ; 226 	return;
4174  025f 80            	iret
4214                     ; 231 @far @interrupt void UART1_Recv_IRQHandler (void)
4214                     ; 232 {
4215                     	switch	.text
4216  0260               f_UART1_Recv_IRQHandler:
4218       00000001      OFST:	set	1
4219  0260 be00          	ldw	x,c_x
4220  0262 89            	pushw	x
4221  0263 88            	push	a
4224                     ; 234 	ch=UART1_DR;
4226  0264 c65231        	ld	a,_UART1_DR
4227  0267 6b01          	ld	(OFST+0,sp),a
4228                     ; 236 	if(c_ok_Flag == 0)
4230                     	btst	_c_ok_Flag
4231  026e 254e          	jrult	L3452
4232                     ; 238 		if(com_Flag == 0)
4234  0270 3d03          	tnz	_com_Flag
4235  0272 260e          	jrne	L5452
4236                     ; 240 			if(ch == c_head)
4238  0274 7b01          	ld	a,(OFST+0,sp)
4239  0276 a13a          	cp	a,#58
4240  0278 2644          	jrne	L3452
4241                     ; 242 				com_Flag = 1;
4243  027a 35010003      	mov	_com_Flag,#1
4244                     ; 243 				com_i = 0;
4246  027e 3f00          	clr	_com_i
4247  0280 203c          	jra	L3452
4248  0282               L5452:
4249                     ; 246 		else if(com_Flag == 1)
4251  0282 b603          	ld	a,_com_Flag
4252  0284 a101          	cp	a,#1
4253  0286 2616          	jrne	L3552
4254                     ; 248 			if(addre == ch)
4256  0288 7b01          	ld	a,(OFST+0,sp)
4257  028a 5f            	clrw	x
4258  028b 97            	ld	xl,a
4259  028c bf00          	ldw	c_x,x
4260  028e be01          	ldw	x,_addre
4261  0290 b300          	cpw	x,c_x
4262  0292 2606          	jrne	L5552
4263                     ; 250 				com_Flag = 2;
4265  0294 35020003      	mov	_com_Flag,#2
4267  0298 2024          	jra	L3452
4268  029a               L5552:
4269                     ; 254 				com_Flag = 0;
4271  029a 3f03          	clr	_com_Flag
4272  029c 2020          	jra	L3452
4273  029e               L3552:
4274                     ; 257 		else if(com_Flag == 2)//2
4276  029e b603          	ld	a,_com_Flag
4277  02a0 a102          	cp	a,#2
4278  02a2 261a          	jrne	L3452
4279                     ; 259 			R_RsBuffer[com_i] = ch;
4281  02a4 b600          	ld	a,_com_i
4282  02a6 5f            	clrw	x
4283  02a7 97            	ld	xl,a
4284  02a8 7b01          	ld	a,(OFST+0,sp)
4285  02aa e709          	ld	(_R_RsBuffer,x),a
4286                     ; 260 			if(com_i == 6)
4288  02ac b600          	ld	a,_com_i
4289  02ae a106          	cp	a,#6
4290  02b0 260a          	jrne	L5652
4291                     ; 262 				com_i = 0;
4293  02b2 3f00          	clr	_com_i
4294                     ; 263 				com_Flag = 0;
4296  02b4 3f03          	clr	_com_Flag
4297                     ; 264 				c_ok_Flag = 1;
4299  02b6 72100000      	bset	_c_ok_Flag
4301  02ba 2002          	jra	L3452
4302  02bc               L5652:
4303                     ; 268 				com_i++;
4305  02bc 3c00          	inc	_com_i
4306  02be               L3452:
4307                     ; 272 	return;
4310  02be 84            	pop	a
4311  02bf 85            	popw	x
4312  02c0 bf00          	ldw	c_x,x
4313  02c2 80            	iret
4315                     	bsct
4316  000e               _fs_i:
4317  000e 00            	dc.b	0
4318  000f               _fs_ok:
4319  000f 00            	dc.b	0
4348                     ; 280 @far @interrupt void UART1_Txcv_IRQHandler (void)
4348                     ; 281 {
4349                     	switch	.text
4350  02c3               f_UART1_Txcv_IRQHandler:
4354                     ; 282 	_asm("sim");//开中断，sim为关中断
4357  02c3 9b            sim
4359                     ; 284 	UART1_SR &= ~(1<<6);    //清除送完成状态位
4361  02c4 721d5230      	bres	_UART1_SR,#6
4362                     ; 285 	UART1_DR = R_TsBuffer[fs_i];
4364  02c8 b60e          	ld	a,_fs_i
4365  02ca 5f            	clrw	x
4366  02cb 97            	ld	xl,a
4367  02cc e600          	ld	a,(_R_TsBuffer,x)
4368  02ce c75231        	ld	_UART1_DR,a
4369                     ; 286 	if(fs_i < 8)fs_i++;
4371  02d1 b60e          	ld	a,_fs_i
4372  02d3 a108          	cp	a,#8
4373  02d5 2404          	jruge	L1062
4376  02d7 3c0e          	inc	_fs_i
4378  02d9 200c          	jra	L3062
4379  02db               L1062:
4380                     ; 289 		fs_i = 0;
4382  02db 3f0e          	clr	_fs_i
4383                     ; 290 		rs485_dr1 = 0;
4385  02dd 721f500f      	bres	_OPD7
4386                     ; 291 		UART1_CR2 &= ~(1<<6);//关闭发送完成中断
4388  02e1 721d5235      	bres	_UART1_CR2,#6
4389                     ; 292 		fs_ok = 0;
4391  02e5 3f0f          	clr	_fs_ok
4392  02e7               L3062:
4393                     ; 298 	_asm("rim");//开中断，sim为关中断
4396  02e7 9a            rim
4398                     ; 299 	return;
4401  02e8 80            	iret
4553                     	xdef	f_UART1_Txcv_IRQHandler
4554                     	xdef	_fs_ok
4555                     	xdef	_fs_i
4556                     	xdef	f_UART1_Recv_IRQHandler
4557                     	xdef	f_TIM1_UPD_OVF_IRQHandler
4558                     	xdef	_main
4559                     	xdef	_TS_count
4560                     	xdef	_Duty_Val
4561                     	xdef	_run_Falg
4562                     	xdef	_T2msFlg
4563                     	xdef	_T1msFlg
4564                     	xdef	_r_num
4565                     	xdef	_r_Flag
4566                     	xdef	_com_Flag
4567                     	xdef	_addre
4568                     	xdef	_com_i
4569                     	xdef	_c_ok_Flag
4570                     	switch	.ubsct
4571  0000               _R_TsBuffer:
4572  0000 000000000000  	ds.b	9
4573                     	xdef	_R_TsBuffer
4574  0009               _R_RsBuffer:
4575  0009 000000000000  	ds.b	9
4576                     	xdef	_R_RsBuffer
4577                     	xref	_SetLed
4578                     	xref	_Eeprom_Write
4579                     	xref	_eeprom_count
4580                     	xref	_Eeprom_Read
4581                     	xref	_Eeprom_Init
4582                     	xref	_robot_mode
4583                     	xref	_UART1_Send
4584                     	xref	_UART1_Init
4585                     	xref	_delayms
4586                     	xref	_Addr_Read
4587                     	xref	_BSP_Init
4588                     	xref.b	c_x
4608                     	end
