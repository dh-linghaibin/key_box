   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3399                     .bit:	section	.data,bit
3400  0000               _c_ok_Flag:
3401  0000 00            	dc.b	0
3402  0001               _but_Flag:
3403  0001 00            	dc.b	0
3404                     	bsct
3405  0000               _rebot_dr:
3406  0000 00            	dc.b	0
3407  0001               _com_i:
3408  0001 00            	dc.b	0
3409  0002               _addre:
3410  0002 01            	dc.b	1
3411  0003               _com_Flag:
3412  0003 00            	dc.b	0
3413  0004               _Rc_ok_Flag:
3414  0004 00            	dc.b	0
3415  0005               _Rcom_i:
3416  0005 00            	dc.b	0
3417  0006               _Rcom_Flag:
3418  0006 00            	dc.b	0
3419  0007               _rb_Flag:
3420  0007 00            	dc.b	0
3421  0008               _wr_new:
3422  0008 00            	dc.b	0
3423  0009               _Dr_Num_Save:
3424  0009 00            	dc.b	0
3425  000a               _fr_Flag:
3426  000a 00            	dc.b	0
3427  000b               _bu_Flag:
3428  000b 00            	dc.b	0
3429  000c               _mirro:
3430  000c 00            	dc.b	0
3431  000d               _Encoder:
3432  000d 00            	dc.b	0
3433  000e               _place_sava:
3434  000e 00            	dc.b	0
3435  000f               _Shield:
3436  000f 0000          	dc.w	0
3437  0011               _S_buf:
3438  0011 01            	dc.b	1
3439  0012 01            	dc.b	1
3440  0013 01            	dc.b	1
3441  0014 01            	dc.b	1
3442  0015 01            	dc.b	1
3443  0016 01            	dc.b	1
3444  0017 01            	dc.b	1
3445  0018 01            	dc.b	1
3446  0019 01            	dc.b	1
3447  001a 01            	dc.b	1
3448                     	switch	.bit
3449  0002               _Encoder_bz:
3450  0002 00            	dc.b	0
3451  0003               _dis_play:
3452  0003 00            	dc.b	0
3453                     	bsct
3454  001b               _Encoder_count:
3455  001b 0000          	dc.w	0
3456                     	switch	.bit
3457  0004               _jxs_out:
3458  0004 00            	dc.b	0
3459                     	bsct
3460  001d               _cheak_wait_count:
3461  001d 0000          	dc.w	0
3593                     .const:	section	.text
3594  0000               L6:
3595  0000 0000fde8      	dc.l	65000
3596  0004               L01:
3597  0004 0000fa01      	dc.l	64001
3598  0008               L41:
3599  0008 0614          	dc.w	L5722
3600  000a 0671          	dc.w	L7722
3601  000c 07b6          	dc.w	L1132
3602  000e 086a          	dc.w	L5132
3603  0010 080f          	dc.w	L3132
3604  0012 0890          	dc.w	L7132
3605  0014 071f          	dc.w	L1032
3606  0016 093b          	dc.w	L5572
3607  0018 093b          	dc.w	L5572
3608  001a 093b          	dc.w	L5572
3609  001c 093b          	dc.w	L5572
3610  001e 093b          	dc.w	L5572
3611  0020 093b          	dc.w	L5572
3612  0022 093b          	dc.w	L5572
3613  0024 093b          	dc.w	L5572
3614  0026 076d          	dc.w	L3032
3615  0028 0780          	dc.w	L5032
3616  002a 0791          	dc.w	L7032
3617  002c 0524          	dc.w	L7622
3618  002e 058f          	dc.w	L1722
3619                     ; 84 main()
3619                     ; 85 {
3620                     	scross	off
3621                     	switch	.text
3622  0000               _main:
3624  0000 5203          	subw	sp,#3
3625       00000003      OFST:	set	3
3628                     ; 86 	BSP_Init();
3630  0002 cd0000        	call	_BSP_Init
3632                     ; 87 	UART1_Init();
3634  0005 cd0000        	call	_UART1_Init
3636                     ; 88 	UART3_Init();
3638  0008 cd0000        	call	_UART3_Init
3640                     ; 89 	Eeprom_Init();/*eeprom解锁*/
3642  000b cd0000        	call	_Eeprom_Init
3644                     ; 90 	LCD12864_Init();//12864初始化
3646  000e cd0000        	call	_LCD12864_Init
3648                     ; 91 	Draw_PM(jm_a);
3650  0011 ae0000        	ldw	x,#_jm_a
3651  0014 cd0000        	call	_Draw_PM
3653                     ; 92 	delayms(1000);
3655  0017 ae03e8        	ldw	x,#1000
3656  001a cd0000        	call	_delayms
3658                     ; 93 	LCD_Clear_BMP();
3660  001d cd0000        	call	_LCD_Clear_BMP
3662                     ; 94 	Addr_Read(&addre);
3664  0020 ae0002        	ldw	x,#_addre
3665  0023 cd0000        	call	_Addr_Read
3667                     ; 96 	Dr_Num_Save += Eeprom_Read(10)*10;
3669  0026 a60a          	ld	a,#10
3670  0028 cd0000        	call	_Eeprom_Read
3672  002b 97            	ld	xl,a
3673  002c a60a          	ld	a,#10
3674  002e 42            	mul	x,a
3675  002f 9f            	ld	a,xl
3676  0030 bb09          	add	a,_Dr_Num_Save
3677  0032 b709          	ld	_Dr_Num_Save,a
3678                     ; 97 	Dr_Num_Save += Eeprom_Read(11);
3680  0034 a60b          	ld	a,#11
3681  0036 cd0000        	call	_Eeprom_Read
3683  0039 bb09          	add	a,_Dr_Num_Save
3684  003b b709          	ld	_Dr_Num_Save,a
3685                     ; 99 	Encoder = Eeprom_Read(5);
3687  003d a605          	ld	a,#5
3688  003f cd0000        	call	_Eeprom_Read
3690  0042 b70d          	ld	_Encoder,a
3691                     ; 101 	page_n.dr_num = 1;
3693  0044 35010003      	mov	_page_n+3,#1
3694                     ; 102 	page_n.rb_num = 1;
3696  0048 35010004      	mov	_page_n+4,#1
3697                     ; 103 	Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
3699  004c ae0000        	ldw	x,#_page_n
3700  004f 89            	pushw	x
3701  0050 3b0009        	push	_Dr_Num_Save
3702  0053 ae0032        	ldw	x,#_RsBuffer
3703  0056 89            	pushw	x
3704  0057 b602          	ld	a,_addre
3705  0059 97            	ld	xl,a
3706  005a a602          	ld	a,#2
3707  005c 95            	ld	xh,a
3708  005d cd0000        	call	_Menu_Host
3710  0060 5b05          	addw	sp,#5
3711  0062               L7632:
3712                     ; 106 		WDT();//清看门狗
3714  0062 35aa50e0      	mov	_IWDG_KR,#170
3715                     ; 108 		if(ts_page == 0)
3717                     	btst	_IPD0
3718  006b 2510          	jrult	L3732
3719                     ; 110 			if(page_n.ts_page_cnt < 5000)
3721  006d be0b          	ldw	x,_page_n+11
3722  006f a31388        	cpw	x,#5000
3723  0072 243d          	jruge	L7732
3724                     ; 112 				page_n.ts_page_cnt++;
3726  0074 be0b          	ldw	x,_page_n+11
3727  0076 1c0001        	addw	x,#1
3728  0079 bf0b          	ldw	_page_n+11,x
3729  007b 2034          	jra	L7732
3730  007d               L3732:
3731                     ; 117 			if(page_n.ts_page_cnt > 4000)
3733  007d be0b          	ldw	x,_page_n+11
3734  007f a30fa1        	cpw	x,#4001
3735  0082 252a          	jrult	L1042
3736                     ; 119 				if(page_n.page < 4)
3738  0084 b600          	ld	a,_page_n
3739  0086 a104          	cp	a,#4
3740  0088 240c          	jruge	L3042
3741                     ; 121 					page_n.page++;
3743  008a 3c00          	inc	_page_n
3744                     ; 122 					if(page_n.page == 1)
3746  008c b600          	ld	a,_page_n
3747  008e a101          	cp	a,#1
3748  0090 2606          	jrne	L7042
3749                     ; 124 						page_n.row = 0;
3751  0092 3f01          	clr	_page_n+1
3752  0094 2002          	jra	L7042
3753  0096               L3042:
3754                     ; 129 					page_n.page = 0;
3756  0096 3f00          	clr	_page_n
3757  0098               L7042:
3758                     ; 131 				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
3760  0098 ae0000        	ldw	x,#_page_n
3761  009b 89            	pushw	x
3762  009c 3b0009        	push	_Dr_Num_Save
3763  009f ae0032        	ldw	x,#_RsBuffer
3764  00a2 89            	pushw	x
3765  00a3 b602          	ld	a,_addre
3766  00a5 97            	ld	xl,a
3767  00a6 a602          	ld	a,#2
3768  00a8 95            	ld	xh,a
3769  00a9 cd0000        	call	_Menu_Host
3771  00ac 5b05          	addw	sp,#5
3772  00ae               L1042:
3773                     ; 133 			page_n.ts_page_cnt = 0;
3775  00ae 5f            	clrw	x
3776  00af bf0b          	ldw	_page_n+11,x
3777  00b1               L7732:
3778                     ; 136 		if(ts_up == 0)
3780                     	btst	_IPE0
3781  00b6 2513          	jrult	L1142
3782                     ; 138 			if(page_n.ts_up_cnt < 5000)
3784  00b8 be07          	ldw	x,_page_n+7
3785  00ba a31388        	cpw	x,#5000
3786  00bd 2503          	jrult	L61
3787  00bf cc0149        	jp	L5142
3788  00c2               L61:
3789                     ; 140 				page_n.ts_up_cnt++;
3791  00c2 be07          	ldw	x,_page_n+7
3792  00c4 1c0001        	addw	x,#1
3793  00c7 bf07          	ldw	_page_n+7,x
3794  00c9 207e          	jra	L5142
3795  00cb               L1142:
3796                     ; 145 			if(page_n.ts_up_cnt > 4000)
3798  00cb be07          	ldw	x,_page_n+7
3799  00cd a30fa1        	cpw	x,#4001
3800  00d0 2574          	jrult	L7142
3801                     ; 147 				if(page_n.ins_row == 0)
3803  00d2 3d02          	tnz	_page_n+2
3804  00d4 262c          	jrne	L1242
3805                     ; 149 					if(page_n.page == 1)
3807  00d6 b600          	ld	a,_page_n
3808  00d8 a101          	cp	a,#1
3809  00da 2606          	jrne	L3242
3810                     ; 151 						page_n.row = 1;
3812  00dc 35010001      	mov	_page_n+1,#1
3814  00e0 204e          	jra	L1442
3815  00e2               L3242:
3816                     ; 153 					else if(page_n.page < 4)
3818  00e2 b600          	ld	a,_page_n
3819  00e4 a104          	cp	a,#4
3820  00e6 240a          	jruge	L7242
3821                     ; 155 						if(page_n.row < 3)
3823  00e8 b601          	ld	a,_page_n+1
3824  00ea a103          	cp	a,#3
3825  00ec 2442          	jruge	L1442
3826                     ; 157 							page_n.row++;
3828  00ee 3c01          	inc	_page_n+1
3829  00f0 203e          	jra	L1442
3830  00f2               L7242:
3831                     ; 160 					else if(page_n.page == 5)
3833  00f2 b600          	ld	a,_page_n
3834  00f4 a105          	cp	a,#5
3835  00f6 2638          	jrne	L1442
3836                     ; 162 						if(page_n.row < 3)
3838  00f8 b601          	ld	a,_page_n+1
3839  00fa a103          	cp	a,#3
3840  00fc 2432          	jruge	L1442
3841                     ; 164 							page_n.row++;
3843  00fe 3c01          	inc	_page_n+1
3844  0100 202e          	jra	L1442
3845  0102               L1242:
3846                     ; 170 					if(page_n.ins_row == 1)
3848  0102 b602          	ld	a,_page_n+2
3849  0104 a101          	cp	a,#1
3850  0106 260a          	jrne	L3442
3851                     ; 172 						if(page_n.dr_num < 72)
3853  0108 b603          	ld	a,_page_n+3
3854  010a a148          	cp	a,#72
3855  010c 2422          	jruge	L1442
3856                     ; 174 							page_n.dr_num ++;
3858  010e 3c03          	inc	_page_n+3
3859  0110 201e          	jra	L1442
3860  0112               L3442:
3861                     ; 177 					else if(page_n.ins_row == 2)
3863  0112 b602          	ld	a,_page_n+2
3864  0114 a102          	cp	a,#2
3865  0116 260a          	jrne	L1542
3866                     ; 179 						if(page_n.rb_num < 10)
3868  0118 b604          	ld	a,_page_n+4
3869  011a a10a          	cp	a,#10
3870  011c 2412          	jruge	L1442
3871                     ; 181 							page_n.rb_num ++;
3873  011e 3c04          	inc	_page_n+4
3874  0120 200e          	jra	L1442
3875  0122               L1542:
3876                     ; 184 					else if(page_n.ins_row == 3)
3878  0122 b602          	ld	a,_page_n+2
3879  0124 a103          	cp	a,#3
3880  0126 2608          	jrne	L1442
3881                     ; 186 						if(page_n.rb_num < 10)
3883  0128 b604          	ld	a,_page_n+4
3884  012a a10a          	cp	a,#10
3885  012c 2402          	jruge	L1442
3886                     ; 188 							page_n.rb_num ++;
3888  012e 3c04          	inc	_page_n+4
3889  0130               L1442:
3890                     ; 192 				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
3892  0130 ae0000        	ldw	x,#_page_n
3893  0133 89            	pushw	x
3894  0134 3b0009        	push	_Dr_Num_Save
3895  0137 ae0032        	ldw	x,#_RsBuffer
3896  013a 89            	pushw	x
3897  013b b602          	ld	a,_addre
3898  013d 97            	ld	xl,a
3899  013e a602          	ld	a,#2
3900  0140 95            	ld	xh,a
3901  0141 cd0000        	call	_Menu_Host
3903  0144 5b05          	addw	sp,#5
3904  0146               L7142:
3905                     ; 194 			page_n.ts_up_cnt = 0;
3907  0146 5f            	clrw	x
3908  0147 bf07          	ldw	_page_n+7,x
3909  0149               L5142:
3910                     ; 197 		if(ts_next == 0)
3912                     	btst	_IPE1
3913  014e 2513          	jrult	L3642
3914                     ; 199 			if(page_n.ts_next_cnt < 5000)
3916  0150 be05          	ldw	x,_page_n+5
3917  0152 a31388        	cpw	x,#5000
3918  0155 2503          	jrult	L02
3919  0157 cc01db        	jp	L7642
3920  015a               L02:
3921                     ; 201 				page_n.ts_next_cnt++;
3923  015a be05          	ldw	x,_page_n+5
3924  015c 1c0001        	addw	x,#1
3925  015f bf05          	ldw	_page_n+5,x
3926  0161 2078          	jra	L7642
3927  0163               L3642:
3928                     ; 206 			if(page_n.ts_next_cnt > 4000)
3930  0163 be05          	ldw	x,_page_n+5
3931  0165 a30fa1        	cpw	x,#4001
3932  0168 256e          	jrult	L1742
3933                     ; 208 				if(page_n.ins_row == 0)
3935  016a 3d02          	tnz	_page_n+2
3936  016c 2626          	jrne	L3742
3937                     ; 210 					if(page_n.page == 1)
3939  016e b600          	ld	a,_page_n
3940  0170 a101          	cp	a,#1
3941  0172 2604          	jrne	L5742
3942                     ; 212 						page_n.row = 0;
3944  0174 3f01          	clr	_page_n+1
3946  0176 204a          	jra	L3152
3947  0178               L5742:
3948                     ; 214 					else if(page_n.page < 4)
3950  0178 b600          	ld	a,_page_n
3951  017a a104          	cp	a,#4
3952  017c 2408          	jruge	L1052
3953                     ; 216 						if(page_n.row > 0)
3955  017e 3d01          	tnz	_page_n+1
3956  0180 2740          	jreq	L3152
3957                     ; 218 							page_n.row--;
3959  0182 3a01          	dec	_page_n+1
3960  0184 203c          	jra	L3152
3961  0186               L1052:
3962                     ; 221 					else if(page_n.page == 5)
3964  0186 b600          	ld	a,_page_n
3965  0188 a105          	cp	a,#5
3966  018a 2636          	jrne	L3152
3967                     ; 223 						if(page_n.row > 0)
3969  018c 3d01          	tnz	_page_n+1
3970  018e 2732          	jreq	L3152
3971                     ; 225 							page_n.row--;
3973  0190 3a01          	dec	_page_n+1
3974  0192 202e          	jra	L3152
3975  0194               L3742:
3976                     ; 231 					if(page_n.ins_row == 1)
3978  0194 b602          	ld	a,_page_n+2
3979  0196 a101          	cp	a,#1
3980  0198 260a          	jrne	L5152
3981                     ; 233 						if(page_n.dr_num > 1)
3983  019a b603          	ld	a,_page_n+3
3984  019c a102          	cp	a,#2
3985  019e 2522          	jrult	L3152
3986                     ; 235 							page_n.dr_num --;
3988  01a0 3a03          	dec	_page_n+3
3989  01a2 201e          	jra	L3152
3990  01a4               L5152:
3991                     ; 238 					else if(page_n.ins_row == 2)
3993  01a4 b602          	ld	a,_page_n+2
3994  01a6 a102          	cp	a,#2
3995  01a8 260a          	jrne	L3252
3996                     ; 240 						if(page_n.rb_num > 1)
3998  01aa b604          	ld	a,_page_n+4
3999  01ac a102          	cp	a,#2
4000  01ae 2512          	jrult	L3152
4001                     ; 242 							page_n.rb_num --;
4003  01b0 3a04          	dec	_page_n+4
4004  01b2 200e          	jra	L3152
4005  01b4               L3252:
4006                     ; 245 					else if(page_n.ins_row == 3)
4008  01b4 b602          	ld	a,_page_n+2
4009  01b6 a103          	cp	a,#3
4010  01b8 2608          	jrne	L3152
4011                     ; 247 						if(page_n.rb_num > 1)
4013  01ba b604          	ld	a,_page_n+4
4014  01bc a102          	cp	a,#2
4015  01be 2502          	jrult	L3152
4016                     ; 249 							page_n.rb_num --;
4018  01c0 3a04          	dec	_page_n+4
4019  01c2               L3152:
4020                     ; 253 				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
4022  01c2 ae0000        	ldw	x,#_page_n
4023  01c5 89            	pushw	x
4024  01c6 3b0009        	push	_Dr_Num_Save
4025  01c9 ae0032        	ldw	x,#_RsBuffer
4026  01cc 89            	pushw	x
4027  01cd b602          	ld	a,_addre
4028  01cf 97            	ld	xl,a
4029  01d0 a602          	ld	a,#2
4030  01d2 95            	ld	xh,a
4031  01d3 cd0000        	call	_Menu_Host
4033  01d6 5b05          	addw	sp,#5
4034  01d8               L1742:
4035                     ; 255 			page_n.ts_next_cnt = 0;
4037  01d8 5f            	clrw	x
4038  01d9 bf05          	ldw	_page_n+5,x
4039  01db               L7642:
4040                     ; 258 		if(ts_ok == 0)
4042                     	btst	_IPE2
4043  01e0 251c          	jrult	L5352
4044                     ; 260 			if(page_n.ts_ok_cnt < 65000)
4046  01e2 9c            	rvf
4047  01e3 be09          	ldw	x,_page_n+9
4048  01e5 cd0000        	call	c_uitolx
4050  01e8 ae0000        	ldw	x,#L6
4051  01eb cd0000        	call	c_lcmp
4053  01ee 2f03          	jrslt	L22
4054  01f0 cc038d        	jp	L1452
4055  01f3               L22:
4056                     ; 262 				page_n.ts_ok_cnt++;
4058  01f3 be09          	ldw	x,_page_n+9
4059  01f5 1c0001        	addw	x,#1
4060  01f8 bf09          	ldw	_page_n+9,x
4061  01fa ac8d038d      	jpf	L1452
4062  01fe               L5352:
4063                     ; 267 			if(page_n.ts_ok_cnt > 64000)
4065  01fe 9c            	rvf
4066  01ff be09          	ldw	x,_page_n+9
4067  0201 cd0000        	call	c_uitolx
4069  0204 ae0004        	ldw	x,#L01
4070  0207 cd0000        	call	c_lcmp
4072  020a 2e03          	jrsge	L42
4073  020c cc02c6        	jp	L3452
4074  020f               L42:
4075                     ; 269 				if(page_n.page == 1)
4077  020f b600          	ld	a,_page_n
4078  0211 a101          	cp	a,#1
4079  0213 261d          	jrne	L5452
4080                     ; 271 					if(page_n.row == 0)
4082  0215 3d01          	tnz	_page_n+1
4083  0217 2609          	jrne	L7452
4084                     ; 273 						eeprom_cle(r_sive_n);
4086  0219 a60f          	ld	a,#15
4087  021b cd0000        	call	_eeprom_cle
4090  021e acac02ac      	jpf	L5552
4091  0222               L7452:
4092                     ; 275 					else if(page_n.row == 1)
4094  0222 b601          	ld	a,_page_n+1
4095  0224 a101          	cp	a,#1
4096  0226 2703          	jreq	L62
4097  0228 cc02ac        	jp	L5552
4098  022b               L62:
4099                     ; 277 						eeprom_cle(r_sive_n+5);
4101  022b a614          	ld	a,#20
4102  022d cd0000        	call	_eeprom_cle
4104  0230 207a          	jra	L5552
4105  0232               L5452:
4106                     ; 280 				else if(page_n.page == 2)
4108  0232 b600          	ld	a,_page_n
4109  0234 a102          	cp	a,#2
4110  0236 2632          	jrne	L7552
4111                     ; 282 					if(page_n.row == 0)
4113  0238 3d01          	tnz	_page_n+1
4114  023a 2607          	jrne	L1652
4115                     ; 284 						eeprom_cle(r_sive_n+10);
4117  023c a619          	ld	a,#25
4118  023e cd0000        	call	_eeprom_cle
4121  0241 2069          	jra	L5552
4122  0243               L1652:
4123                     ; 286 					else if(page_n.row == 1)
4125  0243 b601          	ld	a,_page_n+1
4126  0245 a101          	cp	a,#1
4127  0247 2607          	jrne	L5652
4128                     ; 288 						eeprom_cle(r_sive_n+15);
4130  0249 a61e          	ld	a,#30
4131  024b cd0000        	call	_eeprom_cle
4134  024e 205c          	jra	L5552
4135  0250               L5652:
4136                     ; 290 					else if(page_n.row == 2)
4138  0250 b601          	ld	a,_page_n+1
4139  0252 a102          	cp	a,#2
4140  0254 2607          	jrne	L1752
4141                     ; 292 						eeprom_cle(r_sive_n+20);
4143  0256 a623          	ld	a,#35
4144  0258 cd0000        	call	_eeprom_cle
4147  025b 204f          	jra	L5552
4148  025d               L1752:
4149                     ; 294 					else if(page_n.row == 3)
4151  025d b601          	ld	a,_page_n+1
4152  025f a103          	cp	a,#3
4153  0261 2649          	jrne	L5552
4154                     ; 296 						eeprom_cle(r_sive_n+25);
4156  0263 a628          	ld	a,#40
4157  0265 cd0000        	call	_eeprom_cle
4159  0268 2042          	jra	L5552
4160  026a               L7552:
4161                     ; 299 				else if(page_n.page == 3)
4163  026a b600          	ld	a,_page_n
4164  026c a103          	cp	a,#3
4165  026e 2632          	jrne	L1062
4166                     ; 301 					if(page_n.row == 0)
4168  0270 3d01          	tnz	_page_n+1
4169  0272 2607          	jrne	L3062
4170                     ; 303 						eeprom_cle(r_sive_n+30);
4172  0274 a62d          	ld	a,#45
4173  0276 cd0000        	call	_eeprom_cle
4176  0279 2031          	jra	L5552
4177  027b               L3062:
4178                     ; 305 					else if(page_n.row == 1)
4180  027b b601          	ld	a,_page_n+1
4181  027d a101          	cp	a,#1
4182  027f 2607          	jrne	L7062
4183                     ; 307 						eeprom_cle(r_sive_n+35);
4185  0281 a632          	ld	a,#50
4186  0283 cd0000        	call	_eeprom_cle
4189  0286 2024          	jra	L5552
4190  0288               L7062:
4191                     ; 309 					else if(page_n.row == 2)
4193  0288 b601          	ld	a,_page_n+1
4194  028a a102          	cp	a,#2
4195  028c 2607          	jrne	L3162
4196                     ; 311 						eeprom_cle(r_sive_n+40);
4198  028e a637          	ld	a,#55
4199  0290 cd0000        	call	_eeprom_cle
4202  0293 2017          	jra	L5552
4203  0295               L3162:
4204                     ; 313 					else if(page_n.row == 3)
4206  0295 b601          	ld	a,_page_n+1
4207  0297 a103          	cp	a,#3
4208  0299 2611          	jrne	L5552
4209                     ; 315 						eeprom_cle(r_sive_n+45);
4211  029b a63c          	ld	a,#60
4212  029d cd0000        	call	_eeprom_cle
4214  02a0 200a          	jra	L5552
4215  02a2               L1062:
4216                     ; 318 				else if(page_n.page == 4)
4218  02a2 b600          	ld	a,_page_n
4219  02a4 a104          	cp	a,#4
4220  02a6 2604          	jrne	L5552
4221                     ; 320 					page_n.page = 5;
4223  02a8 35050000      	mov	_page_n,#5
4224  02ac               L5552:
4225                     ; 322 				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
4227  02ac ae0000        	ldw	x,#_page_n
4228  02af 89            	pushw	x
4229  02b0 3b0009        	push	_Dr_Num_Save
4230  02b3 ae0032        	ldw	x,#_RsBuffer
4231  02b6 89            	pushw	x
4232  02b7 b602          	ld	a,_addre
4233  02b9 97            	ld	xl,a
4234  02ba a602          	ld	a,#2
4235  02bc 95            	ld	xh,a
4236  02bd cd0000        	call	_Menu_Host
4238  02c0 5b05          	addw	sp,#5
4240  02c2 ac8a038a      	jpf	L5262
4241  02c6               L3452:
4242                     ; 324 			else if(page_n.ts_ok_cnt > 4000)
4244  02c6 be09          	ldw	x,_page_n+9
4245  02c8 a30fa1        	cpw	x,#4001
4246  02cb 2403          	jruge	L03
4247  02cd cc038a        	jp	L5262
4248  02d0               L03:
4249                     ; 326 				if(page_n.page == 5)/*内部控制*/
4251  02d0 b600          	ld	a,_page_n
4252  02d2 a105          	cp	a,#5
4253  02d4 267a          	jrne	L1362
4254                     ; 328 					if(page_n.ins_row == 0)
4256  02d6 3d02          	tnz	_page_n+2
4257  02d8 262e          	jrne	L3362
4258                     ; 330 						if(page_n.row == 0)
4260  02da 3d01          	tnz	_page_n+1
4261  02dc 2606          	jrne	L5362
4262                     ; 332 							page_n.ins_row = 1;
4264  02de 35010002      	mov	_page_n+2,#1
4266  02e2 206c          	jra	L1362
4267  02e4               L5362:
4268                     ; 334 						else if(page_n.row == 1)
4270  02e4 b601          	ld	a,_page_n+1
4271  02e6 a101          	cp	a,#1
4272  02e8 2606          	jrne	L1462
4273                     ; 336 							page_n.ins_row = 2;
4275  02ea 35020002      	mov	_page_n+2,#2
4277  02ee 2060          	jra	L1362
4278  02f0               L1462:
4279                     ; 338 						else if(page_n.row == 2)
4281  02f0 b601          	ld	a,_page_n+1
4282  02f2 a102          	cp	a,#2
4283  02f4 2606          	jrne	L5462
4284                     ; 340 							page_n.ins_row = 3;
4286  02f6 35030002      	mov	_page_n+2,#3
4288  02fa 2054          	jra	L1362
4289  02fc               L5462:
4290                     ; 342 						else if(page_n.row == 3)
4292  02fc b601          	ld	a,_page_n+1
4293  02fe a103          	cp	a,#3
4294  0300 264e          	jrne	L1362
4295                     ; 344 							page_n.ins_row = 4;
4297  0302 35040002      	mov	_page_n+2,#4
4298  0306 2048          	jra	L1362
4299  0308               L3362:
4300                     ; 349 						if(page_n.ins_row == 1)/*旋转*/
4302  0308 b602          	ld	a,_page_n+2
4303  030a a101          	cp	a,#1
4304  030c 260c          	jrne	L5562
4305                     ; 351 							_Servo_C(page_n.dr_num,&Dr_Num_Save);/*旋转*/
4307  030e ae0009        	ldw	x,#_Dr_Num_Save
4308  0311 89            	pushw	x
4309  0312 b603          	ld	a,_page_n+3
4310  0314 cd0000        	call	__Servo_C
4312  0317 85            	popw	x
4314  0318 2034          	jra	L7562
4315  031a               L5562:
4316                     ; 353 						else if(page_n.ins_row == 2)/*机械手出去*/
4318  031a b602          	ld	a,_page_n+2
4319  031c a102          	cp	a,#2
4320  031e 260e          	jrne	L1662
4321                     ; 355 							UART1_Send(R_TsBuffer,Drawer_out,page_n.rb_num);
4323  0320 3b0004        	push	_page_n+4
4324  0323 4b14          	push	#20
4325  0325 ae0012        	ldw	x,#_R_TsBuffer
4326  0328 cd0000        	call	_UART1_Send
4328  032b 85            	popw	x
4330  032c 2020          	jra	L7562
4331  032e               L1662:
4332                     ; 357 						else if(page_n.ins_row == 3)/*机械手回来*/
4334  032e b602          	ld	a,_page_n+2
4335  0330 a103          	cp	a,#3
4336  0332 260e          	jrne	L5662
4337                     ; 359 							UART1_Send(R_TsBuffer,Drawer_back,page_n.rb_num);
4339  0334 3b0004        	push	_page_n+4
4340  0337 4b16          	push	#22
4341  0339 ae0012        	ldw	x,#_R_TsBuffer
4342  033c cd0000        	call	_UART1_Send
4344  033f 85            	popw	x
4346  0340 200c          	jra	L7562
4347  0342               L5662:
4348                     ; 361 						else if(page_n.ins_row == 4)/*回零*/
4350  0342 b602          	ld	a,_page_n+2
4351  0344 a104          	cp	a,#4
4352  0346 2606          	jrne	L7562
4353                     ; 363 							Back_Zero(&Dr_Num_Save);
4355  0348 ae0009        	ldw	x,#_Dr_Num_Save
4356  034b cd0000        	call	_Back_Zero
4358  034e               L7562:
4359                     ; 365 						page_n.ins_row = 0;
4361  034e 3f02          	clr	_page_n+2
4362  0350               L1362:
4363                     ; 368 				if(page_n.page == 4)/*设置*/
4365  0350 b600          	ld	a,_page_n
4366  0352 a104          	cp	a,#4
4367  0354 261e          	jrne	L3762
4368                     ; 370 					if(Encoder == 0)/*开关编码器*/
4370  0356 3d0d          	tnz	_Encoder
4371  0358 260f          	jrne	L5762
4372                     ; 372 						Encoder = 1;
4374  035a 3501000d      	mov	_Encoder,#1
4375                     ; 373 						Eeprom_Write(5,Encoder);
4377  035e b60d          	ld	a,_Encoder
4378  0360 97            	ld	xl,a
4379  0361 a605          	ld	a,#5
4380  0363 95            	ld	xh,a
4381  0364 cd0000        	call	_Eeprom_Write
4384  0367 200b          	jra	L3762
4385  0369               L5762:
4386                     ; 377 						Encoder = 0;
4388  0369 3f0d          	clr	_Encoder
4389                     ; 378 						Eeprom_Write(5,Encoder);
4391  036b b60d          	ld	a,_Encoder
4392  036d 97            	ld	xl,a
4393  036e a605          	ld	a,#5
4394  0370 95            	ld	xh,a
4395  0371 cd0000        	call	_Eeprom_Write
4397  0374               L3762:
4398                     ; 381 				Menu_Host(2,addre,RsBuffer,Dr_Num_Save,&page_n);
4400  0374 ae0000        	ldw	x,#_page_n
4401  0377 89            	pushw	x
4402  0378 3b0009        	push	_Dr_Num_Save
4403  037b ae0032        	ldw	x,#_RsBuffer
4404  037e 89            	pushw	x
4405  037f b602          	ld	a,_addre
4406  0381 97            	ld	xl,a
4407  0382 a602          	ld	a,#2
4408  0384 95            	ld	xh,a
4409  0385 cd0000        	call	_Menu_Host
4411  0388 5b05          	addw	sp,#5
4412  038a               L5262:
4413                     ; 383 			page_n.ts_ok_cnt = 0;
4415  038a 5f            	clrw	x
4416  038b bf09          	ldw	_page_n+9,x
4417  038d               L1452:
4418                     ; 386 		if(page_n.page == 5)
4420  038d b600          	ld	a,_page_n
4421  038f a105          	cp	a,#5
4422  0391 2703          	jreq	L23
4423  0393 cc04a7        	jp	L1072
4424  0396               L23:
4425                     ; 388 			if(T2msFlg >= 400)
4427  0396 be0d          	ldw	x,_T2msFlg
4428  0398 a30190        	cpw	x,#400
4429  039b 2403          	jruge	L43
4430  039d cc04a7        	jp	L1072
4431  03a0               L43:
4432                     ; 390 				T2msFlg = 0;
4434  03a0 5f            	clrw	x
4435  03a1 bf0d          	ldw	_T2msFlg,x
4436                     ; 391 				if(dis_play == 0)
4438                     	btst	_dis_play
4439  03a8 2403          	jruge	L63
4440  03aa cc045b        	jp	L5072
4441  03ad               L63:
4442                     ; 393 					dis_play = 1;
4444  03ad 72100003      	bset	_dis_play
4445                     ; 394 					if(page_n.ins_row == 1)
4447  03b1 b602          	ld	a,_page_n+2
4448  03b3 a101          	cp	a,#1
4449  03b5 2633          	jrne	L7072
4450                     ; 396 						Display_LCD_String_XY(0,6,":",1);
4452  03b7 4b01          	push	#1
4453  03b9 ae0034        	ldw	x,#L1172
4454  03bc 89            	pushw	x
4455  03bd ae0006        	ldw	x,#6
4456  03c0 4f            	clr	a
4457  03c1 95            	ld	xh,a
4458  03c2 cd0000        	call	_Display_LCD_String_XY
4460  03c5 5b03          	addw	sp,#3
4461                     ; 397 						Write_LCD_Data(0x30+page_n.dr_num/10);
4463  03c7 b603          	ld	a,_page_n+3
4464  03c9 ae000a        	ldw	x,#10
4465  03cc 51            	exgw	x,y
4466  03cd 5f            	clrw	x
4467  03ce 97            	ld	xl,a
4468  03cf 65            	divw	x,y
4469  03d0 9f            	ld	a,xl
4470  03d1 ab30          	add	a,#48
4471  03d3 cd0000        	call	_Write_LCD_Data
4473                     ; 398 						Write_LCD_Data(0x30+page_n.dr_num%10);
4475  03d6 b603          	ld	a,_page_n+3
4476  03d8 ae000a        	ldw	x,#10
4477  03db 51            	exgw	x,y
4478  03dc 5f            	clrw	x
4479  03dd 97            	ld	xl,a
4480  03de 65            	divw	x,y
4481  03df 909f          	ld	a,yl
4482  03e1 ab30          	add	a,#48
4483  03e3 cd0000        	call	_Write_LCD_Data
4486  03e6 aca704a7      	jpf	L1072
4487  03ea               L7072:
4488                     ; 400 					else if(page_n.ins_row == 2)
4490  03ea b602          	ld	a,_page_n+2
4491  03ec a102          	cp	a,#2
4492  03ee 2633          	jrne	L5172
4493                     ; 402 						Display_LCD_String_XY(1,6,":",1);
4495  03f0 4b01          	push	#1
4496  03f2 ae0034        	ldw	x,#L1172
4497  03f5 89            	pushw	x
4498  03f6 ae0006        	ldw	x,#6
4499  03f9 a601          	ld	a,#1
4500  03fb 95            	ld	xh,a
4501  03fc cd0000        	call	_Display_LCD_String_XY
4503  03ff 5b03          	addw	sp,#3
4504                     ; 403 						Write_LCD_Data(0x30+page_n.rb_num/10);
4506  0401 b604          	ld	a,_page_n+4
4507  0403 ae000a        	ldw	x,#10
4508  0406 51            	exgw	x,y
4509  0407 5f            	clrw	x
4510  0408 97            	ld	xl,a
4511  0409 65            	divw	x,y
4512  040a 9f            	ld	a,xl
4513  040b ab30          	add	a,#48
4514  040d cd0000        	call	_Write_LCD_Data
4516                     ; 404 						Write_LCD_Data(0x30+page_n.rb_num%10);
4518  0410 b604          	ld	a,_page_n+4
4519  0412 ae000a        	ldw	x,#10
4520  0415 51            	exgw	x,y
4521  0416 5f            	clrw	x
4522  0417 97            	ld	xl,a
4523  0418 65            	divw	x,y
4524  0419 909f          	ld	a,yl
4525  041b ab30          	add	a,#48
4526  041d cd0000        	call	_Write_LCD_Data
4529  0420 cc04a7        	jra	L1072
4530  0423               L5172:
4531                     ; 406 					else if(page_n.ins_row == 3)
4533  0423 b602          	ld	a,_page_n+2
4534  0425 a103          	cp	a,#3
4535  0427 267e          	jrne	L1072
4536                     ; 408 						Display_LCD_String_XY(2,6,":",1);
4538  0429 4b01          	push	#1
4539  042b ae0034        	ldw	x,#L1172
4540  042e 89            	pushw	x
4541  042f ae0006        	ldw	x,#6
4542  0432 a602          	ld	a,#2
4543  0434 95            	ld	xh,a
4544  0435 cd0000        	call	_Display_LCD_String_XY
4546  0438 5b03          	addw	sp,#3
4547                     ; 409 						Write_LCD_Data(0x30+page_n.rb_num/10);
4549  043a b604          	ld	a,_page_n+4
4550  043c ae000a        	ldw	x,#10
4551  043f 51            	exgw	x,y
4552  0440 5f            	clrw	x
4553  0441 97            	ld	xl,a
4554  0442 65            	divw	x,y
4555  0443 9f            	ld	a,xl
4556  0444 ab30          	add	a,#48
4557  0446 cd0000        	call	_Write_LCD_Data
4559                     ; 410 						Write_LCD_Data(0x30+page_n.rb_num%10);
4561  0449 b604          	ld	a,_page_n+4
4562  044b ae000a        	ldw	x,#10
4563  044e 51            	exgw	x,y
4564  044f 5f            	clrw	x
4565  0450 97            	ld	xl,a
4566  0451 65            	divw	x,y
4567  0452 909f          	ld	a,yl
4568  0454 ab30          	add	a,#48
4569  0456 cd0000        	call	_Write_LCD_Data
4571  0459 204c          	jra	L1072
4572  045b               L5072:
4573                     ; 415 					dis_play = 0;
4575  045b 72110003      	bres	_dis_play
4576                     ; 416 					if(page_n.ins_row == 1)
4578  045f b602          	ld	a,_page_n+2
4579  0461 a101          	cp	a,#1
4580  0463 2612          	jrne	L5272
4581                     ; 418 						Display_LCD_String_XY(0,6,":  ",1);
4583  0465 4b01          	push	#1
4584  0467 ae0030        	ldw	x,#L7272
4585  046a 89            	pushw	x
4586  046b ae0006        	ldw	x,#6
4587  046e 4f            	clr	a
4588  046f 95            	ld	xh,a
4589  0470 cd0000        	call	_Display_LCD_String_XY
4591  0473 5b03          	addw	sp,#3
4593  0475 2030          	jra	L1072
4594  0477               L5272:
4595                     ; 420 					else if(page_n.ins_row == 2)
4597  0477 b602          	ld	a,_page_n+2
4598  0479 a102          	cp	a,#2
4599  047b 2613          	jrne	L3372
4600                     ; 422 						Display_LCD_String_XY(1,6,":  ",1);
4602  047d 4b01          	push	#1
4603  047f ae0030        	ldw	x,#L7272
4604  0482 89            	pushw	x
4605  0483 ae0006        	ldw	x,#6
4606  0486 a601          	ld	a,#1
4607  0488 95            	ld	xh,a
4608  0489 cd0000        	call	_Display_LCD_String_XY
4610  048c 5b03          	addw	sp,#3
4612  048e 2017          	jra	L1072
4613  0490               L3372:
4614                     ; 424 					else if(page_n.ins_row == 3)
4616  0490 b602          	ld	a,_page_n+2
4617  0492 a103          	cp	a,#3
4618  0494 2611          	jrne	L1072
4619                     ; 426 						Display_LCD_String_XY(2,6,":  ",1);
4621  0496 4b01          	push	#1
4622  0498 ae0030        	ldw	x,#L7272
4623  049b 89            	pushw	x
4624  049c ae0006        	ldw	x,#6
4625  049f a602          	ld	a,#2
4626  04a1 95            	ld	xh,a
4627  04a2 cd0000        	call	_Display_LCD_String_XY
4629  04a5 5b03          	addw	sp,#3
4630  04a7               L1072:
4631                     ; 432 		if(jxs_out == 1)
4633                     	btst	_jxs_out
4634  04ac 2411          	jruge	L1472
4635                     ; 434 			if(bu_Flag == 1)
4637  04ae b60b          	ld	a,_bu_Flag
4638  04b0 a101          	cp	a,#1
4639  04b2 260b          	jrne	L1472
4640                     ; 436 				if(but_sw == 0)//按钮被按下
4642                     	btst	_IPD4
4643  04b9 2504          	jrult	L1472
4644                     ; 438 					but_Flag = 1;//按钮按下
4646  04bb 72100001      	bset	_but_Flag
4647  04bf               L1472:
4648                     ; 443 		if(c_ok_Flag == 1)
4650                     	btst	_c_ok_Flag
4651  04c4 2503          	jrult	L04
4652  04c6 cc0955        	jp	L7472
4653  04c9               L04:
4654                     ; 445 			UART_interrupt(1,0);/*关闭串口1中断*/
4656  04c9 5f            	clrw	x
4657  04ca a601          	ld	a,#1
4658  04cc 95            	ld	xh,a
4659  04cd cd0000        	call	_UART_interrupt
4661                     ; 446 			if(Com_Check(RsBuffer,addre))/*校验判断*/
4663  04d0 3b0002        	push	_addre
4664  04d3 ae0032        	ldw	x,#_RsBuffer
4665  04d6 cd0000        	call	_Com_Check
4667  04d9 5b01          	addw	sp,#1
4668  04db 4d            	tnz	a
4669  04dc 2603          	jrne	L24
4670  04de cc093d        	jp	L1572
4671  04e1               L24:
4672                     ; 449 				UART3_Send(TsBuffer,CORRECT,ok);
4674  04e1 4b01          	push	#1
4675  04e3 4b88          	push	#136
4676  04e5 ae0022        	ldw	x,#_TsBuffer
4677  04e8 cd0000        	call	_UART3_Send
4679  04eb 85            	popw	x
4680                     ; 451 				WDT();//清看门狗
4682  04ec 35aa50e0      	mov	_IWDG_KR,#170
4683                     ; 453 				switch(RsBuffer[0])/*判断命令*/
4685  04f0 b632          	ld	a,_RsBuffer
4687                     ; 729 					default:
4687                     ; 730 						break;
4688  04f2 a012          	sub	a,#18
4689  04f4 a114          	cp	a,#20
4690  04f6 2407          	jruge	L21
4691  04f8 5f            	clrw	x
4692  04f9 97            	ld	xl,a
4693  04fa 58            	sllw	x
4694  04fb de0008        	ldw	x,(L41,x)
4695  04fe fc            	jp	(x)
4696  04ff               L21:
4697  04ff a035          	sub	a,#53
4698  0501 2603          	jrne	L44
4699  0503 cc0906        	jp	L3232
4700  0506               L44:
4701  0506 4a            	dec	a
4702  0507 2603          	jrne	L64
4703  0509 cc091f        	jp	L5232
4704  050c               L64:
4705  050c 4a            	dec	a
4706  050d 2603          	jrne	L05
4707  050f cc092c        	jp	L7232
4708  0512               L05:
4709  0512 a00c          	sub	a,#12
4710  0514 2603          	jrne	L25
4711  0516 cc0605        	jp	L3722
4712  0519               L25:
4713  0519 a022          	sub	a,#34
4714  051b 2603          	jrne	L45
4715  051d cc08b6        	jp	L1232
4716  0520               L45:
4717  0520 ac480948      	jpf	L7503
4718  0524               L7622:
4719                     ; 459 					case Detection_barrier:
4719                     ; 460 						Menu_Host(Detection_barrier,addre,RsBuffer,
4719                     ; 461 												Dr_Num_Save,&page_n);/*显示*/
4721  0524 ae0000        	ldw	x,#_page_n
4722  0527 89            	pushw	x
4723  0528 3b0009        	push	_Dr_Num_Save
4724  052b ae0032        	ldw	x,#_RsBuffer
4725  052e 89            	pushw	x
4726  052f b602          	ld	a,_addre
4727  0531 97            	ld	xl,a
4728  0532 a624          	ld	a,#36
4729  0534 95            	ld	xh,a
4730  0535 cd0000        	call	_Menu_Host
4732  0538 5b05          	addw	sp,#5
4733                     ; 462 						Shield_sava(RsBuffer);
4735  053a ae0032        	ldw	x,#_RsBuffer
4736  053d cd0000        	call	_Shield_sava
4738                     ; 463 						if(Bar_Read(TsBuffer))/*检测阻挡*/
4740  0540 ae0022        	ldw	x,#_TsBuffer
4741  0543 cd0000        	call	_Bar_Read
4743  0546 4d            	tnz	a
4744  0547 2722          	jreq	L7572
4745                     ; 466 							UART3_Send(TsBuffer,Detection_barrier,ok);
4747  0549 4b01          	push	#1
4748  054b 4b24          	push	#36
4749  054d ae0022        	ldw	x,#_TsBuffer
4750  0550 cd0000        	call	_UART3_Send
4752  0553 85            	popw	x
4753                     ; 467 							Menu_Host(Detection_barrier,0,
4753                     ; 468 														RsBuffer,0,&page_n);/*显示*/
4755  0554 ae0000        	ldw	x,#_page_n
4756  0557 89            	pushw	x
4757  0558 4b00          	push	#0
4758  055a ae0032        	ldw	x,#_RsBuffer
4759  055d 89            	pushw	x
4760  055e 5f            	clrw	x
4761  055f a624          	ld	a,#36
4762  0561 95            	ld	xh,a
4763  0562 cd0000        	call	_Menu_Host
4765  0565 5b05          	addw	sp,#5
4767  0567 ac480948      	jpf	L7503
4768  056b               L7572:
4769                     ; 473 							UART3_Send(TsBuffer,Detection_barrier,no);
4771  056b 4b00          	push	#0
4772  056d 4b24          	push	#36
4773  056f ae0022        	ldw	x,#_TsBuffer
4774  0572 cd0000        	call	_UART3_Send
4776  0575 85            	popw	x
4777                     ; 474 							Menu_Host(Detection_barrier,hd_num,
4777                     ; 475 														RsBuffer,1,&page_n);/*显示*/
4779  0576 ae0000        	ldw	x,#_page_n
4780  0579 89            	pushw	x
4781  057a 4b01          	push	#1
4782  057c ae0032        	ldw	x,#_RsBuffer
4783  057f 89            	pushw	x
4784  0580 b600          	ld	a,_hd_num
4785  0582 97            	ld	xl,a
4786  0583 a624          	ld	a,#36
4787  0585 95            	ld	xh,a
4788  0586 cd0000        	call	_Menu_Host
4790  0589 5b05          	addw	sp,#5
4791  058b ac480948      	jpf	L7503
4792  058f               L1722:
4793                     ; 479 					case rawer_back_sta:
4793                     ; 480 						Shield_sava(RsBuffer);
4795  058f ae0032        	ldw	x,#_RsBuffer
4796  0592 cd0000        	call	_Shield_sava
4798                     ; 481 						cheak_wait = 40;//快速检测
4800  0595 35280000      	mov	_cheak_wait,#40
4801                     ; 482 						place_sta = 0;
4803  0599 0f02          	clr	(OFST-1,sp)
4804                     ; 483 						for(i_count = 1;i_count < 11;i_count++)
4806  059b a601          	ld	a,#1
4807  059d 6b03          	ld	(OFST+0,sp),a
4808  059f               L3672:
4809                     ; 485 							rawer_back_judge(&rb_Flag,R_TsBuffer,R_RsBuffer,
4809                     ; 486 														i_count,&Rc_ok_Flag,&place_sava);
4811  059f ae000e        	ldw	x,#_place_sava
4812  05a2 89            	pushw	x
4813  05a3 ae0004        	ldw	x,#_Rc_ok_Flag
4814  05a6 89            	pushw	x
4815  05a7 7b07          	ld	a,(OFST+4,sp)
4816  05a9 88            	push	a
4817  05aa ae001a        	ldw	x,#_R_RsBuffer
4818  05ad 89            	pushw	x
4819  05ae ae0012        	ldw	x,#_R_TsBuffer
4820  05b1 89            	pushw	x
4821  05b2 ae0007        	ldw	x,#_rb_Flag
4822  05b5 cd0000        	call	_rawer_back_judge
4824  05b8 5b09          	addw	sp,#9
4825                     ; 487 							if(S_buf[i_count-1] == 1)
4827  05ba 7b03          	ld	a,(OFST+0,sp)
4828  05bc 5f            	clrw	x
4829  05bd 97            	ld	xl,a
4830  05be 5a            	decw	x
4831  05bf e611          	ld	a,(_S_buf,x)
4832  05c1 a101          	cp	a,#1
4833  05c3 2610          	jrne	L1772
4834                     ; 489 								place_sta += place_sava;
4836  05c5 7b02          	ld	a,(OFST-1,sp)
4837  05c7 bb0e          	add	a,_place_sava
4838  05c9 6b02          	ld	(OFST-1,sp),a
4839                     ; 490 								TsBuffer[i_count] = place_sava;
4841  05cb 7b03          	ld	a,(OFST+0,sp)
4842  05cd 5f            	clrw	x
4843  05ce 97            	ld	xl,a
4844  05cf b60e          	ld	a,_place_sava
4845  05d1 e722          	ld	(_TsBuffer,x),a
4847  05d3 2006          	jra	L3772
4848  05d5               L1772:
4849                     ; 494 								TsBuffer[i_count] = 0;
4851  05d5 7b03          	ld	a,(OFST+0,sp)
4852  05d7 5f            	clrw	x
4853  05d8 97            	ld	xl,a
4854  05d9 6f22          	clr	(_TsBuffer,x)
4855  05db               L3772:
4856                     ; 483 						for(i_count = 1;i_count < 11;i_count++)
4858  05db 0c03          	inc	(OFST+0,sp)
4861  05dd 7b03          	ld	a,(OFST+0,sp)
4862  05df a10b          	cp	a,#11
4863  05e1 25bc          	jrult	L3672
4864                     ; 497 						if(place_sta == 0)
4866  05e3 0d02          	tnz	(OFST-1,sp)
4867  05e5 260f          	jrne	L5772
4868                     ; 499 							UART3_Send(TsBuffer,rawer_back_sta,ok);
4870  05e7 4b01          	push	#1
4871  05e9 4b25          	push	#37
4872  05eb ae0022        	ldw	x,#_TsBuffer
4873  05ee cd0000        	call	_UART3_Send
4875  05f1 85            	popw	x
4877  05f2 ac480948      	jpf	L7503
4878  05f6               L5772:
4879                     ; 503 							UART3_Send(TsBuffer,rawer_back_sta,no);
4881  05f6 4b00          	push	#0
4882  05f8 4b25          	push	#37
4883  05fa ae0022        	ldw	x,#_TsBuffer
4884  05fd cd0000        	call	_UART3_Send
4886  0600 85            	popw	x
4887  0601 ac480948      	jpf	L7503
4888  0605               L3722:
4889                     ; 507 					case Reboot:
4889                     ; 508 						/*返回正常，无重启*/
4889                     ; 509 						UART3_Send(TsBuffer,Reboot,ok);
4891  0605 4b01          	push	#1
4892  0607 4b55          	push	#85
4893  0609 ae0022        	ldw	x,#_TsBuffer
4894  060c cd0000        	call	_UART3_Send
4896  060f 85            	popw	x
4897                     ; 510 						break;
4899  0610 ac480948      	jpf	L7503
4900  0614               L5722:
4901                     ; 512 					case Back_zero:
4901                     ; 513 						Menu_Host(Back_zero,addre,RsBuffer,
4901                     ; 514 											Dr_Num_Save,&page_n);/*显示*/
4903  0614 ae0000        	ldw	x,#_page_n
4904  0617 89            	pushw	x
4905  0618 3b0009        	push	_Dr_Num_Save
4906  061b ae0032        	ldw	x,#_RsBuffer
4907  061e 89            	pushw	x
4908  061f b602          	ld	a,_addre
4909  0621 97            	ld	xl,a
4910  0622 a612          	ld	a,#18
4911  0624 95            	ld	xh,a
4912  0625 cd0000        	call	_Menu_Host
4914  0628 5b05          	addw	sp,#5
4915                     ; 515 						WDT();//清看门狗
4917  062a 35aa50e0      	mov	_IWDG_KR,#170
4918                     ; 516 						if(Bar_Read(TsBuffer))/*检测阻挡*/
4920  062e ae0022        	ldw	x,#_TsBuffer
4921  0631 cd0000        	call	_Bar_Read
4923  0634 4d            	tnz	a
4924  0635 272b          	jreq	L1003
4925                     ; 518 							place_sta = 0;
4927  0637 7b02          	ld	a,(OFST-1,sp)
4928  0639 97            	ld	xl,a
4929                     ; 532 								if(Back_Zero(&Dr_Num_Save) == CORRECT)
4931  063a ae0009        	ldw	x,#_Dr_Num_Save
4932  063d cd0000        	call	_Back_Zero
4934  0640 a188          	cp	a,#136
4935  0642 260f          	jrne	L3003
4936                     ; 534 									UART3_Send(TsBuffer,Back_zero,ok);
4938  0644 4b01          	push	#1
4939  0646 4b12          	push	#18
4940  0648 ae0022        	ldw	x,#_TsBuffer
4941  064b cd0000        	call	_UART3_Send
4943  064e 85            	popw	x
4945  064f ac480948      	jpf	L7503
4946  0653               L3003:
4947                     ; 539 									UART3_Send(TsBuffer,Back_zero,no);
4949  0653 4b00          	push	#0
4950  0655 4b12          	push	#18
4951  0657 ae0022        	ldw	x,#_TsBuffer
4952  065a cd0000        	call	_UART3_Send
4954  065d 85            	popw	x
4955  065e ac480948      	jpf	L7503
4956  0662               L1003:
4957                     ; 549 							UART3_Send(TsBuffer,Back_zero,no);
4959  0662 4b00          	push	#0
4960  0664 4b12          	push	#18
4961  0666 ae0022        	ldw	x,#_TsBuffer
4962  0669 cd0000        	call	_UART3_Send
4964  066c 85            	popw	x
4965  066d ac480948      	jpf	L7503
4966  0671               L7722:
4967                     ; 553 					case Motor_rotation:
4967                     ; 554 						Menu_Host(Motor_rotation,addre,RsBuffer,
4967                     ; 555 												Dr_Num_Save,&page_n);/*显示*/
4969  0671 ae0000        	ldw	x,#_page_n
4970  0674 89            	pushw	x
4971  0675 3b0009        	push	_Dr_Num_Save
4972  0678 ae0032        	ldw	x,#_RsBuffer
4973  067b 89            	pushw	x
4974  067c b602          	ld	a,_addre
4975  067e 97            	ld	xl,a
4976  067f a613          	ld	a,#19
4977  0681 95            	ld	xh,a
4978  0682 cd0000        	call	_Menu_Host
4980  0685 5b05          	addw	sp,#5
4981                     ; 556 						WDT();//清看门狗
4983  0687 35aa50e0      	mov	_IWDG_KR,#170
4984                     ; 557 						if(Bar_Read(TsBuffer))/*检测阻挡*/
4986  068b ae0022        	ldw	x,#_TsBuffer
4987  068e cd0000        	call	_Bar_Read
4989  0691 4d            	tnz	a
4990  0692 277c          	jreq	L1103
4991                     ; 559 							place_sta = 0;
4993  0694 7b02          	ld	a,(OFST-1,sp)
4994  0696 97            	ld	xl,a
4995                     ; 572 								abs_num = _Servo_C(RsBuffer[1],&Dr_Num_Save);/*旋转*/
4997  0697 ae0009        	ldw	x,#_Dr_Num_Save
4998  069a 89            	pushw	x
4999  069b b633          	ld	a,_RsBuffer+1
5000  069d cd0000        	call	__Servo_C
5002  06a0 85            	popw	x
5003  06a1 6b01          	ld	(OFST-2,sp),a
5004                     ; 574 								if(Encoder == 0)/*开启编码器*/	
5006  06a3 3d0d          	tnz	_Encoder
5007  06a5 265a          	jrne	L3103
5008                     ; 576 									if(abs_num > 0)
5010  06a7 0d01          	tnz	(OFST-2,sp)
5011  06a9 2747          	jreq	L5103
5012                     ; 578 										if ( abs(abs(Encoder_count/abs_num)-Encoder_hz) > 30  )
5014  06ab 9c            	rvf
5015  06ac be1b          	ldw	x,_Encoder_count
5016  06ae 7b01          	ld	a,(OFST-2,sp)
5017  06b0 62            	div	x,a
5018  06b1 cd0000        	call	_abs
5020  06b4 1d003e        	subw	x,#62
5021  06b7 cd0000        	call	_abs
5023  06ba a3001f        	cpw	x,#31
5024  06bd 2f24          	jrslt	L7103
5025                     ; 580 											UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
5027  06bf 4b00          	push	#0
5028  06c1 4b13          	push	#19
5029  06c3 ae0022        	ldw	x,#_TsBuffer
5030  06c6 cd0000        	call	_UART3_Send
5032  06c9 85            	popw	x
5033                     ; 581 											Menu_Host(3,addre,RsBuffer,
5033                     ; 582 															156,&page_n);/*显示*/
5035  06ca ae0000        	ldw	x,#_page_n
5036  06cd 89            	pushw	x
5037  06ce 4b9c          	push	#156
5038  06d0 ae0032        	ldw	x,#_RsBuffer
5039  06d3 89            	pushw	x
5040  06d4 b602          	ld	a,_addre
5041  06d6 97            	ld	xl,a
5042  06d7 a603          	ld	a,#3
5043  06d9 95            	ld	xh,a
5044  06da cd0000        	call	_Menu_Host
5046  06dd 5b05          	addw	sp,#5
5048  06df ac480948      	jpf	L7503
5049  06e3               L7103:
5050                     ; 586 											UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
5052  06e3 4b01          	push	#1
5053  06e5 4b13          	push	#19
5054  06e7 ae0022        	ldw	x,#_TsBuffer
5055  06ea cd0000        	call	_UART3_Send
5057  06ed 85            	popw	x
5058  06ee ac480948      	jpf	L7503
5059  06f2               L5103:
5060                     ; 591 										UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
5062  06f2 4b01          	push	#1
5063  06f4 4b13          	push	#19
5064  06f6 ae0022        	ldw	x,#_TsBuffer
5065  06f9 cd0000        	call	_UART3_Send
5067  06fc 85            	popw	x
5068  06fd ac480948      	jpf	L7503
5069  0701               L3103:
5070                     ; 596 									UART3_Send(TsBuffer,Motor_rotation,ok);/*返回命*/
5072  0701 4b01          	push	#1
5073  0703 4b13          	push	#19
5074  0705 ae0022        	ldw	x,#_TsBuffer
5075  0708 cd0000        	call	_UART3_Send
5077  070b 85            	popw	x
5078  070c ac480948      	jpf	L7503
5079  0710               L1103:
5080                     ; 606 							UART3_Send(TsBuffer,Motor_rotation,no);/*返回命*/
5082  0710 4b00          	push	#0
5083  0712 4b13          	push	#19
5084  0714 ae0022        	ldw	x,#_TsBuffer
5085  0717 cd0000        	call	_UART3_Send
5087  071a 85            	popw	x
5088  071b ac480948      	jpf	L7503
5089  071f               L1032:
5090                     ; 610 					case Whether_receipt:
5090                     ; 611 						if(hd_num >= 4)
5092  071f b600          	ld	a,_hd_num
5093  0721 a104          	cp	a,#4
5094  0723 2524          	jrult	L1303
5095                     ; 614 							UART3_Send(TsBuffer,Whether_receipt,no);
5097  0725 4b00          	push	#0
5098  0727 4b18          	push	#24
5099  0729 ae0022        	ldw	x,#_TsBuffer
5100  072c cd0000        	call	_UART3_Send
5102  072f 85            	popw	x
5103                     ; 615 							Menu_Host(Whether_receipt,hd_num,
5103                     ; 616 														RsBuffer,1,&page_n);/*显示*/
5105  0730 ae0000        	ldw	x,#_page_n
5106  0733 89            	pushw	x
5107  0734 4b01          	push	#1
5108  0736 ae0032        	ldw	x,#_RsBuffer
5109  0739 89            	pushw	x
5110  073a b600          	ld	a,_hd_num
5111  073c 97            	ld	xl,a
5112  073d a618          	ld	a,#24
5113  073f 95            	ld	xh,a
5114  0740 cd0000        	call	_Menu_Host
5116  0743 5b05          	addw	sp,#5
5118  0745 ac480948      	jpf	L7503
5119  0749               L1303:
5120                     ; 621 							UART3_Send(TsBuffer,Whether_receipt,ok);
5122  0749 4b01          	push	#1
5123  074b 4b18          	push	#24
5124  074d ae0022        	ldw	x,#_TsBuffer
5125  0750 cd0000        	call	_UART3_Send
5127  0753 85            	popw	x
5128                     ; 622 							Menu_Host(Whether_receipt,hd_num,
5128                     ; 623 														RsBuffer,0,&page_n);/*显示*/
5130  0754 ae0000        	ldw	x,#_page_n
5131  0757 89            	pushw	x
5132  0758 4b00          	push	#0
5133  075a ae0032        	ldw	x,#_RsBuffer
5134  075d 89            	pushw	x
5135  075e b600          	ld	a,_hd_num
5136  0760 97            	ld	xl,a
5137  0761 a618          	ld	a,#24
5138  0763 95            	ld	xh,a
5139  0764 cd0000        	call	_Menu_Host
5141  0767 5b05          	addw	sp,#5
5142  0769 ac480948      	jpf	L7503
5143  076d               L3032:
5144                     ; 627 					case Button_enabled:
5144                     ; 628 						bu_Flag = 1;/*使能按钮*/
5146  076d 3501000b      	mov	_bu_Flag,#1
5147                     ; 629 						UART3_Send(TsBuffer,Button_enabled,ok);
5149  0771 4b01          	push	#1
5150  0773 4b21          	push	#33
5151  0775 ae0022        	ldw	x,#_TsBuffer
5152  0778 cd0000        	call	_UART3_Send
5154  077b 85            	popw	x
5155                     ; 630 						break;
5157  077c ac480948      	jpf	L7503
5158  0780               L5032:
5159                     ; 632 					case Button_not_enabled:
5159                     ; 633 						bu_Flag = 0;/*不使能按钮*/
5161  0780 3f0b          	clr	_bu_Flag
5162                     ; 634 						UART3_Send(TsBuffer,Button_not_enabled,ok);
5164  0782 4b01          	push	#1
5165  0784 4b22          	push	#34
5166  0786 ae0022        	ldw	x,#_TsBuffer
5167  0789 cd0000        	call	_UART3_Send
5169  078c 85            	popw	x
5170                     ; 635 						break;
5172  078d ac480948      	jpf	L7503
5173  0791               L7032:
5174                     ; 637 					case Button_detection:
5174                     ; 638 						if(but_Flag == 0)
5176                     	btst	_but_Flag
5177  0796 250f          	jrult	L5303
5178                     ; 641 							UART3_Send(TsBuffer,Button_detection,no);
5180  0798 4b00          	push	#0
5181  079a 4b23          	push	#35
5182  079c ae0022        	ldw	x,#_TsBuffer
5183  079f cd0000        	call	_UART3_Send
5185  07a2 85            	popw	x
5187  07a3 ac480948      	jpf	L7503
5188  07a7               L5303:
5189                     ; 646 							UART3_Send(TsBuffer,Button_detection,ok);
5191  07a7 4b01          	push	#1
5192  07a9 4b23          	push	#35
5193  07ab ae0022        	ldw	x,#_TsBuffer
5194  07ae cd0000        	call	_UART3_Send
5196  07b1 85            	popw	x
5197  07b2 ac480948      	jpf	L7503
5198  07b6               L1132:
5199                     ; 650 					case Drawer_out:
5199                     ; 651 						cheak_wait = 200;//快速检测
5201  07b6 35c80000      	mov	_cheak_wait,#200
5202                     ; 652 						Menu_Host(Drawer_out,addre,RsBuffer,
5202                     ; 653 												Dr_Num_Save,&page_n);/*显示*/
5204  07ba ae0000        	ldw	x,#_page_n
5205  07bd 89            	pushw	x
5206  07be 3b0009        	push	_Dr_Num_Save
5207  07c1 ae0032        	ldw	x,#_RsBuffer
5208  07c4 89            	pushw	x
5209  07c5 b602          	ld	a,_addre
5210  07c7 97            	ld	xl,a
5211  07c8 a614          	ld	a,#20
5212  07ca 95            	ld	xh,a
5213  07cb cd0000        	call	_Menu_Host
5215  07ce 5b05          	addw	sp,#5
5216                     ; 654 						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
5216                     ; 655 															RsBuffer,Drawer_out,&Rc_ok_Flag);
5218  07d0 ae0004        	ldw	x,#_Rc_ok_Flag
5219  07d3 89            	pushw	x
5220  07d4 4b14          	push	#20
5221  07d6 ae0032        	ldw	x,#_RsBuffer
5222  07d9 89            	pushw	x
5223  07da ae0022        	ldw	x,#_TsBuffer
5224  07dd 89            	pushw	x
5225  07de ae001a        	ldw	x,#_R_RsBuffer
5226  07e1 89            	pushw	x
5227  07e2 ae0012        	ldw	x,#_R_TsBuffer
5228  07e5 89            	pushw	x
5229  07e6 ae0007        	ldw	x,#_rb_Flag
5230  07e9 cd0000        	call	_Drawer_cont
5232  07ec 5b0b          	addw	sp,#11
5233                     ; 656 						rebot_dr = RsBuffer[1];
5235  07ee 453300        	mov	_rebot_dr,_RsBuffer+1
5236                     ; 657 						eeprom_count(r_sive_n+((rebot_dr-1)*5));
5238  07f1 b600          	ld	a,_rebot_dr
5239  07f3 97            	ld	xl,a
5240  07f4 a605          	ld	a,#5
5241  07f6 42            	mul	x,a
5242  07f7 9f            	ld	a,xl
5243  07f8 ab0a          	add	a,#10
5244  07fa cd0000        	call	_eeprom_count
5246                     ; 658 						if(bu_Flag == 1)
5248  07fd b60b          	ld	a,_bu_Flag
5249  07ff a101          	cp	a,#1
5250  0801 2604          	jrne	L1403
5251                     ; 660 							but_led = 0;/*打开LED*/
5253  0803 7217500f      	bres	_OPD3
5254  0807               L1403:
5255                     ; 662 						jxs_out = 1;//机械手出去
5257  0807 72100004      	bset	_jxs_out
5258                     ; 663 						break;
5260  080b ac480948      	jpf	L7503
5261  080f               L3132:
5262                     ; 665 					case Drawer_back:
5262                     ; 666 Drawer_back_1:
5262                     ; 667 						cheak_wait = 200;//快速检测
5264  080f 35c80000      	mov	_cheak_wait,#200
5265                     ; 668 						Menu_Host(Drawer_back,addre,RsBuffer,
5265                     ; 669 												Dr_Num_Save,&page_n);/*显示*/
5267  0813 ae0000        	ldw	x,#_page_n
5268  0816 89            	pushw	x
5269  0817 3b0009        	push	_Dr_Num_Save
5270  081a ae0032        	ldw	x,#_RsBuffer
5271  081d 89            	pushw	x
5272  081e b602          	ld	a,_addre
5273  0820 97            	ld	xl,a
5274  0821 a616          	ld	a,#22
5275  0823 95            	ld	xh,a
5276  0824 cd0000        	call	_Menu_Host
5278  0827 5b05          	addw	sp,#5
5279                     ; 670 						R_TsBuffer[1] = rebot_dr;
5281  0829 450013        	mov	_R_TsBuffer+1,_rebot_dr
5282                     ; 671 						rb_Flag = 1;/*初始化状态标志位*/
5284  082c 35010007      	mov	_rb_Flag,#1
5285                     ; 672 						if(RsBuffer[2] == 0)//第一次拉回的时候才清楚回单值 避免失去回单 2015/7/32改  凌海滨
5287  0830 3d34          	tnz	_RsBuffer+2
5288  0832 2604          	jrne	L3403
5289                     ; 674 							hd_num = 0;/*清除回单状态*/
5291  0834 3f00          	clr	_hd_num
5292                     ; 675 							fr_Flag = 0;/*初始化回单标志位*/
5294  0836 3f0a          	clr	_fr_Flag
5295  0838               L3403:
5296                     ; 677 						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
5296                     ; 678 												 RsBuffer,Drawer_back,&Rc_ok_Flag);									
5298  0838 ae0004        	ldw	x,#_Rc_ok_Flag
5299  083b 89            	pushw	x
5300  083c 4b16          	push	#22
5301  083e ae0032        	ldw	x,#_RsBuffer
5302  0841 89            	pushw	x
5303  0842 ae0022        	ldw	x,#_TsBuffer
5304  0845 89            	pushw	x
5305  0846 ae001a        	ldw	x,#_R_RsBuffer
5306  0849 89            	pushw	x
5307  084a ae0012        	ldw	x,#_R_TsBuffer
5308  084d 89            	pushw	x
5309  084e ae0007        	ldw	x,#_rb_Flag
5310  0851 cd0000        	call	_Drawer_cont
5312  0854 5b0b          	addw	sp,#11
5313                     ; 679 						mirro = 0;
5315  0856 3f0c          	clr	_mirro
5316                     ; 680 						rebot_dr = 0;
5318  0858 3f00          	clr	_rebot_dr
5319                     ; 681 						but_led = 1;/*关闭led*/
5321  085a 7216500f      	bset	_OPD3
5322                     ; 682 						jxs_out = 0;//机械手回来
5324  085e 72110004      	bres	_jxs_out
5325                     ; 683 						but_Flag = 0;//清楚按钮按下
5327  0862 72110001      	bres	_but_Flag
5328                     ; 684 						break;
5330  0866 ac480948      	jpf	L7503
5331  086a               L5132:
5332                     ; 686 					case Drawer_out_place:
5332                     ; 687 						cheak_wait = 40;//快速检测
5334  086a 35280000      	mov	_cheak_wait,#40
5335                     ; 688 						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
5335                     ; 689 												RsBuffer,Drawer_out_place,&Rc_ok_Flag);
5337  086e ae0004        	ldw	x,#_Rc_ok_Flag
5338  0871 89            	pushw	x
5339  0872 4b15          	push	#21
5340  0874 ae0032        	ldw	x,#_RsBuffer
5341  0877 89            	pushw	x
5342  0878 ae0022        	ldw	x,#_TsBuffer
5343  087b 89            	pushw	x
5344  087c ae001a        	ldw	x,#_R_RsBuffer
5345  087f 89            	pushw	x
5346  0880 ae0012        	ldw	x,#_R_TsBuffer
5347  0883 89            	pushw	x
5348  0884 ae0007        	ldw	x,#_rb_Flag
5349  0887 cd0000        	call	_Drawer_cont
5351  088a 5b0b          	addw	sp,#11
5352                     ; 690 						break;
5354  088c ac480948      	jpf	L7503
5355  0890               L7132:
5356                     ; 692 					case Drawer_back_place:
5356                     ; 693 						cheak_wait = 40;//快速检测
5358  0890 35280000      	mov	_cheak_wait,#40
5359                     ; 694 						Drawer_cont(&rb_Flag,R_TsBuffer,R_RsBuffer,TsBuffer,
5359                     ; 695 													RsBuffer,Drawer_back_place,&Rc_ok_Flag);
5361  0894 ae0004        	ldw	x,#_Rc_ok_Flag
5362  0897 89            	pushw	x
5363  0898 4b17          	push	#23
5364  089a ae0032        	ldw	x,#_RsBuffer
5365  089d 89            	pushw	x
5366  089e ae0022        	ldw	x,#_TsBuffer
5367  08a1 89            	pushw	x
5368  08a2 ae001a        	ldw	x,#_R_RsBuffer
5369  08a5 89            	pushw	x
5370  08a6 ae0012        	ldw	x,#_R_TsBuffer
5371  08a9 89            	pushw	x
5372  08aa ae0007        	ldw	x,#_rb_Flag
5373  08ad cd0000        	call	_Drawer_cont
5375  08b0 5b0b          	addw	sp,#11
5376                     ; 696 						break;
5378  08b2 ac480948      	jpf	L7503
5379  08b6               L1232:
5380                     ; 698 					case ask_count:
5380                     ; 699 						UART1_Send(R_TsBuffer,Check_num,RsBuffer[1]);
5382  08b6 3b0033        	push	_RsBuffer+1
5383  08b9 4b46          	push	#70
5384  08bb ae0012        	ldw	x,#_R_TsBuffer
5385  08be cd0000        	call	_UART1_Send
5387  08c1 85            	popw	x
5388                     ; 700 						UART_interrupt(0,1);/*使能串口1接收中断*/
5390  08c2 ae0001        	ldw	x,#1
5391  08c5 4f            	clr	a
5392  08c6 95            	ld	xh,a
5393  08c7 cd0000        	call	_UART_interrupt
5395                     ; 701 						cheak_wait_count = 0;
5397  08ca 5f            	clrw	x
5398  08cb bf1d          	ldw	_cheak_wait_count,x
5400  08cd 2023          	jra	L1503
5401  08cf               L5403:
5402                     ; 704 							if(Rc_ok_Flag == 1)
5404  08cf b604          	ld	a,_Rc_ok_Flag
5405  08d1 a101          	cp	a,#1
5406  08d3 2616          	jrne	L5503
5407                     ; 706 								TsBuffer[1] = R_RsBuffer[2];
5409  08d5 451c23        	mov	_TsBuffer+1,_R_RsBuffer+2
5410                     ; 707 								TsBuffer[2] = R_RsBuffer[3];
5412  08d8 451d24        	mov	_TsBuffer+2,_R_RsBuffer+3
5413                     ; 708 								TsBuffer[3] = R_RsBuffer[4];
5415  08db 451e25        	mov	_TsBuffer+3,_R_RsBuffer+4
5416                     ; 709 								TsBuffer[4] = R_RsBuffer[5];
5418  08de 451f26        	mov	_TsBuffer+4,_R_RsBuffer+5
5419                     ; 710 								TsBuffer[5] = R_RsBuffer[6];
5421  08e1 452027        	mov	_TsBuffer+5,_R_RsBuffer+6
5422                     ; 711 								Rc_ok_Flag = 0;
5424  08e4 3f04          	clr	_Rc_ok_Flag
5425                     ; 712 								cheak_wait_count = 65534;
5427  08e6 aefffe        	ldw	x,#65534
5428  08e9 bf1d          	ldw	_cheak_wait_count,x
5429  08eb               L5503:
5430                     ; 714 							cheak_wait_count++;
5432  08eb be1d          	ldw	x,_cheak_wait_count
5433  08ed 1c0001        	addw	x,#1
5434  08f0 bf1d          	ldw	_cheak_wait_count,x
5435  08f2               L1503:
5436                     ; 702 						while((cheak_wait_count < 26000))
5438  08f2 be1d          	ldw	x,_cheak_wait_count
5439  08f4 a36590        	cpw	x,#26000
5440  08f7 25d6          	jrult	L5403
5441                     ; 716 						UART3_Send(TsBuffer,ask_count,ok);
5443  08f9 4b01          	push	#1
5444  08fb 4b77          	push	#119
5445  08fd ae0022        	ldw	x,#_TsBuffer
5446  0900 cd0000        	call	_UART3_Send
5448  0903 85            	popw	x
5449                     ; 717 						break;
5451  0904 2042          	jra	L7503
5452  0906               L3232:
5453                     ; 718 					case Check_num_zero:
5453                     ; 719 						UART1_Send(R_TsBuffer,Check_num_zero,RsBuffer[1]);
5455  0906 3b0033        	push	_RsBuffer+1
5456  0909 4b47          	push	#71
5457  090b ae0012        	ldw	x,#_R_TsBuffer
5458  090e cd0000        	call	_UART1_Send
5460  0911 85            	popw	x
5461                     ; 720 						UART3_Send(TsBuffer,Check_num_zero,ok);
5463  0912 4b01          	push	#1
5464  0914 4b47          	push	#71
5465  0916 ae0022        	ldw	x,#_TsBuffer
5466  0919 cd0000        	call	_UART3_Send
5468  091c 85            	popw	x
5469                     ; 721 						break;
5471  091d 2029          	jra	L7503
5472  091f               L5232:
5473                     ; 722 					case 0x48:
5473                     ; 723 						UART1_Send(R_TsBuffer,0x48,Check_num_zero);
5475  091f 4b47          	push	#71
5476  0921 4b48          	push	#72
5477  0923 ae0012        	ldw	x,#_R_TsBuffer
5478  0926 cd0000        	call	_UART1_Send
5480  0929 85            	popw	x
5481                     ; 724 						break;
5483  092a 201c          	jra	L7503
5484  092c               L7232:
5485                     ; 725 					case 0x49:
5485                     ; 726 						UART1_Send(R_TsBuffer,0x49,Check_num_zero);
5487  092c 4b47          	push	#71
5488  092e 4b49          	push	#73
5489  0930 ae0012        	ldw	x,#_R_TsBuffer
5490  0933 cd0000        	call	_UART1_Send
5492  0936 85            	popw	x
5493                     ; 727 						break;
5495  0937 200f          	jra	L7503
5496  0939               L1332:
5497                     ; 729 					default:
5497                     ; 730 						break;
5499  0939 200d          	jra	L7503
5500  093b               L5572:
5502  093b 200b          	jra	L7503
5503  093d               L1572:
5504                     ; 735 				UART3_Send(TsBuffer,ERROR,no);/*校验错误*/
5506  093d 4b00          	push	#0
5507  093f 4b44          	push	#68
5508  0941 ae0022        	ldw	x,#_TsBuffer
5509  0944 cd0000        	call	_UART3_Send
5511  0947 85            	popw	x
5512  0948               L7503:
5513                     ; 737 			c_ok_Flag = 0;/*命令完成，开始接收下一个命令*/
5515  0948 72110000      	bres	_c_ok_Flag
5516                     ; 738 			UART_interrupt(1,1);/*使能串口1中断*/
5518  094c ae0001        	ldw	x,#1
5519  094f a601          	ld	a,#1
5520  0951 95            	ld	xh,a
5521  0952 cd0000        	call	_UART_interrupt
5523  0955               L7472:
5524                     ; 741 		if(rebot_dr > 0)/*丛机机械手出来成功*/
5526  0955 3d00          	tnz	_rebot_dr
5527  0957 2724          	jreq	L1603
5528                     ; 743 			UART_interrupt(0,1);/*使能串口1接收中断*/
5530  0959 ae0001        	ldw	x,#1
5531  095c 4f            	clr	a
5532  095d 95            	ld	xh,a
5533  095e cd0000        	call	_UART_interrupt
5535                     ; 744 			if(Rc_ok_Flag == 1)
5537  0961 b604          	ld	a,_Rc_ok_Flag
5538  0963 a101          	cp	a,#1
5539  0965 2616          	jrne	L1603
5540                     ; 746 				if(R_RsBuffer[2] == 0x0a)
5542  0967 b61c          	ld	a,_R_RsBuffer+2
5543  0969 a10a          	cp	a,#10
5544  096b 2610          	jrne	L1603
5545                     ; 748 					if(R_RsBuffer[1] == 0x09)
5547  096d b61b          	ld	a,_R_RsBuffer+1
5548  096f a109          	cp	a,#9
5549  0971 260a          	jrne	L1603
5550                     ; 750 						Rc_ok_Flag = 0;
5552  0973 3f04          	clr	_Rc_ok_Flag
5553                     ; 751 						mirro = 1;
5555  0975 3501000c      	mov	_mirro,#1
5556                     ; 752 						goto Drawer_back_1;
5558  0979 ac0f080f      	jpf	L3132
5559  097d               L1603:
5560                     ; 758 		if(T1msFlg >= 400)
5562  097d be0f          	ldw	x,_T1msFlg
5563  097f a30190        	cpw	x,#400
5564  0982 2403          	jruge	L65
5565  0984 cc0062        	jp	L7632
5566  0987               L65:
5567                     ; 760 			T1msFlg = 0;
5569  0987 5f            	clrw	x
5570  0988 bf0f          	ldw	_T1msFlg,x
5571                     ; 761 			led_os = ~led_os;
5573  098a 9012500a      	bcpl	_OPC1
5574  098e ac620062      	jpf	L7632
5606                     ; 768 @far @interrupt void TIM1_UPD_OVF_IRQHandler (void)
5606                     ; 769 {
5608                     	switch	.text
5609  0992               f_TIM1_UPD_OVF_IRQHandler:
5613                     ; 770 	TIM1_SR1 &= (~0x01);        //清除中断标志
5615  0992 72115255      	bres	_TIM1_SR1,#0
5616                     ; 771 	T1msFlg++;
5618  0996 be0f          	ldw	x,_T1msFlg
5619  0998 1c0001        	addw	x,#1
5620  099b bf0f          	ldw	_T1msFlg,x
5621                     ; 772 	T2msFlg++;
5623  099d be0d          	ldw	x,_T2msFlg
5624  099f 1c0001        	addw	x,#1
5625  09a2 bf0d          	ldw	_T2msFlg,x
5626                     ; 773 	if(Encoder_bz == 1)/*开启编码器*/	
5628                     	btst	_Encoder_bz
5629  09a9 241e          	jruge	L3013
5630                     ; 775 		if(Encoder == 0)
5632  09ab 3d0d          	tnz	_Encoder
5633  09ad 261a          	jrne	L3013
5634                     ; 777 			if(bu_Encoder == 0)
5636                     	btst	_IPC4
5637  09b4 2511          	jrult	L7013
5638                     ; 779 				if(fr_Flag == 0)
5640  09b6 3d0a          	tnz	_fr_Flag
5641  09b8 260f          	jrne	L3013
5642                     ; 781 					fr_Flag = 1;
5644  09ba 3501000a      	mov	_fr_Flag,#1
5645                     ; 782 					Encoder_count++;
5647  09be be1b          	ldw	x,_Encoder_count
5648  09c0 1c0001        	addw	x,#1
5649  09c3 bf1b          	ldw	_Encoder_count,x
5650  09c5 2002          	jra	L3013
5651  09c7               L7013:
5652                     ; 787 				fr_Flag = 0;
5654  09c7 3f0a          	clr	_fr_Flag
5655  09c9               L3013:
5656                     ; 791 	return;
5659  09c9 80            	iret
5661                     	bsct
5662  001f               _ua_count:
5663  001f 00            	dc.b	0
5702                     ; 797 @far @interrupt void UART1_Recv_IRQHandler (void)
5702                     ; 798 {
5703                     	switch	.text
5704  09ca               f_UART1_Recv_IRQHandler:
5706       00000001      OFST:	set	1
5707  09ca 88            	push	a
5710                     ; 800 	ch=UART1_DR;
5712  09cb c65231        	ld	a,_UART1_DR
5713  09ce 6b01          	ld	(OFST+0,sp),a
5714                     ; 801 	if( Rc_ok_Flag == 0 )
5716  09d0 3d04          	tnz	_Rc_ok_Flag
5717  09d2 2634          	jrne	L3313
5718                     ; 803 		if(Rcom_Flag == 0)
5720  09d4 3d06          	tnz	_Rcom_Flag
5721  09d6 260e          	jrne	L5313
5722                     ; 805 			if(ch == c_head)
5724  09d8 7b01          	ld	a,(OFST+0,sp)
5725  09da a13a          	cp	a,#58
5726  09dc 262a          	jrne	L3313
5727                     ; 807 				Rcom_Flag = 1;
5729  09de 35010006      	mov	_Rcom_Flag,#1
5730                     ; 808 				Rcom_i = 0;
5732  09e2 3f05          	clr	_Rcom_i
5733  09e4 2022          	jra	L3313
5734  09e6               L5313:
5735                     ; 811 		else if(Rcom_Flag == 1)
5737  09e6 b606          	ld	a,_Rcom_Flag
5738  09e8 a101          	cp	a,#1
5739  09ea 261c          	jrne	L3313
5740                     ; 813 			R_RsBuffer[Rcom_i] = ch;
5742  09ec b605          	ld	a,_Rcom_i
5743  09ee 5f            	clrw	x
5744  09ef 97            	ld	xl,a
5745  09f0 7b01          	ld	a,(OFST+0,sp)
5746  09f2 e71a          	ld	(_R_RsBuffer,x),a
5747                     ; 814 			if(Rcom_i == 7)
5749  09f4 b605          	ld	a,_Rcom_i
5750  09f6 a107          	cp	a,#7
5751  09f8 260c          	jrne	L5413
5752                     ; 816 				Rcom_i = 0;
5754  09fa 3f05          	clr	_Rcom_i
5755                     ; 817 				Rcom_Flag = 0;
5757  09fc 3f06          	clr	_Rcom_Flag
5758                     ; 818 				Rc_ok_Flag = 1;
5760  09fe 35010004      	mov	_Rc_ok_Flag,#1
5761                     ; 819 				ua_count = 0;
5763  0a02 3f1f          	clr	_ua_count
5765  0a04 2002          	jra	L3313
5766  0a06               L5413:
5767                     ; 823 				Rcom_i++;
5769  0a06 3c05          	inc	_Rcom_i
5770  0a08               L3313:
5771                     ; 827 	return;
5774  0a08 84            	pop	a
5775  0a09 80            	iret
5815                     ; 832 @far @interrupt void UART3_Recv_IRQHandler (void)
5815                     ; 833 {
5816                     	switch	.text
5817  0a0a               f_UART3_Recv_IRQHandler:
5819       00000001      OFST:	set	1
5820  0a0a 88            	push	a
5823                     ; 835 	ch=UART3_DR;
5825  0a0b c65241        	ld	a,_UART3_DR
5826  0a0e 6b01          	ld	(OFST+0,sp),a
5827                     ; 836 	if(c_ok_Flag == 0)
5829                     	btst	_c_ok_Flag
5830  0a15 2548          	jrult	L7613
5831                     ; 838 		if(com_Flag == 0)
5833  0a17 3d03          	tnz	_com_Flag
5834  0a19 260e          	jrne	L1713
5835                     ; 840 			if(ch == c_head)
5837  0a1b 7b01          	ld	a,(OFST+0,sp)
5838  0a1d a13a          	cp	a,#58
5839  0a1f 263e          	jrne	L7613
5840                     ; 842 				com_Flag = 1;
5842  0a21 35010003      	mov	_com_Flag,#1
5843                     ; 843 				com_i = 0;
5845  0a25 3f01          	clr	_com_i
5846  0a27 2036          	jra	L7613
5847  0a29               L1713:
5848                     ; 846 		else if(com_Flag == 1)
5850  0a29 b603          	ld	a,_com_Flag
5851  0a2b a101          	cp	a,#1
5852  0a2d 2610          	jrne	L7713
5853                     ; 848 			if(addre == ch)
5855  0a2f b602          	ld	a,_addre
5856  0a31 1101          	cp	a,(OFST+0,sp)
5857  0a33 2606          	jrne	L1023
5858                     ; 850 				com_Flag = 2;
5860  0a35 35020003      	mov	_com_Flag,#2
5862  0a39 2024          	jra	L7613
5863  0a3b               L1023:
5864                     ; 854 				com_Flag = 0;
5866  0a3b 3f03          	clr	_com_Flag
5867  0a3d 2020          	jra	L7613
5868  0a3f               L7713:
5869                     ; 857 		else if(com_Flag == 2)
5871  0a3f b603          	ld	a,_com_Flag
5872  0a41 a102          	cp	a,#2
5873  0a43 261a          	jrne	L7613
5874                     ; 859 			RsBuffer[com_i] = ch;
5876  0a45 b601          	ld	a,_com_i
5877  0a47 5f            	clrw	x
5878  0a48 97            	ld	xl,a
5879  0a49 7b01          	ld	a,(OFST+0,sp)
5880  0a4b e732          	ld	(_RsBuffer,x),a
5881                     ; 860 			if(com_i == 13)
5883  0a4d b601          	ld	a,_com_i
5884  0a4f a10d          	cp	a,#13
5885  0a51 260a          	jrne	L1123
5886                     ; 862 				com_i = 0;
5888  0a53 3f01          	clr	_com_i
5889                     ; 863 				com_Flag = 0;
5891  0a55 3f03          	clr	_com_Flag
5892                     ; 864 				c_ok_Flag = 1;
5894  0a57 72100000      	bset	_c_ok_Flag
5896  0a5b 2002          	jra	L7613
5897  0a5d               L1123:
5898                     ; 868 				com_i++;
5900  0a5d 3c01          	inc	_com_i
5901  0a5f               L7613:
5902                     ; 872 	return;
5905  0a5f 84            	pop	a
5906  0a60 80            	iret
5908                     	bsct
5909  0020               _ts1_count:
5910  0020 00            	dc.b	0
5911  0021               _ts1_ok:
5912  0021 00            	dc.b	0
5941                     ; 879 @far @interrupt void UART1_Txcv_IRQHandler (void)
5941                     ; 880 {
5942                     	switch	.text
5943  0a61               f_UART1_Txcv_IRQHandler:
5947                     ; 882 	_asm("sim");//开中断，sim为关中断
5950  0a61 9b            sim
5952                     ; 883 	UART1_SR&= ~(1<<6);    //清除送完成状态位
5954  0a62 721d5230      	bres	_UART1_SR,#6
5955                     ; 884 	UART1_DR =  R_TsBuffer[ts1_count];
5957  0a66 b620          	ld	a,_ts1_count
5958  0a68 5f            	clrw	x
5959  0a69 97            	ld	xl,a
5960  0a6a e612          	ld	a,(_R_TsBuffer,x)
5961  0a6c c75231        	ld	_UART1_DR,a
5962                     ; 885 	if(ts1_count < 8)ts1_count++;
5964  0a6f b620          	ld	a,_ts1_count
5965  0a71 a108          	cp	a,#8
5966  0a73 2404          	jruge	L5223
5969  0a75 3c20          	inc	_ts1_count
5971  0a77 200c          	jra	L7223
5972  0a79               L5223:
5973                     ; 888 		ts1_count = 0;
5975  0a79 3f20          	clr	_ts1_count
5976                     ; 889 		rs485_dr1 = 0;
5978  0a7b 721d5000      	bres	_OPA6
5979                     ; 890 		UART1_CR2 &= ~BIT(6);//开发送完成中?
5981  0a7f 721d5235      	bres	_UART1_CR2,#6
5982                     ; 891 		ts1_ok = 0;
5984  0a83 3f21          	clr	_ts1_ok
5985  0a85               L7223:
5986                     ; 898 	_asm("rim");//开中断，sim为关中断
5989  0a85 9a            rim
5991                     ; 899 	return;
5994  0a86 80            	iret
5996                     	bsct
5997  0022               _ts3_count:
5998  0022 00            	dc.b	0
5999  0023               _ts3_ok:
6000  0023 00            	dc.b	0
6029                     ; 906 @far @interrupt void UART3_Txcv_IRQHandler (void)
6029                     ; 907 {
6030                     	switch	.text
6031  0a87               f_UART3_Txcv_IRQHandler:
6035                     ; 909 	_asm("sim");//开中断，sim为关中断
6038  0a87 9b            sim
6040                     ; 910 	UART3_SR&= ~(1<<6);    //清除送完成状态位
6042  0a88 721d5240      	bres	_UART3_SR,#6
6043                     ; 912 	UART3_DR = TsBuffer[ts3_count];
6045  0a8c b622          	ld	a,_ts3_count
6046  0a8e 5f            	clrw	x
6047  0a8f 97            	ld	xl,a
6048  0a90 e622          	ld	a,(_TsBuffer,x)
6049  0a92 c75241        	ld	_UART3_DR,a
6050                     ; 913 	if(ts3_count < 15)ts3_count++;
6052  0a95 b622          	ld	a,_ts3_count
6053  0a97 a10f          	cp	a,#15
6054  0a99 2404          	jruge	L1423
6057  0a9b 3c22          	inc	_ts3_count
6059  0a9d 200c          	jra	L3423
6060  0a9f               L1423:
6061                     ; 916 		ts3_count = 0;
6063  0a9f 3f22          	clr	_ts3_count
6064                     ; 917 		rs485_dr2 = 0;
6066  0aa1 721f500f      	bres	_OPD7
6067                     ; 918 		UART3_CR2 &= ~BIT(6);//开发送完成中?
6069  0aa5 721d5245      	bres	_UART3_CR2,#6
6070                     ; 919 		ts3_ok = 0;
6072  0aa9 3f23          	clr	_ts3_ok
6073  0aab               L3423:
6074                     ; 926 	_asm("rim");//开中断，sim为关中断
6077  0aab 9a            rim
6079                     ; 927 	return;
6082  0aac 80            	iret
6106                     ; 932 @far @interrupt void TIM2_UPD_OVF_IRQHandler (void)
6106                     ; 933 {
6107                     	switch	.text
6108  0aad               f_TIM2_UPD_OVF_IRQHandler:
6112                     ; 934 	TIM2_SR1 &= (~0x01);        //清除中断标志
6114  0aad 72115302      	bres	_TIM2_SR1,#0
6115                     ; 936 	return;
6118  0ab1 80            	iret
6156                     ; 955 @far @interrupt void TIM3_UPD_OVF_IRQHandler (void)
6156                     ; 956 {
6157                     	switch	.text
6158  0ab2               f_TIM3_UPD_OVF_IRQHandler:
6160  0ab2 be02          	ldw	x,c_lreg+2
6161  0ab4 89            	pushw	x
6162  0ab5 be00          	ldw	x,c_lreg
6163  0ab7 89            	pushw	x
6166                     ; 957 	_asm("sim");//开中断，sim为关中断
6169  0ab8 9b            sim
6171                     ; 958 	TIM3_SR1 &= (~0x01);        //清除中断标志
6173  0ab9 72115322      	bres	_TIM3_SR1,#0
6174                     ; 959 	TIM3_ARRH=timerlow[k]>>8;           
6176  0abd b600          	ld	a,_k
6177  0abf 5f            	clrw	x
6178  0ac0 97            	ld	xl,a
6179  0ac1 58            	sllw	x
6180  0ac2 ee00          	ldw	x,(_timerlow,x)
6181  0ac4 4f            	clr	a
6182  0ac5 01            	rrwa	x,a
6183  0ac6 01            	rrwa	x,a
6184  0ac7 c7532b        	ld	_TIM3_ARRH,a
6185  0aca 02            	rlwa	x,a
6186                     ; 960 	TIM3_ARRL=timerlow[k];	 //246
6188  0acb b600          	ld	a,_k
6189  0acd 5f            	clrw	x
6190  0ace 97            	ld	xl,a
6191  0acf 58            	sllw	x
6192  0ad0 e601          	ld	a,(_timerlow+1,x)
6193  0ad2 c7532c        	ld	_TIM3_ARRL,a
6194                     ; 961 	WDT();//清看门狗
6196  0ad5 35aa50e0      	mov	_IWDG_KR,#170
6197                     ; 962 	if(up_or_down == 1)
6199  0ad9 b600          	ld	a,_up_or_down
6200  0adb a101          	cp	a,#1
6201  0add 2630          	jrne	L5623
6202                     ; 964 		ksteps--;
6204  0adf be00          	ldw	x,_ksteps
6205  0ae1 1d0001        	subw	x,#1
6206  0ae4 bf00          	ldw	_ksteps,x
6207                     ; 965 		steps_count+=1;
6209  0ae6 ae0000        	ldw	x,#_steps_count
6210  0ae9 a601          	ld	a,#1
6211  0aeb cd0000        	call	c_lgadc
6213                     ; 966 		steps_count2+=2;          
6215  0aee ae0000        	ldw	x,#_steps_count2
6216  0af1 a602          	ld	a,#2
6217  0af3 cd0000        	call	c_lgadc
6219                     ; 967 		if(steps_count>=steps_half)
6221  0af6 ae0000        	ldw	x,#_steps_count
6222  0af9 cd0000        	call	c_ltor
6224  0afc ae0000        	ldw	x,#_steps_half
6225  0aff cd0000        	call	c_lcmp
6227  0b02 2507          	jrult	L7623
6228                     ; 969 			half_over=1;
6230  0b04 35010000      	mov	_half_over,#1
6231                     ; 970 			ksteps=0;
6233  0b08 5f            	clrw	x
6234  0b09 bf00          	ldw	_ksteps,x
6235  0b0b               L7623:
6236                     ; 972 		moto_hz = !moto_hz;
6238  0b0b 90165000      	bcpl	_OPA3
6239  0b0f               L5623:
6240                     ; 974 	if(up_or_down == 2)
6242  0b0f b600          	ld	a,_up_or_down
6243  0b11 a102          	cp	a,#2
6244  0b13 2614          	jrne	L1723
6245                     ; 976 		steps_keep_count-=1;
6247  0b15 ae0000        	ldw	x,#_steps_keep_count
6248  0b18 a601          	ld	a,#1
6249  0b1a cd0000        	call	c_lgsbc
6251                     ; 977 		steps_count+=1;
6253  0b1d ae0000        	ldw	x,#_steps_count
6254  0b20 a601          	ld	a,#1
6255  0b22 cd0000        	call	c_lgadc
6257                     ; 978 		moto_hz = !moto_hz;
6259  0b25 90165000      	bcpl	_OPA3
6260  0b29               L1723:
6261                     ; 980 	if(up_or_down == 3)
6263  0b29 b600          	ld	a,_up_or_down
6264  0b2b a103          	cp	a,#3
6265  0b2d 2624          	jrne	L3723
6266                     ; 982 		ksteps--;
6268  0b2f be00          	ldw	x,_ksteps
6269  0b31 1d0001        	subw	x,#1
6270  0b34 bf00          	ldw	_ksteps,x
6271                     ; 983 		steps_count=steps_count+1;
6273  0b36 ae0000        	ldw	x,#_steps_count
6274  0b39 a601          	ld	a,#1
6275  0b3b cd0000        	call	c_lgadc
6277                     ; 984 		if(steps_count>=steps) ksteps=0;
6279  0b3e ae0000        	ldw	x,#_steps_count
6280  0b41 cd0000        	call	c_ltor
6282  0b44 ae0000        	ldw	x,#_steps
6283  0b47 cd0000        	call	c_lcmp
6285  0b4a 2503          	jrult	L5723
6288  0b4c 5f            	clrw	x
6289  0b4d bf00          	ldw	_ksteps,x
6290  0b4f               L5723:
6291                     ; 985 		moto_hz = !moto_hz;
6293  0b4f 90165000      	bcpl	_OPA3
6294  0b53               L3723:
6295                     ; 987 	_asm("rim");//开中断，sim为关中断
6298  0b53 9a            rim
6300                     ; 988 }  
6303  0b54 85            	popw	x
6304  0b55 bf00          	ldw	c_lreg,x
6305  0b57 85            	popw	x
6306  0b58 bf02          	ldw	c_lreg+2,x
6307  0b5a 80            	iret
6735                     	xdef	f_TIM3_UPD_OVF_IRQHandler
6736                     	xref.b	_timerlow
6737                     	xref.b	_steps_keep_count
6738                     	xref.b	_steps_count2
6739                     	xref.b	_steps_count
6740                     	xref.b	_steps_half
6741                     	xref.b	_steps
6742                     	xref.b	_ksteps
6743                     	xref.b	_half_over
6744                     	xref.b	_up_or_down
6745                     	xref.b	_k
6746                     	xdef	f_TIM2_UPD_OVF_IRQHandler
6747                     	xdef	f_UART3_Txcv_IRQHandler
6748                     	xdef	_ts3_ok
6749                     	xdef	_ts3_count
6750                     	xdef	f_UART1_Txcv_IRQHandler
6751                     	xdef	_ts1_ok
6752                     	xdef	_ts1_count
6753                     	xdef	f_UART3_Recv_IRQHandler
6754                     	xdef	f_UART1_Recv_IRQHandler
6755                     	xdef	_ua_count
6756                     	xdef	f_TIM1_UPD_OVF_IRQHandler
6757                     	xdef	_main
6758                     	switch	.ubsct
6759  0000               _page_n:
6760  0000 000000000000  	ds.b	13
6761                     	xdef	_page_n
6762  000d               _T2msFlg:
6763  000d 0000          	ds.b	2
6764                     	xdef	_T2msFlg
6765  000f               _T1msFlg:
6766  000f 0000          	ds.b	2
6767                     	xdef	_T1msFlg
6768                     	xdef	_cheak_wait_count
6769                     	xref.b	_cheak_wait
6770                     	xdef	_jxs_out
6771                     	xdef	_Encoder_count
6772                     	xref.b	_hd_num
6773                     	xdef	_dis_play
6774                     	xdef	_Encoder_bz
6775                     	xdef	_S_buf
6776                     	xdef	_Shield
6777                     	xdef	_place_sava
6778                     	xdef	_Encoder
6779                     	xdef	_mirro
6780                     	xdef	_bu_Flag
6781                     	xdef	_fr_Flag
6782                     	xdef	_Dr_Num_Save
6783                     	xdef	_wr_new
6784                     	xdef	_rb_Flag
6785  0011               _SDr_Num_Save:
6786  0011 00            	ds.b	1
6787                     	xdef	_SDr_Num_Save
6788                     	xdef	_Rcom_Flag
6789                     	xdef	_Rcom_i
6790                     	xdef	_Rc_ok_Flag
6791                     	xdef	_com_Flag
6792                     	xdef	_addre
6793                     	xdef	_com_i
6794                     	xdef	_rebot_dr
6795                     	xdef	_but_Flag
6796                     	xdef	_c_ok_Flag
6797  0012               _R_TsBuffer:
6798  0012 000000000000  	ds.b	8
6799                     	xdef	_R_TsBuffer
6800  001a               _R_RsBuffer:
6801  001a 000000000000  	ds.b	8
6802                     	xdef	_R_RsBuffer
6803  0022               _TsBuffer:
6804  0022 000000000000  	ds.b	16
6805                     	xdef	_TsBuffer
6806  0032               _RsBuffer:
6807  0032 000000000000  	ds.b	16
6808                     	xdef	_RsBuffer
6809                     	xref	_jm_a
6810                     	xref	_abs
6811                     	xref	_eeprom_cle
6812                     	xref	_eeprom_count
6813                     	xref	_Menu_Host
6814                     	xref	_rawer_back_judge
6815                     	xref	_UART_interrupt
6816                     	xref	_UART1_Send
6817                     	xref	_UART3_Send
6818                     	xref	_UART3_Init
6819                     	xref	_UART1_Init
6820                     	xref	_Eeprom_Read
6821                     	xref	_Eeprom_Write
6822                     	xref	_Eeprom_Init
6823                     	xref	_Drawer_cont
6824                     	xref	__Servo_C
6825                     	xref	_Back_Zero
6826                     	xref	_Com_Check
6827                     	xref	_Bar_Read
6828                     	xref	_Addr_Read
6829                     	xref	_Shield_sava
6830                     	xref	_delayms
6831                     	xref	_BSP_Init
6832                     	xref	_Display_LCD_String_XY
6833                     	xref	_Draw_PM
6834                     	xref	_Write_LCD_Data
6835                     	xref	_LCD_Clear_BMP
6836                     	xref	_LCD12864_Init
6837                     	switch	.const
6838  0030               L7272:
6839  0030 3a202000      	dc.b	":  ",0
6840  0034               L1172:
6841  0034 3a00          	dc.b	":",0
6842                     	xref.b	c_lreg
6862                     	xref	c_lgsbc
6863                     	xref	c_ltor
6864                     	xref	c_lgadc
6865                     	xref	c_lcmp
6866                     	xref	c_uitolx
6867                     	end
