   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3459                     ; 62 void delayms(u16 ms)	
3459                     ; 63 {						
3461                     	switch	.text
3462  0000               _delayms:
3464  0000 89            	pushw	x
3465  0001 89            	pushw	x
3466       00000002      OFST:	set	2
3469  0002 2015          	jra	L1232
3470  0004               L7132:
3471                     ; 67 		WDT();//清看门狗
3473  0004 35aa50e0      	mov	_IWDG_KR,#170
3474                     ; 68 		for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
3476  0008 5f            	clrw	x
3477  0009 1f01          	ldw	(OFST-1,sp),x
3478  000b               L5232:
3482  000b 1e01          	ldw	x,(OFST-1,sp)
3483  000d 1c0001        	addw	x,#1
3484  0010 1f01          	ldw	(OFST-1,sp),x
3487  0012 1e01          	ldw	x,(OFST-1,sp)
3488  0014 a30465        	cpw	x,#1125
3489  0017 25f2          	jrult	L5232
3490  0019               L1232:
3491                     ; 65 	while(ms--)
3493  0019 1e03          	ldw	x,(OFST+1,sp)
3494  001b 1d0001        	subw	x,#1
3495  001e 1f03          	ldw	(OFST+1,sp),x
3496  0020 1c0001        	addw	x,#1
3497  0023 a30000        	cpw	x,#0
3498  0026 26dc          	jrne	L7132
3499                     ; 70 }
3502  0028 5b04          	addw	sp,#4
3503  002a 81            	ret
3537                     ; 78 void delayus(u16 us) 	
3537                     ; 79 {	
3538                     	switch	.text
3539  002b               _delayus:
3541  002b 89            	pushw	x
3542       00000000      OFST:	set	0
3545  002c               L3532:
3546                     ; 80 	while(us--);
3548  002c 1e01          	ldw	x,(OFST+1,sp)
3549  002e 1d0001        	subw	x,#1
3550  0031 1f01          	ldw	(OFST+1,sp),x
3551  0033 1c0001        	addw	x,#1
3552  0036 a30000        	cpw	x,#0
3553  0039 26f1          	jrne	L3532
3554                     ; 81 }
3557  003b 85            	popw	x
3558  003c 81            	ret
3625                     ; 89 void BSP_Init(void)
3625                     ; 90 {
3626                     	switch	.text
3627  003d               _BSP_Init:
3631                     ; 91 	CLK_CKDIVR=0x00;//时钟预分频，默认8分配，0x18.16M-0x00；8M-0x08;4M-0x10;
3633  003d 725f50c6      	clr	_CLK_CKDIVR
3634                     ; 93 	PA_DDR |= BIT(3);
3636  0041 72165002      	bset	_PA_DDR,#3
3637                     ; 94 	PA_CR1 |= BIT(3); 
3639  0045 72165003      	bset	_PA_CR1,#3
3640                     ; 95 	PA_CR2 |= BIT(3);
3642  0049 72165004      	bset	_PA_CR2,#3
3643                     ; 97 	PD_DDR |= BIT(2);
3645  004d 72145011      	bset	_PD_DDR,#2
3646                     ; 98 	PD_CR1 |= BIT(2); 
3648  0051 72145012      	bset	_PD_CR1,#2
3649                     ; 99 	PD_CR2 |= BIT(2);
3651  0055 72145013      	bset	_PD_CR2,#2
3652                     ; 101 	PD_DDR &= ~BIT(4);
3654  0059 72195011      	bres	_PD_DDR,#4
3655                     ; 102 	PD_CR1 |= BIT(4); 
3657  005d 72185012      	bset	_PD_CR1,#4
3658                     ; 103 	PD_CR2 &= ~BIT(4);
3660  0061 72195013      	bres	_PD_CR2,#4
3661                     ; 105 	PD_DDR |= BIT(3);
3663  0065 72165011      	bset	_PD_DDR,#3
3664                     ; 106 	PD_CR1 |= BIT(3); 
3666  0069 72165012      	bset	_PD_CR1,#3
3667                     ; 107 	PD_CR2 |= BIT(3);
3669  006d 72165013      	bset	_PD_CR2,#3
3670                     ; 109 	PC_DDR &= ~BIT(3);
3672  0071 7217500c      	bres	_PC_DDR,#3
3673                     ; 110 	PC_CR1 |= BIT(3); 
3675  0075 7216500d      	bset	_PC_CR1,#3
3676                     ; 111 	PC_CR2 &= ~BIT(3);
3678  0079 7217500e      	bres	_PC_CR2,#3
3679                     ; 113 	PC_DDR &= ~BIT(4);
3681  007d 7219500c      	bres	_PC_DDR,#4
3682                     ; 114 	PC_CR1 |= BIT(4); 
3684  0081 7218500d      	bset	_PC_CR1,#4
3685                     ; 115 	PC_CR2 &= ~BIT(4);
3687  0085 7219500e      	bres	_PC_CR2,#4
3688                     ; 117 	PC_DDR &= ~BIT(7);
3690  0089 721f500c      	bres	_PC_DDR,#7
3691                     ; 118 	PC_CR1 |= BIT(7); 
3693  008d 721e500d      	bset	_PC_CR1,#7
3694                     ; 119 	PC_CR2 &= ~BIT(7);
3696  0091 721f500e      	bres	_PC_CR2,#7
3697                     ; 120 	PG_DDR &= ~BIT(0);
3699  0095 72115020      	bres	_PG_DDR,#0
3700                     ; 121 	PG_CR1 |= BIT(0); 
3702  0099 72105021      	bset	_PG_CR1,#0
3703                     ; 122 	PG_CR2 &= ~BIT(0);
3705  009d 72115022      	bres	_PG_CR2,#0
3706                     ; 123 	PG_DDR &= ~BIT(1);
3708  00a1 72135020      	bres	_PG_DDR,#1
3709                     ; 124 	PG_CR1 |= BIT(1); 
3711  00a5 72125021      	bset	_PG_CR1,#1
3712                     ; 125 	PG_CR2 &= ~BIT(1);
3714  00a9 72135022      	bres	_PG_CR2,#1
3715                     ; 126 	PE_DDR &= ~BIT(3);
3717  00ad 72175016      	bres	_PE_DDR,#3
3718                     ; 127 	PE_CR1 |= BIT(3); 
3720  00b1 72165017      	bset	_PE_CR1,#3
3721                     ; 128 	PE_CR2 &= ~BIT(3);
3723  00b5 72175018      	bres	_PE_CR2,#3
3724                     ; 130 	PE_DDR &= ~BIT(0);
3726  00b9 72115016      	bres	_PE_DDR,#0
3727                     ; 131 	PE_CR1 |= BIT(0); 
3729  00bd 72105017      	bset	_PE_CR1,#0
3730                     ; 132 	PE_CR2 &= ~BIT(0);
3732  00c1 72115018      	bres	_PE_CR2,#0
3733                     ; 133 	PE_DDR &= ~BIT(1);
3735  00c5 72135016      	bres	_PE_DDR,#1
3736                     ; 134 	PE_CR1 |= BIT(1); 
3738  00c9 72125017      	bset	_PE_CR1,#1
3739                     ; 135 	PE_CR2 &= ~BIT(1);
3741  00cd 72135018      	bres	_PE_CR2,#1
3742                     ; 136 	PE_DDR &= ~BIT(2);
3744  00d1 72155016      	bres	_PE_DDR,#2
3745                     ; 137 	PE_CR1 |= BIT(2); 
3747  00d5 72145017      	bset	_PE_CR1,#2
3748                     ; 138 	PE_CR2 &= ~BIT(2);
3750  00d9 72155018      	bres	_PE_CR2,#2
3751                     ; 139 	PD_DDR &= ~BIT(0);
3753  00dd 72115011      	bres	_PD_DDR,#0
3754                     ; 140 	PD_CR1 |= BIT(0); 
3756  00e1 72105012      	bset	_PD_CR1,#0
3757                     ; 141 	PD_CR2 &= ~BIT(0);
3759  00e5 72115013      	bres	_PD_CR2,#0
3760                     ; 143 	PC_DDR |= BIT(2);
3762  00e9 7214500c      	bset	_PC_DDR,#2
3763                     ; 144 	PC_CR1 |= BIT(2); 
3765  00ed 7214500d      	bset	_PC_CR1,#2
3766                     ; 145 	PC_CR2 |= BIT(2);
3768  00f1 7214500e      	bset	_PC_CR2,#2
3769                     ; 147 	PC_DDR |= BIT(1);
3771  00f5 7212500c      	bset	_PC_DDR,#1
3772                     ; 148 	PC_CR1 |= BIT(1); 
3774  00f9 7212500d      	bset	_PC_CR1,#1
3775                     ; 149 	PC_CR2 |= BIT(1);
3777  00fd 7212500e      	bset	_PC_CR2,#1
3778                     ; 151 	PA_DDR |= BIT(1);
3780  0101 72125002      	bset	_PA_DDR,#1
3781                     ; 152 	PA_CR1 |= BIT(1); 
3783  0105 72125003      	bset	_PA_CR1,#1
3784                     ; 153 	PA_CR2 |= BIT(1);
3786  0109 72125004      	bset	_PA_CR2,#1
3787                     ; 155 	PB_DDR &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
3789  010d c65007        	ld	a,_PB_DDR
3790  0110 a400          	and	a,#0
3791  0112 c75007        	ld	_PB_DDR,a
3792                     ; 156 	PB_CR1 |= ( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) ); 
3794  0115 c65008        	ld	a,_PB_CR1
3795  0118 aaff          	or	a,#255
3796  011a c75008        	ld	_PB_CR1,a
3797                     ; 157 	PB_CR2 &= ~( BIT(0)|BIT(1)|BIT(2)|BIT(3)|BIT(4)|BIT(5)|BIT(6)|BIT(7) );
3799  011d c65009        	ld	a,_PB_CR2
3800  0120 a400          	and	a,#0
3801  0122 c75009        	ld	_PB_CR2,a
3802                     ; 158 	PE_DDR &= ~( BIT(6)|BIT(7) );
3804  0125 c65016        	ld	a,_PE_DDR
3805  0128 a43f          	and	a,#63
3806  012a c75016        	ld	_PE_DDR,a
3807                     ; 159 	PE_CR1 |= ( BIT(6)|BIT(7) ); 
3809  012d c65017        	ld	a,_PE_CR1
3810  0130 aac0          	or	a,#192
3811  0132 c75017        	ld	_PE_CR1,a
3812                     ; 160 	PE_CR2 &= ~( BIT(6)|BIT(7) );
3814  0135 c65018        	ld	a,_PE_CR2
3815  0138 a43f          	and	a,#63
3816  013a c75018        	ld	_PE_CR2,a
3817                     ; 162 	PA_DDR |= BIT(2);
3819  013d 72145002      	bset	_PA_DDR,#2
3820                     ; 163 	PA_CR1 |= BIT(2); 
3822  0141 72145003      	bset	_PA_CR1,#2
3823                     ; 164 	PA_CR2 |= BIT(2);
3825  0145 72145004      	bset	_PA_CR2,#2
3826                     ; 166 	TIM1_PSCRH = 0X1F;
3828  0149 351f5260      	mov	_TIM1_PSCRH,#31
3829                     ; 167 	TIM1_PSCRL = 0X3F;
3831  014d 353f5261      	mov	_TIM1_PSCRL,#63
3832                     ; 168 	TIM1_ARRH = 0X00;
3834  0151 725f5262      	clr	_TIM1_ARRH
3835                     ; 169 	TIM1_ARRL = 0X01;
3837  0155 35015263      	mov	_TIM1_ARRL,#1
3838                     ; 170 	TIM1_IER = 0X01;
3840  0159 35015254      	mov	_TIM1_IER,#1
3841                     ; 171 	TIM1_CR1 = 0X01;
3843  015d 35015250      	mov	_TIM1_CR1,#1
3844                     ; 173 	TIM3_PSCR  =0x00;  
3846  0161 725f532a      	clr	_TIM3_PSCR
3847                     ; 174 	TIM3_EGR = 0x01; 
3849  0165 35015324      	mov	_TIM3_EGR,#1
3850                     ; 175 	TIM3_CNTRH = 0x0;          // Counter Starting Value;
3852  0169 725f5328      	clr	_TIM3_CNTRH
3853                     ; 176 	TIM3_CNTRL = 0x0;     
3855  016d 725f5329      	clr	_TIM3_CNTRL
3856                     ; 177 	TIM3_ARRH = 0X40;
3858  0171 3540532b      	mov	_TIM3_ARRH,#64
3859                     ; 178 	TIM3_ARRL = 0X01;
3861  0175 3501532c      	mov	_TIM3_ARRL,#1
3862                     ; 179 	TIM3_IER = 0X01;
3864  0179 35015321      	mov	_TIM3_IER,#1
3865                     ; 180 	TIM3_CR1 = 0X00;
3867  017d 725f5320      	clr	_TIM3_CR1
3868                     ; 183 	IWDG_KR = 0xCC;       //启动看门狗
3870  0181 35cc50e0      	mov	_IWDG_KR,#204
3871                     ; 184 	IWDG_KR = 0x55;       //解除写保护
3873  0185 355550e0      	mov	_IWDG_KR,#85
3874                     ; 185 	IWDG_PR = 0x06;       //256分频，最高1.02秒
3876  0189 350650e1      	mov	_IWDG_PR,#6
3877                     ; 186 	IWDG_RLR = 255;       //1020ms
3879  018d 35ff50e2      	mov	_IWDG_RLR,#255
3880                     ; 187 	IWDG_KR = 0xAA;       //写保护
3882  0191 35aa50e0      	mov	_IWDG_KR,#170
3883                     ; 188 	WDT();//清看门狗
3885  0195 35aa50e0      	mov	_IWDG_KR,#170
3886                     ; 202 	ITC_SPR5 |= BIT(2)|BIT(3)|BIT(4)|BIT(5);
3888  0199 c67f74        	ld	a,_ITC_SPR5
3889  019c aa3c          	or	a,#60
3890  019e c77f74        	ld	_ITC_SPR5,a
3891                     ; 203 	ITC_SPR6 |= BIT(0)|BIT(1)|BIT(2)|BIT(3);
3893  01a1 c67f75        	ld	a,_ITC_SPR6
3894  01a4 aa0f          	or	a,#15
3895  01a6 c77f75        	ld	_ITC_SPR6,a
3896                     ; 204 	ITC_SPR3 |= BIT(7);
3898  01a9 721e7f72      	bset	_ITC_SPR3,#7
3899                     ; 205 	ITC_SPR3 &= ~BIT(6);
3901  01ad 721d7f72      	bres	_ITC_SPR3,#6
3902                     ; 206 	ITC_SPR4 |= BIT(3);
3904  01b1 72167f73      	bset	_ITC_SPR4,#3
3905                     ; 207 	ITC_SPR4 &= ~BIT(2);
3907  01b5 72157f73      	bres	_ITC_SPR4,#2
3908                     ; 209 	pla_dc = 0;
3910  01b9 72155000      	bres	_OPA2
3911                     ; 210 	buzzer = 0;/*关闭蜂鸣器*/
3913  01bd 72135000      	bres	_OPA1
3914                     ; 211 	but_led = 1;/*关闭led*/
3916  01c1 7216500f      	bset	_OPD3
3917                     ; 212 	_asm("rim");//开中断，sim为关中断
3920  01c5 9a            rim
3922                     ; 213 }
3925  01c6 81            	ret
3964                     ; 221 void Addr_Read(u8 *address)
3964                     ; 222 {
3965                     	switch	.text
3966  01c7               _Addr_Read:
3968  01c7 89            	pushw	x
3969       00000000      OFST:	set	0
3972                     ; 223 	*address = 0;
3974  01c8 7f            	clr	(x)
3975                     ; 224 	if(adr_1 == 0)
3977                     	btst	_IPE3
3978  01ce 2506          	jrult	L5042
3979                     ; 226 		*address |= BIT(0);
3981  01d0 f6            	ld	a,(x)
3982  01d1 aa01          	or	a,#1
3983  01d3 f7            	ld	(x),a
3985  01d4 2006          	jra	L7042
3986  01d6               L5042:
3987                     ; 229 		*address &= ~BIT(0);
3989  01d6 1e01          	ldw	x,(OFST+1,sp)
3990  01d8 f6            	ld	a,(x)
3991  01d9 a4fe          	and	a,#254
3992  01db f7            	ld	(x),a
3993  01dc               L7042:
3994                     ; 231 	if(adr_2 == 0)
3996                     	btst	_IPG1
3997  01e1 2508          	jrult	L1142
3998                     ; 233 		*address |= BIT(1);
4000  01e3 1e01          	ldw	x,(OFST+1,sp)
4001  01e5 f6            	ld	a,(x)
4002  01e6 aa02          	or	a,#2
4003  01e8 f7            	ld	(x),a
4005  01e9 2006          	jra	L3142
4006  01eb               L1142:
4007                     ; 236 		*address &= ~BIT(1);
4009  01eb 1e01          	ldw	x,(OFST+1,sp)
4010  01ed f6            	ld	a,(x)
4011  01ee a4fd          	and	a,#253
4012  01f0 f7            	ld	(x),a
4013  01f1               L3142:
4014                     ; 238 	if(adr_3 == 0)
4016                     	btst	_IPG0
4017  01f6 2508          	jrult	L5142
4018                     ; 240 		*address |= BIT(2);
4020  01f8 1e01          	ldw	x,(OFST+1,sp)
4021  01fa f6            	ld	a,(x)
4022  01fb aa04          	or	a,#4
4023  01fd f7            	ld	(x),a
4025  01fe 2006          	jra	L7142
4026  0200               L5142:
4027                     ; 243 		*address &= ~BIT(2);
4029  0200 1e01          	ldw	x,(OFST+1,sp)
4030  0202 f6            	ld	a,(x)
4031  0203 a4fb          	and	a,#251
4032  0205 f7            	ld	(x),a
4033  0206               L7142:
4034                     ; 245 	if(adr_4 == 0)
4036                     	btst	_IPC7
4037  020b 2508          	jrult	L1242
4038                     ; 247 		*address |= BIT(3);
4040  020d 1e01          	ldw	x,(OFST+1,sp)
4041  020f f6            	ld	a,(x)
4042  0210 aa08          	or	a,#8
4043  0212 f7            	ld	(x),a
4045  0213 2006          	jra	L3242
4046  0215               L1242:
4047                     ; 250 		*address &= ~BIT(3);
4049  0215 1e01          	ldw	x,(OFST+1,sp)
4050  0217 f6            	ld	a,(x)
4051  0218 a4f7          	and	a,#247
4052  021a f7            	ld	(x),a
4053  021b               L3242:
4054                     ; 252 }
4057  021b 85            	popw	x
4058  021c 81            	ret
4104                     ; 255 void Shield_sava(u8 *Array)
4104                     ; 256 {
4105                     	switch	.text
4106  021d               _Shield_sava:
4108  021d 89            	pushw	x
4109  021e 5203          	subw	sp,#3
4110       00000003      OFST:	set	3
4113                     ; 258 	Shield = 0x03ff;
4115  0220 ae03ff        	ldw	x,#1023
4116  0223 bf00          	ldw	_Shield,x
4117                     ; 259 	for(i = 1;i < 11;i++)
4119  0225 a601          	ld	a,#1
4120  0227 6b03          	ld	(OFST+0,sp),a
4121  0229               L7442:
4122                     ; 261 		if(Array[i] == 0)
4124  0229 7b04          	ld	a,(OFST+1,sp)
4125  022b 97            	ld	xl,a
4126  022c 7b05          	ld	a,(OFST+2,sp)
4127  022e 1b03          	add	a,(OFST+0,sp)
4128  0230 2401          	jrnc	L61
4129  0232 5c            	incw	x
4130  0233               L61:
4131  0233 02            	rlwa	x,a
4132  0234 7d            	tnz	(x)
4133  0235 2626          	jrne	L5542
4134                     ; 263 			Shield &= (~BIT(i-1));
4136  0237 ae0001        	ldw	x,#1
4137  023a 7b03          	ld	a,(OFST+0,sp)
4138  023c 4a            	dec	a
4139  023d 4d            	tnz	a
4140  023e 2704          	jreq	L02
4141  0240               L22:
4142  0240 58            	sllw	x
4143  0241 4a            	dec	a
4144  0242 26fc          	jrne	L22
4145  0244               L02:
4146  0244 53            	cplw	x
4147  0245 1f01          	ldw	(OFST-2,sp),x
4148  0247 be00          	ldw	x,_Shield
4149  0249 01            	rrwa	x,a
4150  024a 1402          	and	a,(OFST-1,sp)
4151  024c 01            	rrwa	x,a
4152  024d 1401          	and	a,(OFST-2,sp)
4153  024f 01            	rrwa	x,a
4154  0250 bf00          	ldw	_Shield,x
4155                     ; 264 			S_buf[i-1] = 1;
4157  0252 7b03          	ld	a,(OFST+0,sp)
4158  0254 5f            	clrw	x
4159  0255 97            	ld	xl,a
4160  0256 5a            	decw	x
4161  0257 a601          	ld	a,#1
4162  0259 e700          	ld	(_S_buf,x),a
4164  025b 2007          	jra	L7542
4165  025d               L5542:
4166                     ; 268 			S_buf[i-1] = 0;
4168  025d 7b03          	ld	a,(OFST+0,sp)
4169  025f 5f            	clrw	x
4170  0260 97            	ld	xl,a
4171  0261 5a            	decw	x
4172  0262 6f00          	clr	(_S_buf,x)
4173  0264               L7542:
4174                     ; 259 	for(i = 1;i < 11;i++)
4176  0264 0c03          	inc	(OFST+0,sp)
4179  0266 7b03          	ld	a,(OFST+0,sp)
4180  0268 a10b          	cp	a,#11
4181  026a 25bd          	jrult	L7442
4182                     ; 271 }
4185  026c 5b05          	addw	sp,#5
4186  026e 81            	ret
4245                     ; 279 u8 Bar_Read(u8 *Array)
4245                     ; 280 {
4246                     	switch	.text
4247  026f               _Bar_Read:
4249  026f 89            	pushw	x
4250  0270 89            	pushw	x
4251       00000002      OFST:	set	2
4254                     ; 281 	volatile u16 place = 0;/*先对数据清零*/
4256  0271 5f            	clrw	x
4257  0272 1f01          	ldw	(OFST-1,sp),x
4258                     ; 282 	pla_dc = 0;/*打开光耦电源*/
4260  0274 72155000      	bres	_OPA2
4261                     ; 283 	delayms(5);/*等待稳定*/
4263  0278 ae0005        	ldw	x,#5
4264  027b cd0000        	call	_delayms
4266                     ; 284 	WDT();//清看门狗
4268  027e 35aa50e0      	mov	_IWDG_KR,#170
4269                     ; 285 	if(pla_0 == 0)
4271                     	btst	_IPB7
4272  0287 250c          	jrult	L3052
4273                     ; 287 		Array[1] = 0;
4275  0289 1e03          	ldw	x,(OFST+1,sp)
4276  028b 6f01          	clr	(1,x)
4277                     ; 288 		place |= BIT(0);
4279  028d 7b02          	ld	a,(OFST+0,sp)
4280  028f aa01          	or	a,#1
4281  0291 6b02          	ld	(OFST+0,sp),a
4283  0293 2012          	jra	L5052
4284  0295               L3052:
4285                     ; 292 		Array[1] = 1;
4287  0295 1e03          	ldw	x,(OFST+1,sp)
4288  0297 a601          	ld	a,#1
4289  0299 e701          	ld	(1,x),a
4290                     ; 293 		Array[1] = S_buf[0];
4292  029b 1e03          	ldw	x,(OFST+1,sp)
4293  029d b600          	ld	a,_S_buf
4294  029f e701          	ld	(1,x),a
4295                     ; 294 		place &= ~BIT(0);
4297  02a1 7b02          	ld	a,(OFST+0,sp)
4298  02a3 a4fe          	and	a,#254
4299  02a5 6b02          	ld	(OFST+0,sp),a
4300  02a7               L5052:
4301                     ; 296 	if(pla_1 == 0)
4303                     	btst	_IPB6
4304  02ac 250c          	jrult	L7052
4305                     ; 298 		Array[2] = 0;
4307  02ae 1e03          	ldw	x,(OFST+1,sp)
4308  02b0 6f02          	clr	(2,x)
4309                     ; 299 		place |= BIT(1);
4311  02b2 7b02          	ld	a,(OFST+0,sp)
4312  02b4 aa02          	or	a,#2
4313  02b6 6b02          	ld	(OFST+0,sp),a
4315  02b8 2012          	jra	L1152
4316  02ba               L7052:
4317                     ; 303 		Array[2] = 1;
4319  02ba 1e03          	ldw	x,(OFST+1,sp)
4320  02bc a601          	ld	a,#1
4321  02be e702          	ld	(2,x),a
4322                     ; 304 		Array[2] = S_buf[1];
4324  02c0 1e03          	ldw	x,(OFST+1,sp)
4325  02c2 b601          	ld	a,_S_buf+1
4326  02c4 e702          	ld	(2,x),a
4327                     ; 305 		place &= ~BIT(1);
4329  02c6 7b02          	ld	a,(OFST+0,sp)
4330  02c8 a4fd          	and	a,#253
4331  02ca 6b02          	ld	(OFST+0,sp),a
4332  02cc               L1152:
4333                     ; 307 	if(pla_2 == 0)
4335                     	btst	_IPB5
4336  02d1 250c          	jrult	L3152
4337                     ; 309 		Array[3] = 0;
4339  02d3 1e03          	ldw	x,(OFST+1,sp)
4340  02d5 6f03          	clr	(3,x)
4341                     ; 310 		place |= BIT(2);
4343  02d7 7b02          	ld	a,(OFST+0,sp)
4344  02d9 aa04          	or	a,#4
4345  02db 6b02          	ld	(OFST+0,sp),a
4347  02dd 2012          	jra	L5152
4348  02df               L3152:
4349                     ; 314 		Array[3] = 1;
4351  02df 1e03          	ldw	x,(OFST+1,sp)
4352  02e1 a601          	ld	a,#1
4353  02e3 e703          	ld	(3,x),a
4354                     ; 315 		Array[3] = S_buf[2];
4356  02e5 1e03          	ldw	x,(OFST+1,sp)
4357  02e7 b602          	ld	a,_S_buf+2
4358  02e9 e703          	ld	(3,x),a
4359                     ; 316 		place &= ~BIT(2);
4361  02eb 7b02          	ld	a,(OFST+0,sp)
4362  02ed a4fb          	and	a,#251
4363  02ef 6b02          	ld	(OFST+0,sp),a
4364  02f1               L5152:
4365                     ; 318 	if(pla_3 == 0)
4367                     	btst	_IPB4
4368  02f6 250c          	jrult	L7152
4369                     ; 320 		Array[4] = 0;
4371  02f8 1e03          	ldw	x,(OFST+1,sp)
4372  02fa 6f04          	clr	(4,x)
4373                     ; 321 		place |= BIT(3);
4375  02fc 7b02          	ld	a,(OFST+0,sp)
4376  02fe aa08          	or	a,#8
4377  0300 6b02          	ld	(OFST+0,sp),a
4379  0302 2012          	jra	L1252
4380  0304               L7152:
4381                     ; 325 		Array[4] = 1;
4383  0304 1e03          	ldw	x,(OFST+1,sp)
4384  0306 a601          	ld	a,#1
4385  0308 e704          	ld	(4,x),a
4386                     ; 326 		Array[4] = S_buf[3];
4388  030a 1e03          	ldw	x,(OFST+1,sp)
4389  030c b603          	ld	a,_S_buf+3
4390  030e e704          	ld	(4,x),a
4391                     ; 327 		place &= ~BIT(3);
4393  0310 7b02          	ld	a,(OFST+0,sp)
4394  0312 a4f7          	and	a,#247
4395  0314 6b02          	ld	(OFST+0,sp),a
4396  0316               L1252:
4397                     ; 329 	if(pla_4 == 0)
4399                     	btst	_IPB3
4400  031b 250c          	jrult	L3252
4401                     ; 331 		Array[5] = 0;
4403  031d 1e03          	ldw	x,(OFST+1,sp)
4404  031f 6f05          	clr	(5,x)
4405                     ; 332 		place |= BIT(4);
4407  0321 7b02          	ld	a,(OFST+0,sp)
4408  0323 aa10          	or	a,#16
4409  0325 6b02          	ld	(OFST+0,sp),a
4411  0327 2012          	jra	L5252
4412  0329               L3252:
4413                     ; 336 		Array[5] = 1;
4415  0329 1e03          	ldw	x,(OFST+1,sp)
4416  032b a601          	ld	a,#1
4417  032d e705          	ld	(5,x),a
4418                     ; 337 		Array[5] = S_buf[4];
4420  032f 1e03          	ldw	x,(OFST+1,sp)
4421  0331 b604          	ld	a,_S_buf+4
4422  0333 e705          	ld	(5,x),a
4423                     ; 338 		place &= ~BIT(4);
4425  0335 7b02          	ld	a,(OFST+0,sp)
4426  0337 a4ef          	and	a,#239
4427  0339 6b02          	ld	(OFST+0,sp),a
4428  033b               L5252:
4429                     ; 340 	if(pla_5 == 0)
4431                     	btst	_IPB2
4432  0340 250c          	jrult	L7252
4433                     ; 342 		Array[6] = 0;
4435  0342 1e03          	ldw	x,(OFST+1,sp)
4436  0344 6f06          	clr	(6,x)
4437                     ; 343 		place |= BIT(5);
4439  0346 7b02          	ld	a,(OFST+0,sp)
4440  0348 aa20          	or	a,#32
4441  034a 6b02          	ld	(OFST+0,sp),a
4443  034c 2012          	jra	L1352
4444  034e               L7252:
4445                     ; 347 		Array[6] = 1;
4447  034e 1e03          	ldw	x,(OFST+1,sp)
4448  0350 a601          	ld	a,#1
4449  0352 e706          	ld	(6,x),a
4450                     ; 348 		Array[6] = S_buf[5];
4452  0354 1e03          	ldw	x,(OFST+1,sp)
4453  0356 b605          	ld	a,_S_buf+5
4454  0358 e706          	ld	(6,x),a
4455                     ; 349 		place &= ~BIT(5);
4457  035a 7b02          	ld	a,(OFST+0,sp)
4458  035c a4df          	and	a,#223
4459  035e 6b02          	ld	(OFST+0,sp),a
4460  0360               L1352:
4461                     ; 351 	if(pla_6 == 0)
4463                     	btst	_IPB1
4464  0365 250c          	jrult	L3352
4465                     ; 353 		Array[7] = 0;
4467  0367 1e03          	ldw	x,(OFST+1,sp)
4468  0369 6f07          	clr	(7,x)
4469                     ; 354 		place |= BIT(6);
4471  036b 7b02          	ld	a,(OFST+0,sp)
4472  036d aa40          	or	a,#64
4473  036f 6b02          	ld	(OFST+0,sp),a
4475  0371 2012          	jra	L5352
4476  0373               L3352:
4477                     ; 358 		Array[7] = 1;
4479  0373 1e03          	ldw	x,(OFST+1,sp)
4480  0375 a601          	ld	a,#1
4481  0377 e707          	ld	(7,x),a
4482                     ; 359 		Array[7] = S_buf[6];
4484  0379 1e03          	ldw	x,(OFST+1,sp)
4485  037b b606          	ld	a,_S_buf+6
4486  037d e707          	ld	(7,x),a
4487                     ; 360 		place &= ~BIT(6);
4489  037f 7b02          	ld	a,(OFST+0,sp)
4490  0381 a4bf          	and	a,#191
4491  0383 6b02          	ld	(OFST+0,sp),a
4492  0385               L5352:
4493                     ; 362 	if(pla_7 == 0)
4495                     	btst	_IPB0
4496  038a 250c          	jrult	L7352
4497                     ; 364 		Array[8] = 0;
4499  038c 1e03          	ldw	x,(OFST+1,sp)
4500  038e 6f08          	clr	(8,x)
4501                     ; 365 		place |= BIT(7);
4503  0390 7b02          	ld	a,(OFST+0,sp)
4504  0392 aa80          	or	a,#128
4505  0394 6b02          	ld	(OFST+0,sp),a
4507  0396 2012          	jra	L1452
4508  0398               L7352:
4509                     ; 369 		Array[8] = 1;
4511  0398 1e03          	ldw	x,(OFST+1,sp)
4512  039a a601          	ld	a,#1
4513  039c e708          	ld	(8,x),a
4514                     ; 370 		Array[8] = S_buf[7];
4516  039e 1e03          	ldw	x,(OFST+1,sp)
4517  03a0 b607          	ld	a,_S_buf+7
4518  03a2 e708          	ld	(8,x),a
4519                     ; 371 		place &= ~BIT(7);
4521  03a4 7b02          	ld	a,(OFST+0,sp)
4522  03a6 a47f          	and	a,#127
4523  03a8 6b02          	ld	(OFST+0,sp),a
4524  03aa               L1452:
4525                     ; 373 	if(pla_8 == 0)
4527                     	btst	_IPE7
4528  03af 250c          	jrult	L3452
4529                     ; 375 		Array[9] = 0;
4531  03b1 1e03          	ldw	x,(OFST+1,sp)
4532  03b3 6f09          	clr	(9,x)
4533                     ; 376 		place |= BIT(8);
4535  03b5 7b01          	ld	a,(OFST-1,sp)
4536  03b7 aa01          	or	a,#1
4537  03b9 6b01          	ld	(OFST-1,sp),a
4539  03bb 2012          	jra	L5452
4540  03bd               L3452:
4541                     ; 380 		Array[9] = 1;
4543  03bd 1e03          	ldw	x,(OFST+1,sp)
4544  03bf a601          	ld	a,#1
4545  03c1 e709          	ld	(9,x),a
4546                     ; 381 		Array[9] = S_buf[8];
4548  03c3 1e03          	ldw	x,(OFST+1,sp)
4549  03c5 b608          	ld	a,_S_buf+8
4550  03c7 e709          	ld	(9,x),a
4551                     ; 382 		place &= ~BIT(8);
4553  03c9 7b01          	ld	a,(OFST-1,sp)
4554  03cb a4fe          	and	a,#254
4555  03cd 6b01          	ld	(OFST-1,sp),a
4556  03cf               L5452:
4557                     ; 384 	if(pla_9 == 0)
4559                     	btst	_IPE6
4560  03d4 250c          	jrult	L7452
4561                     ; 386 		Array[10] = 0;
4563  03d6 1e03          	ldw	x,(OFST+1,sp)
4564  03d8 6f0a          	clr	(10,x)
4565                     ; 387 		place |= BIT(9);
4567  03da 7b01          	ld	a,(OFST-1,sp)
4568  03dc aa02          	or	a,#2
4569  03de 6b01          	ld	(OFST-1,sp),a
4571  03e0 2012          	jra	L1552
4572  03e2               L7452:
4573                     ; 391 		Array[10] = 1;
4575  03e2 1e03          	ldw	x,(OFST+1,sp)
4576  03e4 a601          	ld	a,#1
4577  03e6 e70a          	ld	(10,x),a
4578                     ; 392 		Array[10] = S_buf[9];
4580  03e8 1e03          	ldw	x,(OFST+1,sp)
4581  03ea b609          	ld	a,_S_buf+9
4582  03ec e70a          	ld	(10,x),a
4583                     ; 393 		place &= ~BIT(9);
4585  03ee 7b01          	ld	a,(OFST-1,sp)
4586  03f0 a4fd          	and	a,#253
4587  03f2 6b01          	ld	(OFST-1,sp),a
4588  03f4               L1552:
4589                     ; 395 	place |= Shield;
4591  03f4 be00          	ldw	x,_Shield
4592  03f6 01            	rrwa	x,a
4593  03f7 1a02          	or	a,(OFST+0,sp)
4594  03f9 01            	rrwa	x,a
4595  03fa 1a01          	or	a,(OFST-1,sp)
4596  03fc 01            	rrwa	x,a
4597  03fd 1f01          	ldw	(OFST-1,sp),x
4598                     ; 396 	if(place == 0x3ff)/*检测有无阻挡，有则不关闭电源，一直到无阻挡*/
4600  03ff 1e01          	ldw	x,(OFST-1,sp)
4601  0401 a303ff        	cpw	x,#1023
4602  0404 2604          	jrne	L3552
4603                     ; 399 		return 1;
4605  0406 a601          	ld	a,#1
4607  0408 2001          	jra	L62
4608  040a               L3552:
4609                     ; 401 	return 0;
4611  040a 4f            	clr	a
4613  040b               L62:
4615  040b 5b04          	addw	sp,#4
4616  040d 81            	ret
4678                     ; 410 u8 Com_Check(u8 *place,u8 ad)
4678                     ; 411 {
4679                     	switch	.text
4680  040e               _Com_Check:
4682  040e 89            	pushw	x
4683  040f 5206          	subw	sp,#6
4684       00000006      OFST:	set	6
4687                     ; 413 	check_1 = place[0]+ad;
4689  0411 f6            	ld	a,(x)
4690  0412 1b0b          	add	a,(OFST+5,sp)
4691  0414 6b05          	ld	(OFST-1,sp),a
4693  0416 e602          	ld	a,(2,x)
4694  0418 1e07          	ldw	x,(OFST+1,sp)
4695  041a eb01          	add	a,(1,x)
4696  041c 1e07          	ldw	x,(OFST+1,sp)
4697  041e eb03          	add	a,(3,x)
4698  0420 1e07          	ldw	x,(OFST+1,sp)
4699  0422 eb04          	add	a,(4,x)
4700  0424 1e07          	ldw	x,(OFST+1,sp)
4701  0426 eb05          	add	a,(5,x)
4702  0428 1e07          	ldw	x,(OFST+1,sp)
4703  042a eb06          	add	a,(6,x)
4704  042c 1e07          	ldw	x,(OFST+1,sp)
4705  042e eb07          	add	a,(7,x)
4706  0430 1e07          	ldw	x,(OFST+1,sp)
4707  0432 eb08          	add	a,(8,x)
4708  0434 1e07          	ldw	x,(OFST+1,sp)
4709  0436 eb09          	add	a,(9,x)
4710  0438 6b04          	ld	(OFST-2,sp),a
4711                     ; 414 	check_2 = place[1]+place[2]+place[3]+place[4]+place[5]+place[6]+
4711                     ; 415 						place[7]+place[8]+place[9]+place[10];
4712  043a 7b04          	ld	a,(OFST-2,sp)
4713  043c 1e07          	ldw	x,(OFST+1,sp)
4714  043e eb0a          	add	a,(10,x)
4715  0440 6b06          	ld	(OFST+0,sp),a
4716                     ; 416 	if( (check_1 == place[11])&(check_2 == place[12])&(place[13] == 0x0a) )
4718  0442 1e07          	ldw	x,(OFST+1,sp)
4719  0444 e60d          	ld	a,(13,x)
4720  0446 a10a          	cp	a,#10
4721  0448 2605          	jrne	L23
4722  044a ae0001        	ldw	x,#1
4723  044d 2001          	jra	L43
4724  044f               L23:
4725  044f 5f            	clrw	x
4726  0450               L43:
4727  0450 1f03          	ldw	(OFST-3,sp),x
4728  0452 1e07          	ldw	x,(OFST+1,sp)
4729  0454 e60c          	ld	a,(12,x)
4730  0456 1106          	cp	a,(OFST+0,sp)
4731  0458 2605          	jrne	L63
4732  045a ae0001        	ldw	x,#1
4733  045d 2001          	jra	L04
4734  045f               L63:
4735  045f 5f            	clrw	x
4736  0460               L04:
4737  0460 1f01          	ldw	(OFST-5,sp),x
4738  0462 1e07          	ldw	x,(OFST+1,sp)
4739  0464 e60b          	ld	a,(11,x)
4740  0466 1105          	cp	a,(OFST-1,sp)
4741  0468 2605          	jrne	L24
4742  046a ae0001        	ldw	x,#1
4743  046d 2001          	jra	L44
4744  046f               L24:
4745  046f 5f            	clrw	x
4746  0470               L44:
4747  0470 01            	rrwa	x,a
4748  0471 1402          	and	a,(OFST-4,sp)
4749  0473 01            	rrwa	x,a
4750  0474 1401          	and	a,(OFST-5,sp)
4751  0476 01            	rrwa	x,a
4752  0477 01            	rrwa	x,a
4753  0478 1404          	and	a,(OFST-2,sp)
4754  047a 01            	rrwa	x,a
4755  047b 1403          	and	a,(OFST-3,sp)
4756  047d 01            	rrwa	x,a
4757  047e a30000        	cpw	x,#0
4758  0481 2704          	jreq	L7062
4759                     ; 418 		return 1;
4761  0483 a601          	ld	a,#1
4763  0485 2001          	jra	L64
4764  0487               L7062:
4765                     ; 420 	return 0;
4767  0487 4f            	clr	a
4769  0488               L64:
4771  0488 5b08          	addw	sp,#8
4772  048a 81            	ret
4800                     ; 429 void Eeprom_Init(void)
4800                     ; 430 {
4801                     	switch	.text
4802  048b               _Eeprom_Init:
4806                     ; 431 	FLASH_CR1 = 0X00;
4808  048b 725f505a      	clr	_FLASH_CR1
4809                     ; 432 	FLASH_CR2 = 0X00;
4811  048f 725f505b      	clr	_FLASH_CR2
4812                     ; 433 	FLASH_NCR2 = 0XFF;
4814  0493 35ff505c      	mov	_FLASH_NCR2,#255
4815                     ; 434 	FLASH_DUKR = 0XAE;
4817  0497 35ae5064      	mov	_FLASH_DUKR,#174
4818                     ; 435 	FLASH_DUKR = 0X56;
4820  049b 35565064      	mov	_FLASH_DUKR,#86
4822  049f               L5262:
4823                     ; 436 	while(!(FLASH_IAPSR&0X08));
4825  049f c6505f        	ld	a,_FLASH_IAPSR
4826  04a2 a508          	bcp	a,#8
4827  04a4 27f9          	jreq	L5262
4828                     ; 437 }
4831  04a6 81            	ret
4885                     ; 445 void Eeprom_Write(u8 addr,u8 dat)
4885                     ; 446 {
4886                     	switch	.text
4887  04a7               _Eeprom_Write:
4889  04a7 89            	pushw	x
4890  04a8 89            	pushw	x
4891       00000002      OFST:	set	2
4894                     ; 448 	p = (u8 *)(0x4000+addr);
4896  04a9 a640          	ld	a,#64
4897  04ab 97            	ld	xl,a
4898  04ac a600          	ld	a,#0
4899  04ae 1b03          	add	a,(OFST+1,sp)
4900  04b0 2401          	jrnc	L45
4901  04b2 5c            	incw	x
4902  04b3               L45:
4903  04b3 02            	rlwa	x,a
4904  04b4 1f01          	ldw	(OFST-1,sp),x
4905  04b6 01            	rrwa	x,a
4906                     ; 449 	*p = dat;
4908  04b7 7b04          	ld	a,(OFST+2,sp)
4909  04b9 1e01          	ldw	x,(OFST-1,sp)
4910  04bb f7            	ld	(x),a
4912  04bc               L3662:
4913                     ; 450 	while(!(FLASH_IAPSR&0X40));
4915  04bc c6505f        	ld	a,_FLASH_IAPSR
4916  04bf a540          	bcp	a,#64
4917  04c1 27f9          	jreq	L3662
4918                     ; 451 }
4921  04c3 5b04          	addw	sp,#4
4922  04c5 81            	ret
4966                     ; 459 u8 Eeprom_Read(u8 addr)
4966                     ; 460 {
4967                     	switch	.text
4968  04c6               _Eeprom_Read:
4970  04c6 88            	push	a
4971  04c7 89            	pushw	x
4972       00000002      OFST:	set	2
4975                     ; 462 	p = (u8 *)(0x4000+addr);
4977  04c8 a640          	ld	a,#64
4978  04ca 97            	ld	xl,a
4979  04cb a600          	ld	a,#0
4980  04cd 1b03          	add	a,(OFST+1,sp)
4981  04cf 2401          	jrnc	L06
4982  04d1 5c            	incw	x
4983  04d2               L06:
4984  04d2 02            	rlwa	x,a
4985  04d3 1f01          	ldw	(OFST-1,sp),x
4986  04d5 01            	rrwa	x,a
4987                     ; 463 	return *p;
4989  04d6 1e01          	ldw	x,(OFST-1,sp)
4990  04d8 f6            	ld	a,(x)
4993  04d9 5b03          	addw	sp,#3
4994  04db 81            	ret
5049                     .const:	section	.text
5050  0000               L46:
5051  0000 0000ffff      	dc.l	65535
5052                     ; 472 void Moto_Hz(u32 hz)
5052                     ; 473 {
5053                     	switch	.text
5054  04dc               _Moto_Hz:
5056  04dc 5203          	subw	sp,#3
5057       00000003      OFST:	set	3
5060                     ; 476 	i = (hz*9)/0xffff;
5062  04de 96            	ldw	x,sp
5063  04df 1c0006        	addw	x,#OFST+3
5064  04e2 cd0000        	call	c_ltor
5066  04e5 a609          	ld	a,#9
5067  04e7 cd0000        	call	c_smul
5069  04ea ae0000        	ldw	x,#L46
5070  04ed cd0000        	call	c_ludv
5072  04f0 b603          	ld	a,c_lreg+3
5073  04f2 6b01          	ld	(OFST-2,sp),a
5074                     ; 477 	j = (hz*9)%0xffff;
5076  04f4 96            	ldw	x,sp
5077  04f5 1c0006        	addw	x,#OFST+3
5078  04f8 cd0000        	call	c_ltor
5080  04fb a609          	ld	a,#9
5081  04fd cd0000        	call	c_smul
5083  0500 ae0000        	ldw	x,#L46
5084  0503 cd0000        	call	c_lumd
5086  0506 be02          	ldw	x,c_lreg+2
5087  0508 1f02          	ldw	(OFST-1,sp),x
5088                     ; 478 	TIM2_PSCR =  i;
5090  050a 7b01          	ld	a,(OFST-2,sp)
5091  050c c7530c        	ld	_TIM2_PSCR,a
5092                     ; 479 	TIM2_ARRH = j>>8;
5094  050f 7b02          	ld	a,(OFST-1,sp)
5095  0511 c7530d        	ld	_TIM2_ARRH,a
5096                     ; 480 	TIM2_ARRL = j;
5098  0514 7b03          	ld	a,(OFST+0,sp)
5099  0516 c7530e        	ld	_TIM2_ARRL,a
5100                     ; 481 }
5103  0519 5b03          	addw	sp,#3
5104  051b 81            	ret
5107                     	bsct
5108  0000               _hd_num:
5109  0000 00            	dc.b	0
5173                     ; 490 void Found_Receipt(u8 *Array_R,u8 *wr_Flag,u8 *sta_Flag)
5173                     ; 491 {
5174                     	switch	.text
5175  051c               _Found_Receipt:
5177  051c 89            	pushw	x
5178       00000000      OFST:	set	0
5181                     ; 492 	if(Array_R[1] == 0x01)
5183  051d e601          	ld	a,(1,x)
5184  051f a101          	cp	a,#1
5185  0521 262d          	jrne	L5672
5186                     ; 494 		if(pla_0 == 0)
5188                     	btst	_IPB7
5189  0528 251f          	jrult	L7672
5190                     ; 496 			if(*sta_Flag == 0)
5192  052a 1e07          	ldw	x,(OFST+7,sp)
5193  052c 7d            	tnz	(x)
5194  052d 2703          	jreq	L07
5195  052f cc0716        	jp	L5772
5196  0532               L07:
5197                     ; 498 				*sta_Flag = 1;
5199  0532 1e07          	ldw	x,(OFST+7,sp)
5200  0534 a601          	ld	a,#1
5201  0536 f7            	ld	(x),a
5202                     ; 499 				*wr_Flag ++;
5204  0537 1e05          	ldw	x,(OFST+5,sp)
5205  0539 1c0001        	addw	x,#1
5206  053c 1f05          	ldw	(OFST+5,sp),x
5207  053e 1d0001        	subw	x,#1
5208  0541 f6            	ld	a,(x)
5209  0542 97            	ld	xl,a
5210                     ; 500 				hd_num++;
5212  0543 3c00          	inc	_hd_num
5213  0545 ac160716      	jpf	L5772
5214  0549               L7672:
5215                     ; 505 			*sta_Flag = 0;
5217  0549 1e07          	ldw	x,(OFST+7,sp)
5218  054b 7f            	clr	(x)
5219  054c ac160716      	jpf	L5772
5220  0550               L5672:
5221                     ; 508 	else if(Array_R[1] == 0x02)
5223  0550 1e01          	ldw	x,(OFST+1,sp)
5224  0552 e601          	ld	a,(1,x)
5225  0554 a102          	cp	a,#2
5226  0556 262d          	jrne	L7772
5227                     ; 510 		if(pla_1 == 0)
5229                     	btst	_IPB6
5230  055d 251f          	jrult	L1003
5231                     ; 512 			if(*sta_Flag == 0)
5233  055f 1e07          	ldw	x,(OFST+7,sp)
5234  0561 7d            	tnz	(x)
5235  0562 2703          	jreq	L27
5236  0564 cc0716        	jp	L5772
5237  0567               L27:
5238                     ; 514 				*sta_Flag = 1;
5240  0567 1e07          	ldw	x,(OFST+7,sp)
5241  0569 a601          	ld	a,#1
5242  056b f7            	ld	(x),a
5243                     ; 515 				*wr_Flag ++;
5245  056c 1e05          	ldw	x,(OFST+5,sp)
5246  056e 1c0001        	addw	x,#1
5247  0571 1f05          	ldw	(OFST+5,sp),x
5248  0573 1d0001        	subw	x,#1
5249  0576 f6            	ld	a,(x)
5250  0577 97            	ld	xl,a
5251                     ; 516 				hd_num++;
5253  0578 3c00          	inc	_hd_num
5254  057a ac160716      	jpf	L5772
5255  057e               L1003:
5256                     ; 521 			*sta_Flag = 0;
5258  057e 1e07          	ldw	x,(OFST+7,sp)
5259  0580 7f            	clr	(x)
5260  0581 ac160716      	jpf	L5772
5261  0585               L7772:
5262                     ; 524 	else if(Array_R[1] == 0x03)
5264  0585 1e01          	ldw	x,(OFST+1,sp)
5265  0587 e601          	ld	a,(1,x)
5266  0589 a103          	cp	a,#3
5267  058b 262d          	jrne	L1103
5268                     ; 526 		if(pla_2 == 0)
5270                     	btst	_IPB5
5271  0592 251f          	jrult	L3103
5272                     ; 528 			if(*sta_Flag == 0)
5274  0594 1e07          	ldw	x,(OFST+7,sp)
5275  0596 7d            	tnz	(x)
5276  0597 2703          	jreq	L47
5277  0599 cc0716        	jp	L5772
5278  059c               L47:
5279                     ; 530 				*sta_Flag = 1;
5281  059c 1e07          	ldw	x,(OFST+7,sp)
5282  059e a601          	ld	a,#1
5283  05a0 f7            	ld	(x),a
5284                     ; 531 				*wr_Flag ++;
5286  05a1 1e05          	ldw	x,(OFST+5,sp)
5287  05a3 1c0001        	addw	x,#1
5288  05a6 1f05          	ldw	(OFST+5,sp),x
5289  05a8 1d0001        	subw	x,#1
5290  05ab f6            	ld	a,(x)
5291  05ac 97            	ld	xl,a
5292                     ; 532 				hd_num++;
5294  05ad 3c00          	inc	_hd_num
5295  05af ac160716      	jpf	L5772
5296  05b3               L3103:
5297                     ; 537 			*sta_Flag = 0;
5299  05b3 1e07          	ldw	x,(OFST+7,sp)
5300  05b5 7f            	clr	(x)
5301  05b6 ac160716      	jpf	L5772
5302  05ba               L1103:
5303                     ; 540 	else if(Array_R[1] == 0x04)
5305  05ba 1e01          	ldw	x,(OFST+1,sp)
5306  05bc e601          	ld	a,(1,x)
5307  05be a104          	cp	a,#4
5308  05c0 262d          	jrne	L3203
5309                     ; 542 		if(pla_3 == 0)
5311                     	btst	_IPB4
5312  05c7 251f          	jrult	L5203
5313                     ; 544 			if(*sta_Flag == 0)
5315  05c9 1e07          	ldw	x,(OFST+7,sp)
5316  05cb 7d            	tnz	(x)
5317  05cc 2703          	jreq	L67
5318  05ce cc0716        	jp	L5772
5319  05d1               L67:
5320                     ; 546 				*sta_Flag = 1;
5322  05d1 1e07          	ldw	x,(OFST+7,sp)
5323  05d3 a601          	ld	a,#1
5324  05d5 f7            	ld	(x),a
5325                     ; 547 				*wr_Flag ++;
5327  05d6 1e05          	ldw	x,(OFST+5,sp)
5328  05d8 1c0001        	addw	x,#1
5329  05db 1f05          	ldw	(OFST+5,sp),x
5330  05dd 1d0001        	subw	x,#1
5331  05e0 f6            	ld	a,(x)
5332  05e1 97            	ld	xl,a
5333                     ; 548 				hd_num++;
5335  05e2 3c00          	inc	_hd_num
5336  05e4 ac160716      	jpf	L5772
5337  05e8               L5203:
5338                     ; 553 			*sta_Flag = 0;
5340  05e8 1e07          	ldw	x,(OFST+7,sp)
5341  05ea 7f            	clr	(x)
5342  05eb ac160716      	jpf	L5772
5343  05ef               L3203:
5344                     ; 556 	else if(Array_R[1] == 0x05)
5346  05ef 1e01          	ldw	x,(OFST+1,sp)
5347  05f1 e601          	ld	a,(1,x)
5348  05f3 a105          	cp	a,#5
5349  05f5 262d          	jrne	L5303
5350                     ; 558 		if(pla_4 == 0)
5352                     	btst	_IPB3
5353  05fc 251f          	jrult	L7303
5354                     ; 560 			if(*sta_Flag == 0)
5356  05fe 1e07          	ldw	x,(OFST+7,sp)
5357  0600 7d            	tnz	(x)
5358  0601 2703          	jreq	L001
5359  0603 cc0716        	jp	L5772
5360  0606               L001:
5361                     ; 562 				*sta_Flag = 1;
5363  0606 1e07          	ldw	x,(OFST+7,sp)
5364  0608 a601          	ld	a,#1
5365  060a f7            	ld	(x),a
5366                     ; 563 				*wr_Flag ++;
5368  060b 1e05          	ldw	x,(OFST+5,sp)
5369  060d 1c0001        	addw	x,#1
5370  0610 1f05          	ldw	(OFST+5,sp),x
5371  0612 1d0001        	subw	x,#1
5372  0615 f6            	ld	a,(x)
5373  0616 97            	ld	xl,a
5374                     ; 564 				hd_num++;
5376  0617 3c00          	inc	_hd_num
5377  0619 ac160716      	jpf	L5772
5378  061d               L7303:
5379                     ; 569 			*sta_Flag = 0;
5381  061d 1e07          	ldw	x,(OFST+7,sp)
5382  061f 7f            	clr	(x)
5383  0620 ac160716      	jpf	L5772
5384  0624               L5303:
5385                     ; 572 	else if(Array_R[1] == 0x06)
5387  0624 1e01          	ldw	x,(OFST+1,sp)
5388  0626 e601          	ld	a,(1,x)
5389  0628 a106          	cp	a,#6
5390  062a 262d          	jrne	L7403
5391                     ; 574 		if(pla_5 == 0)
5393                     	btst	_IPB2
5394  0631 251f          	jrult	L1503
5395                     ; 576 			if(*sta_Flag == 0)
5397  0633 1e07          	ldw	x,(OFST+7,sp)
5398  0635 7d            	tnz	(x)
5399  0636 2703          	jreq	L201
5400  0638 cc0716        	jp	L5772
5401  063b               L201:
5402                     ; 578 				*sta_Flag = 1;
5404  063b 1e07          	ldw	x,(OFST+7,sp)
5405  063d a601          	ld	a,#1
5406  063f f7            	ld	(x),a
5407                     ; 579 				*wr_Flag ++;
5409  0640 1e05          	ldw	x,(OFST+5,sp)
5410  0642 1c0001        	addw	x,#1
5411  0645 1f05          	ldw	(OFST+5,sp),x
5412  0647 1d0001        	subw	x,#1
5413  064a f6            	ld	a,(x)
5414  064b 97            	ld	xl,a
5415                     ; 580 				hd_num++;
5417  064c 3c00          	inc	_hd_num
5418  064e ac160716      	jpf	L5772
5419  0652               L1503:
5420                     ; 585 			*sta_Flag = 0;
5422  0652 1e07          	ldw	x,(OFST+7,sp)
5423  0654 7f            	clr	(x)
5424  0655 ac160716      	jpf	L5772
5425  0659               L7403:
5426                     ; 588 	else if(Array_R[1] == 0x07)
5428  0659 1e01          	ldw	x,(OFST+1,sp)
5429  065b e601          	ld	a,(1,x)
5430  065d a107          	cp	a,#7
5431  065f 262d          	jrne	L1603
5432                     ; 590 		if(pla_6 == 0)
5434                     	btst	_IPB1
5435  0666 251f          	jrult	L3603
5436                     ; 592 			if(*sta_Flag == 0)
5438  0668 1e07          	ldw	x,(OFST+7,sp)
5439  066a 7d            	tnz	(x)
5440  066b 2703          	jreq	L401
5441  066d cc0716        	jp	L5772
5442  0670               L401:
5443                     ; 594 				*sta_Flag = 1;
5445  0670 1e07          	ldw	x,(OFST+7,sp)
5446  0672 a601          	ld	a,#1
5447  0674 f7            	ld	(x),a
5448                     ; 595 				*wr_Flag ++;
5450  0675 1e05          	ldw	x,(OFST+5,sp)
5451  0677 1c0001        	addw	x,#1
5452  067a 1f05          	ldw	(OFST+5,sp),x
5453  067c 1d0001        	subw	x,#1
5454  067f f6            	ld	a,(x)
5455  0680 97            	ld	xl,a
5456                     ; 596 				hd_num++;
5458  0681 3c00          	inc	_hd_num
5459  0683 ac160716      	jpf	L5772
5460  0687               L3603:
5461                     ; 601 			*sta_Flag = 0;
5463  0687 1e07          	ldw	x,(OFST+7,sp)
5464  0689 7f            	clr	(x)
5465  068a ac160716      	jpf	L5772
5466  068e               L1603:
5467                     ; 604 	else if(Array_R[1] == 0x08)
5469  068e 1e01          	ldw	x,(OFST+1,sp)
5470  0690 e601          	ld	a,(1,x)
5471  0692 a108          	cp	a,#8
5472  0694 2626          	jrne	L3703
5473                     ; 606 		if(pla_7 == 0)
5475                     	btst	_IPB0
5476  069b 251a          	jrult	L5703
5477                     ; 608 			if(*sta_Flag == 0)
5479  069d 1e07          	ldw	x,(OFST+7,sp)
5480  069f 7d            	tnz	(x)
5481  06a0 2674          	jrne	L5772
5482                     ; 610 				*sta_Flag = 1;
5484  06a2 1e07          	ldw	x,(OFST+7,sp)
5485  06a4 a601          	ld	a,#1
5486  06a6 f7            	ld	(x),a
5487                     ; 611 				*wr_Flag ++;
5489  06a7 1e05          	ldw	x,(OFST+5,sp)
5490  06a9 1c0001        	addw	x,#1
5491  06ac 1f05          	ldw	(OFST+5,sp),x
5492  06ae 1d0001        	subw	x,#1
5493  06b1 f6            	ld	a,(x)
5494  06b2 97            	ld	xl,a
5495                     ; 612 				hd_num++;
5497  06b3 3c00          	inc	_hd_num
5498  06b5 205f          	jra	L5772
5499  06b7               L5703:
5500                     ; 617 			*sta_Flag = 0;
5502  06b7 1e07          	ldw	x,(OFST+7,sp)
5503  06b9 7f            	clr	(x)
5504  06ba 205a          	jra	L5772
5505  06bc               L3703:
5506                     ; 620 	else if(Array_R[1] == 0x09)
5508  06bc 1e01          	ldw	x,(OFST+1,sp)
5509  06be e601          	ld	a,(1,x)
5510  06c0 a109          	cp	a,#9
5511  06c2 2626          	jrne	L5013
5512                     ; 622 		if(pla_8 == 0)
5514                     	btst	_IPE7
5515  06c9 251a          	jrult	L7013
5516                     ; 624 			if(*sta_Flag == 0)
5518  06cb 1e07          	ldw	x,(OFST+7,sp)
5519  06cd 7d            	tnz	(x)
5520  06ce 2646          	jrne	L5772
5521                     ; 626 				*sta_Flag = 1;
5523  06d0 1e07          	ldw	x,(OFST+7,sp)
5524  06d2 a601          	ld	a,#1
5525  06d4 f7            	ld	(x),a
5526                     ; 627 				*wr_Flag ++;
5528  06d5 1e05          	ldw	x,(OFST+5,sp)
5529  06d7 1c0001        	addw	x,#1
5530  06da 1f05          	ldw	(OFST+5,sp),x
5531  06dc 1d0001        	subw	x,#1
5532  06df f6            	ld	a,(x)
5533  06e0 97            	ld	xl,a
5534                     ; 628 				hd_num++;
5536  06e1 3c00          	inc	_hd_num
5537  06e3 2031          	jra	L5772
5538  06e5               L7013:
5539                     ; 633 			*sta_Flag = 0;
5541  06e5 1e07          	ldw	x,(OFST+7,sp)
5542  06e7 7f            	clr	(x)
5543  06e8 202c          	jra	L5772
5544  06ea               L5013:
5545                     ; 636 	else if(Array_R[1] == 0x0a)
5547  06ea 1e01          	ldw	x,(OFST+1,sp)
5548  06ec e601          	ld	a,(1,x)
5549  06ee a10a          	cp	a,#10
5550  06f0 2624          	jrne	L5772
5551                     ; 638 		if(pla_9 == 0)
5553                     	btst	_IPE6
5554  06f7 251a          	jrult	L1213
5555                     ; 640 			if(*sta_Flag == 0)
5557  06f9 1e07          	ldw	x,(OFST+7,sp)
5558  06fb 7d            	tnz	(x)
5559  06fc 2618          	jrne	L5772
5560                     ; 642 				*sta_Flag = 1;
5562  06fe 1e07          	ldw	x,(OFST+7,sp)
5563  0700 a601          	ld	a,#1
5564  0702 f7            	ld	(x),a
5565                     ; 643 				*wr_Flag ++;
5567  0703 1e05          	ldw	x,(OFST+5,sp)
5568  0705 1c0001        	addw	x,#1
5569  0708 1f05          	ldw	(OFST+5,sp),x
5570  070a 1d0001        	subw	x,#1
5571  070d f6            	ld	a,(x)
5572  070e 97            	ld	xl,a
5573                     ; 644 				hd_num++;
5575  070f 3c00          	inc	_hd_num
5576  0711 2003          	jra	L5772
5577  0713               L1213:
5578                     ; 649 			*sta_Flag = 0;
5580  0713 1e07          	ldw	x,(OFST+7,sp)
5581  0715 7f            	clr	(x)
5582  0716               L5772:
5583                     ; 652 }
5586  0716 85            	popw	x
5587  0717 81            	ret
5656                     ; 660 u8 Back_Zero(u8 *Dr_Num_Save)
5656                     ; 661 {
5657                     	switch	.text
5658  0718               _Back_Zero:
5660  0718 89            	pushw	x
5661  0719 5205          	subw	sp,#5
5662       00000005      OFST:	set	5
5665                     ; 662 	u8 cheack_save = 0;//保存位置状态
5667  071b 0f01          	clr	(OFST-4,sp)
5668                     ; 663 	u16 stepes = 0;
5670  071d 5f            	clrw	x
5671  071e 1f04          	ldw	(OFST-1,sp),x
5672                     ; 664 	u16 stepes_2 = 0;
5674  0720 5f            	clrw	x
5675  0721 1f02          	ldw	(OFST-3,sp),x
5676                     ; 665 	moto_dr = 0;/*改变方向*/
5678  0723 7215500f      	bres	_OPD2
5679                     ; 666 	if(b_sar == 0)//不在零位
5681                     	btst	_IPC3
5682  072c 2403          	jruge	L211
5683  072e cc07f0        	jp	L1613
5684  0731               L211:
5685                     ; 668 		cheack_save ++;//不在零位
5687  0731 0c01          	inc	(OFST-4,sp)
5689  0733 ace207e2      	jpf	L5613
5690  0737               L3613:
5691                     ; 671 			WDT();//清看门狗
5693  0737 35aa50e0      	mov	_IWDG_KR,#170
5694                     ; 672 			if(stepes < 100)
5696  073b 1e04          	ldw	x,(OFST-1,sp)
5697  073d a30064        	cpw	x,#100
5698  0740 2414          	jruge	L1713
5699                     ; 674 				moto_hz = !moto_hz;
5701  0742 90165000      	bcpl	_OPA3
5702                     ; 675 				delayus(1500);
5704  0746 ae05dc        	ldw	x,#1500
5705  0749 cd002b        	call	_delayus
5707                     ; 676 				stepes++;
5709  074c 1e04          	ldw	x,(OFST-1,sp)
5710  074e 1c0001        	addw	x,#1
5711  0751 1f04          	ldw	(OFST-1,sp),x
5713  0753 cc07e2        	jra	L5613
5714  0756               L1713:
5715                     ; 678 			else if(stepes < 200)
5717  0756 1e04          	ldw	x,(OFST-1,sp)
5718  0758 a300c8        	cpw	x,#200
5719  075b 2413          	jruge	L5713
5720                     ; 680 				moto_hz = !moto_hz;
5722  075d 90165000      	bcpl	_OPA3
5723                     ; 681 				delayus(1200);
5725  0761 ae04b0        	ldw	x,#1200
5726  0764 cd002b        	call	_delayus
5728                     ; 682 				stepes++;
5730  0767 1e04          	ldw	x,(OFST-1,sp)
5731  0769 1c0001        	addw	x,#1
5732  076c 1f04          	ldw	(OFST-1,sp),x
5734  076e 2072          	jra	L5613
5735  0770               L5713:
5736                     ; 684 			else if(stepes < 300)
5738  0770 1e04          	ldw	x,(OFST-1,sp)
5739  0772 a3012c        	cpw	x,#300
5740  0775 2413          	jruge	L1023
5741                     ; 686 				moto_hz = !moto_hz;
5743  0777 90165000      	bcpl	_OPA3
5744                     ; 687 				delayus(1100);
5746  077b ae044c        	ldw	x,#1100
5747  077e cd002b        	call	_delayus
5749                     ; 688 				stepes++;
5751  0781 1e04          	ldw	x,(OFST-1,sp)
5752  0783 1c0001        	addw	x,#1
5753  0786 1f04          	ldw	(OFST-1,sp),x
5755  0788 2058          	jra	L5613
5756  078a               L1023:
5757                     ; 690 			else if(stepes < 400)
5759  078a 1e04          	ldw	x,(OFST-1,sp)
5760  078c a30190        	cpw	x,#400
5761  078f 2413          	jruge	L5023
5762                     ; 692 				moto_hz = !moto_hz;
5764  0791 90165000      	bcpl	_OPA3
5765                     ; 693 				delayus(1000);
5767  0795 ae03e8        	ldw	x,#1000
5768  0798 cd002b        	call	_delayus
5770                     ; 694 				stepes++;
5772  079b 1e04          	ldw	x,(OFST-1,sp)
5773  079d 1c0001        	addw	x,#1
5774  07a0 1f04          	ldw	(OFST-1,sp),x
5776  07a2 203e          	jra	L5613
5777  07a4               L5023:
5778                     ; 696 			else if(stepes < 500)
5780  07a4 1e04          	ldw	x,(OFST-1,sp)
5781  07a6 a301f4        	cpw	x,#500
5782  07a9 2413          	jruge	L1123
5783                     ; 698 				moto_hz = !moto_hz;
5785  07ab 90165000      	bcpl	_OPA3
5786                     ; 699 				delayus(900);
5788  07af ae0384        	ldw	x,#900
5789  07b2 cd002b        	call	_delayus
5791                     ; 700 				stepes++;
5793  07b5 1e04          	ldw	x,(OFST-1,sp)
5794  07b7 1c0001        	addw	x,#1
5795  07ba 1f04          	ldw	(OFST-1,sp),x
5797  07bc 2024          	jra	L5613
5798  07be               L1123:
5799                     ; 702 			else if(stepes < 600)
5801  07be 1e04          	ldw	x,(OFST-1,sp)
5802  07c0 a30258        	cpw	x,#600
5803  07c3 2413          	jruge	L5123
5804                     ; 704 				moto_hz = !moto_hz;
5806  07c5 90165000      	bcpl	_OPA3
5807                     ; 705 				delayus(820);
5809  07c9 ae0334        	ldw	x,#820
5810  07cc cd002b        	call	_delayus
5812                     ; 706 				stepes++;
5814  07cf 1e04          	ldw	x,(OFST-1,sp)
5815  07d1 1c0001        	addw	x,#1
5816  07d4 1f04          	ldw	(OFST-1,sp),x
5818  07d6 200a          	jra	L5613
5819  07d8               L5123:
5820                     ; 710 				moto_hz = !moto_hz;
5822  07d8 90165000      	bcpl	_OPA3
5823                     ; 711 				delayus(640);
5825  07dc ae0280        	ldw	x,#640
5826  07df cd002b        	call	_delayus
5828  07e2               L5613:
5829                     ; 669 		while(b_sar == 0)
5831                     	btst	_IPC3
5832  07e7 2503          	jrult	L411
5833  07e9 cc0737        	jp	L3613
5834  07ec               L411:
5836  07ec ac200920      	jpf	L5223
5837  07f0               L1613:
5838                     ; 717 		stepes = 200;
5840  07f0 ae00c8        	ldw	x,#200
5841  07f3 1f04          	ldw	(OFST-1,sp),x
5842  07f5 ac200920      	jpf	L5223
5843  07f9               L3223:
5844                     ; 721 		WDT();//清看门狗
5846  07f9 35aa50e0      	mov	_IWDG_KR,#170
5847                     ; 722 		if(stepes > 600)
5849  07fd 1e04          	ldw	x,(OFST-1,sp)
5850  07ff a30259        	cpw	x,#601
5851  0802 2527          	jrult	L1323
5852                     ; 724 			moto_hz = !moto_hz;
5854  0804 90165000      	bcpl	_OPA3
5855                     ; 725 			delayus(750);
5857  0808 ae02ee        	ldw	x,#750
5858  080b cd002b        	call	_delayus
5860                     ; 726 			stepes_2++;
5862  080e 1e02          	ldw	x,(OFST-3,sp)
5863  0810 1c0001        	addw	x,#1
5864  0813 1f02          	ldw	(OFST-3,sp),x
5865                     ; 727 			if(stepes_2 == 100)
5867  0815 1e02          	ldw	x,(OFST-3,sp)
5868  0817 a30064        	cpw	x,#100
5869  081a 2703          	jreq	L611
5870  081c cc0920        	jp	L5223
5871  081f               L611:
5872                     ; 729 				stepes_2 = 0;
5874  081f 5f            	clrw	x
5875  0820 1f02          	ldw	(OFST-3,sp),x
5876                     ; 730 				stepes = 550;
5878  0822 ae0226        	ldw	x,#550
5879  0825 1f04          	ldw	(OFST-1,sp),x
5880  0827 ac200920      	jpf	L5223
5881  082b               L1323:
5882                     ; 733 		else if(stepes > 500)
5884  082b 1e04          	ldw	x,(OFST-1,sp)
5885  082d a301f5        	cpw	x,#501
5886  0830 2527          	jrult	L7323
5887                     ; 735 			moto_hz = !moto_hz;
5889  0832 90165000      	bcpl	_OPA3
5890                     ; 736 			delayus(900);
5892  0836 ae0384        	ldw	x,#900
5893  0839 cd002b        	call	_delayus
5895                     ; 737 			stepes_2++;
5897  083c 1e02          	ldw	x,(OFST-3,sp)
5898  083e 1c0001        	addw	x,#1
5899  0841 1f02          	ldw	(OFST-3,sp),x
5900                     ; 738 			if(stepes_2 == 100)
5902  0843 1e02          	ldw	x,(OFST-3,sp)
5903  0845 a30064        	cpw	x,#100
5904  0848 2703          	jreq	L021
5905  084a cc0920        	jp	L5223
5906  084d               L021:
5907                     ; 740 				stepes_2 = 0;
5909  084d 5f            	clrw	x
5910  084e 1f02          	ldw	(OFST-3,sp),x
5911                     ; 741 				stepes = 450;
5913  0850 ae01c2        	ldw	x,#450
5914  0853 1f04          	ldw	(OFST-1,sp),x
5915  0855 ac200920      	jpf	L5223
5916  0859               L7323:
5917                     ; 744 		else if(stepes > 400)
5919  0859 1e04          	ldw	x,(OFST-1,sp)
5920  085b a30191        	cpw	x,#401
5921  085e 2527          	jrult	L5423
5922                     ; 746 			moto_hz = !moto_hz;
5924  0860 90165000      	bcpl	_OPA3
5925                     ; 747 			delayus(1000);
5927  0864 ae03e8        	ldw	x,#1000
5928  0867 cd002b        	call	_delayus
5930                     ; 748 			stepes_2++;
5932  086a 1e02          	ldw	x,(OFST-3,sp)
5933  086c 1c0001        	addw	x,#1
5934  086f 1f02          	ldw	(OFST-3,sp),x
5935                     ; 749 			if(stepes_2 == 100)
5937  0871 1e02          	ldw	x,(OFST-3,sp)
5938  0873 a30064        	cpw	x,#100
5939  0876 2703          	jreq	L221
5940  0878 cc0920        	jp	L5223
5941  087b               L221:
5942                     ; 751 				stepes_2 = 0;
5944  087b 5f            	clrw	x
5945  087c 1f02          	ldw	(OFST-3,sp),x
5946                     ; 752 				stepes = 350;
5948  087e ae015e        	ldw	x,#350
5949  0881 1f04          	ldw	(OFST-1,sp),x
5950  0883 ac200920      	jpf	L5223
5951  0887               L5423:
5952                     ; 755 		else if(stepes > 300)
5954  0887 1e04          	ldw	x,(OFST-1,sp)
5955  0889 a3012d        	cpw	x,#301
5956  088c 2522          	jrult	L3523
5957                     ; 757 			moto_hz = !moto_hz;
5959  088e 90165000      	bcpl	_OPA3
5960                     ; 758 			delayus(1100);
5962  0892 ae044c        	ldw	x,#1100
5963  0895 cd002b        	call	_delayus
5965                     ; 759 			stepes_2++;
5967  0898 1e02          	ldw	x,(OFST-3,sp)
5968  089a 1c0001        	addw	x,#1
5969  089d 1f02          	ldw	(OFST-3,sp),x
5970                     ; 760 			if(stepes_2 == 100)
5972  089f 1e02          	ldw	x,(OFST-3,sp)
5973  08a1 a30064        	cpw	x,#100
5974  08a4 267a          	jrne	L5223
5975                     ; 762 				stepes_2 = 0;
5977  08a6 5f            	clrw	x
5978  08a7 1f02          	ldw	(OFST-3,sp),x
5979                     ; 763 				stepes = 250;
5981  08a9 ae00fa        	ldw	x,#250
5982  08ac 1f04          	ldw	(OFST-1,sp),x
5983  08ae 2070          	jra	L5223
5984  08b0               L3523:
5985                     ; 766 		else if(stepes > 200)
5987  08b0 1e04          	ldw	x,(OFST-1,sp)
5988  08b2 a300c9        	cpw	x,#201
5989  08b5 2522          	jrult	L1623
5990                     ; 768 			moto_hz = !moto_hz;
5992  08b7 90165000      	bcpl	_OPA3
5993                     ; 769 			delayus(1200);
5995  08bb ae04b0        	ldw	x,#1200
5996  08be cd002b        	call	_delayus
5998                     ; 770 			stepes_2++;
6000  08c1 1e02          	ldw	x,(OFST-3,sp)
6001  08c3 1c0001        	addw	x,#1
6002  08c6 1f02          	ldw	(OFST-3,sp),x
6003                     ; 771 			if(stepes_2 == 100)
6005  08c8 1e02          	ldw	x,(OFST-3,sp)
6006  08ca a30064        	cpw	x,#100
6007  08cd 2651          	jrne	L5223
6008                     ; 773 				stepes_2 = 0;
6010  08cf 5f            	clrw	x
6011  08d0 1f02          	ldw	(OFST-3,sp),x
6012                     ; 774 				stepes = 150;
6014  08d2 ae0096        	ldw	x,#150
6015  08d5 1f04          	ldw	(OFST-1,sp),x
6016  08d7 2047          	jra	L5223
6017  08d9               L1623:
6018                     ; 777 		else if(stepes > 150)
6020  08d9 1e04          	ldw	x,(OFST-1,sp)
6021  08db a30097        	cpw	x,#151
6022  08de 2522          	jrult	L7623
6023                     ; 779 			moto_hz = !moto_hz;
6025  08e0 90165000      	bcpl	_OPA3
6026                     ; 780 			delayus(1500);
6028  08e4 ae05dc        	ldw	x,#1500
6029  08e7 cd002b        	call	_delayus
6031                     ; 781 			stepes_2++;
6033  08ea 1e02          	ldw	x,(OFST-3,sp)
6034  08ec 1c0001        	addw	x,#1
6035  08ef 1f02          	ldw	(OFST-3,sp),x
6036                     ; 782 			if(stepes_2 == 100)
6038  08f1 1e02          	ldw	x,(OFST-3,sp)
6039  08f3 a30064        	cpw	x,#100
6040  08f6 2628          	jrne	L5223
6041                     ; 784 				stepes_2 = 0;
6043  08f8 5f            	clrw	x
6044  08f9 1f02          	ldw	(OFST-3,sp),x
6045                     ; 785 				stepes = 100;
6047  08fb ae0064        	ldw	x,#100
6048  08fe 1f04          	ldw	(OFST-1,sp),x
6049  0900 201e          	jra	L5223
6050  0902               L7623:
6051                     ; 790 			moto_hz = !moto_hz;
6053  0902 90165000      	bcpl	_OPA3
6054                     ; 791 			delayus(2000);
6056  0906 ae07d0        	ldw	x,#2000
6057  0909 cd002b        	call	_delayus
6059                     ; 792 			stepes_2++;
6061  090c 1e02          	ldw	x,(OFST-3,sp)
6062  090e 1c0001        	addw	x,#1
6063  0911 1f02          	ldw	(OFST-3,sp),x
6064                     ; 793 			if(stepes_2 == 500)
6066  0913 1e02          	ldw	x,(OFST-3,sp)
6067  0915 a301f4        	cpw	x,#500
6068  0918 2606          	jrne	L5223
6069                     ; 795 				stepes_2 = 0;
6071  091a 5f            	clrw	x
6072  091b 1f02          	ldw	(OFST-3,sp),x
6073                     ; 796 				stepes = 0;
6075  091d 5f            	clrw	x
6076  091e 1f04          	ldw	(OFST-1,sp),x
6077  0920               L5223:
6078                     ; 719 	while(stepes)//在零位
6080  0920 1e04          	ldw	x,(OFST-1,sp)
6081  0922 2703          	jreq	L421
6082  0924 cc07f9        	jp	L3223
6083  0927               L421:
6084                     ; 800 	delayms(300);
6086  0927 ae012c        	ldw	x,#300
6087  092a cd0000        	call	_delayms
6089                     ; 801 	WDT();//清看门狗
6091  092d 35aa50e0      	mov	_IWDG_KR,#170
6092                     ; 802 	moto_dr = 1;/*改变方向*/
6094  0931 7214500f      	bset	_OPD2
6096  0935 2010          	jra	L3033
6097  0937               L7723:
6098                     ; 805 		cheack_save ++;//不在零位
6100  0937 0c01          	inc	(OFST-4,sp)
6101                     ; 806 		moto_hz = !moto_hz;
6103  0939 90165000      	bcpl	_OPA3
6104                     ; 807 		delayus(2000);
6106  093d ae07d0        	ldw	x,#2000
6107  0940 cd002b        	call	_delayus
6109                     ; 808 		WDT();//清看门狗
6111  0943 35aa50e0      	mov	_IWDG_KR,#170
6112  0947               L3033:
6113                     ; 803 	while(b_sar == 0)
6115                     	btst	_IPC3
6116  094c 24e9          	jruge	L7723
6117                     ; 810 	*Dr_Num_Save = 1;
6119  094e 1e06          	ldw	x,(OFST+1,sp)
6120  0950 a601          	ld	a,#1
6121  0952 f7            	ld	(x),a
6122                     ; 811 	Eeprom_Write(10,*Dr_Num_Save/10);
6124  0953 1e06          	ldw	x,(OFST+1,sp)
6125  0955 f6            	ld	a,(x)
6126  0956 ae000a        	ldw	x,#10
6127  0959 51            	exgw	x,y
6128  095a 5f            	clrw	x
6129  095b 97            	ld	xl,a
6130  095c 65            	divw	x,y
6131  095d 9f            	ld	a,xl
6132  095e 97            	ld	xl,a
6133  095f a60a          	ld	a,#10
6134  0961 95            	ld	xh,a
6135  0962 cd04a7        	call	_Eeprom_Write
6137                     ; 812 	Eeprom_Write(11,*Dr_Num_Save%10);
6139  0965 1e06          	ldw	x,(OFST+1,sp)
6140  0967 f6            	ld	a,(x)
6141  0968 ae000a        	ldw	x,#10
6142  096b 51            	exgw	x,y
6143  096c 5f            	clrw	x
6144  096d 97            	ld	xl,a
6145  096e 65            	divw	x,y
6146  096f 909f          	ld	a,yl
6147  0971 97            	ld	xl,a
6148  0972 a60b          	ld	a,#11
6149  0974 95            	ld	xh,a
6150  0975 cd04a7        	call	_Eeprom_Write
6152                     ; 813 	if(cheack_save > 0)
6154  0978 0d01          	tnz	(OFST-4,sp)
6155  097a 2704          	jreq	L7033
6156                     ; 815 		return CORRECT;
6158  097c a688          	ld	a,#136
6160  097e 2002          	jra	L011
6161  0980               L7033:
6162                     ; 819 		return ERROR;//回零有错误
6164  0980 a644          	ld	a,#68
6166  0982               L011:
6168  0982 5b07          	addw	sp,#7
6169  0984 81            	ret
6172                     	bsct
6173  0001               _timerlow:
6174  0001 4e20          	dc.w	20000
6175  0003 445c          	dc.w	17500
6176  0005 3e80          	dc.w	16000
6177  0007 38a4          	dc.w	14500
6178  0009 3390          	dc.w	13200
6179  000b 2fa8          	dc.w	12200
6180  000d 2c24          	dc.w	11300
6181  000f 2968          	dc.w	10600
6182  0011 26ac          	dc.w	9900
6183  0013 2454          	dc.w	9300
6184  0015 22c4          	dc.w	8900
6185  0017 20d0          	dc.w	8400
6186  0019 1f40          	dc.w	8000
6187  001b 1d9c          	dc.w	7580
6188  001d 1c84          	dc.w	7300
6254                     ; 836 u8 _Servo_C(u8 Dr_Num,u8 *Dr_Num_Save)//伺服电机控制
6254                     ; 837 {
6255                     	switch	.text
6256  0985               __Servo_C:
6258  0985 88            	push	a
6259       00000000      OFST:	set	0
6262                     ; 838 	Encoder_count = 0;/*重新开始计数*/
6264  0986 5f            	clrw	x
6265  0987 bf00          	ldw	_Encoder_count,x
6266                     ; 839 	if(Dr_Num == 0) return 0; //如果出现抽屉编号为0
6268  0989 4d            	tnz	a
6269  098a 2604          	jrne	L5333
6272  098c 4f            	clr	a
6275  098d 5b01          	addw	sp,#1
6276  098f 81            	ret
6277  0990               L5333:
6278                     ; 840  	if(Dr_Num > 76) return 0; //大于76，则返回
6280  0990 7b01          	ld	a,(OFST+1,sp)
6281  0992 a14d          	cp	a,#77
6282  0994 2504          	jrult	L7333
6285  0996 4f            	clr	a
6288  0997 5b01          	addw	sp,#1
6289  0999 81            	ret
6290  099a               L7333:
6291                     ; 841  	if(Dr_Num > 65) Dr_Num=Dr_Num+4;  
6293  099a 7b01          	ld	a,(OFST+1,sp)
6294  099c a142          	cp	a,#66
6295  099e 2508          	jrult	L1433
6298  09a0 7b01          	ld	a,(OFST+1,sp)
6299  09a2 ab04          	add	a,#4
6300  09a4 6b01          	ld	(OFST+1,sp),a
6302  09a6 2022          	jra	L3433
6303  09a8               L1433:
6304                     ; 843  	else if(Dr_Num > 46) Dr_Num=Dr_Num+3;
6306  09a8 7b01          	ld	a,(OFST+1,sp)
6307  09aa a12f          	cp	a,#47
6308  09ac 2508          	jrult	L5433
6311  09ae 7b01          	ld	a,(OFST+1,sp)
6312  09b0 ab03          	add	a,#3
6313  09b2 6b01          	ld	(OFST+1,sp),a
6315  09b4 2014          	jra	L3433
6316  09b6               L5433:
6317                     ; 844  	else if(Dr_Num > 27) Dr_Num=Dr_Num+2;
6319  09b6 7b01          	ld	a,(OFST+1,sp)
6320  09b8 a11c          	cp	a,#28
6321  09ba 2506          	jrult	L1533
6324  09bc 0c01          	inc	(OFST+1,sp)
6325  09be 0c01          	inc	(OFST+1,sp)
6327  09c0 2008          	jra	L3433
6328  09c2               L1533:
6329                     ; 845  	else if(Dr_Num > 8) Dr_Num=Dr_Num+1;
6331  09c2 7b01          	ld	a,(OFST+1,sp)
6332  09c4 a109          	cp	a,#9
6333  09c6 2502          	jrult	L3433
6336  09c8 0c01          	inc	(OFST+1,sp)
6337  09ca               L3433:
6338                     ; 846 	if(Dr_Num < *Dr_Num_Save)
6340  09ca 1e04          	ldw	x,(OFST+4,sp)
6341  09cc f6            	ld	a,(x)
6342  09cd 1101          	cp	a,(OFST+1,sp)
6343  09cf 2354          	jrule	L7533
6344                     ; 848 		if((*Dr_Num_Save-Dr_Num) <= (Total_Circle/2))
6346  09d1 9c            	rvf
6347  09d2 1e04          	ldw	x,(OFST+4,sp)
6348  09d4 f6            	ld	a,(x)
6349  09d5 5f            	clrw	x
6350  09d6 1001          	sub	a,(OFST+1,sp)
6351  09d8 2401          	jrnc	L031
6352  09da 5a            	decw	x
6353  09db               L031:
6354  09db 02            	rlwa	x,a
6355  09dc a30029        	cpw	x,#41
6356  09df 2e1f          	jrsge	L1633
6357                     ; 850 			moto_dr = 1;/*改变方向*/
6359  09e1 7214500f      	bset	_OPD2
6360                     ; 851 			result_move = *Dr_Num_Save-Dr_Num;
6362  09e5 1e04          	ldw	x,(OFST+4,sp)
6363  09e7 f6            	ld	a,(x)
6364  09e8 5f            	clrw	x
6365  09e9 1001          	sub	a,(OFST+1,sp)
6366  09eb 2401          	jrnc	L231
6367  09ed 5a            	decw	x
6368  09ee               L231:
6369  09ee cd0000        	call	c_itol
6371  09f1 ae0000        	ldw	x,#_result_move
6372  09f4 cd0000        	call	c_rtol
6374                     ; 852 			*Dr_Num_Save=Dr_Num;
6376  09f7 7b01          	ld	a,(OFST+1,sp)
6377  09f9 1e04          	ldw	x,(OFST+4,sp)
6378  09fb f7            	ld	(x),a
6380  09fc ac8f0a8f      	jpf	L5633
6381  0a00               L1633:
6382                     ; 856 			moto_dr = 0;/*改变方向*/
6384  0a00 7215500f      	bres	_OPD2
6385                     ; 857 			result_move=Total_Circle+Dr_Num-*Dr_Num_Save;
6387  0a04 a600          	ld	a,#0
6388  0a06 97            	ld	xl,a
6389  0a07 a650          	ld	a,#80
6390  0a09 1b01          	add	a,(OFST+1,sp)
6391  0a0b 2401          	jrnc	L431
6392  0a0d 5c            	incw	x
6393  0a0e               L431:
6394  0a0e 1604          	ldw	y,(OFST+4,sp)
6395  0a10 90f0          	sub	a,(y)
6396  0a12 2401          	jrnc	L631
6397  0a14 5a            	decw	x
6398  0a15               L631:
6399  0a15 cd0000        	call	c_itol
6401  0a18 ae0000        	ldw	x,#_result_move
6402  0a1b cd0000        	call	c_rtol
6404                     ; 858 			*Dr_Num_Save=Dr_Num;
6406  0a1e 7b01          	ld	a,(OFST+1,sp)
6407  0a20 1e04          	ldw	x,(OFST+4,sp)
6408  0a22 f7            	ld	(x),a
6409  0a23 206a          	jra	L5633
6410  0a25               L7533:
6411                     ; 861 	else if(Dr_Num>=*Dr_Num_Save)
6413  0a25 1e04          	ldw	x,(OFST+4,sp)
6414  0a27 f6            	ld	a,(x)
6415  0a28 1101          	cp	a,(OFST+1,sp)
6416  0a2a 2263          	jrugt	L5633
6417                     ; 863 		if((Dr_Num-*Dr_Num_Save)<=(Total_Circle /2))
6419  0a2c 9c            	rvf
6420  0a2d 7b01          	ld	a,(OFST+1,sp)
6421  0a2f 5f            	clrw	x
6422  0a30 1604          	ldw	y,(OFST+4,sp)
6423  0a32 90f0          	sub	a,(y)
6424  0a34 2401          	jrnc	L041
6425  0a36 5a            	decw	x
6426  0a37               L041:
6427  0a37 02            	rlwa	x,a
6428  0a38 a30029        	cpw	x,#41
6429  0a3b 2e1e          	jrsge	L1733
6430                     ; 865 			moto_dr = 0;/*改变方向*/
6432  0a3d 7215500f      	bres	_OPD2
6433                     ; 866 			result_move=Dr_Num-*Dr_Num_Save;
6435  0a41 7b01          	ld	a,(OFST+1,sp)
6436  0a43 5f            	clrw	x
6437  0a44 1604          	ldw	y,(OFST+4,sp)
6438  0a46 90f0          	sub	a,(y)
6439  0a48 2401          	jrnc	L241
6440  0a4a 5a            	decw	x
6441  0a4b               L241:
6442  0a4b cd0000        	call	c_itol
6444  0a4e ae0000        	ldw	x,#_result_move
6445  0a51 cd0000        	call	c_rtol
6447                     ; 867 			*Dr_Num_Save=Dr_Num;
6449  0a54 7b01          	ld	a,(OFST+1,sp)
6450  0a56 1e04          	ldw	x,(OFST+4,sp)
6451  0a58 f7            	ld	(x),a
6453  0a59 2034          	jra	L5633
6454  0a5b               L1733:
6455                     ; 869 		else if((Dr_Num-*Dr_Num_Save)>(Total_Circle /2))
6457  0a5b 9c            	rvf
6458  0a5c 7b01          	ld	a,(OFST+1,sp)
6459  0a5e 5f            	clrw	x
6460  0a5f 1604          	ldw	y,(OFST+4,sp)
6461  0a61 90f0          	sub	a,(y)
6462  0a63 2401          	jrnc	L441
6463  0a65 5a            	decw	x
6464  0a66               L441:
6465  0a66 02            	rlwa	x,a
6466  0a67 a30029        	cpw	x,#41
6467  0a6a 2f23          	jrslt	L5633
6468                     ; 871 			moto_dr = 1;/*改变方向*/
6470  0a6c 7214500f      	bset	_OPD2
6471                     ; 872 			result_move=Total_Circle-Dr_Num+*Dr_Num_Save;
6473  0a70 a600          	ld	a,#0
6474  0a72 97            	ld	xl,a
6475  0a73 a650          	ld	a,#80
6476  0a75 1001          	sub	a,(OFST+1,sp)
6477  0a77 2401          	jrnc	L641
6478  0a79 5a            	decw	x
6479  0a7a               L641:
6480  0a7a 1604          	ldw	y,(OFST+4,sp)
6481  0a7c 90fb          	add	a,(y)
6482  0a7e 2401          	jrnc	L051
6483  0a80 5c            	incw	x
6484  0a81               L051:
6485  0a81 cd0000        	call	c_itol
6487  0a84 ae0000        	ldw	x,#_result_move
6488  0a87 cd0000        	call	c_rtol
6490                     ; 873 			*Dr_Num_Save=Dr_Num;
6492  0a8a 7b01          	ld	a,(OFST+1,sp)
6493  0a8c 1e04          	ldw	x,(OFST+4,sp)
6494  0a8e f7            	ld	(x),a
6495  0a8f               L5633:
6496                     ; 876 	WDT();//清看门狗
6498  0a8f 35aa50e0      	mov	_IWDG_KR,#170
6499                     ; 877 	if(result_move == 0) return 0;
6501  0a93 ae0000        	ldw	x,#_result_move
6502  0a96 cd0000        	call	c_lzmp
6504  0a99 2604          	jrne	L7733
6507  0a9b 4f            	clr	a
6510  0a9c 5b01          	addw	sp,#1
6511  0a9e 81            	ret
6512  0a9f               L7733:
6513                     ; 878  	steps = result_move* Average_Pulse *2;
6515  0a9f ae0000        	ldw	x,#_result_move
6516  0aa2 cd0000        	call	c_ltor
6518  0aa5 a6af          	ld	a,#175
6519  0aa7 cd0000        	call	c_smul
6521  0aaa 3803          	sll	c_lreg+3
6522  0aac 3902          	rlc	c_lreg+2
6523  0aae 3901          	rlc	c_lreg+1
6524  0ab0 3900          	rlc	c_lreg
6525  0ab2 ae0014        	ldw	x,#_steps
6526  0ab5 cd0000        	call	c_rtol
6528                     ; 879  	steps_half = steps/2;  
6530  0ab8 ae0014        	ldw	x,#_steps
6531  0abb cd0000        	call	c_ltor
6533  0abe 3400          	srl	c_lreg
6534  0ac0 3601          	rrc	c_lreg+1
6535  0ac2 3602          	rrc	c_lreg+2
6536  0ac4 3603          	rrc	c_lreg+3
6537  0ac6 ae0010        	ldw	x,#_steps_half
6538  0ac9 cd0000        	call	c_rtol
6540                     ; 880  	n_max = 14;               //最高运行速度档位设置，可独立修改  
6542  0acc 350e001e      	mov	_n_max,#14
6543                     ; 881  	ksteps_inc = 20;          //根据运行质量进行修改这两个参数
6545  0ad0 ae0014        	ldw	x,#20
6546  0ad3 bf1a          	ldw	_ksteps_inc,x
6547                     ; 882  	ksteps_save = 10;  
6549  0ad5 ae000a        	ldw	x,#10
6550  0ad8 bf18          	ldw	_ksteps_save,x
6551                     ; 883  	steps_count = 0;
6553  0ada ae0000        	ldw	x,#0
6554  0add bf0e          	ldw	_steps_count+2,x
6555  0adf ae0000        	ldw	x,#0
6556  0ae2 bf0c          	ldw	_steps_count,x
6557                     ; 884  	steps_count2 = 0; 
6559  0ae4 ae0000        	ldw	x,#0
6560  0ae7 bf0a          	ldw	_steps_count2+2,x
6561  0ae9 ae0000        	ldw	x,#0
6562  0aec bf08          	ldw	_steps_count2,x
6563                     ; 885  	up_or_down = 1;
6565  0aee 35010021      	mov	_up_or_down,#1
6566                     ; 886  	half_over = 0; 
6568  0af2 3f20          	clr	_half_over
6569                     ; 887  	moto_hz = 0;
6571  0af4 72175000      	bres	_OPA3
6572                     ; 888 	Encoder_bz = 1;/*开启编码器*/	
6574  0af8 72100000      	bset	_Encoder_bz
6575                     ; 889  	TIM3_ARRH=timerlow[0]>>8;           
6577  0afc be01          	ldw	x,_timerlow
6578  0afe 4f            	clr	a
6579  0aff 01            	rrwa	x,a
6580  0b00 01            	rrwa	x,a
6581  0b01 c7532b        	ld	_TIM3_ARRH,a
6582  0b04 02            	rlwa	x,a
6583                     ; 890  	TIM3_ARRL=timerlow[0];	 //246
6585  0b05 550002532c    	mov	_TIM3_ARRL,_timerlow+1
6586                     ; 891 	TIM3_CR1 = 0X01; 
6588  0b0a 35015320      	mov	_TIM3_CR1,#1
6589                     ; 892  	for(k=0;(half_over==0)&&(k<=n_max);k+=1)   
6591  0b0e 3f22          	clr	_k
6593  0b10 2012          	jra	L5043
6594  0b12               L1043:
6595                     ; 894 		ksteps_save=ksteps_save+ksteps_inc;
6597  0b12 be18          	ldw	x,_ksteps_save
6598  0b14 72bb001a      	addw	x,_ksteps_inc
6599  0b18 bf18          	ldw	_ksteps_save,x
6600                     ; 895 		ksteps=ksteps_save;     
6602  0b1a be18          	ldw	x,_ksteps_save
6603  0b1c bf1c          	ldw	_ksteps,x
6605  0b1e               L5143:
6606                     ; 896 		while(ksteps>0);  //加速阶段  
6608  0b1e be1c          	ldw	x,_ksteps
6609  0b20 26fc          	jrne	L5143
6610                     ; 892  	for(k=0;(half_over==0)&&(k<=n_max);k+=1)   
6612  0b22 3c22          	inc	_k
6613  0b24               L5043:
6616  0b24 3d20          	tnz	_half_over
6617  0b26 2606          	jrne	L1243
6619  0b28 b622          	ld	a,_k
6620  0b2a b11e          	cp	a,_n_max
6621  0b2c 23e4          	jrule	L1043
6622  0b2e               L1243:
6623                     ; 898 	k-=1;
6625  0b2e 3a22          	dec	_k
6626                     ; 899 	if(half_over==0)
6628  0b30 3d20          	tnz	_half_over
6629  0b32 261e          	jrne	L3243
6630                     ; 901 		up_or_down=2;
6632  0b34 35020021      	mov	_up_or_down,#2
6633                     ; 902 		steps_keep_count=steps-steps_count2;
6635  0b38 ae0014        	ldw	x,#_steps
6636  0b3b cd0000        	call	c_ltor
6638  0b3e ae0008        	ldw	x,#_steps_count2
6639  0b41 cd0000        	call	c_lsub
6641  0b44 ae0004        	ldw	x,#_steps_keep_count
6642  0b47 cd0000        	call	c_rtol
6645  0b4a               L1343:
6646                     ; 903 		while(steps_keep_count);
6648  0b4a ae0004        	ldw	x,#_steps_keep_count
6649  0b4d cd0000        	call	c_lzmp
6651  0b50 26f8          	jrne	L1343
6652  0b52               L3243:
6653                     ; 905 	up_or_down=3;
6655  0b52 35030021      	mov	_up_or_down,#3
6657  0b56 201f          	jra	L1443
6658  0b58               L5343:
6659                     ; 908 		ksteps_save=ksteps_save-ksteps_inc;
6661  0b58 be18          	ldw	x,_ksteps_save
6662  0b5a 72b0001a      	subw	x,_ksteps_inc
6663  0b5e bf18          	ldw	_ksteps_save,x
6664                     ; 909 		ksteps=ksteps_save;	//减速阶段
6666  0b60 be18          	ldw	x,_ksteps_save
6667  0b62 bf1c          	ldw	_ksteps,x
6668                     ; 910 		if(k<1)
6670  0b64 3d22          	tnz	_k
6671  0b66 2609          	jrne	L1543
6672                     ; 912 			k=1;
6674  0b68 35010022      	mov	_k,#1
6675                     ; 913 			ksteps=7000;
6677  0b6c ae1b58        	ldw	x,#7000
6678  0b6f bf1c          	ldw	_ksteps,x
6679  0b71               L1543:
6680                     ; 915 		while(ksteps>0);       
6682  0b71 be1c          	ldw	x,_ksteps
6683  0b73 26fc          	jrne	L1543
6684                     ; 906  	for(;steps_count<steps;k-=1)
6686  0b75 3a22          	dec	_k
6687  0b77               L1443:
6690  0b77 ae000c        	ldw	x,#_steps_count
6691  0b7a cd0000        	call	c_ltor
6693  0b7d ae0014        	ldw	x,#_steps
6694  0b80 cd0000        	call	c_lcmp
6696  0b83 25d3          	jrult	L5343
6697                     ; 917 	TIM3_CR1 = 0X00;
6699  0b85 725f5320      	clr	_TIM3_CR1
6700                     ; 918 	moto_hz = 1;
6702  0b89 72165000      	bset	_OPA3
6703                     ; 919 	delayus(2);
6705  0b8d ae0002        	ldw	x,#2
6706  0b90 cd002b        	call	_delayus
6708                     ; 920 	moto_hz = 0;
6710  0b93 72175000      	bres	_OPA3
6711                     ; 921 	delayus(2);
6713  0b97 ae0002        	ldw	x,#2
6714  0b9a cd002b        	call	_delayus
6716                     ; 922 	WDT();//清看门狗
6718  0b9d 35aa50e0      	mov	_IWDG_KR,#170
6719                     ; 923 	Encoder_bz = 0;/*开启编码器*/	
6721  0ba1 72110000      	bres	_Encoder_bz
6722                     ; 925 	*Dr_Num_Save = Dr_Num;
6724  0ba5 7b01          	ld	a,(OFST+1,sp)
6725  0ba7 1e04          	ldw	x,(OFST+4,sp)
6726  0ba9 f7            	ld	(x),a
6727                     ; 926 	Eeprom_Write(10,*Dr_Num_Save/10);
6729  0baa 1e04          	ldw	x,(OFST+4,sp)
6730  0bac f6            	ld	a,(x)
6731  0bad ae000a        	ldw	x,#10
6732  0bb0 51            	exgw	x,y
6733  0bb1 5f            	clrw	x
6734  0bb2 97            	ld	xl,a
6735  0bb3 65            	divw	x,y
6736  0bb4 9f            	ld	a,xl
6737  0bb5 97            	ld	xl,a
6738  0bb6 a60a          	ld	a,#10
6739  0bb8 95            	ld	xh,a
6740  0bb9 cd04a7        	call	_Eeprom_Write
6742                     ; 927 	Eeprom_Write(11,*Dr_Num_Save%10);
6744  0bbc 1e04          	ldw	x,(OFST+4,sp)
6745  0bbe f6            	ld	a,(x)
6746  0bbf ae000a        	ldw	x,#10
6747  0bc2 51            	exgw	x,y
6748  0bc3 5f            	clrw	x
6749  0bc4 97            	ld	xl,a
6750  0bc5 65            	divw	x,y
6751  0bc6 909f          	ld	a,yl
6752  0bc8 97            	ld	xl,a
6753  0bc9 a60b          	ld	a,#11
6754  0bcb 95            	ld	xh,a
6755  0bcc cd04a7        	call	_Eeprom_Write
6757                     ; 928 	return result_move;
6759  0bcf b603          	ld	a,_result_move+3
6762  0bd1 5b01          	addw	sp,#1
6763  0bd3 81            	ret
6923                     	xdef	_timerlow
6924                     	xref.b	_Encoder_count
6925                     	xbit	_Encoder_bz
6926                     	xdef	_hd_num
6927                     	xref.b	_S_buf
6928                     	xref.b	_Shield
6929                     	switch	.ubsct
6930  0000               _result_move:
6931  0000 00000000      	ds.b	4
6932                     	xdef	_result_move
6933  0004               _steps_keep_count:
6934  0004 00000000      	ds.b	4
6935                     	xdef	_steps_keep_count
6936  0008               _steps_count2:
6937  0008 00000000      	ds.b	4
6938                     	xdef	_steps_count2
6939  000c               _steps_count:
6940  000c 00000000      	ds.b	4
6941                     	xdef	_steps_count
6942  0010               _steps_half:
6943  0010 00000000      	ds.b	4
6944                     	xdef	_steps_half
6945  0014               _steps:
6946  0014 00000000      	ds.b	4
6947                     	xdef	_steps
6948  0018               _ksteps_save:
6949  0018 0000          	ds.b	2
6950                     	xdef	_ksteps_save
6951  001a               _ksteps_inc:
6952  001a 0000          	ds.b	2
6953                     	xdef	_ksteps_inc
6954  001c               _ksteps:
6955  001c 0000          	ds.b	2
6956                     	xdef	_ksteps
6957  001e               _n_max:
6958  001e 00            	ds.b	1
6959                     	xdef	_n_max
6960  001f               _direction:
6961  001f 00            	ds.b	1
6962                     	xdef	_direction
6963  0020               _half_over:
6964  0020 00            	ds.b	1
6965                     	xdef	_half_over
6966  0021               _up_or_down:
6967  0021 00            	ds.b	1
6968                     	xdef	_up_or_down
6969  0022               _k:
6970  0022 00            	ds.b	1
6971                     	xdef	_k
6972                     	xdef	_Eeprom_Read
6973                     	xdef	_Eeprom_Write
6974                     	xdef	_Eeprom_Init
6975                     	xdef	_Found_Receipt
6976                     	xdef	__Servo_C
6977                     	xdef	_Moto_Hz
6978                     	xdef	_Back_Zero
6979                     	xdef	_Com_Check
6980                     	xdef	_Bar_Read
6981                     	xdef	_Addr_Read
6982                     	xdef	_Shield_sava
6983                     	xdef	_delayus
6984                     	xdef	_delayms
6985                     	xdef	_BSP_Init
6986                     	xref.b	c_lreg
6987                     	xref.b	c_x
7007                     	xref	c_lcmp
7008                     	xref	c_lsub
7009                     	xref	c_lzmp
7010                     	xref	c_rtol
7011                     	xref	c_itol
7012                     	xref	c_lumd
7013                     	xref	c_ludv
7014                     	xref	c_smul
7015                     	xref	c_ltor
7016                     	end
