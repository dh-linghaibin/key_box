   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3563                     ; 11 void Menu_Host(u8 status,u8 address,u8 *Array_R,u8 dr_num,page_num *page_n)
3563                     ; 12 {
3565                     	switch	.text
3566  0000               _Menu_Host:
3568  0000 89            	pushw	x
3569       00000000      OFST:	set	0
3572                     ; 14 	if(page_n->page == 0)
3574  0001 1e08          	ldw	x,(OFST+8,sp)
3575  0003 7d            	tnz	(x)
3576  0004 2703          	jreq	L01
3577  0006 cc054b        	jp	L5042
3578  0009               L01:
3579                     ; 16 		switch(status)
3581  0009 7b01          	ld	a,(OFST+1,sp)
3583                     ; 137 			default:;
3584  000b a002          	sub	a,#2
3585  000d 2603          	jrne	L21
3586  000f cc01a8        	jp	L3722
3587  0012               L21:
3588  0012 4a            	dec	a
3589  0013 2603          	jrne	L41
3590  0015 cc029c        	jp	L5722
3591  0018               L41:
3592  0018 a00f          	sub	a,#15
3593  001a 2725          	jreq	L7622
3594  001c 4a            	dec	a
3595  001d 2603          	jrne	L61
3596  001f cc00f5        	jp	L1722
3597  0022               L61:
3598  0022 4a            	dec	a
3599  0023 2603          	jrne	L02
3600  0025 cc03e3        	jp	L3032
3601  0028               L02:
3602  0028 a002          	sub	a,#2
3603  002a 2603          	jrne	L22
3604  002c cc0495        	jp	L5032
3605  002f               L22:
3606  002f a002          	sub	a,#2
3607  0031 2603          	jrne	L42
3608  0033 cc02f4        	jp	L7722
3609  0036               L42:
3610  0036 a00c          	sub	a,#12
3611  0038 2603          	jrne	L62
3612  003a cc037a        	jp	L1032
3613  003d               L62:
3614  003d acf00df0      	jpf	L3152
3615  0041               L7622:
3616                     ; 18 			case Back_zero: 
3616                     ; 19 				Display_LCD_String_XY(0,0,"  ",0);
3618  0041 4b00          	push	#0
3619  0043 ae01a0        	ldw	x,#L3142
3620  0046 89            	pushw	x
3621  0047 5f            	clrw	x
3622  0048 4f            	clr	a
3623  0049 95            	ld	xh,a
3624  004a cd0000        	call	_Display_LCD_String_XY
3626  004d 5b03          	addw	sp,#3
3627                     ; 20 				Display_LCD_String_XY(3,0,"  ",0);
3629  004f 4b00          	push	#0
3630  0051 ae01a0        	ldw	x,#L3142
3631  0054 89            	pushw	x
3632  0055 5f            	clrw	x
3633  0056 a603          	ld	a,#3
3634  0058 95            	ld	xh,a
3635  0059 cd0000        	call	_Display_LCD_String_XY
3637  005c 5b03          	addw	sp,#3
3638                     ; 21 				Display_LCD_String_XY(1,0,"回",1);
3640  005e 4b01          	push	#1
3641  0060 ae019d        	ldw	x,#L5142
3642  0063 89            	pushw	x
3643  0064 5f            	clrw	x
3644  0065 a601          	ld	a,#1
3645  0067 95            	ld	xh,a
3646  0068 cd0000        	call	_Display_LCD_String_XY
3648  006b 5b03          	addw	sp,#3
3649                     ; 22 				Display_LCD_String_XY(2,0,"零",1);
3651  006d 4b01          	push	#1
3652  006f ae019a        	ldw	x,#L7142
3653  0072 89            	pushw	x
3654  0073 5f            	clrw	x
3655  0074 a602          	ld	a,#2
3656  0076 95            	ld	xh,a
3657  0077 cd0000        	call	_Display_LCD_String_XY
3659  007a 5b03          	addw	sp,#3
3660                     ; 23 				Display_LCD_String_XY(1,1,"  当前位置:",1);
3662  007c 4b01          	push	#1
3663  007e ae018e        	ldw	x,#L1242
3664  0081 89            	pushw	x
3665  0082 ae0001        	ldw	x,#1
3666  0085 a601          	ld	a,#1
3667  0087 95            	ld	xh,a
3668  0088 cd0000        	call	_Display_LCD_String_XY
3670  008b 5b03          	addw	sp,#3
3671                     ; 24 				Write_LCD_Data(0x30+dr_num/10);
3673  008d 7b07          	ld	a,(OFST+7,sp)
3674  008f ae000a        	ldw	x,#10
3675  0092 51            	exgw	x,y
3676  0093 5f            	clrw	x
3677  0094 97            	ld	xl,a
3678  0095 65            	divw	x,y
3679  0096 9f            	ld	a,xl
3680  0097 ab30          	add	a,#48
3681  0099 cd0000        	call	_Write_LCD_Data
3683                     ; 25 				Write_LCD_Data(0x30+dr_num%10);
3685  009c 7b07          	ld	a,(OFST+7,sp)
3686  009e ae000a        	ldw	x,#10
3687  00a1 51            	exgw	x,y
3688  00a2 5f            	clrw	x
3689  00a3 97            	ld	xl,a
3690  00a4 65            	divw	x,y
3691  00a5 909f          	ld	a,yl
3692  00a7 ab30          	add	a,#48
3693  00a9 cd0000        	call	_Write_LCD_Data
3695                     ; 26 				Display_LCD_String_XY(2,1,"  旋转位置:01 ",1);
3697  00ac 4b01          	push	#1
3698  00ae ae017f        	ldw	x,#L3242
3699  00b1 89            	pushw	x
3700  00b2 ae0001        	ldw	x,#1
3701  00b5 a602          	ld	a,#2
3702  00b7 95            	ld	xh,a
3703  00b8 cd0000        	call	_Display_LCD_String_XY
3705  00bb 5b03          	addw	sp,#3
3706                     ; 28 				Display_LCD_String_XY(1,1,"  抽屉位置:",1);
3708  00bd 4b01          	push	#1
3709  00bf ae0173        	ldw	x,#L5242
3710  00c2 89            	pushw	x
3711  00c3 ae0001        	ldw	x,#1
3712  00c6 a601          	ld	a,#1
3713  00c8 95            	ld	xh,a
3714  00c9 cd0000        	call	_Display_LCD_String_XY
3716  00cc 5b03          	addw	sp,#3
3717                     ; 29 				Write_LCD_Data(0x30+Array_R[1]/10);
3719  00ce 1e05          	ldw	x,(OFST+5,sp)
3720  00d0 e601          	ld	a,(1,x)
3721  00d2 ae000a        	ldw	x,#10
3722  00d5 51            	exgw	x,y
3723  00d6 5f            	clrw	x
3724  00d7 97            	ld	xl,a
3725  00d8 65            	divw	x,y
3726  00d9 9f            	ld	a,xl
3727  00da ab30          	add	a,#48
3728  00dc cd0000        	call	_Write_LCD_Data
3730                     ; 30 				Write_LCD_Data(0x30+Array_R[1]%10);
3732  00df 1e05          	ldw	x,(OFST+5,sp)
3733  00e1 e601          	ld	a,(1,x)
3734  00e3 ae000a        	ldw	x,#10
3735  00e6 51            	exgw	x,y
3736  00e7 5f            	clrw	x
3737  00e8 97            	ld	xl,a
3738  00e9 65            	divw	x,y
3739  00ea 909f          	ld	a,yl
3740  00ec ab30          	add	a,#48
3741  00ee cd0000        	call	_Write_LCD_Data
3743                     ; 31 			break;
3745  00f1 acf00df0      	jpf	L3152
3746  00f5               L1722:
3747                     ; 32 			case Motor_rotation:
3747                     ; 33 				Display_LCD_String_XY(0,0,"  ",0);
3749  00f5 4b00          	push	#0
3750  00f7 ae01a0        	ldw	x,#L3142
3751  00fa 89            	pushw	x
3752  00fb 5f            	clrw	x
3753  00fc 4f            	clr	a
3754  00fd 95            	ld	xh,a
3755  00fe cd0000        	call	_Display_LCD_String_XY
3757  0101 5b03          	addw	sp,#3
3758                     ; 34 				Display_LCD_String_XY(3,0,"  ",0);
3760  0103 4b00          	push	#0
3761  0105 ae01a0        	ldw	x,#L3142
3762  0108 89            	pushw	x
3763  0109 5f            	clrw	x
3764  010a a603          	ld	a,#3
3765  010c 95            	ld	xh,a
3766  010d cd0000        	call	_Display_LCD_String_XY
3768  0110 5b03          	addw	sp,#3
3769                     ; 35 				Display_LCD_String_XY(1,0,"旋",1);
3771  0112 4b01          	push	#1
3772  0114 ae0170        	ldw	x,#L7242
3773  0117 89            	pushw	x
3774  0118 5f            	clrw	x
3775  0119 a601          	ld	a,#1
3776  011b 95            	ld	xh,a
3777  011c cd0000        	call	_Display_LCD_String_XY
3779  011f 5b03          	addw	sp,#3
3780                     ; 36 				Display_LCD_String_XY(2,0,"转",1);
3782  0121 4b01          	push	#1
3783  0123 ae016d        	ldw	x,#L1342
3784  0126 89            	pushw	x
3785  0127 5f            	clrw	x
3786  0128 a602          	ld	a,#2
3787  012a 95            	ld	xh,a
3788  012b cd0000        	call	_Display_LCD_String_XY
3790  012e 5b03          	addw	sp,#3
3791                     ; 37 				Display_LCD_String_XY(0,1,"              ",1);
3793  0130 4b01          	push	#1
3794  0132 ae015e        	ldw	x,#L3342
3795  0135 89            	pushw	x
3796  0136 ae0001        	ldw	x,#1
3797  0139 4f            	clr	a
3798  013a 95            	ld	xh,a
3799  013b cd0000        	call	_Display_LCD_String_XY
3801  013e 5b03          	addw	sp,#3
3802                     ; 38 				Display_LCD_String_XY(1,1,"  当前位置:",1);
3804  0140 4b01          	push	#1
3805  0142 ae018e        	ldw	x,#L1242
3806  0145 89            	pushw	x
3807  0146 ae0001        	ldw	x,#1
3808  0149 a601          	ld	a,#1
3809  014b 95            	ld	xh,a
3810  014c cd0000        	call	_Display_LCD_String_XY
3812  014f 5b03          	addw	sp,#3
3813                     ; 39 				Write_LCD_Data(0x30+dr_num/10);
3815  0151 7b07          	ld	a,(OFST+7,sp)
3816  0153 ae000a        	ldw	x,#10
3817  0156 51            	exgw	x,y
3818  0157 5f            	clrw	x
3819  0158 97            	ld	xl,a
3820  0159 65            	divw	x,y
3821  015a 9f            	ld	a,xl
3822  015b ab30          	add	a,#48
3823  015d cd0000        	call	_Write_LCD_Data
3825                     ; 40 				Write_LCD_Data(0x30+dr_num%10);
3827  0160 7b07          	ld	a,(OFST+7,sp)
3828  0162 ae000a        	ldw	x,#10
3829  0165 51            	exgw	x,y
3830  0166 5f            	clrw	x
3831  0167 97            	ld	xl,a
3832  0168 65            	divw	x,y
3833  0169 909f          	ld	a,yl
3834  016b ab30          	add	a,#48
3835  016d cd0000        	call	_Write_LCD_Data
3837                     ; 42 				Display_LCD_String_XY(2,1,"  旋转位置:",1);
3839  0170 4b01          	push	#1
3840  0172 ae0152        	ldw	x,#L5342
3841  0175 89            	pushw	x
3842  0176 ae0001        	ldw	x,#1
3843  0179 a602          	ld	a,#2
3844  017b 95            	ld	xh,a
3845  017c cd0000        	call	_Display_LCD_String_XY
3847  017f 5b03          	addw	sp,#3
3848                     ; 43 				Write_LCD_Data(0x30+Array_R[1]/10);
3850  0181 1e05          	ldw	x,(OFST+5,sp)
3851  0183 e601          	ld	a,(1,x)
3852  0185 ae000a        	ldw	x,#10
3853  0188 51            	exgw	x,y
3854  0189 5f            	clrw	x
3855  018a 97            	ld	xl,a
3856  018b 65            	divw	x,y
3857  018c 9f            	ld	a,xl
3858  018d ab30          	add	a,#48
3859  018f cd0000        	call	_Write_LCD_Data
3861                     ; 44 				Write_LCD_Data(0x30+Array_R[1]%10);
3863  0192 1e05          	ldw	x,(OFST+5,sp)
3864  0194 e601          	ld	a,(1,x)
3865  0196 ae000a        	ldw	x,#10
3866  0199 51            	exgw	x,y
3867  019a 5f            	clrw	x
3868  019b 97            	ld	xl,a
3869  019c 65            	divw	x,y
3870  019d 909f          	ld	a,yl
3871  019f ab30          	add	a,#48
3872  01a1 cd0000        	call	_Write_LCD_Data
3874                     ; 45 				break;
3876  01a4 acf00df0      	jpf	L3152
3877  01a8               L3722:
3878                     ; 46 			case 2: 
3878                     ; 47 				Display_LCD_String_XY(0,0,"  ",0);
3880  01a8 4b00          	push	#0
3881  01aa ae01a0        	ldw	x,#L3142
3882  01ad 89            	pushw	x
3883  01ae 5f            	clrw	x
3884  01af 4f            	clr	a
3885  01b0 95            	ld	xh,a
3886  01b1 cd0000        	call	_Display_LCD_String_XY
3888  01b4 5b03          	addw	sp,#3
3889                     ; 48 				Display_LCD_String_XY(3,0,"  ",0);
3891  01b6 4b00          	push	#0
3892  01b8 ae01a0        	ldw	x,#L3142
3893  01bb 89            	pushw	x
3894  01bc 5f            	clrw	x
3895  01bd a603          	ld	a,#3
3896  01bf 95            	ld	xh,a
3897  01c0 cd0000        	call	_Display_LCD_String_XY
3899  01c3 5b03          	addw	sp,#3
3900                     ; 49 				Display_LCD_String_XY(1,0,"正",1);
3902  01c5 4b01          	push	#1
3903  01c7 ae014f        	ldw	x,#L7342
3904  01ca 89            	pushw	x
3905  01cb 5f            	clrw	x
3906  01cc a601          	ld	a,#1
3907  01ce 95            	ld	xh,a
3908  01cf cd0000        	call	_Display_LCD_String_XY
3910  01d2 5b03          	addw	sp,#3
3911                     ; 50 				Display_LCD_String_XY(2,0,"常",1);
3913  01d4 4b01          	push	#1
3914  01d6 ae014c        	ldw	x,#L1442
3915  01d9 89            	pushw	x
3916  01da 5f            	clrw	x
3917  01db a602          	ld	a,#2
3918  01dd 95            	ld	xh,a
3919  01de cd0000        	call	_Display_LCD_String_XY
3921  01e1 5b03          	addw	sp,#3
3922                     ; 52 				Display_LCD_String_XY(0,1,"  等待接收命令",1);
3924  01e3 4b01          	push	#1
3925  01e5 ae013d        	ldw	x,#L3442
3926  01e8 89            	pushw	x
3927  01e9 ae0001        	ldw	x,#1
3928  01ec 4f            	clr	a
3929  01ed 95            	ld	xh,a
3930  01ee cd0000        	call	_Display_LCD_String_XY
3932  01f1 5b03          	addw	sp,#3
3933                     ; 53 				Display_LCD_String_XY(1,1,"              ",1);
3935  01f3 4b01          	push	#1
3936  01f5 ae015e        	ldw	x,#L3342
3937  01f8 89            	pushw	x
3938  01f9 ae0001        	ldw	x,#1
3939  01fc a601          	ld	a,#1
3940  01fe 95            	ld	xh,a
3941  01ff cd0000        	call	_Display_LCD_String_XY
3943  0202 5b03          	addw	sp,#3
3944                     ; 54 				Display_LCD_String_XY(1,1,"  抽屉位置:",1);
3946  0204 4b01          	push	#1
3947  0206 ae0173        	ldw	x,#L5242
3948  0209 89            	pushw	x
3949  020a ae0001        	ldw	x,#1
3950  020d a601          	ld	a,#1
3951  020f 95            	ld	xh,a
3952  0210 cd0000        	call	_Display_LCD_String_XY
3954  0213 5b03          	addw	sp,#3
3955                     ; 55 				Write_LCD_Data(0x30+Array_R[1]/10);
3957  0215 1e05          	ldw	x,(OFST+5,sp)
3958  0217 e601          	ld	a,(1,x)
3959  0219 ae000a        	ldw	x,#10
3960  021c 51            	exgw	x,y
3961  021d 5f            	clrw	x
3962  021e 97            	ld	xl,a
3963  021f 65            	divw	x,y
3964  0220 9f            	ld	a,xl
3965  0221 ab30          	add	a,#48
3966  0223 cd0000        	call	_Write_LCD_Data
3968                     ; 56 				Write_LCD_Data(0x30+Array_R[1]%10);
3970  0226 1e05          	ldw	x,(OFST+5,sp)
3971  0228 e601          	ld	a,(1,x)
3972  022a ae000a        	ldw	x,#10
3973  022d 51            	exgw	x,y
3974  022e 5f            	clrw	x
3975  022f 97            	ld	xl,a
3976  0230 65            	divw	x,y
3977  0231 909f          	ld	a,yl
3978  0233 ab30          	add	a,#48
3979  0235 cd0000        	call	_Write_LCD_Data
3981                     ; 59 				Display_LCD_String_XY(2,1,"  当前位置:",1);
3983  0238 4b01          	push	#1
3984  023a ae018e        	ldw	x,#L1242
3985  023d 89            	pushw	x
3986  023e ae0001        	ldw	x,#1
3987  0241 a602          	ld	a,#2
3988  0243 95            	ld	xh,a
3989  0244 cd0000        	call	_Display_LCD_String_XY
3991  0247 5b03          	addw	sp,#3
3992                     ; 60 				Write_LCD_Data(0x30+dr_num/10);
3994  0249 7b07          	ld	a,(OFST+7,sp)
3995  024b ae000a        	ldw	x,#10
3996  024e 51            	exgw	x,y
3997  024f 5f            	clrw	x
3998  0250 97            	ld	xl,a
3999  0251 65            	divw	x,y
4000  0252 9f            	ld	a,xl
4001  0253 ab30          	add	a,#48
4002  0255 cd0000        	call	_Write_LCD_Data
4004                     ; 61 				Write_LCD_Data(0x30+dr_num%10);
4006  0258 7b07          	ld	a,(OFST+7,sp)
4007  025a ae000a        	ldw	x,#10
4008  025d 51            	exgw	x,y
4009  025e 5f            	clrw	x
4010  025f 97            	ld	xl,a
4011  0260 65            	divw	x,y
4012  0261 909f          	ld	a,yl
4013  0263 ab30          	add	a,#48
4014  0265 cd0000        	call	_Write_LCD_Data
4016                     ; 63 				Display_LCD_String_XY(3,1,"  本机编号:",1);
4018  0268 4b01          	push	#1
4019  026a ae0131        	ldw	x,#L5442
4020  026d 89            	pushw	x
4021  026e ae0001        	ldw	x,#1
4022  0271 a603          	ld	a,#3
4023  0273 95            	ld	xh,a
4024  0274 cd0000        	call	_Display_LCD_String_XY
4026  0277 5b03          	addw	sp,#3
4027                     ; 64 				Write_LCD_Data(0x30+address/10);
4029  0279 7b02          	ld	a,(OFST+2,sp)
4030  027b ae000a        	ldw	x,#10
4031  027e 51            	exgw	x,y
4032  027f 5f            	clrw	x
4033  0280 97            	ld	xl,a
4034  0281 65            	divw	x,y
4035  0282 9f            	ld	a,xl
4036  0283 ab30          	add	a,#48
4037  0285 cd0000        	call	_Write_LCD_Data
4039                     ; 65 				Write_LCD_Data(0x30+address%10);
4041  0288 7b02          	ld	a,(OFST+2,sp)
4042  028a ae000a        	ldw	x,#10
4043  028d 51            	exgw	x,y
4044  028e 5f            	clrw	x
4045  028f 97            	ld	xl,a
4046  0290 65            	divw	x,y
4047  0291 909f          	ld	a,yl
4048  0293 ab30          	add	a,#48
4049  0295 cd0000        	call	_Write_LCD_Data
4051                     ; 66 				break;
4053  0298 acf00df0      	jpf	L3152
4054  029c               L5722:
4055                     ; 67 			case 3:
4055                     ; 68 				Display_LCD_String_XY(0,0,"  ",0);
4057  029c 4b00          	push	#0
4058  029e ae01a0        	ldw	x,#L3142
4059  02a1 89            	pushw	x
4060  02a2 5f            	clrw	x
4061  02a3 4f            	clr	a
4062  02a4 95            	ld	xh,a
4063  02a5 cd0000        	call	_Display_LCD_String_XY
4065  02a8 5b03          	addw	sp,#3
4066                     ; 69 				Display_LCD_String_XY(3,0,"  ",0);
4068  02aa 4b00          	push	#0
4069  02ac ae01a0        	ldw	x,#L3142
4070  02af 89            	pushw	x
4071  02b0 5f            	clrw	x
4072  02b1 a603          	ld	a,#3
4073  02b3 95            	ld	xh,a
4074  02b4 cd0000        	call	_Display_LCD_String_XY
4076  02b7 5b03          	addw	sp,#3
4077                     ; 70 				Display_LCD_String_XY(1,0,"异",1);
4079  02b9 4b01          	push	#1
4080  02bb ae012e        	ldw	x,#L7442
4081  02be 89            	pushw	x
4082  02bf 5f            	clrw	x
4083  02c0 a601          	ld	a,#1
4084  02c2 95            	ld	xh,a
4085  02c3 cd0000        	call	_Display_LCD_String_XY
4087  02c6 5b03          	addw	sp,#3
4088                     ; 71 				Display_LCD_String_XY(2,0,"常",1);
4090  02c8 4b01          	push	#1
4091  02ca ae014c        	ldw	x,#L1442
4092  02cd 89            	pushw	x
4093  02ce 5f            	clrw	x
4094  02cf a602          	ld	a,#2
4095  02d1 95            	ld	xh,a
4096  02d2 cd0000        	call	_Display_LCD_String_XY
4098  02d5 5b03          	addw	sp,#3
4099                     ; 73 				if(dr_num == 156)
4101  02d7 7b07          	ld	a,(OFST+7,sp)
4102  02d9 a19c          	cp	a,#156
4103  02db 2703          	jreq	L03
4104  02dd cc0df0        	jp	L3152
4105  02e0               L03:
4106                     ; 75 					Display_LCD_String_XY(0,1,"  编码器异常",1);
4108  02e0 4b01          	push	#1
4109  02e2 ae0121        	ldw	x,#L3542
4110  02e5 89            	pushw	x
4111  02e6 ae0001        	ldw	x,#1
4112  02e9 4f            	clr	a
4113  02ea 95            	ld	xh,a
4114  02eb cd0000        	call	_Display_LCD_String_XY
4116  02ee 5b03          	addw	sp,#3
4117  02f0 acf00df0      	jpf	L3152
4118  02f4               L7722:
4119                     ; 79 			case Whether_receipt: /*检测回单*/
4119                     ; 80 				Display_LCD_String_XY(0,0,"  ",0);
4121  02f4 4b00          	push	#0
4122  02f6 ae01a0        	ldw	x,#L3142
4123  02f9 89            	pushw	x
4124  02fa 5f            	clrw	x
4125  02fb 4f            	clr	a
4126  02fc 95            	ld	xh,a
4127  02fd cd0000        	call	_Display_LCD_String_XY
4129  0300 5b03          	addw	sp,#3
4130                     ; 81 				Display_LCD_String_XY(3,0,"  ",0);
4132  0302 4b00          	push	#0
4133  0304 ae01a0        	ldw	x,#L3142
4134  0307 89            	pushw	x
4135  0308 5f            	clrw	x
4136  0309 a603          	ld	a,#3
4137  030b 95            	ld	xh,a
4138  030c cd0000        	call	_Display_LCD_String_XY
4140  030f 5b03          	addw	sp,#3
4141                     ; 82 				Display_LCD_String_XY(1,0,"回",1);
4143  0311 4b01          	push	#1
4144  0313 ae019d        	ldw	x,#L5142
4145  0316 89            	pushw	x
4146  0317 5f            	clrw	x
4147  0318 a601          	ld	a,#1
4148  031a 95            	ld	xh,a
4149  031b cd0000        	call	_Display_LCD_String_XY
4151  031e 5b03          	addw	sp,#3
4152                     ; 83 				Display_LCD_String_XY(2,0,"单",1);
4154  0320 4b01          	push	#1
4155  0322 ae011e        	ldw	x,#L5542
4156  0325 89            	pushw	x
4157  0326 5f            	clrw	x
4158  0327 a602          	ld	a,#2
4159  0329 95            	ld	xh,a
4160  032a cd0000        	call	_Display_LCD_String_XY
4162  032d 5b03          	addw	sp,#3
4163                     ; 84 				if(dr_num == 0)
4165  032f 0d07          	tnz	(OFST+7,sp)
4166  0331 2613          	jrne	L7542
4167                     ; 86 					Display_LCD_String_XY(1,1,"  有回单:  ",1);
4169  0333 4b01          	push	#1
4170  0335 ae0112        	ldw	x,#L1642
4171  0338 89            	pushw	x
4172  0339 ae0001        	ldw	x,#1
4173  033c a601          	ld	a,#1
4174  033e 95            	ld	xh,a
4175  033f cd0000        	call	_Display_LCD_String_XY
4177  0342 5b03          	addw	sp,#3
4179  0344 2011          	jra	L3642
4180  0346               L7542:
4181                     ; 90 					Display_LCD_String_XY(1,1,"  无回单:  ",1);
4183  0346 4b01          	push	#1
4184  0348 ae0106        	ldw	x,#L5642
4185  034b 89            	pushw	x
4186  034c ae0001        	ldw	x,#1
4187  034f a601          	ld	a,#1
4188  0351 95            	ld	xh,a
4189  0352 cd0000        	call	_Display_LCD_String_XY
4191  0355 5b03          	addw	sp,#3
4192  0357               L3642:
4193                     ; 92 				Write_LCD_Data(0x30+address/10);
4195  0357 7b02          	ld	a,(OFST+2,sp)
4196  0359 ae000a        	ldw	x,#10
4197  035c 51            	exgw	x,y
4198  035d 5f            	clrw	x
4199  035e 97            	ld	xl,a
4200  035f 65            	divw	x,y
4201  0360 9f            	ld	a,xl
4202  0361 ab30          	add	a,#48
4203  0363 cd0000        	call	_Write_LCD_Data
4205                     ; 93 				Write_LCD_Data(0x30+address%10);
4207  0366 7b02          	ld	a,(OFST+2,sp)
4208  0368 ae000a        	ldw	x,#10
4209  036b 51            	exgw	x,y
4210  036c 5f            	clrw	x
4211  036d 97            	ld	xl,a
4212  036e 65            	divw	x,y
4213  036f 909f          	ld	a,yl
4214  0371 ab30          	add	a,#48
4215  0373 cd0000        	call	_Write_LCD_Data
4217                     ; 94 			break;
4219  0376 acf00df0      	jpf	L3152
4220  037a               L1032:
4221                     ; 95 			case Detection_barrier:
4221                     ; 96 				Display_LCD_String_XY(0,0,"检",1);
4223  037a 4b01          	push	#1
4224  037c ae0103        	ldw	x,#L7642
4225  037f 89            	pushw	x
4226  0380 5f            	clrw	x
4227  0381 4f            	clr	a
4228  0382 95            	ld	xh,a
4229  0383 cd0000        	call	_Display_LCD_String_XY
4231  0386 5b03          	addw	sp,#3
4232                     ; 97 				Display_LCD_String_XY(1,0,"测",1);
4234  0388 4b01          	push	#1
4235  038a ae0100        	ldw	x,#L1742
4236  038d 89            	pushw	x
4237  038e 5f            	clrw	x
4238  038f a601          	ld	a,#1
4239  0391 95            	ld	xh,a
4240  0392 cd0000        	call	_Display_LCD_String_XY
4242  0395 5b03          	addw	sp,#3
4243                     ; 98 				Display_LCD_String_XY(2,0,"阻",1);
4245  0397 4b01          	push	#1
4246  0399 ae00fd        	ldw	x,#L3742
4247  039c 89            	pushw	x
4248  039d 5f            	clrw	x
4249  039e a602          	ld	a,#2
4250  03a0 95            	ld	xh,a
4251  03a1 cd0000        	call	_Display_LCD_String_XY
4253  03a4 5b03          	addw	sp,#3
4254                     ; 99 				Display_LCD_String_XY(3,0,"档",1);
4256  03a6 4b01          	push	#1
4257  03a8 ae00fa        	ldw	x,#L5742
4258  03ab 89            	pushw	x
4259  03ac 5f            	clrw	x
4260  03ad a603          	ld	a,#3
4261  03af 95            	ld	xh,a
4262  03b0 cd0000        	call	_Display_LCD_String_XY
4264  03b3 5b03          	addw	sp,#3
4265                     ; 100 				if(dr_num == 0)
4267  03b5 0d07          	tnz	(OFST+7,sp)
4268  03b7 2615          	jrne	L7742
4269                     ; 102 					Display_LCD_String_XY(1,1,"  无阻挡正常 ",1);
4271  03b9 4b01          	push	#1
4272  03bb ae00ec        	ldw	x,#L1052
4273  03be 89            	pushw	x
4274  03bf ae0001        	ldw	x,#1
4275  03c2 a601          	ld	a,#1
4276  03c4 95            	ld	xh,a
4277  03c5 cd0000        	call	_Display_LCD_String_XY
4279  03c8 5b03          	addw	sp,#3
4281  03ca acf00df0      	jpf	L3152
4282  03ce               L7742:
4283                     ; 106 					Display_LCD_String_XY(1,1,"  有阻挡异常 ",1);
4285  03ce 4b01          	push	#1
4286  03d0 ae00de        	ldw	x,#L5052
4287  03d3 89            	pushw	x
4288  03d4 ae0001        	ldw	x,#1
4289  03d7 a601          	ld	a,#1
4290  03d9 95            	ld	xh,a
4291  03da cd0000        	call	_Display_LCD_String_XY
4293  03dd 5b03          	addw	sp,#3
4294  03df acf00df0      	jpf	L3152
4295  03e3               L3032:
4296                     ; 109 			case Drawer_out: 
4296                     ; 110 				Display_LCD_String_XY(0,0,"  ",0);
4298  03e3 4b00          	push	#0
4299  03e5 ae01a0        	ldw	x,#L3142
4300  03e8 89            	pushw	x
4301  03e9 5f            	clrw	x
4302  03ea 4f            	clr	a
4303  03eb 95            	ld	xh,a
4304  03ec cd0000        	call	_Display_LCD_String_XY
4306  03ef 5b03          	addw	sp,#3
4307                     ; 111 				Display_LCD_String_XY(3,0,"  ",0);
4309  03f1 4b00          	push	#0
4310  03f3 ae01a0        	ldw	x,#L3142
4311  03f6 89            	pushw	x
4312  03f7 5f            	clrw	x
4313  03f8 a603          	ld	a,#3
4314  03fa 95            	ld	xh,a
4315  03fb cd0000        	call	_Display_LCD_String_XY
4317  03fe 5b03          	addw	sp,#3
4318                     ; 112 				Display_LCD_String_XY(1,0,"抽",1);
4320  0400 4b01          	push	#1
4321  0402 ae00db        	ldw	x,#L7052
4322  0405 89            	pushw	x
4323  0406 5f            	clrw	x
4324  0407 a601          	ld	a,#1
4325  0409 95            	ld	xh,a
4326  040a cd0000        	call	_Display_LCD_String_XY
4328  040d 5b03          	addw	sp,#3
4329                     ; 113 				Display_LCD_String_XY(2,0,"屉",1);
4331  040f 4b01          	push	#1
4332  0411 ae00d8        	ldw	x,#L1152
4333  0414 89            	pushw	x
4334  0415 5f            	clrw	x
4335  0416 a602          	ld	a,#2
4336  0418 95            	ld	xh,a
4337  0419 cd0000        	call	_Display_LCD_String_XY
4339  041c 5b03          	addw	sp,#3
4340                     ; 114 				Display_LCD_String_XY(0,7,"  ",1);
4342  041e 4b01          	push	#1
4343  0420 ae01a0        	ldw	x,#L3142
4344  0423 89            	pushw	x
4345  0424 ae0007        	ldw	x,#7
4346  0427 4f            	clr	a
4347  0428 95            	ld	xh,a
4348  0429 cd0000        	call	_Display_LCD_String_XY
4350  042c 5b03          	addw	sp,#3
4351                     ; 115 				Display_LCD_String_XY(0,1,"  当前位置:",1);
4353  042e 4b01          	push	#1
4354  0430 ae018e        	ldw	x,#L1242
4355  0433 89            	pushw	x
4356  0434 ae0001        	ldw	x,#1
4357  0437 4f            	clr	a
4358  0438 95            	ld	xh,a
4359  0439 cd0000        	call	_Display_LCD_String_XY
4361  043c 5b03          	addw	sp,#3
4362                     ; 116 				Write_LCD_Data(0x30+dr_num/10);
4364  043e 7b07          	ld	a,(OFST+7,sp)
4365  0440 ae000a        	ldw	x,#10
4366  0443 51            	exgw	x,y
4367  0444 5f            	clrw	x
4368  0445 97            	ld	xl,a
4369  0446 65            	divw	x,y
4370  0447 9f            	ld	a,xl
4371  0448 ab30          	add	a,#48
4372  044a cd0000        	call	_Write_LCD_Data
4374                     ; 117 				Write_LCD_Data(0x30+dr_num%10);
4376  044d 7b07          	ld	a,(OFST+7,sp)
4377  044f ae000a        	ldw	x,#10
4378  0452 51            	exgw	x,y
4379  0453 5f            	clrw	x
4380  0454 97            	ld	xl,a
4381  0455 65            	divw	x,y
4382  0456 909f          	ld	a,yl
4383  0458 ab30          	add	a,#48
4384  045a cd0000        	call	_Write_LCD_Data
4386                     ; 119 				Display_LCD_String_XY(1,1,"  抽屉位置:",1);
4388  045d 4b01          	push	#1
4389  045f ae0173        	ldw	x,#L5242
4390  0462 89            	pushw	x
4391  0463 ae0001        	ldw	x,#1
4392  0466 a601          	ld	a,#1
4393  0468 95            	ld	xh,a
4394  0469 cd0000        	call	_Display_LCD_String_XY
4396  046c 5b03          	addw	sp,#3
4397                     ; 120 				Write_LCD_Data(0x30+Array_R[1]/10);
4399  046e 1e05          	ldw	x,(OFST+5,sp)
4400  0470 e601          	ld	a,(1,x)
4401  0472 ae000a        	ldw	x,#10
4402  0475 51            	exgw	x,y
4403  0476 5f            	clrw	x
4404  0477 97            	ld	xl,a
4405  0478 65            	divw	x,y
4406  0479 9f            	ld	a,xl
4407  047a ab30          	add	a,#48
4408  047c cd0000        	call	_Write_LCD_Data
4410                     ; 121 				Write_LCD_Data(0x30+Array_R[1]%10);
4412  047f 1e05          	ldw	x,(OFST+5,sp)
4413  0481 e601          	ld	a,(1,x)
4414  0483 ae000a        	ldw	x,#10
4415  0486 51            	exgw	x,y
4416  0487 5f            	clrw	x
4417  0488 97            	ld	xl,a
4418  0489 65            	divw	x,y
4419  048a 909f          	ld	a,yl
4420  048c ab30          	add	a,#48
4421  048e cd0000        	call	_Write_LCD_Data
4423                     ; 122 				break;
4425  0491 acf00df0      	jpf	L3152
4426  0495               L5032:
4427                     ; 123 			case Drawer_back: 
4427                     ; 124 				Display_LCD_String_XY(0,0,"  ",0);
4429  0495 4b00          	push	#0
4430  0497 ae01a0        	ldw	x,#L3142
4431  049a 89            	pushw	x
4432  049b 5f            	clrw	x
4433  049c 4f            	clr	a
4434  049d 95            	ld	xh,a
4435  049e cd0000        	call	_Display_LCD_String_XY
4437  04a1 5b03          	addw	sp,#3
4438                     ; 125 				Display_LCD_String_XY(3,0,"  ",0);
4440  04a3 4b00          	push	#0
4441  04a5 ae01a0        	ldw	x,#L3142
4442  04a8 89            	pushw	x
4443  04a9 5f            	clrw	x
4444  04aa a603          	ld	a,#3
4445  04ac 95            	ld	xh,a
4446  04ad cd0000        	call	_Display_LCD_String_XY
4448  04b0 5b03          	addw	sp,#3
4449                     ; 126 				Display_LCD_String_XY(1,0,"抽",1);
4451  04b2 4b01          	push	#1
4452  04b4 ae00db        	ldw	x,#L7052
4453  04b7 89            	pushw	x
4454  04b8 5f            	clrw	x
4455  04b9 a601          	ld	a,#1
4456  04bb 95            	ld	xh,a
4457  04bc cd0000        	call	_Display_LCD_String_XY
4459  04bf 5b03          	addw	sp,#3
4460                     ; 127 				Display_LCD_String_XY(2,0,"屉",1);
4462  04c1 4b01          	push	#1
4463  04c3 ae00d8        	ldw	x,#L1152
4464  04c6 89            	pushw	x
4465  04c7 5f            	clrw	x
4466  04c8 a602          	ld	a,#2
4467  04ca 95            	ld	xh,a
4468  04cb cd0000        	call	_Display_LCD_String_XY
4470  04ce 5b03          	addw	sp,#3
4471                     ; 128 				Display_LCD_String_XY(0,7,"  ",1);
4473  04d0 4b01          	push	#1
4474  04d2 ae01a0        	ldw	x,#L3142
4475  04d5 89            	pushw	x
4476  04d6 ae0007        	ldw	x,#7
4477  04d9 4f            	clr	a
4478  04da 95            	ld	xh,a
4479  04db cd0000        	call	_Display_LCD_String_XY
4481  04de 5b03          	addw	sp,#3
4482                     ; 129 				Display_LCD_String_XY(0,1,"  当前位置:",1);
4484  04e0 4b01          	push	#1
4485  04e2 ae018e        	ldw	x,#L1242
4486  04e5 89            	pushw	x
4487  04e6 ae0001        	ldw	x,#1
4488  04e9 4f            	clr	a
4489  04ea 95            	ld	xh,a
4490  04eb cd0000        	call	_Display_LCD_String_XY
4492  04ee 5b03          	addw	sp,#3
4493                     ; 130 				Write_LCD_Data(0x30+dr_num/10);
4495  04f0 7b07          	ld	a,(OFST+7,sp)
4496  04f2 ae000a        	ldw	x,#10
4497  04f5 51            	exgw	x,y
4498  04f6 5f            	clrw	x
4499  04f7 97            	ld	xl,a
4500  04f8 65            	divw	x,y
4501  04f9 9f            	ld	a,xl
4502  04fa ab30          	add	a,#48
4503  04fc cd0000        	call	_Write_LCD_Data
4505                     ; 131 				Write_LCD_Data(0x30+dr_num%10);
4507  04ff 7b07          	ld	a,(OFST+7,sp)
4508  0501 ae000a        	ldw	x,#10
4509  0504 51            	exgw	x,y
4510  0505 5f            	clrw	x
4511  0506 97            	ld	xl,a
4512  0507 65            	divw	x,y
4513  0508 909f          	ld	a,yl
4514  050a ab30          	add	a,#48
4515  050c cd0000        	call	_Write_LCD_Data
4517                     ; 133 				Display_LCD_String_XY(1,1,"  抽屉位置:",1);
4519  050f 4b01          	push	#1
4520  0511 ae0173        	ldw	x,#L5242
4521  0514 89            	pushw	x
4522  0515 ae0001        	ldw	x,#1
4523  0518 a601          	ld	a,#1
4524  051a 95            	ld	xh,a
4525  051b cd0000        	call	_Display_LCD_String_XY
4527  051e 5b03          	addw	sp,#3
4528                     ; 134 				Write_LCD_Data(0x30+Array_R[1]/10);
4530  0520 1e05          	ldw	x,(OFST+5,sp)
4531  0522 e601          	ld	a,(1,x)
4532  0524 ae000a        	ldw	x,#10
4533  0527 51            	exgw	x,y
4534  0528 5f            	clrw	x
4535  0529 97            	ld	xl,a
4536  052a 65            	divw	x,y
4537  052b 9f            	ld	a,xl
4538  052c ab30          	add	a,#48
4539  052e cd0000        	call	_Write_LCD_Data
4541                     ; 135 				Write_LCD_Data(0x30+Array_R[1]%10);
4543  0531 1e05          	ldw	x,(OFST+5,sp)
4544  0533 e601          	ld	a,(1,x)
4545  0535 ae000a        	ldw	x,#10
4546  0538 51            	exgw	x,y
4547  0539 5f            	clrw	x
4548  053a 97            	ld	xl,a
4549  053b 65            	divw	x,y
4550  053c 909f          	ld	a,yl
4551  053e ab30          	add	a,#48
4552  0540 cd0000        	call	_Write_LCD_Data
4554                     ; 136 				break;
4556  0543 acf00df0      	jpf	L3152
4557  0547               L1142:
4558                     ; 137 			default:;
4559  0547 acf00df0      	jpf	L3152
4560  054b               L5042:
4561                     ; 140 	else if(page_n->page == 1)
4563  054b 1e08          	ldw	x,(OFST+8,sp)
4564  054d f6            	ld	a,(x)
4565  054e a101          	cp	a,#1
4566  0550 2703          	jreq	L23
4567  0552 cc06cc        	jp	L5152
4568  0555               L23:
4569                     ; 142 		Display_LCD_String_XY(0,6,"    ",0);
4571  0555 4b00          	push	#0
4572  0557 ae00d3        	ldw	x,#L7152
4573  055a 89            	pushw	x
4574  055b ae0006        	ldw	x,#6
4575  055e 4f            	clr	a
4576  055f 95            	ld	xh,a
4577  0560 cd0000        	call	_Display_LCD_String_XY
4579  0563 5b03          	addw	sp,#3
4580                     ; 143 			Display_LCD_String_XY(1,6,"    ",0);
4582  0565 4b00          	push	#0
4583  0567 ae00d3        	ldw	x,#L7152
4584  056a 89            	pushw	x
4585  056b ae0006        	ldw	x,#6
4586  056e a601          	ld	a,#1
4587  0570 95            	ld	xh,a
4588  0571 cd0000        	call	_Display_LCD_String_XY
4590  0574 5b03          	addw	sp,#3
4591                     ; 144 			Display_LCD_String_XY(2,6,"    ",0);
4593  0576 4b00          	push	#0
4594  0578 ae00d3        	ldw	x,#L7152
4595  057b 89            	pushw	x
4596  057c ae0006        	ldw	x,#6
4597  057f a602          	ld	a,#2
4598  0581 95            	ld	xh,a
4599  0582 cd0000        	call	_Display_LCD_String_XY
4601  0585 5b03          	addw	sp,#3
4602                     ; 145 			Display_LCD_String_XY(3,6,"    ",0);
4604  0587 4b00          	push	#0
4605  0589 ae00d3        	ldw	x,#L7152
4606  058c 89            	pushw	x
4607  058d ae0006        	ldw	x,#6
4608  0590 a603          	ld	a,#3
4609  0592 95            	ld	xh,a
4610  0593 cd0000        	call	_Display_LCD_String_XY
4612  0596 5b03          	addw	sp,#3
4613                     ; 147 			Display_LCD_String_XY(0,0,"机",0);
4615  0598 4b00          	push	#0
4616  059a ae00d0        	ldw	x,#L1252
4617  059d 89            	pushw	x
4618  059e 5f            	clrw	x
4619  059f 4f            	clr	a
4620  05a0 95            	ld	xh,a
4621  05a1 cd0000        	call	_Display_LCD_String_XY
4623  05a4 5b03          	addw	sp,#3
4624                     ; 148 			Display_LCD_String_XY(1,0,"械",0);
4626  05a6 4b00          	push	#0
4627  05a8 ae00cd        	ldw	x,#L3252
4628  05ab 89            	pushw	x
4629  05ac 5f            	clrw	x
4630  05ad a601          	ld	a,#1
4631  05af 95            	ld	xh,a
4632  05b0 cd0000        	call	_Display_LCD_String_XY
4634  05b3 5b03          	addw	sp,#3
4635                     ; 149 			Display_LCD_String_XY(2,0,"手",0);
4637  05b5 4b00          	push	#0
4638  05b7 ae00ca        	ldw	x,#L5252
4639  05ba 89            	pushw	x
4640  05bb 5f            	clrw	x
4641  05bc a602          	ld	a,#2
4642  05be 95            	ld	xh,a
4643  05bf cd0000        	call	_Display_LCD_String_XY
4645  05c2 5b03          	addw	sp,#3
4646                     ; 150 			Display_LCD_String_XY(3,0,"1 ", 0);
4648  05c4 4b00          	push	#0
4649  05c6 ae00c7        	ldw	x,#L7252
4650  05c9 89            	pushw	x
4651  05ca 5f            	clrw	x
4652  05cb a603          	ld	a,#3
4653  05cd 95            	ld	xh,a
4654  05ce cd0000        	call	_Display_LCD_String_XY
4656  05d1 5b03          	addw	sp,#3
4657                     ; 152 			Display_LCD_String_XY(0,1,"  机械手使用量",1);
4659  05d3 4b01          	push	#1
4660  05d5 ae00b8        	ldw	x,#L1352
4661  05d8 89            	pushw	x
4662  05d9 ae0001        	ldw	x,#1
4663  05dc 4f            	clr	a
4664  05dd 95            	ld	xh,a
4665  05de cd0000        	call	_Display_LCD_String_XY
4667  05e1 5b03          	addw	sp,#3
4668                     ; 153 			Display_LCD_String_XY(1,1,"  长按ok清零  ",1);
4670  05e3 4b01          	push	#1
4671  05e5 ae00a9        	ldw	x,#L3352
4672  05e8 89            	pushw	x
4673  05e9 ae0001        	ldw	x,#1
4674  05ec a601          	ld	a,#1
4675  05ee 95            	ld	xh,a
4676  05ef cd0000        	call	_Display_LCD_String_XY
4678  05f2 5b03          	addw	sp,#3
4679                     ; 155 			Display_LCD_String_XY(2,1,"  ",1);
4681  05f4 4b01          	push	#1
4682  05f6 ae01a0        	ldw	x,#L3142
4683  05f9 89            	pushw	x
4684  05fa ae0001        	ldw	x,#1
4685  05fd a602          	ld	a,#2
4686  05ff 95            	ld	xh,a
4687  0600 cd0000        	call	_Display_LCD_String_XY
4689  0603 5b03          	addw	sp,#3
4690                     ; 156 			Display_LCD_String_XY(3,1,"  ",1);
4692  0605 4b01          	push	#1
4693  0607 ae01a0        	ldw	x,#L3142
4694  060a 89            	pushw	x
4695  060b ae0001        	ldw	x,#1
4696  060e a603          	ld	a,#3
4697  0610 95            	ld	xh,a
4698  0611 cd0000        	call	_Display_LCD_String_XY
4700  0614 5b03          	addw	sp,#3
4701                     ; 158 			Display_LCD_String_XY(2,2,"R1:",1);
4703  0616 4b01          	push	#1
4704  0618 ae00a5        	ldw	x,#L5352
4705  061b 89            	pushw	x
4706  061c ae0002        	ldw	x,#2
4707  061f a602          	ld	a,#2
4708  0621 95            	ld	xh,a
4709  0622 cd0000        	call	_Display_LCD_String_XY
4711  0625 5b03          	addw	sp,#3
4712                     ; 159 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n));
4714  0627 a60f          	ld	a,#15
4715  0629 cd0000        	call	_Eeprom_Read
4717  062c ab30          	add	a,#48
4718  062e cd0000        	call	_Write_LCD_Data
4720                     ; 160 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+1));
4722  0631 a610          	ld	a,#16
4723  0633 cd0000        	call	_Eeprom_Read
4725  0636 ab30          	add	a,#48
4726  0638 cd0000        	call	_Write_LCD_Data
4728                     ; 161 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+2));
4730  063b a611          	ld	a,#17
4731  063d cd0000        	call	_Eeprom_Read
4733  0640 ab30          	add	a,#48
4734  0642 cd0000        	call	_Write_LCD_Data
4736                     ; 162 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+3));
4738  0645 a612          	ld	a,#18
4739  0647 cd0000        	call	_Eeprom_Read
4741  064a ab30          	add	a,#48
4742  064c cd0000        	call	_Write_LCD_Data
4744                     ; 163 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+4));
4746  064f a613          	ld	a,#19
4747  0651 cd0000        	call	_Eeprom_Read
4749  0654 ab30          	add	a,#48
4750  0656 cd0000        	call	_Write_LCD_Data
4752                     ; 164 			Display_LCD_String_XY(3,2,"R2:",1);
4754  0659 4b01          	push	#1
4755  065b ae00a1        	ldw	x,#L7352
4756  065e 89            	pushw	x
4757  065f ae0002        	ldw	x,#2
4758  0662 a603          	ld	a,#3
4759  0664 95            	ld	xh,a
4760  0665 cd0000        	call	_Display_LCD_String_XY
4762  0668 5b03          	addw	sp,#3
4763                     ; 165 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+5));
4765  066a a614          	ld	a,#20
4766  066c cd0000        	call	_Eeprom_Read
4768  066f ab30          	add	a,#48
4769  0671 cd0000        	call	_Write_LCD_Data
4771                     ; 166 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+6));
4773  0674 a615          	ld	a,#21
4774  0676 cd0000        	call	_Eeprom_Read
4776  0679 ab30          	add	a,#48
4777  067b cd0000        	call	_Write_LCD_Data
4779                     ; 167 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+7));
4781  067e a616          	ld	a,#22
4782  0680 cd0000        	call	_Eeprom_Read
4784  0683 ab30          	add	a,#48
4785  0685 cd0000        	call	_Write_LCD_Data
4787                     ; 168 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+8));
4789  0688 a617          	ld	a,#23
4790  068a cd0000        	call	_Eeprom_Read
4792  068d ab30          	add	a,#48
4793  068f cd0000        	call	_Write_LCD_Data
4795                     ; 169 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+9));
4797  0692 a618          	ld	a,#24
4798  0694 cd0000        	call	_Eeprom_Read
4800  0697 ab30          	add	a,#48
4801  0699 cd0000        	call	_Write_LCD_Data
4803                     ; 170 			if(page_n->row == 0)
4805  069c 1e08          	ldw	x,(OFST+8,sp)
4806  069e 6d01          	tnz	(1,x)
4807  06a0 2615          	jrne	L1452
4808                     ; 172 				Display_LCD_String_XY(2,1,"●",1);
4810  06a2 4b01          	push	#1
4811  06a4 ae009e        	ldw	x,#L3452
4812  06a7 89            	pushw	x
4813  06a8 ae0001        	ldw	x,#1
4814  06ab a602          	ld	a,#2
4815  06ad 95            	ld	xh,a
4816  06ae cd0000        	call	_Display_LCD_String_XY
4818  06b1 5b03          	addw	sp,#3
4820  06b3 acf00df0      	jpf	L3152
4821  06b7               L1452:
4822                     ; 176 				Display_LCD_String_XY(3,1,"●",1);
4824  06b7 4b01          	push	#1
4825  06b9 ae009e        	ldw	x,#L3452
4826  06bc 89            	pushw	x
4827  06bd ae0001        	ldw	x,#1
4828  06c0 a603          	ld	a,#3
4829  06c2 95            	ld	xh,a
4830  06c3 cd0000        	call	_Display_LCD_String_XY
4832  06c6 5b03          	addw	sp,#3
4833  06c8 acf00df0      	jpf	L3152
4834  06cc               L5152:
4835                     ; 179 	else if(page_n->page == 2)
4837  06cc 1e08          	ldw	x,(OFST+8,sp)
4838  06ce f6            	ld	a,(x)
4839  06cf a102          	cp	a,#2
4840  06d1 2703          	jreq	L43
4841  06d3 cc0916        	jp	L1552
4842  06d6               L43:
4843                     ; 181 			Display_LCD_String_XY(0,6,"    ",0);
4845  06d6 4b00          	push	#0
4846  06d8 ae00d3        	ldw	x,#L7152
4847  06db 89            	pushw	x
4848  06dc ae0006        	ldw	x,#6
4849  06df 4f            	clr	a
4850  06e0 95            	ld	xh,a
4851  06e1 cd0000        	call	_Display_LCD_String_XY
4853  06e4 5b03          	addw	sp,#3
4854                     ; 182 			Display_LCD_String_XY(1,6,"    ",0);
4856  06e6 4b00          	push	#0
4857  06e8 ae00d3        	ldw	x,#L7152
4858  06eb 89            	pushw	x
4859  06ec ae0006        	ldw	x,#6
4860  06ef a601          	ld	a,#1
4861  06f1 95            	ld	xh,a
4862  06f2 cd0000        	call	_Display_LCD_String_XY
4864  06f5 5b03          	addw	sp,#3
4865                     ; 183 			Display_LCD_String_XY(2,6,"    ",0);
4867  06f7 4b00          	push	#0
4868  06f9 ae00d3        	ldw	x,#L7152
4869  06fc 89            	pushw	x
4870  06fd ae0006        	ldw	x,#6
4871  0700 a602          	ld	a,#2
4872  0702 95            	ld	xh,a
4873  0703 cd0000        	call	_Display_LCD_String_XY
4875  0706 5b03          	addw	sp,#3
4876                     ; 184 			Display_LCD_String_XY(3,6,"    ",0);
4878  0708 4b00          	push	#0
4879  070a ae00d3        	ldw	x,#L7152
4880  070d 89            	pushw	x
4881  070e ae0006        	ldw	x,#6
4882  0711 a603          	ld	a,#3
4883  0713 95            	ld	xh,a
4884  0714 cd0000        	call	_Display_LCD_String_XY
4886  0717 5b03          	addw	sp,#3
4887                     ; 186 			Display_LCD_String_XY(0,0,"机",0);
4889  0719 4b00          	push	#0
4890  071b ae00d0        	ldw	x,#L1252
4891  071e 89            	pushw	x
4892  071f 5f            	clrw	x
4893  0720 4f            	clr	a
4894  0721 95            	ld	xh,a
4895  0722 cd0000        	call	_Display_LCD_String_XY
4897  0725 5b03          	addw	sp,#3
4898                     ; 187 			Display_LCD_String_XY(1,0,"械",0);
4900  0727 4b00          	push	#0
4901  0729 ae00cd        	ldw	x,#L3252
4902  072c 89            	pushw	x
4903  072d 5f            	clrw	x
4904  072e a601          	ld	a,#1
4905  0730 95            	ld	xh,a
4906  0731 cd0000        	call	_Display_LCD_String_XY
4908  0734 5b03          	addw	sp,#3
4909                     ; 188 			Display_LCD_String_XY(2,0,"手",0);
4911  0736 4b00          	push	#0
4912  0738 ae00ca        	ldw	x,#L5252
4913  073b 89            	pushw	x
4914  073c 5f            	clrw	x
4915  073d a602          	ld	a,#2
4916  073f 95            	ld	xh,a
4917  0740 cd0000        	call	_Display_LCD_String_XY
4919  0743 5b03          	addw	sp,#3
4920                     ; 189 			Display_LCD_String_XY(3,0,"2 ", 0);
4922  0745 4b00          	push	#0
4923  0747 ae009b        	ldw	x,#L3552
4924  074a 89            	pushw	x
4925  074b 5f            	clrw	x
4926  074c a603          	ld	a,#3
4927  074e 95            	ld	xh,a
4928  074f cd0000        	call	_Display_LCD_String_XY
4930  0752 5b03          	addw	sp,#3
4931                     ; 191 			Display_LCD_String_XY(0,1,"  ",1);
4933  0754 4b01          	push	#1
4934  0756 ae01a0        	ldw	x,#L3142
4935  0759 89            	pushw	x
4936  075a ae0001        	ldw	x,#1
4937  075d 4f            	clr	a
4938  075e 95            	ld	xh,a
4939  075f cd0000        	call	_Display_LCD_String_XY
4941  0762 5b03          	addw	sp,#3
4942                     ; 192 			Display_LCD_String_XY(1,1,"  ",1);
4944  0764 4b01          	push	#1
4945  0766 ae01a0        	ldw	x,#L3142
4946  0769 89            	pushw	x
4947  076a ae0001        	ldw	x,#1
4948  076d a601          	ld	a,#1
4949  076f 95            	ld	xh,a
4950  0770 cd0000        	call	_Display_LCD_String_XY
4952  0773 5b03          	addw	sp,#3
4953                     ; 193 			Display_LCD_String_XY(2,1,"  ",1);
4955  0775 4b01          	push	#1
4956  0777 ae01a0        	ldw	x,#L3142
4957  077a 89            	pushw	x
4958  077b ae0001        	ldw	x,#1
4959  077e a602          	ld	a,#2
4960  0780 95            	ld	xh,a
4961  0781 cd0000        	call	_Display_LCD_String_XY
4963  0784 5b03          	addw	sp,#3
4964                     ; 194 			Display_LCD_String_XY(3,1,"  ",1);
4966  0786 4b01          	push	#1
4967  0788 ae01a0        	ldw	x,#L3142
4968  078b 89            	pushw	x
4969  078c ae0001        	ldw	x,#1
4970  078f a603          	ld	a,#3
4971  0791 95            	ld	xh,a
4972  0792 cd0000        	call	_Display_LCD_String_XY
4974  0795 5b03          	addw	sp,#3
4975                     ; 196 			Display_LCD_String_XY(0,2,"R3:",1);
4977  0797 4b01          	push	#1
4978  0799 ae0097        	ldw	x,#L5552
4979  079c 89            	pushw	x
4980  079d ae0002        	ldw	x,#2
4981  07a0 4f            	clr	a
4982  07a1 95            	ld	xh,a
4983  07a2 cd0000        	call	_Display_LCD_String_XY
4985  07a5 5b03          	addw	sp,#3
4986                     ; 197 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+14));
4988  07a7 a61d          	ld	a,#29
4989  07a9 cd0000        	call	_Eeprom_Read
4991  07ac ab30          	add	a,#48
4992  07ae cd0000        	call	_Write_LCD_Data
4994                     ; 198 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+13));
4996  07b1 a61c          	ld	a,#28
4997  07b3 cd0000        	call	_Eeprom_Read
4999  07b6 ab30          	add	a,#48
5000  07b8 cd0000        	call	_Write_LCD_Data
5002                     ; 199 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+12));
5004  07bb a61b          	ld	a,#27
5005  07bd cd0000        	call	_Eeprom_Read
5007  07c0 ab30          	add	a,#48
5008  07c2 cd0000        	call	_Write_LCD_Data
5010                     ; 200 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+11));
5012  07c5 a61a          	ld	a,#26
5013  07c7 cd0000        	call	_Eeprom_Read
5015  07ca ab30          	add	a,#48
5016  07cc cd0000        	call	_Write_LCD_Data
5018                     ; 201 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+10));
5020  07cf a619          	ld	a,#25
5021  07d1 cd0000        	call	_Eeprom_Read
5023  07d4 ab30          	add	a,#48
5024  07d6 cd0000        	call	_Write_LCD_Data
5026                     ; 202 			Display_LCD_String_XY(1,2,"R4:",1);
5028  07d9 4b01          	push	#1
5029  07db ae0093        	ldw	x,#L7552
5030  07de 89            	pushw	x
5031  07df ae0002        	ldw	x,#2
5032  07e2 a601          	ld	a,#1
5033  07e4 95            	ld	xh,a
5034  07e5 cd0000        	call	_Display_LCD_String_XY
5036  07e8 5b03          	addw	sp,#3
5037                     ; 203 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+19));
5039  07ea a622          	ld	a,#34
5040  07ec cd0000        	call	_Eeprom_Read
5042  07ef ab30          	add	a,#48
5043  07f1 cd0000        	call	_Write_LCD_Data
5045                     ; 204 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+18));
5047  07f4 a621          	ld	a,#33
5048  07f6 cd0000        	call	_Eeprom_Read
5050  07f9 ab30          	add	a,#48
5051  07fb cd0000        	call	_Write_LCD_Data
5053                     ; 205 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+17));
5055  07fe a620          	ld	a,#32
5056  0800 cd0000        	call	_Eeprom_Read
5058  0803 ab30          	add	a,#48
5059  0805 cd0000        	call	_Write_LCD_Data
5061                     ; 206 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+15));
5063  0808 a61e          	ld	a,#30
5064  080a cd0000        	call	_Eeprom_Read
5066  080d ab30          	add	a,#48
5067  080f cd0000        	call	_Write_LCD_Data
5069                     ; 207 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+16));
5071  0812 a61f          	ld	a,#31
5072  0814 cd0000        	call	_Eeprom_Read
5074  0817 ab30          	add	a,#48
5075  0819 cd0000        	call	_Write_LCD_Data
5077                     ; 208 			Display_LCD_String_XY(2,2,"R5:",1);
5079  081c 4b01          	push	#1
5080  081e ae008f        	ldw	x,#L1652
5081  0821 89            	pushw	x
5082  0822 ae0002        	ldw	x,#2
5083  0825 a602          	ld	a,#2
5084  0827 95            	ld	xh,a
5085  0828 cd0000        	call	_Display_LCD_String_XY
5087  082b 5b03          	addw	sp,#3
5088                     ; 209 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+24));
5090  082d a627          	ld	a,#39
5091  082f cd0000        	call	_Eeprom_Read
5093  0832 ab30          	add	a,#48
5094  0834 cd0000        	call	_Write_LCD_Data
5096                     ; 210 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+23));
5098  0837 a626          	ld	a,#38
5099  0839 cd0000        	call	_Eeprom_Read
5101  083c ab30          	add	a,#48
5102  083e cd0000        	call	_Write_LCD_Data
5104                     ; 211 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+22));
5106  0841 a625          	ld	a,#37
5107  0843 cd0000        	call	_Eeprom_Read
5109  0846 ab30          	add	a,#48
5110  0848 cd0000        	call	_Write_LCD_Data
5112                     ; 212 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+21));
5114  084b a624          	ld	a,#36
5115  084d cd0000        	call	_Eeprom_Read
5117  0850 ab30          	add	a,#48
5118  0852 cd0000        	call	_Write_LCD_Data
5120                     ; 213 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+20));
5122  0855 a623          	ld	a,#35
5123  0857 cd0000        	call	_Eeprom_Read
5125  085a ab30          	add	a,#48
5126  085c cd0000        	call	_Write_LCD_Data
5128                     ; 214 			Display_LCD_String_XY(3,2,"R6:",1);
5130  085f 4b01          	push	#1
5131  0861 ae008b        	ldw	x,#L3652
5132  0864 89            	pushw	x
5133  0865 ae0002        	ldw	x,#2
5134  0868 a603          	ld	a,#3
5135  086a 95            	ld	xh,a
5136  086b cd0000        	call	_Display_LCD_String_XY
5138  086e 5b03          	addw	sp,#3
5139                     ; 215 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+29));
5141  0870 a62c          	ld	a,#44
5142  0872 cd0000        	call	_Eeprom_Read
5144  0875 ab30          	add	a,#48
5145  0877 cd0000        	call	_Write_LCD_Data
5147                     ; 216 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+28));
5149  087a a62b          	ld	a,#43
5150  087c cd0000        	call	_Eeprom_Read
5152  087f ab30          	add	a,#48
5153  0881 cd0000        	call	_Write_LCD_Data
5155                     ; 217 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+27));
5157  0884 a62a          	ld	a,#42
5158  0886 cd0000        	call	_Eeprom_Read
5160  0889 ab30          	add	a,#48
5161  088b cd0000        	call	_Write_LCD_Data
5163                     ; 218 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+26));
5165  088e a629          	ld	a,#41
5166  0890 cd0000        	call	_Eeprom_Read
5168  0893 ab30          	add	a,#48
5169  0895 cd0000        	call	_Write_LCD_Data
5171                     ; 219 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+25));
5173  0898 a628          	ld	a,#40
5174  089a cd0000        	call	_Eeprom_Read
5176  089d ab30          	add	a,#48
5177  089f cd0000        	call	_Write_LCD_Data
5179                     ; 220 			if(page_n->row == 0)
5181  08a2 1e08          	ldw	x,(OFST+8,sp)
5182  08a4 6d01          	tnz	(1,x)
5183  08a6 2614          	jrne	L5652
5184                     ; 222 				Display_LCD_String_XY(0,1,"●",1);
5186  08a8 4b01          	push	#1
5187  08aa ae009e        	ldw	x,#L3452
5188  08ad 89            	pushw	x
5189  08ae ae0001        	ldw	x,#1
5190  08b1 4f            	clr	a
5191  08b2 95            	ld	xh,a
5192  08b3 cd0000        	call	_Display_LCD_String_XY
5194  08b6 5b03          	addw	sp,#3
5196  08b8 acf00df0      	jpf	L3152
5197  08bc               L5652:
5198                     ; 224 			else if(page_n->row == 1)
5200  08bc 1e08          	ldw	x,(OFST+8,sp)
5201  08be e601          	ld	a,(1,x)
5202  08c0 a101          	cp	a,#1
5203  08c2 2615          	jrne	L1752
5204                     ; 226 				Display_LCD_String_XY(1,1,"●",1);
5206  08c4 4b01          	push	#1
5207  08c6 ae009e        	ldw	x,#L3452
5208  08c9 89            	pushw	x
5209  08ca ae0001        	ldw	x,#1
5210  08cd a601          	ld	a,#1
5211  08cf 95            	ld	xh,a
5212  08d0 cd0000        	call	_Display_LCD_String_XY
5214  08d3 5b03          	addw	sp,#3
5216  08d5 acf00df0      	jpf	L3152
5217  08d9               L1752:
5218                     ; 228 			else if(page_n->row == 2)
5220  08d9 1e08          	ldw	x,(OFST+8,sp)
5221  08db e601          	ld	a,(1,x)
5222  08dd a102          	cp	a,#2
5223  08df 2615          	jrne	L5752
5224                     ; 230 				Display_LCD_String_XY(2,1,"●",1);
5226  08e1 4b01          	push	#1
5227  08e3 ae009e        	ldw	x,#L3452
5228  08e6 89            	pushw	x
5229  08e7 ae0001        	ldw	x,#1
5230  08ea a602          	ld	a,#2
5231  08ec 95            	ld	xh,a
5232  08ed cd0000        	call	_Display_LCD_String_XY
5234  08f0 5b03          	addw	sp,#3
5236  08f2 acf00df0      	jpf	L3152
5237  08f6               L5752:
5238                     ; 232 			else if(page_n->row == 3)
5240  08f6 1e08          	ldw	x,(OFST+8,sp)
5241  08f8 e601          	ld	a,(1,x)
5242  08fa a103          	cp	a,#3
5243  08fc 2703          	jreq	L63
5244  08fe cc0df0        	jp	L3152
5245  0901               L63:
5246                     ; 234 				Display_LCD_String_XY(3,1,"●",1);
5248  0901 4b01          	push	#1
5249  0903 ae009e        	ldw	x,#L3452
5250  0906 89            	pushw	x
5251  0907 ae0001        	ldw	x,#1
5252  090a a603          	ld	a,#3
5253  090c 95            	ld	xh,a
5254  090d cd0000        	call	_Display_LCD_String_XY
5256  0910 5b03          	addw	sp,#3
5257  0912 acf00df0      	jpf	L3152
5258  0916               L1552:
5259                     ; 237 	else if(page_n->page == 3)
5261  0916 1e08          	ldw	x,(OFST+8,sp)
5262  0918 f6            	ld	a,(x)
5263  0919 a103          	cp	a,#3
5264  091b 2703          	jreq	L04
5265  091d cc0b60        	jp	L5062
5266  0920               L04:
5267                     ; 239 		Display_LCD_String_XY(0,6,"    ",0);
5269  0920 4b00          	push	#0
5270  0922 ae00d3        	ldw	x,#L7152
5271  0925 89            	pushw	x
5272  0926 ae0006        	ldw	x,#6
5273  0929 4f            	clr	a
5274  092a 95            	ld	xh,a
5275  092b cd0000        	call	_Display_LCD_String_XY
5277  092e 5b03          	addw	sp,#3
5278                     ; 240 		Display_LCD_String_XY(1,6,"    ",0);
5280  0930 4b00          	push	#0
5281  0932 ae00d3        	ldw	x,#L7152
5282  0935 89            	pushw	x
5283  0936 ae0006        	ldw	x,#6
5284  0939 a601          	ld	a,#1
5285  093b 95            	ld	xh,a
5286  093c cd0000        	call	_Display_LCD_String_XY
5288  093f 5b03          	addw	sp,#3
5289                     ; 241 		Display_LCD_String_XY(2,6,"    ",0);
5291  0941 4b00          	push	#0
5292  0943 ae00d3        	ldw	x,#L7152
5293  0946 89            	pushw	x
5294  0947 ae0006        	ldw	x,#6
5295  094a a602          	ld	a,#2
5296  094c 95            	ld	xh,a
5297  094d cd0000        	call	_Display_LCD_String_XY
5299  0950 5b03          	addw	sp,#3
5300                     ; 242 		Display_LCD_String_XY(3,6,"    ",0);
5302  0952 4b00          	push	#0
5303  0954 ae00d3        	ldw	x,#L7152
5304  0957 89            	pushw	x
5305  0958 ae0006        	ldw	x,#6
5306  095b a603          	ld	a,#3
5307  095d 95            	ld	xh,a
5308  095e cd0000        	call	_Display_LCD_String_XY
5310  0961 5b03          	addw	sp,#3
5311                     ; 244 		Display_LCD_String_XY(0,0,"机",0);
5313  0963 4b00          	push	#0
5314  0965 ae00d0        	ldw	x,#L1252
5315  0968 89            	pushw	x
5316  0969 5f            	clrw	x
5317  096a 4f            	clr	a
5318  096b 95            	ld	xh,a
5319  096c cd0000        	call	_Display_LCD_String_XY
5321  096f 5b03          	addw	sp,#3
5322                     ; 245 		Display_LCD_String_XY(1,0,"械",0);
5324  0971 4b00          	push	#0
5325  0973 ae00cd        	ldw	x,#L3252
5326  0976 89            	pushw	x
5327  0977 5f            	clrw	x
5328  0978 a601          	ld	a,#1
5329  097a 95            	ld	xh,a
5330  097b cd0000        	call	_Display_LCD_String_XY
5332  097e 5b03          	addw	sp,#3
5333                     ; 246 		Display_LCD_String_XY(2,0,"手",0);
5335  0980 4b00          	push	#0
5336  0982 ae00ca        	ldw	x,#L5252
5337  0985 89            	pushw	x
5338  0986 5f            	clrw	x
5339  0987 a602          	ld	a,#2
5340  0989 95            	ld	xh,a
5341  098a cd0000        	call	_Display_LCD_String_XY
5343  098d 5b03          	addw	sp,#3
5344                     ; 247 		Display_LCD_String_XY(3,0,"3 ", 0);
5346  098f 4b00          	push	#0
5347  0991 ae0088        	ldw	x,#L7062
5348  0994 89            	pushw	x
5349  0995 5f            	clrw	x
5350  0996 a603          	ld	a,#3
5351  0998 95            	ld	xh,a
5352  0999 cd0000        	call	_Display_LCD_String_XY
5354  099c 5b03          	addw	sp,#3
5355                     ; 249 		Display_LCD_String_XY(0,1,"  ",1);
5357  099e 4b01          	push	#1
5358  09a0 ae01a0        	ldw	x,#L3142
5359  09a3 89            	pushw	x
5360  09a4 ae0001        	ldw	x,#1
5361  09a7 4f            	clr	a
5362  09a8 95            	ld	xh,a
5363  09a9 cd0000        	call	_Display_LCD_String_XY
5365  09ac 5b03          	addw	sp,#3
5366                     ; 250 		Display_LCD_String_XY(1,1,"  ",1);
5368  09ae 4b01          	push	#1
5369  09b0 ae01a0        	ldw	x,#L3142
5370  09b3 89            	pushw	x
5371  09b4 ae0001        	ldw	x,#1
5372  09b7 a601          	ld	a,#1
5373  09b9 95            	ld	xh,a
5374  09ba cd0000        	call	_Display_LCD_String_XY
5376  09bd 5b03          	addw	sp,#3
5377                     ; 251 		Display_LCD_String_XY(2,1,"  ",1);
5379  09bf 4b01          	push	#1
5380  09c1 ae01a0        	ldw	x,#L3142
5381  09c4 89            	pushw	x
5382  09c5 ae0001        	ldw	x,#1
5383  09c8 a602          	ld	a,#2
5384  09ca 95            	ld	xh,a
5385  09cb cd0000        	call	_Display_LCD_String_XY
5387  09ce 5b03          	addw	sp,#3
5388                     ; 252 		Display_LCD_String_XY(3,1,"  ",1);
5390  09d0 4b01          	push	#1
5391  09d2 ae01a0        	ldw	x,#L3142
5392  09d5 89            	pushw	x
5393  09d6 ae0001        	ldw	x,#1
5394  09d9 a603          	ld	a,#3
5395  09db 95            	ld	xh,a
5396  09dc cd0000        	call	_Display_LCD_String_XY
5398  09df 5b03          	addw	sp,#3
5399                     ; 254 		Display_LCD_String_XY(0,2,"R7:",1);
5401  09e1 4b01          	push	#1
5402  09e3 ae0084        	ldw	x,#L1162
5403  09e6 89            	pushw	x
5404  09e7 ae0002        	ldw	x,#2
5405  09ea 4f            	clr	a
5406  09eb 95            	ld	xh,a
5407  09ec cd0000        	call	_Display_LCD_String_XY
5409  09ef 5b03          	addw	sp,#3
5410                     ; 255 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+34));
5412  09f1 a631          	ld	a,#49
5413  09f3 cd0000        	call	_Eeprom_Read
5415  09f6 ab30          	add	a,#48
5416  09f8 cd0000        	call	_Write_LCD_Data
5418                     ; 256 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+33));
5420  09fb a630          	ld	a,#48
5421  09fd cd0000        	call	_Eeprom_Read
5423  0a00 ab30          	add	a,#48
5424  0a02 cd0000        	call	_Write_LCD_Data
5426                     ; 257 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+32));
5428  0a05 a62f          	ld	a,#47
5429  0a07 cd0000        	call	_Eeprom_Read
5431  0a0a ab30          	add	a,#48
5432  0a0c cd0000        	call	_Write_LCD_Data
5434                     ; 258 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+31));
5436  0a0f a62e          	ld	a,#46
5437  0a11 cd0000        	call	_Eeprom_Read
5439  0a14 ab30          	add	a,#48
5440  0a16 cd0000        	call	_Write_LCD_Data
5442                     ; 259 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+30));
5444  0a19 a62d          	ld	a,#45
5445  0a1b cd0000        	call	_Eeprom_Read
5447  0a1e ab30          	add	a,#48
5448  0a20 cd0000        	call	_Write_LCD_Data
5450                     ; 260 		Display_LCD_String_XY(1,2,"R8:",1);
5452  0a23 4b01          	push	#1
5453  0a25 ae0080        	ldw	x,#L3162
5454  0a28 89            	pushw	x
5455  0a29 ae0002        	ldw	x,#2
5456  0a2c a601          	ld	a,#1
5457  0a2e 95            	ld	xh,a
5458  0a2f cd0000        	call	_Display_LCD_String_XY
5460  0a32 5b03          	addw	sp,#3
5461                     ; 261 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+39));
5463  0a34 a636          	ld	a,#54
5464  0a36 cd0000        	call	_Eeprom_Read
5466  0a39 ab30          	add	a,#48
5467  0a3b cd0000        	call	_Write_LCD_Data
5469                     ; 262 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+38));
5471  0a3e a635          	ld	a,#53
5472  0a40 cd0000        	call	_Eeprom_Read
5474  0a43 ab30          	add	a,#48
5475  0a45 cd0000        	call	_Write_LCD_Data
5477                     ; 263 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+37));
5479  0a48 a634          	ld	a,#52
5480  0a4a cd0000        	call	_Eeprom_Read
5482  0a4d ab30          	add	a,#48
5483  0a4f cd0000        	call	_Write_LCD_Data
5485                     ; 264 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+36));
5487  0a52 a633          	ld	a,#51
5488  0a54 cd0000        	call	_Eeprom_Read
5490  0a57 ab30          	add	a,#48
5491  0a59 cd0000        	call	_Write_LCD_Data
5493                     ; 265 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+35));
5495  0a5c a632          	ld	a,#50
5496  0a5e cd0000        	call	_Eeprom_Read
5498  0a61 ab30          	add	a,#48
5499  0a63 cd0000        	call	_Write_LCD_Data
5501                     ; 266 		Display_LCD_String_XY(2,2,"R9:",1);
5503  0a66 4b01          	push	#1
5504  0a68 ae007c        	ldw	x,#L5162
5505  0a6b 89            	pushw	x
5506  0a6c ae0002        	ldw	x,#2
5507  0a6f a602          	ld	a,#2
5508  0a71 95            	ld	xh,a
5509  0a72 cd0000        	call	_Display_LCD_String_XY
5511  0a75 5b03          	addw	sp,#3
5512                     ; 267 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+44));
5514  0a77 a63b          	ld	a,#59
5515  0a79 cd0000        	call	_Eeprom_Read
5517  0a7c ab30          	add	a,#48
5518  0a7e cd0000        	call	_Write_LCD_Data
5520                     ; 268 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+43));
5522  0a81 a63a          	ld	a,#58
5523  0a83 cd0000        	call	_Eeprom_Read
5525  0a86 ab30          	add	a,#48
5526  0a88 cd0000        	call	_Write_LCD_Data
5528                     ; 269 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+42));
5530  0a8b a639          	ld	a,#57
5531  0a8d cd0000        	call	_Eeprom_Read
5533  0a90 ab30          	add	a,#48
5534  0a92 cd0000        	call	_Write_LCD_Data
5536                     ; 270 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+41));
5538  0a95 a638          	ld	a,#56
5539  0a97 cd0000        	call	_Eeprom_Read
5541  0a9a ab30          	add	a,#48
5542  0a9c cd0000        	call	_Write_LCD_Data
5544                     ; 271 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+40));
5546  0a9f a637          	ld	a,#55
5547  0aa1 cd0000        	call	_Eeprom_Read
5549  0aa4 ab30          	add	a,#48
5550  0aa6 cd0000        	call	_Write_LCD_Data
5552                     ; 272 		Display_LCD_String_XY(3,2,"R10:",1);
5554  0aa9 4b01          	push	#1
5555  0aab ae0077        	ldw	x,#L7162
5556  0aae 89            	pushw	x
5557  0aaf ae0002        	ldw	x,#2
5558  0ab2 a603          	ld	a,#3
5559  0ab4 95            	ld	xh,a
5560  0ab5 cd0000        	call	_Display_LCD_String_XY
5562  0ab8 5b03          	addw	sp,#3
5563                     ; 273 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+49));
5565  0aba a640          	ld	a,#64
5566  0abc cd0000        	call	_Eeprom_Read
5568  0abf ab30          	add	a,#48
5569  0ac1 cd0000        	call	_Write_LCD_Data
5571                     ; 274 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+48));
5573  0ac4 a63f          	ld	a,#63
5574  0ac6 cd0000        	call	_Eeprom_Read
5576  0ac9 ab30          	add	a,#48
5577  0acb cd0000        	call	_Write_LCD_Data
5579                     ; 275 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+47));
5581  0ace a63e          	ld	a,#62
5582  0ad0 cd0000        	call	_Eeprom_Read
5584  0ad3 ab30          	add	a,#48
5585  0ad5 cd0000        	call	_Write_LCD_Data
5587                     ; 276 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+46));
5589  0ad8 a63d          	ld	a,#61
5590  0ada cd0000        	call	_Eeprom_Read
5592  0add ab30          	add	a,#48
5593  0adf cd0000        	call	_Write_LCD_Data
5595                     ; 277 			Write_LCD_Data(0x30+Eeprom_Read(r_sive_n+45));
5597  0ae2 a63c          	ld	a,#60
5598  0ae4 cd0000        	call	_Eeprom_Read
5600  0ae7 ab30          	add	a,#48
5601  0ae9 cd0000        	call	_Write_LCD_Data
5603                     ; 278 			if(page_n->row == 0)
5605  0aec 1e08          	ldw	x,(OFST+8,sp)
5606  0aee 6d01          	tnz	(1,x)
5607  0af0 2614          	jrne	L1262
5608                     ; 280 				Display_LCD_String_XY(0,1,"●",1);
5610  0af2 4b01          	push	#1
5611  0af4 ae009e        	ldw	x,#L3452
5612  0af7 89            	pushw	x
5613  0af8 ae0001        	ldw	x,#1
5614  0afb 4f            	clr	a
5615  0afc 95            	ld	xh,a
5616  0afd cd0000        	call	_Display_LCD_String_XY
5618  0b00 5b03          	addw	sp,#3
5620  0b02 acf00df0      	jpf	L3152
5621  0b06               L1262:
5622                     ; 282 			else if(page_n->row == 1)
5624  0b06 1e08          	ldw	x,(OFST+8,sp)
5625  0b08 e601          	ld	a,(1,x)
5626  0b0a a101          	cp	a,#1
5627  0b0c 2615          	jrne	L5262
5628                     ; 284 				Display_LCD_String_XY(1,1,"●",1);
5630  0b0e 4b01          	push	#1
5631  0b10 ae009e        	ldw	x,#L3452
5632  0b13 89            	pushw	x
5633  0b14 ae0001        	ldw	x,#1
5634  0b17 a601          	ld	a,#1
5635  0b19 95            	ld	xh,a
5636  0b1a cd0000        	call	_Display_LCD_String_XY
5638  0b1d 5b03          	addw	sp,#3
5640  0b1f acf00df0      	jpf	L3152
5641  0b23               L5262:
5642                     ; 286 			else if(page_n->row == 2)
5644  0b23 1e08          	ldw	x,(OFST+8,sp)
5645  0b25 e601          	ld	a,(1,x)
5646  0b27 a102          	cp	a,#2
5647  0b29 2615          	jrne	L1362
5648                     ; 288 				Display_LCD_String_XY(2,1,"●",1);
5650  0b2b 4b01          	push	#1
5651  0b2d ae009e        	ldw	x,#L3452
5652  0b30 89            	pushw	x
5653  0b31 ae0001        	ldw	x,#1
5654  0b34 a602          	ld	a,#2
5655  0b36 95            	ld	xh,a
5656  0b37 cd0000        	call	_Display_LCD_String_XY
5658  0b3a 5b03          	addw	sp,#3
5660  0b3c acf00df0      	jpf	L3152
5661  0b40               L1362:
5662                     ; 290 			else if(page_n->row == 3)
5664  0b40 1e08          	ldw	x,(OFST+8,sp)
5665  0b42 e601          	ld	a,(1,x)
5666  0b44 a103          	cp	a,#3
5667  0b46 2703          	jreq	L24
5668  0b48 cc0df0        	jp	L3152
5669  0b4b               L24:
5670                     ; 292 				Display_LCD_String_XY(3,1,"●",1);
5672  0b4b 4b01          	push	#1
5673  0b4d ae009e        	ldw	x,#L3452
5674  0b50 89            	pushw	x
5675  0b51 ae0001        	ldw	x,#1
5676  0b54 a603          	ld	a,#3
5677  0b56 95            	ld	xh,a
5678  0b57 cd0000        	call	_Display_LCD_String_XY
5680  0b5a 5b03          	addw	sp,#3
5681  0b5c acf00df0      	jpf	L3152
5682  0b60               L5062:
5683                     ; 295 	else if(page_n->page == 4)
5685  0b60 1e08          	ldw	x,(OFST+8,sp)
5686  0b62 f6            	ld	a,(x)
5687  0b63 a104          	cp	a,#4
5688  0b65 2703          	jreq	L44
5689  0b67 cc0c22        	jp	L1462
5690  0b6a               L44:
5691                     ; 297 		Display_LCD_String_XY(0,0,"  ",0);
5693  0b6a 4b00          	push	#0
5694  0b6c ae01a0        	ldw	x,#L3142
5695  0b6f 89            	pushw	x
5696  0b70 5f            	clrw	x
5697  0b71 4f            	clr	a
5698  0b72 95            	ld	xh,a
5699  0b73 cd0000        	call	_Display_LCD_String_XY
5701  0b76 5b03          	addw	sp,#3
5702                     ; 298 		Display_LCD_String_XY(1,0,"设",0);
5704  0b78 4b00          	push	#0
5705  0b7a ae0074        	ldw	x,#L3462
5706  0b7d 89            	pushw	x
5707  0b7e 5f            	clrw	x
5708  0b7f a601          	ld	a,#1
5709  0b81 95            	ld	xh,a
5710  0b82 cd0000        	call	_Display_LCD_String_XY
5712  0b85 5b03          	addw	sp,#3
5713                     ; 299 		Display_LCD_String_XY(2,0,"置",0);
5715  0b87 4b00          	push	#0
5716  0b89 ae0071        	ldw	x,#L5462
5717  0b8c 89            	pushw	x
5718  0b8d 5f            	clrw	x
5719  0b8e a602          	ld	a,#2
5720  0b90 95            	ld	xh,a
5721  0b91 cd0000        	call	_Display_LCD_String_XY
5723  0b94 5b03          	addw	sp,#3
5724                     ; 300 		Display_LCD_String_XY(3,0,"  ",0);
5726  0b96 4b00          	push	#0
5727  0b98 ae01a0        	ldw	x,#L3142
5728  0b9b 89            	pushw	x
5729  0b9c 5f            	clrw	x
5730  0b9d a603          	ld	a,#3
5731  0b9f 95            	ld	xh,a
5732  0ba0 cd0000        	call	_Display_LCD_String_XY
5734  0ba3 5b03          	addw	sp,#3
5735                     ; 302 		Display_LCD_String_XY(0,1,"  编码器: ",1);
5737  0ba5 4b01          	push	#1
5738  0ba7 ae0066        	ldw	x,#L7462
5739  0baa 89            	pushw	x
5740  0bab ae0001        	ldw	x,#1
5741  0bae 4f            	clr	a
5742  0baf 95            	ld	xh,a
5743  0bb0 cd0000        	call	_Display_LCD_String_XY
5745  0bb3 5b03          	addw	sp,#3
5746                     ; 303 		if(Encoder == 0)
5748  0bb5 3d00          	tnz	_Encoder
5749  0bb7 2612          	jrne	L1562
5750                     ; 305 			Display_LCD_String_XY(0,6,"开 ",1);
5752  0bb9 4b01          	push	#1
5753  0bbb ae0062        	ldw	x,#L3562
5754  0bbe 89            	pushw	x
5755  0bbf ae0006        	ldw	x,#6
5756  0bc2 4f            	clr	a
5757  0bc3 95            	ld	xh,a
5758  0bc4 cd0000        	call	_Display_LCD_String_XY
5760  0bc7 5b03          	addw	sp,#3
5762  0bc9 2010          	jra	L5562
5763  0bcb               L1562:
5764                     ; 309 			Display_LCD_String_XY(0,6,"关 ",1);
5766  0bcb 4b01          	push	#1
5767  0bcd ae005e        	ldw	x,#L7562
5768  0bd0 89            	pushw	x
5769  0bd1 ae0006        	ldw	x,#6
5770  0bd4 4f            	clr	a
5771  0bd5 95            	ld	xh,a
5772  0bd6 cd0000        	call	_Display_LCD_String_XY
5774  0bd9 5b03          	addw	sp,#3
5775  0bdb               L5562:
5776                     ; 311 		Display_LCD_String_XY(1,1,"  软件版本:V6L",1);
5778  0bdb 4b01          	push	#1
5779  0bdd ae004f        	ldw	x,#L1662
5780  0be0 89            	pushw	x
5781  0be1 ae0001        	ldw	x,#1
5782  0be4 a601          	ld	a,#1
5783  0be6 95            	ld	xh,a
5784  0be7 cd0000        	call	_Display_LCD_String_XY
5786  0bea 5b03          	addw	sp,#3
5787                     ; 312 		Display_LCD_String_XY(2,1,"  硬件版本:V5L",1);
5789  0bec 4b01          	push	#1
5790  0bee ae0040        	ldw	x,#L3662
5791  0bf1 89            	pushw	x
5792  0bf2 ae0001        	ldw	x,#1
5793  0bf5 a602          	ld	a,#2
5794  0bf7 95            	ld	xh,a
5795  0bf8 cd0000        	call	_Display_LCD_String_XY
5797  0bfb 5b03          	addw	sp,#3
5798                     ; 313 		Display_LCD_String_XY(3,1,"  更新:15-8-2",1);
5800  0bfd 4b01          	push	#1
5801  0bff ae0032        	ldw	x,#L5662
5802  0c02 89            	pushw	x
5803  0c03 ae0001        	ldw	x,#1
5804  0c06 a603          	ld	a,#3
5805  0c08 95            	ld	xh,a
5806  0c09 cd0000        	call	_Display_LCD_String_XY
5808  0c0c 5b03          	addw	sp,#3
5809                     ; 314 		Display_LCD_String_XY(0,1,"●",1);
5811  0c0e 4b01          	push	#1
5812  0c10 ae009e        	ldw	x,#L3452
5813  0c13 89            	pushw	x
5814  0c14 ae0001        	ldw	x,#1
5815  0c17 4f            	clr	a
5816  0c18 95            	ld	xh,a
5817  0c19 cd0000        	call	_Display_LCD_String_XY
5819  0c1c 5b03          	addw	sp,#3
5821  0c1e acf00df0      	jpf	L3152
5822  0c22               L1462:
5823                     ; 316 	else if(page_n->page == 5)/*内部高权限操作普通方法下不来*/
5825  0c22 1e08          	ldw	x,(OFST+8,sp)
5826  0c24 f6            	ld	a,(x)
5827  0c25 a105          	cp	a,#5
5828  0c27 2703          	jreq	L64
5829  0c29 cc0df0        	jp	L3152
5830  0c2c               L64:
5831                     ; 318 		Display_LCD_String_XY(0,0,"测",0);
5833  0c2c 4b00          	push	#0
5834  0c2e ae0100        	ldw	x,#L1742
5835  0c31 89            	pushw	x
5836  0c32 5f            	clrw	x
5837  0c33 4f            	clr	a
5838  0c34 95            	ld	xh,a
5839  0c35 cd0000        	call	_Display_LCD_String_XY
5841  0c38 5b03          	addw	sp,#3
5842                     ; 319 		Display_LCD_String_XY(1,0,"试",0);
5844  0c3a 4b00          	push	#0
5845  0c3c ae002f        	ldw	x,#L3762
5846  0c3f 89            	pushw	x
5847  0c40 5f            	clrw	x
5848  0c41 a601          	ld	a,#1
5849  0c43 95            	ld	xh,a
5850  0c44 cd0000        	call	_Display_LCD_String_XY
5852  0c47 5b03          	addw	sp,#3
5853                     ; 320 		Display_LCD_String_XY(2,0,"模",0);
5855  0c49 4b00          	push	#0
5856  0c4b ae002c        	ldw	x,#L5762
5857  0c4e 89            	pushw	x
5858  0c4f 5f            	clrw	x
5859  0c50 a602          	ld	a,#2
5860  0c52 95            	ld	xh,a
5861  0c53 cd0000        	call	_Display_LCD_String_XY
5863  0c56 5b03          	addw	sp,#3
5864                     ; 321 		Display_LCD_String_XY(3,0,"式", 0);
5866  0c58 4b00          	push	#0
5867  0c5a ae0029        	ldw	x,#L7762
5868  0c5d 89            	pushw	x
5869  0c5e 5f            	clrw	x
5870  0c5f a603          	ld	a,#3
5871  0c61 95            	ld	xh,a
5872  0c62 cd0000        	call	_Display_LCD_String_XY
5874  0c65 5b03          	addw	sp,#3
5875                     ; 323 		Display_LCD_String_XY(0,1,"  旋转位置:",1);
5877  0c67 4b01          	push	#1
5878  0c69 ae0152        	ldw	x,#L5342
5879  0c6c 89            	pushw	x
5880  0c6d ae0001        	ldw	x,#1
5881  0c70 4f            	clr	a
5882  0c71 95            	ld	xh,a
5883  0c72 cd0000        	call	_Display_LCD_String_XY
5885  0c75 5b03          	addw	sp,#3
5886                     ; 324 		Write_LCD_Data(0x30+page_n->dr_num/10);
5888  0c77 1e08          	ldw	x,(OFST+8,sp)
5889  0c79 e603          	ld	a,(3,x)
5890  0c7b ae000a        	ldw	x,#10
5891  0c7e 51            	exgw	x,y
5892  0c7f 5f            	clrw	x
5893  0c80 97            	ld	xl,a
5894  0c81 65            	divw	x,y
5895  0c82 9f            	ld	a,xl
5896  0c83 ab30          	add	a,#48
5897  0c85 cd0000        	call	_Write_LCD_Data
5899                     ; 325 		Write_LCD_Data(0x30+page_n->dr_num%10);
5901  0c88 1e08          	ldw	x,(OFST+8,sp)
5902  0c8a e603          	ld	a,(3,x)
5903  0c8c ae000a        	ldw	x,#10
5904  0c8f 51            	exgw	x,y
5905  0c90 5f            	clrw	x
5906  0c91 97            	ld	xl,a
5907  0c92 65            	divw	x,y
5908  0c93 909f          	ld	a,yl
5909  0c95 ab30          	add	a,#48
5910  0c97 cd0000        	call	_Write_LCD_Data
5912                     ; 326 		Display_LCD_String_XY(1,1,"  抽屉出来:",1);
5914  0c9a 4b01          	push	#1
5915  0c9c ae001d        	ldw	x,#L1072
5916  0c9f 89            	pushw	x
5917  0ca0 ae0001        	ldw	x,#1
5918  0ca3 a601          	ld	a,#1
5919  0ca5 95            	ld	xh,a
5920  0ca6 cd0000        	call	_Display_LCD_String_XY
5922  0ca9 5b03          	addw	sp,#3
5923                     ; 327 		Write_LCD_Data(0x30+page_n->rb_num/10);
5925  0cab 1e08          	ldw	x,(OFST+8,sp)
5926  0cad e604          	ld	a,(4,x)
5927  0caf ae000a        	ldw	x,#10
5928  0cb2 51            	exgw	x,y
5929  0cb3 5f            	clrw	x
5930  0cb4 97            	ld	xl,a
5931  0cb5 65            	divw	x,y
5932  0cb6 9f            	ld	a,xl
5933  0cb7 ab30          	add	a,#48
5934  0cb9 cd0000        	call	_Write_LCD_Data
5936                     ; 328 		Write_LCD_Data(0x30+page_n->rb_num%10);
5938  0cbc 1e08          	ldw	x,(OFST+8,sp)
5939  0cbe e604          	ld	a,(4,x)
5940  0cc0 ae000a        	ldw	x,#10
5941  0cc3 51            	exgw	x,y
5942  0cc4 5f            	clrw	x
5943  0cc5 97            	ld	xl,a
5944  0cc6 65            	divw	x,y
5945  0cc7 909f          	ld	a,yl
5946  0cc9 ab30          	add	a,#48
5947  0ccb cd0000        	call	_Write_LCD_Data
5949                     ; 329 		Display_LCD_String_XY(2,1,"  抽提回来:",1);
5951  0cce 4b01          	push	#1
5952  0cd0 ae0011        	ldw	x,#L3072
5953  0cd3 89            	pushw	x
5954  0cd4 ae0001        	ldw	x,#1
5955  0cd7 a602          	ld	a,#2
5956  0cd9 95            	ld	xh,a
5957  0cda cd0000        	call	_Display_LCD_String_XY
5959  0cdd 5b03          	addw	sp,#3
5960                     ; 330 		Write_LCD_Data(0x30+page_n->rb_num/10);
5962  0cdf 1e08          	ldw	x,(OFST+8,sp)
5963  0ce1 e604          	ld	a,(4,x)
5964  0ce3 ae000a        	ldw	x,#10
5965  0ce6 51            	exgw	x,y
5966  0ce7 5f            	clrw	x
5967  0ce8 97            	ld	xl,a
5968  0ce9 65            	divw	x,y
5969  0cea 9f            	ld	a,xl
5970  0ceb ab30          	add	a,#48
5971  0ced cd0000        	call	_Write_LCD_Data
5973                     ; 331 		Write_LCD_Data(0x30+page_n->rb_num%10);
5975  0cf0 1e08          	ldw	x,(OFST+8,sp)
5976  0cf2 e604          	ld	a,(4,x)
5977  0cf4 ae000a        	ldw	x,#10
5978  0cf7 51            	exgw	x,y
5979  0cf8 5f            	clrw	x
5980  0cf9 97            	ld	xl,a
5981  0cfa 65            	divw	x,y
5982  0cfb 909f          	ld	a,yl
5983  0cfd ab30          	add	a,#48
5984  0cff cd0000        	call	_Write_LCD_Data
5986                     ; 332 		Display_LCD_String_XY(3,1,"  回到零位   ",1);
5988  0d02 4b01          	push	#1
5989  0d04 ae0003        	ldw	x,#L5072
5990  0d07 89            	pushw	x
5991  0d08 ae0001        	ldw	x,#1
5992  0d0b a603          	ld	a,#3
5993  0d0d 95            	ld	xh,a
5994  0d0e cd0000        	call	_Display_LCD_String_XY
5996  0d11 5b03          	addw	sp,#3
5997                     ; 335 		if(page_n->ins_row == 0)
5999  0d13 1e08          	ldw	x,(OFST+8,sp)
6000  0d15 6d02          	tnz	(2,x)
6001  0d17 266e          	jrne	L7072
6002                     ; 337 			if(page_n->row == 0)
6004  0d19 1e08          	ldw	x,(OFST+8,sp)
6005  0d1b 6d01          	tnz	(1,x)
6006  0d1d 2614          	jrne	L1172
6007                     ; 339 				Display_LCD_String_XY(0,1,"●",1);
6009  0d1f 4b01          	push	#1
6010  0d21 ae009e        	ldw	x,#L3452
6011  0d24 89            	pushw	x
6012  0d25 ae0001        	ldw	x,#1
6013  0d28 4f            	clr	a
6014  0d29 95            	ld	xh,a
6015  0d2a cd0000        	call	_Display_LCD_String_XY
6017  0d2d 5b03          	addw	sp,#3
6019  0d2f acf00df0      	jpf	L3152
6020  0d33               L1172:
6021                     ; 341 			else if(page_n->row == 1)
6023  0d33 1e08          	ldw	x,(OFST+8,sp)
6024  0d35 e601          	ld	a,(1,x)
6025  0d37 a101          	cp	a,#1
6026  0d39 2615          	jrne	L5172
6027                     ; 343 				Display_LCD_String_XY(1,1,"●",1);
6029  0d3b 4b01          	push	#1
6030  0d3d ae009e        	ldw	x,#L3452
6031  0d40 89            	pushw	x
6032  0d41 ae0001        	ldw	x,#1
6033  0d44 a601          	ld	a,#1
6034  0d46 95            	ld	xh,a
6035  0d47 cd0000        	call	_Display_LCD_String_XY
6037  0d4a 5b03          	addw	sp,#3
6039  0d4c acf00df0      	jpf	L3152
6040  0d50               L5172:
6041                     ; 345 			else if(page_n->row == 2)
6043  0d50 1e08          	ldw	x,(OFST+8,sp)
6044  0d52 e601          	ld	a,(1,x)
6045  0d54 a102          	cp	a,#2
6046  0d56 2614          	jrne	L1272
6047                     ; 347 				Display_LCD_String_XY(2,1,"●",1);
6049  0d58 4b01          	push	#1
6050  0d5a ae009e        	ldw	x,#L3452
6051  0d5d 89            	pushw	x
6052  0d5e ae0001        	ldw	x,#1
6053  0d61 a602          	ld	a,#2
6054  0d63 95            	ld	xh,a
6055  0d64 cd0000        	call	_Display_LCD_String_XY
6057  0d67 5b03          	addw	sp,#3
6059  0d69 cc0df0        	jra	L3152
6060  0d6c               L1272:
6061                     ; 349 			else if(page_n->row == 3)
6063  0d6c 1e08          	ldw	x,(OFST+8,sp)
6064  0d6e e601          	ld	a,(1,x)
6065  0d70 a103          	cp	a,#3
6066  0d72 267c          	jrne	L3152
6067                     ; 351 				Display_LCD_String_XY(3,1,"●",1);
6069  0d74 4b01          	push	#1
6070  0d76 ae009e        	ldw	x,#L3452
6071  0d79 89            	pushw	x
6072  0d7a ae0001        	ldw	x,#1
6073  0d7d a603          	ld	a,#3
6074  0d7f 95            	ld	xh,a
6075  0d80 cd0000        	call	_Display_LCD_String_XY
6077  0d83 5b03          	addw	sp,#3
6078  0d85 2069          	jra	L3152
6079  0d87               L7072:
6080                     ; 354 		else if(page_n->ins_row == 1)
6082  0d87 1e08          	ldw	x,(OFST+8,sp)
6083  0d89 e602          	ld	a,(2,x)
6084  0d8b a101          	cp	a,#1
6085  0d8d 2612          	jrne	L1372
6086                     ; 356 			Display_LCD_String_XY(0,1,"○",1);
6088  0d8f 4b01          	push	#1
6089  0d91 ae0000        	ldw	x,#L3372
6090  0d94 89            	pushw	x
6091  0d95 ae0001        	ldw	x,#1
6092  0d98 4f            	clr	a
6093  0d99 95            	ld	xh,a
6094  0d9a cd0000        	call	_Display_LCD_String_XY
6096  0d9d 5b03          	addw	sp,#3
6098  0d9f 204f          	jra	L3152
6099  0da1               L1372:
6100                     ; 358 		else if(page_n->ins_row == 2)
6102  0da1 1e08          	ldw	x,(OFST+8,sp)
6103  0da3 e602          	ld	a,(2,x)
6104  0da5 a102          	cp	a,#2
6105  0da7 2613          	jrne	L7372
6106                     ; 360 			Display_LCD_String_XY(1,1,"○",1);
6108  0da9 4b01          	push	#1
6109  0dab ae0000        	ldw	x,#L3372
6110  0dae 89            	pushw	x
6111  0daf ae0001        	ldw	x,#1
6112  0db2 a601          	ld	a,#1
6113  0db4 95            	ld	xh,a
6114  0db5 cd0000        	call	_Display_LCD_String_XY
6116  0db8 5b03          	addw	sp,#3
6118  0dba 2034          	jra	L3152
6119  0dbc               L7372:
6120                     ; 362 		else if(page_n->ins_row == 3)
6122  0dbc 1e08          	ldw	x,(OFST+8,sp)
6123  0dbe e602          	ld	a,(2,x)
6124  0dc0 a103          	cp	a,#3
6125  0dc2 2613          	jrne	L3472
6126                     ; 364 			Display_LCD_String_XY(2,1,"○",1);
6128  0dc4 4b01          	push	#1
6129  0dc6 ae0000        	ldw	x,#L3372
6130  0dc9 89            	pushw	x
6131  0dca ae0001        	ldw	x,#1
6132  0dcd a602          	ld	a,#2
6133  0dcf 95            	ld	xh,a
6134  0dd0 cd0000        	call	_Display_LCD_String_XY
6136  0dd3 5b03          	addw	sp,#3
6138  0dd5 2019          	jra	L3152
6139  0dd7               L3472:
6140                     ; 366 		else if(page_n->ins_row == 4)
6142  0dd7 1e08          	ldw	x,(OFST+8,sp)
6143  0dd9 e602          	ld	a,(2,x)
6144  0ddb a104          	cp	a,#4
6145  0ddd 2611          	jrne	L3152
6146                     ; 368 			Display_LCD_String_XY(3,1,"○",1);
6148  0ddf 4b01          	push	#1
6149  0de1 ae0000        	ldw	x,#L3372
6150  0de4 89            	pushw	x
6151  0de5 ae0001        	ldw	x,#1
6152  0de8 a603          	ld	a,#3
6153  0dea 95            	ld	xh,a
6154  0deb cd0000        	call	_Display_LCD_String_XY
6156  0dee 5b03          	addw	sp,#3
6157  0df0               L3152:
6158                     ; 371 }
6161  0df0 85            	popw	x
6162  0df1 81            	ret
6207                     ; 373 void eeprom_count(u8 ad)
6207                     ; 374 {
6208                     	switch	.text
6209  0df2               _eeprom_count:
6211  0df2 88            	push	a
6212  0df3 88            	push	a
6213       00000001      OFST:	set	1
6216                     ; 375 	u8 i = Eeprom_Read(ad);
6218  0df4 cd0000        	call	_Eeprom_Read
6220  0df7 6b01          	ld	(OFST+0,sp),a
6221                     ; 376 	if(i == 9)
6223  0df9 7b01          	ld	a,(OFST+0,sp)
6224  0dfb a109          	cp	a,#9
6225  0dfd 2703          	jreq	L25
6226  0dff cc0e99        	jp	L3772
6227  0e02               L25:
6228                     ; 378 		Eeprom_Write(ad,0);
6230  0e02 5f            	clrw	x
6231  0e03 7b02          	ld	a,(OFST+1,sp)
6232  0e05 95            	ld	xh,a
6233  0e06 cd0000        	call	_Eeprom_Write
6235                     ; 379 		i = Eeprom_Read(ad+1);
6237  0e09 7b02          	ld	a,(OFST+1,sp)
6238  0e0b 4c            	inc	a
6239  0e0c cd0000        	call	_Eeprom_Read
6241  0e0f 6b01          	ld	(OFST+0,sp),a
6242                     ; 380 		if(i == 9)
6244  0e11 7b01          	ld	a,(OFST+0,sp)
6245  0e13 a109          	cp	a,#9
6246  0e15 2674          	jrne	L5772
6247                     ; 382 			Eeprom_Write(ad+1,0);
6249  0e17 5f            	clrw	x
6250  0e18 7b02          	ld	a,(OFST+1,sp)
6251  0e1a 4c            	inc	a
6252  0e1b 95            	ld	xh,a
6253  0e1c cd0000        	call	_Eeprom_Write
6255                     ; 383 			i = Eeprom_Read(ad+2);
6257  0e1f 7b02          	ld	a,(OFST+1,sp)
6258  0e21 ab02          	add	a,#2
6259  0e23 cd0000        	call	_Eeprom_Read
6261  0e26 6b01          	ld	(OFST+0,sp),a
6262                     ; 384 			if(i == 9)
6264  0e28 7b01          	ld	a,(OFST+0,sp)
6265  0e2a a109          	cp	a,#9
6266  0e2c 264e          	jrne	L7772
6267                     ; 386 				Eeprom_Write(ad+2,0);
6269  0e2e 5f            	clrw	x
6270  0e2f 7b02          	ld	a,(OFST+1,sp)
6271  0e31 ab02          	add	a,#2
6272  0e33 95            	ld	xh,a
6273  0e34 cd0000        	call	_Eeprom_Write
6275                     ; 387 				i = Eeprom_Read(ad+3);
6277  0e37 7b02          	ld	a,(OFST+1,sp)
6278  0e39 ab03          	add	a,#3
6279  0e3b cd0000        	call	_Eeprom_Read
6281  0e3e 6b01          	ld	(OFST+0,sp),a
6282                     ; 388 				if(i == 9)
6284  0e40 7b01          	ld	a,(OFST+0,sp)
6285  0e42 a109          	cp	a,#9
6286  0e44 2627          	jrne	L1003
6287                     ; 390 					Eeprom_Write(ad+3,0);
6289  0e46 5f            	clrw	x
6290  0e47 7b02          	ld	a,(OFST+1,sp)
6291  0e49 ab03          	add	a,#3
6292  0e4b 95            	ld	xh,a
6293  0e4c cd0000        	call	_Eeprom_Write
6295                     ; 391 					i = Eeprom_Read(ad+4);
6297  0e4f 7b02          	ld	a,(OFST+1,sp)
6298  0e51 ab04          	add	a,#4
6299  0e53 cd0000        	call	_Eeprom_Read
6301  0e56 6b01          	ld	(OFST+0,sp),a
6302                     ; 392 					if(i == 9)
6304  0e58 7b01          	ld	a,(OFST+0,sp)
6305  0e5a a109          	cp	a,#9
6306  0e5c 2746          	jreq	L5103
6308                     ; 398 						i++;
6310  0e5e 0c01          	inc	(OFST+0,sp)
6311                     ; 399 						Eeprom_Write(ad+4,i);
6313  0e60 7b01          	ld	a,(OFST+0,sp)
6314  0e62 97            	ld	xl,a
6315  0e63 7b02          	ld	a,(OFST+1,sp)
6316  0e65 ab04          	add	a,#4
6317  0e67 95            	ld	xh,a
6318  0e68 cd0000        	call	_Eeprom_Write
6320  0e6b 2037          	jra	L5103
6321  0e6d               L1003:
6322                     ; 404 					i++;
6324  0e6d 0c01          	inc	(OFST+0,sp)
6325                     ; 405 					Eeprom_Write(ad+3,i);
6327  0e6f 7b01          	ld	a,(OFST+0,sp)
6328  0e71 97            	ld	xl,a
6329  0e72 7b02          	ld	a,(OFST+1,sp)
6330  0e74 ab03          	add	a,#3
6331  0e76 95            	ld	xh,a
6332  0e77 cd0000        	call	_Eeprom_Write
6334  0e7a 2028          	jra	L5103
6335  0e7c               L7772:
6336                     ; 410 				i++;
6338  0e7c 0c01          	inc	(OFST+0,sp)
6339                     ; 411 				Eeprom_Write(ad+2,i);
6341  0e7e 7b01          	ld	a,(OFST+0,sp)
6342  0e80 97            	ld	xl,a
6343  0e81 7b02          	ld	a,(OFST+1,sp)
6344  0e83 ab02          	add	a,#2
6345  0e85 95            	ld	xh,a
6346  0e86 cd0000        	call	_Eeprom_Write
6348  0e89 2019          	jra	L5103
6349  0e8b               L5772:
6350                     ; 416 			i++;
6352  0e8b 0c01          	inc	(OFST+0,sp)
6353                     ; 417 			Eeprom_Write(ad+1,i);
6355  0e8d 7b01          	ld	a,(OFST+0,sp)
6356  0e8f 97            	ld	xl,a
6357  0e90 7b02          	ld	a,(OFST+1,sp)
6358  0e92 4c            	inc	a
6359  0e93 95            	ld	xh,a
6360  0e94 cd0000        	call	_Eeprom_Write
6362  0e97 200b          	jra	L5103
6363  0e99               L3772:
6364                     ; 422 		i++;
6366  0e99 0c01          	inc	(OFST+0,sp)
6367                     ; 423 		Eeprom_Write(ad,i);
6369  0e9b 7b01          	ld	a,(OFST+0,sp)
6370  0e9d 97            	ld	xl,a
6371  0e9e 7b02          	ld	a,(OFST+1,sp)
6372  0ea0 95            	ld	xh,a
6373  0ea1 cd0000        	call	_Eeprom_Write
6375  0ea4               L5103:
6376                     ; 425 }
6379  0ea4 85            	popw	x
6380  0ea5 81            	ret
6415                     ; 427 void eeprom_cle(u8 ad)
6415                     ; 428 {
6416                     	switch	.text
6417  0ea6               _eeprom_cle:
6419  0ea6 88            	push	a
6420       00000000      OFST:	set	0
6423                     ; 429 	Eeprom_Write(ad,0);
6425  0ea7 5f            	clrw	x
6426  0ea8 95            	ld	xh,a
6427  0ea9 cd0000        	call	_Eeprom_Write
6429                     ; 430 	Eeprom_Write(ad+1,0);
6431  0eac 5f            	clrw	x
6432  0ead 7b01          	ld	a,(OFST+1,sp)
6433  0eaf 4c            	inc	a
6434  0eb0 95            	ld	xh,a
6435  0eb1 cd0000        	call	_Eeprom_Write
6437                     ; 431 	Eeprom_Write(ad+2,0);
6439  0eb4 5f            	clrw	x
6440  0eb5 7b01          	ld	a,(OFST+1,sp)
6441  0eb7 ab02          	add	a,#2
6442  0eb9 95            	ld	xh,a
6443  0eba cd0000        	call	_Eeprom_Write
6445                     ; 432 	Eeprom_Write(ad+3,0);
6447  0ebd 5f            	clrw	x
6448  0ebe 7b01          	ld	a,(OFST+1,sp)
6449  0ec0 ab03          	add	a,#3
6450  0ec2 95            	ld	xh,a
6451  0ec3 cd0000        	call	_Eeprom_Write
6453                     ; 433 	Eeprom_Write(ad+4,0);
6455  0ec6 5f            	clrw	x
6456  0ec7 7b01          	ld	a,(OFST+1,sp)
6457  0ec9 ab04          	add	a,#4
6458  0ecb 95            	ld	xh,a
6459  0ecc cd0000        	call	_Eeprom_Write
6461                     ; 434 }
6464  0ecf 84            	pop	a
6465  0ed0 81            	ret
6499                     ; 436 int abs(int x)
6499                     ; 437 {
6500                     	switch	.text
6501  0ed1               _abs:
6503  0ed1 89            	pushw	x
6504       00000000      OFST:	set	0
6507                     ; 438 	if (x < 0)
6509  0ed2 9c            	rvf
6510  0ed3 a30000        	cpw	x,#0
6511  0ed6 2e03          	jrsge	L3503
6512                     ; 439 	return x * -1;
6514  0ed8 50            	negw	x
6516  0ed9 2002          	jra	L06
6517  0edb               L3503:
6518                     ; 441 	return x;
6520  0edb 1e01          	ldw	x,(OFST+1,sp)
6522  0edd               L06:
6524  0edd 5b02          	addw	sp,#2
6525  0edf 81            	ret
6538                     	xref.b	_Encoder
6539                     	xdef	_abs
6540                     	xdef	_eeprom_cle
6541                     	xdef	_eeprom_count
6542                     	xdef	_Menu_Host
6543                     	xref	_Eeprom_Read
6544                     	xref	_Eeprom_Write
6545                     	xref	_Display_LCD_String_XY
6546                     	xref	_Write_LCD_Data
6547                     .const:	section	.text
6548  0000               L3372:
6549  0000 a1f000        	dc.b	161,240,0
6550  0003               L5072:
6551  0003 2020bb        	dc.b	"  ",187
6552  0006 d8b5bdc1e3ce  	dc.b	216,181,189,193,227,206
6553  000c bb20202000    	dc.b	187,32,32,32,0
6554  0011               L3072:
6555  0011 2020b3        	dc.b	"  ",179
6556  0014 e9cce1bbd8c0  	dc.b	233,204,225,187,216,192
6557  001a b43a00        	dc.b	180,58,0
6558  001d               L1072:
6559  001d 2020b3        	dc.b	"  ",179
6560  0020 e9ccebb3f6c0  	dc.b	233,204,235,179,246,192
6561  0026 b43a00        	dc.b	180,58,0
6562  0029               L7762:
6563  0029 cabd00        	dc.b	202,189,0
6564  002c               L5762:
6565  002c c4a300        	dc.b	196,163,0
6566  002f               L3762:
6567  002f cad400        	dc.b	202,212,0
6568  0032               L5662:
6569  0032 2020b8        	dc.b	"  ",184
6570  0035 fcd0c23a3135  	dc.b	252,208,194,58,49,53
6571  003b 2d382d3200    	dc.b	"-8-2",0
6572  0040               L3662:
6573  0040 2020d3        	dc.b	"  ",211
6574  0043 b2bcfeb0e6b1  	dc.b	178,188,254,176,230,177
6575  0049 be3a56354c00  	dc.b	190,58,86,53,76,0
6576  004f               L1662:
6577  004f 2020c8        	dc.b	"  ",200
6578  0052 edbcfeb0e6b1  	dc.b	237,188,254,176,230,177
6579  0058 be3a56364c00  	dc.b	190,58,86,54,76,0
6580  005e               L7562:
6581  005e b9d82000      	dc.b	185,216,32,0
6582  0062               L3562:
6583  0062 bfaa2000      	dc.b	191,170,32,0
6584  0066               L7462:
6585  0066 2020b1        	dc.b	"  ",177
6586  0069 e0c2ebc6f73a  	dc.b	224,194,235,198,247,58
6587  006f 2000          	dc.b	" ",0
6588  0071               L5462:
6589  0071 d6c300        	dc.b	214,195,0
6590  0074               L3462:
6591  0074 c9e800        	dc.b	201,232,0
6592  0077               L7162:
6593  0077 5231303a00    	dc.b	"R10:",0
6594  007c               L5162:
6595  007c 52393a00      	dc.b	"R9:",0
6596  0080               L3162:
6597  0080 52383a00      	dc.b	"R8:",0
6598  0084               L1162:
6599  0084 52373a00      	dc.b	"R7:",0
6600  0088               L7062:
6601  0088 332000        	dc.b	"3 ",0
6602  008b               L3652:
6603  008b 52363a00      	dc.b	"R6:",0
6604  008f               L1652:
6605  008f 52353a00      	dc.b	"R5:",0
6606  0093               L7552:
6607  0093 52343a00      	dc.b	"R4:",0
6608  0097               L5552:
6609  0097 52333a00      	dc.b	"R3:",0
6610  009b               L3552:
6611  009b 322000        	dc.b	"2 ",0
6612  009e               L3452:
6613  009e a1f100        	dc.b	161,241,0
6614  00a1               L7352:
6615  00a1 52323a00      	dc.b	"R2:",0
6616  00a5               L5352:
6617  00a5 52313a00      	dc.b	"R1:",0
6618  00a9               L3352:
6619  00a9 2020b3        	dc.b	"  ",179
6620  00ac a4b0b46f6bc7  	dc.b	164,176,180,111,107,199
6621  00b2 e5c1e3202000  	dc.b	229,193,227,32,32,0
6622  00b8               L1352:
6623  00b8 2020bb        	dc.b	"  ",187
6624  00bb fad0b5cad6ca  	dc.b	250,208,181,202,214,202
6625  00c1 b9d3c3c1bf00  	dc.b	185,211,195,193,191,0
6626  00c7               L7252:
6627  00c7 312000        	dc.b	"1 ",0
6628  00ca               L5252:
6629  00ca cad600        	dc.b	202,214,0
6630  00cd               L3252:
6631  00cd d0b500        	dc.b	208,181,0
6632  00d0               L1252:
6633  00d0 bbfa00        	dc.b	187,250,0
6634  00d3               L7152:
6635  00d3 2020202000    	dc.b	"    ",0
6636  00d8               L1152:
6637  00d8 cceb00        	dc.b	204,235,0
6638  00db               L7052:
6639  00db b3e900        	dc.b	179,233,0
6640  00de               L5052:
6641  00de 2020d3        	dc.b	"  ",211
6642  00e1 d0d7e8b5b2d2  	dc.b	208,215,232,181,178,210
6643  00e7 ecb3a32000    	dc.b	236,179,163,32,0
6644  00ec               L1052:
6645  00ec 2020ce        	dc.b	"  ",206
6646  00ef ded7e8b5b2d5  	dc.b	222,215,232,181,178,213
6647  00f5 fdb3a32000    	dc.b	253,179,163,32,0
6648  00fa               L5742:
6649  00fa b5b500        	dc.b	181,181,0
6650  00fd               L3742:
6651  00fd d7e800        	dc.b	215,232,0
6652  0100               L1742:
6653  0100 b2e200        	dc.b	178,226,0
6654  0103               L7642:
6655  0103 bcec00        	dc.b	188,236,0
6656  0106               L5642:
6657  0106 2020ce        	dc.b	"  ",206
6658  0109 debbd8b5a53a  	dc.b	222,187,216,181,165,58
6659  010f 202000        	dc.b	"  ",0
6660  0112               L1642:
6661  0112 2020d3        	dc.b	"  ",211
6662  0115 d0bbd8b5a53a  	dc.b	208,187,216,181,165,58
6663  011b 202000        	dc.b	"  ",0
6664  011e               L5542:
6665  011e b5a500        	dc.b	181,165,0
6666  0121               L3542:
6667  0121 2020b1        	dc.b	"  ",177
6668  0124 e0c2ebc6f7d2  	dc.b	224,194,235,198,247,210
6669  012a ecb3a300      	dc.b	236,179,163,0
6670  012e               L7442:
6671  012e d2ec00        	dc.b	210,236,0
6672  0131               L5442:
6673  0131 2020b1        	dc.b	"  ",177
6674  0134 bebbfab1e0ba  	dc.b	190,187,250,177,224,186
6675  013a c53a00        	dc.b	197,58,0
6676  013d               L3442:
6677  013d 2020b5        	dc.b	"  ",181
6678  0140 c8b4fdbdd3ca  	dc.b	200,180,253,189,211,202
6679  0146 d5c3fcc1ee00  	dc.b	213,195,252,193,238,0
6680  014c               L1442:
6681  014c b3a300        	dc.b	179,163,0
6682  014f               L7342:
6683  014f d5fd00        	dc.b	213,253,0
6684  0152               L5342:
6685  0152 2020d0        	dc.b	"  ",208
6686  0155 fdd7aacebbd6  	dc.b	253,215,170,206,187,214
6687  015b c33a00        	dc.b	195,58,0
6688  015e               L3342:
6689  015e 202020202020  	dc.b	"              ",0
6690  016d               L1342:
6691  016d d7aa00        	dc.b	215,170,0
6692  0170               L7242:
6693  0170 d0fd00        	dc.b	208,253,0
6694  0173               L5242:
6695  0173 2020b3        	dc.b	"  ",179
6696  0176 e9ccebcebbd6  	dc.b	233,204,235,206,187,214
6697  017c c33a00        	dc.b	195,58,0
6698  017f               L3242:
6699  017f 2020d0        	dc.b	"  ",208
6700  0182 fdd7aacebbd6  	dc.b	253,215,170,206,187,214
6701  0188 c33a30312000  	dc.b	195,58,48,49,32,0
6702  018e               L1242:
6703  018e 2020b5        	dc.b	"  ",181
6704  0191 b1c7b0cebbd6  	dc.b	177,199,176,206,187,214
6705  0197 c33a00        	dc.b	195,58,0
6706  019a               L7142:
6707  019a c1e300        	dc.b	193,227,0
6708  019d               L5142:
6709  019d bbd800        	dc.b	187,216,0
6710  01a0               L3142:
6711  01a0 202000        	dc.b	"  ",0
6731                     	end
