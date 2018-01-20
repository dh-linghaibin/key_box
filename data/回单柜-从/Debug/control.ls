   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.8 - 03 Dec 2008
3578                     ; 37 void delayms(u16 ms)	
3578                     ; 38 {						
3580                     	switch	.text
3581  0000               _delayms:
3583  0000 89            	pushw	x
3584  0001 89            	pushw	x
3585       00000002      OFST:	set	2
3588  0002 2015          	jra	L5732
3589  0004               L3732:
3590                     ; 42 		for(i=0;i<1125;i++);//2M晶振一周期1us，i=140;刚好1ms,16M时，i=1125
3592  0004 5f            	clrw	x
3593  0005 1f01          	ldw	(OFST-1,sp),x
3594  0007               L1042:
3598  0007 1e01          	ldw	x,(OFST-1,sp)
3599  0009 1c0001        	addw	x,#1
3600  000c 1f01          	ldw	(OFST-1,sp),x
3603  000e 1e01          	ldw	x,(OFST-1,sp)
3604  0010 a30465        	cpw	x,#1125
3605  0013 25f2          	jrult	L1042
3606                     ; 43 		WDT();//清看门狗
3608  0015 35aa50e0      	mov	_IWDG_KR,#170
3609  0019               L5732:
3610                     ; 40 	while(ms--)
3612  0019 1e03          	ldw	x,(OFST+1,sp)
3613  001b 1d0001        	subw	x,#1
3614  001e 1f03          	ldw	(OFST+1,sp),x
3615  0020 1c0001        	addw	x,#1
3616  0023 a30000        	cpw	x,#0
3617  0026 26dc          	jrne	L3732
3618                     ; 45 }
3621  0028 5b04          	addw	sp,#4
3622  002a 81            	ret
3656                     ; 53 void delayus(u16 us) 	
3656                     ; 54 {	
3657                     	switch	.text
3658  002b               _delayus:
3660  002b 89            	pushw	x
3661       00000000      OFST:	set	0
3664  002c               L7242:
3665                     ; 55 	while(us--);
3667  002c 1e01          	ldw	x,(OFST+1,sp)
3668  002e 1d0001        	subw	x,#1
3669  0031 1f01          	ldw	(OFST+1,sp),x
3670  0033 1c0001        	addw	x,#1
3671  0036 a30000        	cpw	x,#0
3672  0039 26f1          	jrne	L7242
3673                     ; 56 }
3676  003b 85            	popw	x
3677  003c 81            	ret
3728                     ; 64 void BSP_Init(void)
3728                     ; 65 {
3729                     	switch	.text
3730  003d               _BSP_Init:
3734                     ; 66 	CLK_CKDIVR=0x00;
3736  003d 725f50c6      	clr	_CLK_CKDIVR
3737                     ; 69 	PA_DDR |= BIT(3);
3739  0041 72165002      	bset	_PA_DDR,#3
3740                     ; 70 	PA_CR1 |= BIT(3); 
3742  0045 72165003      	bset	_PA_CR1,#3
3743                     ; 71 	PA_CR2 |= BIT(3);
3745  0049 72165004      	bset	_PA_CR2,#3
3746                     ; 73 	PF_DDR |= BIT(4);
3748  004d 7218501b      	bset	_PF_DDR,#4
3749                     ; 74 	PF_CR1 |= BIT(4); 
3751  0051 7218501c      	bset	_PF_CR1,#4
3752                     ; 75 	PF_CR2 |= BIT(4);
3754  0055 7218501d      	bset	_PF_CR2,#4
3755                     ; 77 	PB_DDR |= BIT(3);
3757  0059 72165007      	bset	_PB_DDR,#3
3758                     ; 78 	PB_CR1 |= BIT(3); 
3760  005d 72165008      	bset	_PB_CR1,#3
3761                     ; 79 	PB_CR2 |= BIT(3);
3763  0061 72165009      	bset	_PB_CR2,#3
3764                     ; 81 	PB_DDR |= BIT(7);
3766  0065 721e5007      	bset	_PB_DDR,#7
3767                     ; 82 	PB_CR1 |= BIT(7); 
3769  0069 721e5008      	bset	_PB_CR1,#7
3770                     ; 83 	PB_CR2 |= BIT(7);
3772  006d 721e5009      	bset	_PB_CR2,#7
3773                     ; 85 	PB_DDR &= ~BIT(2);
3775  0071 72155007      	bres	_PB_DDR,#2
3776                     ; 86 	PB_CR1 &= ~BIT(2); 
3778  0075 72155008      	bres	_PB_CR1,#2
3779                     ; 87 	PB_CR2 &= ~BIT(2);
3781  0079 72155009      	bres	_PB_CR2,#2
3782                     ; 89 	PB_DDR |= BIT(6);
3784  007d 721c5007      	bset	_PB_DDR,#6
3785                     ; 90 	PB_CR1 |= BIT(6); 
3787  0081 721c5008      	bset	_PB_CR1,#6
3788                     ; 91 	PB_CR2 |= BIT(6);
3790  0085 721c5009      	bset	_PB_CR2,#6
3791                     ; 93 	OPA3 = 1;
3793  0089 72165000      	bset	_OPA3
3794                     ; 94 	OPF4 = 1;
3796  008d 72185019      	bset	_OPF4
3797                     ; 95 	OPB3 = 0;
3799  0091 72175005      	bres	_OPB3
3800                     ; 96 	OPB7 = 1;
3802  0095 721e5005      	bset	_OPB7
3803                     ; 97 	OPB6 = 1;	
3805  0099 721c5005      	bset	_OPB6
3806                     ; 100 	PC_DDR &= ~BIT(2);
3808  009d 7215500c      	bres	_PC_DDR,#2
3809                     ; 101 	PC_CR1 &= ~BIT(2); 
3811  00a1 7215500d      	bres	_PC_CR1,#2
3812                     ; 102 	PC_CR2 &= ~BIT(2);
3814  00a5 7215500e      	bres	_PC_CR2,#2
3815                     ; 104 	PC_DDR &= ~BIT(5);
3817  00a9 721b500c      	bres	_PC_DDR,#5
3818                     ; 105 	PC_CR1 &= ~BIT(5); 
3820  00ad 721b500d      	bres	_PC_CR1,#5
3821                     ; 106 	PC_CR2 &= ~BIT(5);
3823  00b1 721b500e      	bres	_PC_CR2,#5
3824                     ; 108 	PD_DDR &= ~BIT(0);
3826  00b5 72115011      	bres	_PD_DDR,#0
3827                     ; 109 	PD_CR1 &= ~BIT(0); 
3829  00b9 72115012      	bres	_PD_CR1,#0
3830                     ; 110 	PD_CR2 &= ~BIT(0);
3832  00bd 72115013      	bres	_PD_CR2,#0
3833                     ; 112 	PD_DDR &= ~BIT(2);
3835  00c1 72155011      	bres	_PD_DDR,#2
3836                     ; 113 	PD_CR1 &= ~BIT(2); 
3838  00c5 72155012      	bres	_PD_CR1,#2
3839                     ; 114 	PD_CR2 &= ~BIT(2);
3841  00c9 72155013      	bres	_PD_CR2,#2
3842                     ; 116 	PD_DDR &= ~BIT(3);
3844  00cd 72175011      	bres	_PD_DDR,#3
3845                     ; 117 	PD_CR1 &= ~BIT(3); 
3847  00d1 72175012      	bres	_PD_CR1,#3
3848                     ; 118 	PD_CR2 &= ~BIT(3);
3850  00d5 72175013      	bres	_PD_CR2,#3
3851                     ; 120 	PD_DDR &= ~BIT(4);
3853  00d9 72195011      	bres	_PD_DDR,#4
3854                     ; 121 	PD_CR1 &= ~BIT(4); 
3856  00dd 72195012      	bres	_PD_CR1,#4
3857                     ; 122 	PD_CR2 &= ~BIT(4);
3859  00e1 72195013      	bres	_PD_CR2,#4
3860                     ; 124 	PC_DDR &= ~BIT(7);
3862  00e5 721f500c      	bres	_PC_DDR,#7
3863                     ; 125 	PC_CR1 &= ~BIT(7); 
3865  00e9 721f500d      	bres	_PC_CR1,#7
3866                     ; 126 	PC_CR2 &= ~BIT(7);
3868  00ed 721f500e      	bres	_PC_CR2,#7
3869                     ; 128 	PC_DDR &= ~BIT(6);
3871  00f1 721d500c      	bres	_PC_DDR,#6
3872                     ; 129 	PC_CR1 &= ~BIT(6); 
3874  00f5 721d500d      	bres	_PC_CR1,#6
3875                     ; 130 	PC_CR2 &= ~BIT(6);
3877  00f9 721d500e      	bres	_PC_CR2,#6
3878                     ; 132 	PC_DDR &= ~BIT(4);
3880  00fd 7219500c      	bres	_PC_DDR,#4
3881                     ; 133 	PC_CR1 &= ~BIT(4); 
3883  0101 7219500d      	bres	_PC_CR1,#4
3884                     ; 134 	PC_CR2 &= ~BIT(4);
3886  0105 7219500e      	bres	_PC_CR2,#4
3887                     ; 136 	PC_DDR &= ~BIT(3);
3889  0109 7217500c      	bres	_PC_DDR,#3
3890                     ; 137 	PC_CR1 &= ~BIT(3); 
3892  010d 7217500d      	bres	_PC_CR1,#3
3893                     ; 138 	PC_CR2 &= ~BIT(3);
3895  0111 7217500e      	bres	_PC_CR2,#3
3896                     ; 142 	PE_DDR &= ~BIT(5);
3898  0115 721b5016      	bres	_PE_DDR,#5
3899                     ; 143 	PE_CR1 |= BIT(5); 
3901  0119 721a5017      	bset	_PE_CR1,#5
3902                     ; 144 	PE_CR2 &= ~BIT(5);
3904  011d 721b5018      	bres	_PE_CR2,#5
3905                     ; 146 	PB_DDR &= ~BIT(0);
3907  0121 72115007      	bres	_PB_DDR,#0
3908                     ; 147 	PB_CR1 |= BIT(0); 
3910  0125 72105008      	bset	_PB_CR1,#0
3911                     ; 148 	PB_CR2 &= ~BIT(0);
3913  0129 72115009      	bres	_PB_CR2,#0
3914                     ; 150 	PA_DDR |= BIT(1);
3916  012d 72125002      	bset	_PA_DDR,#1
3917                     ; 151 	PA_CR1 |= BIT(1); 
3919  0131 72125003      	bset	_PA_CR1,#1
3920                     ; 152 	PA_CR2 |= BIT(1);
3922  0135 72125004      	bset	_PA_CR2,#1
3923                     ; 156 	PC_DDR |= BIT(1);
3925  0139 7212500c      	bset	_PC_DDR,#1
3926                     ; 157 	PC_CR1 |= BIT(1); 
3928  013d 7212500d      	bset	_PC_CR1,#1
3929                     ; 158 	PC_CR2 |= BIT(1);
3931  0141 7212500e      	bset	_PC_CR2,#1
3932                     ; 162 	PB_DDR |= BIT(1);
3934  0145 72125007      	bset	_PB_DDR,#1
3935                     ; 163 	PB_CR1 |= BIT(1); 
3937  0149 72125008      	bset	_PB_CR1,#1
3938                     ; 164 	PB_CR2 |= BIT(1);
3940  014d 72125009      	bset	_PB_CR2,#1
3941                     ; 165 	OPB1 = 0;
3943  0151 72135005      	bres	_OPB1
3944                     ; 188 	IWDG_KR = 0xCC;       //启动看门狗
3946  0155 35cc50e0      	mov	_IWDG_KR,#204
3947                     ; 189 	IWDG_KR = 0x55;       //解除写保护
3949  0159 355550e0      	mov	_IWDG_KR,#85
3950                     ; 190 	IWDG_PR = 0x06;       //256分频，最高1.02秒
3952  015d 350650e1      	mov	_IWDG_PR,#6
3953                     ; 191 	IWDG_RLR = 255;       //1020ms
3955  0161 35ff50e2      	mov	_IWDG_RLR,#255
3956                     ; 192 	IWDG_KR = 0xAA;       //写保护
3958  0165 35aa50e0      	mov	_IWDG_KR,#170
3959                     ; 193 	WDT();//清看门狗
3961  0169 35aa50e0      	mov	_IWDG_KR,#170
3962                     ; 194 }
3965  016d 81            	ret
4010                     ; 202 void Addr_Read(u16 *address)
4010                     ; 203 {
4011                     	switch	.text
4012  016e               _Addr_Read:
4014  016e 89            	pushw	x
4015       00000000      OFST:	set	0
4018                     ; 204 	*address = 0;
4020  016f 905f          	clrw	y
4021  0171 ff            	ldw	(x),y
4022                     ; 205 	if(adr_1 == 0)
4024                     	btst	_IPC2
4025  0177 2505          	jrult	L1642
4026                     ; 207 		*address = 1;
4028  0179 90ae0001      	ldw	y,#1
4029  017d ff            	ldw	(x),y
4030  017e               L1642:
4031                     ; 209 	if(adr_2 == 0)
4033                     	btst	_IPC5
4034  0183 2507          	jrult	L3642
4035                     ; 211 		*address = 2;
4037  0185 1e01          	ldw	x,(OFST+1,sp)
4038  0187 90ae0002      	ldw	y,#2
4039  018b ff            	ldw	(x),y
4040  018c               L3642:
4041                     ; 213 	if(adr_3 == 0)
4043                     	btst	_IPD0
4044  0191 2507          	jrult	L5642
4045                     ; 215 		*address = 3;
4047  0193 1e01          	ldw	x,(OFST+1,sp)
4048  0195 90ae0003      	ldw	y,#3
4049  0199 ff            	ldw	(x),y
4050  019a               L5642:
4051                     ; 217 	if(adr_4 == 0)
4053                     	btst	_IPD2
4054  019f 2507          	jrult	L7642
4055                     ; 219 		*address = 4;
4057  01a1 1e01          	ldw	x,(OFST+1,sp)
4058  01a3 90ae0004      	ldw	y,#4
4059  01a7 ff            	ldw	(x),y
4060  01a8               L7642:
4061                     ; 221 	if(adr_5 == 0)
4063                     	btst	_IPD3
4064  01ad 2507          	jrult	L1742
4065                     ; 223 		*address = 5;
4067  01af 1e01          	ldw	x,(OFST+1,sp)
4068  01b1 90ae0005      	ldw	y,#5
4069  01b5 ff            	ldw	(x),y
4070  01b6               L1742:
4071                     ; 225 	if(adr_6 == 0)
4073                     	btst	_IPD4
4074  01bb 2507          	jrult	L3742
4075                     ; 227 		*address = 6;
4077  01bd 1e01          	ldw	x,(OFST+1,sp)
4078  01bf 90ae0006      	ldw	y,#6
4079  01c3 ff            	ldw	(x),y
4080  01c4               L3742:
4081                     ; 229 	if(adr_7 == 0)
4083                     	btst	_IPC7
4084  01c9 2507          	jrult	L5742
4085                     ; 231 		*address = 7;
4087  01cb 1e01          	ldw	x,(OFST+1,sp)
4088  01cd 90ae0007      	ldw	y,#7
4089  01d1 ff            	ldw	(x),y
4090  01d2               L5742:
4091                     ; 233 	if(adr_8 == 0)
4093                     	btst	_IPC6
4094  01d7 2507          	jrult	L7742
4095                     ; 235 		*address = 8;
4097  01d9 1e01          	ldw	x,(OFST+1,sp)
4098  01db 90ae0008      	ldw	y,#8
4099  01df ff            	ldw	(x),y
4100  01e0               L7742:
4101                     ; 237 	if(adr_9 == 0)
4103                     	btst	_IPC4
4104  01e5 2507          	jrult	L1052
4105                     ; 239 		*address = 9;
4107  01e7 1e01          	ldw	x,(OFST+1,sp)
4108  01e9 90ae0009      	ldw	y,#9
4109  01ed ff            	ldw	(x),y
4110  01ee               L1052:
4111                     ; 241 	if(adr_10 == 0)
4113                     	btst	_IPC3
4114  01f3 2507          	jrult	L3052
4115                     ; 243 		*address = 10;
4117  01f5 1e01          	ldw	x,(OFST+1,sp)
4118  01f7 90ae000a      	ldw	y,#10
4119  01fb ff            	ldw	(x),y
4120  01fc               L3052:
4121                     ; 245 }
4124  01fc 85            	popw	x
4125  01fd 81            	ret
4194                     ; 246 u8 robot_mode(u8 mode) {
4195                     	switch	.text
4196  01fe               _robot_mode:
4198  01fe 88            	push	a
4199  01ff 5206          	subw	sp,#6
4200       00000006      OFST:	set	6
4203                     ; 247 	u16 moto_flag_count = 0;
4205  0201 5f            	clrw	x
4206  0202 1f01          	ldw	(OFST-5,sp),x
4207                     ; 248 	u16 moto_flag = 0;
4209  0204 5f            	clrw	x
4210  0205 1f03          	ldw	(OFST-3,sp),x
4211                     ; 249 	u16 moto_sleep = 0;
4213  0207 1e05          	ldw	x,(OFST-1,sp)
4214                     ; 251 	moto_sleep = 1000;
4216  0209 ae03e8        	ldw	x,#1000
4217  020c 1f05          	ldw	(OFST-1,sp),x
4218                     ; 252 	WDT();//清看门狗
4220  020e 35aa50e0      	mov	_IWDG_KR,#170
4221                     ; 253 	en_seat = 1;
4223  0212 72125000      	bset	_OPA1
4224                     ; 254 	delayms(10);
4226  0216 ae000a        	ldw	x,#10
4227  0219 cd0000        	call	_delayms
4229                     ; 255 	if(mode == 0) {
4231  021c 0d07          	tnz	(OFST+1,sp)
4232  021e 2673          	jrne	L7352
4233                     ; 256 		if(back_seat == 1) {
4235                     	btst	_IPE5
4236  0225 2404          	jruge	L1452
4237                     ; 257 			return 0x01;
4239  0227 a601          	ld	a,#1
4241  0229 2035          	jra	L61
4242  022b               L1452:
4243                     ; 259 			moto_dir = 0;
4245  022b 721d5005      	bres	_OPB6
4247  022f 2053          	jra	L1552
4248  0231               L5452:
4249                     ; 261 				moto_step = 0;
4251  0231 72175000      	bres	_OPA3
4252                     ; 262 				delayus(moto_sleep);
4254  0235 1e05          	ldw	x,(OFST-1,sp)
4255  0237 cd002b        	call	_delayus
4257                     ; 263 				moto_step = 1;
4259  023a 72165000      	bset	_OPA3
4260                     ; 264 				delayus(moto_sleep);
4262  023e 1e05          	ldw	x,(OFST-1,sp)
4263  0240 cd002b        	call	_delayus
4265                     ; 265 				WDT();//清看门狗
4267  0243 35aa50e0      	mov	_IWDG_KR,#170
4268                     ; 266 				if(back_seat == 1){
4270                     	btst	_IPE5
4271  024c 2415          	jruge	L5552
4272                     ; 267 					if(moto_flag < 2000) {
4274  024e 1e03          	ldw	x,(OFST-3,sp)
4275  0250 a307d0        	cpw	x,#2000
4276  0253 2409          	jruge	L7552
4277                     ; 268 						moto_flag++;
4279  0255 1e03          	ldw	x,(OFST-3,sp)
4280  0257 1c0001        	addw	x,#1
4281  025a 1f03          	ldw	(OFST-3,sp),x
4283  025c 2008          	jra	L3652
4284  025e               L7552:
4285                     ; 270 						return 0x44;
4287  025e a644          	ld	a,#68
4289  0260               L61:
4291  0260 5b07          	addw	sp,#7
4292  0262 81            	ret
4293  0263               L5552:
4294                     ; 273 					moto_flag = 0;
4296  0263 5f            	clrw	x
4297  0264 1f03          	ldw	(OFST-3,sp),x
4298  0266               L3652:
4299                     ; 275 				if(moto_flag_count < 1) {
4301  0266 1e01          	ldw	x,(OFST-5,sp)
4302  0268 2609          	jrne	L5652
4303                     ; 276 					moto_flag_count++;	
4305  026a 1e01          	ldw	x,(OFST-5,sp)
4306  026c 1c0001        	addw	x,#1
4307  026f 1f01          	ldw	(OFST-5,sp),x
4309  0271 2011          	jra	L1552
4310  0273               L5652:
4311                     ; 278 					moto_flag_count = 0;
4313  0273 5f            	clrw	x
4314  0274 1f01          	ldw	(OFST-5,sp),x
4315                     ; 279 					if(moto_sleep > 250) {
4317  0276 1e05          	ldw	x,(OFST-1,sp)
4318  0278 a300fb        	cpw	x,#251
4319  027b 2507          	jrult	L1552
4320                     ; 280 						moto_sleep--;
4322  027d 1e05          	ldw	x,(OFST-1,sp)
4323  027f 1d0001        	subw	x,#1
4324  0282 1f05          	ldw	(OFST-1,sp),x
4325  0284               L1552:
4326                     ; 260 			while(moto_flag < 600) {
4328  0284 1e03          	ldw	x,(OFST-3,sp)
4329  0286 a30258        	cpw	x,#600
4330  0289 25a6          	jrult	L5452
4331                     ; 284 			en_seat = 0;
4333  028b 72135000      	bres	_OPA1
4334                     ; 285 			return 0x02;
4336  028f a602          	ld	a,#2
4338  0291 20cd          	jra	L61
4339  0293               L7352:
4340                     ; 288 		if(out_seat == 1) {
4342                     	btst	_IPB0
4343  0298 2404          	jruge	L5752
4344                     ; 289 			return 0x01;
4346  029a a601          	ld	a,#1
4348  029c 20c2          	jra	L61
4349  029e               L5752:
4350                     ; 291 			moto_dir = 1;
4352  029e 721c5005      	bset	_OPB6
4354  02a2 2052          	jra	L5062
4355  02a4               L1062:
4356                     ; 293 				moto_step = 0;
4358  02a4 72175000      	bres	_OPA3
4359                     ; 294 				delayus(moto_sleep);
4361  02a8 1e05          	ldw	x,(OFST-1,sp)
4362  02aa cd002b        	call	_delayus
4364                     ; 295 				moto_step = 1;
4366  02ad 72165000      	bset	_OPA3
4367                     ; 296 				delayus(moto_sleep);
4369  02b1 1e05          	ldw	x,(OFST-1,sp)
4370  02b3 cd002b        	call	_delayus
4372                     ; 297 				WDT();//清看门狗
4374  02b6 35aa50e0      	mov	_IWDG_KR,#170
4375                     ; 298 				if(out_seat == 1){
4377                     	btst	_IPB0
4378  02bf 2414          	jruge	L1162
4379                     ; 299 					if(moto_flag < 2000) {
4381  02c1 1e03          	ldw	x,(OFST-3,sp)
4382  02c3 a307d0        	cpw	x,#2000
4383  02c6 2409          	jruge	L3162
4384                     ; 300 						moto_flag++;
4386  02c8 1e03          	ldw	x,(OFST-3,sp)
4387  02ca 1c0001        	addw	x,#1
4388  02cd 1f03          	ldw	(OFST-3,sp),x
4390  02cf 2007          	jra	L7162
4391  02d1               L3162:
4392                     ; 302 						return 0x44;
4394  02d1 a644          	ld	a,#68
4396  02d3 208b          	jra	L61
4397  02d5               L1162:
4398                     ; 305 					moto_flag = 0;
4400  02d5 5f            	clrw	x
4401  02d6 1f03          	ldw	(OFST-3,sp),x
4402  02d8               L7162:
4403                     ; 307 				if(moto_flag_count < 1) {
4405  02d8 1e01          	ldw	x,(OFST-5,sp)
4406  02da 2609          	jrne	L1262
4407                     ; 308 					moto_flag_count++;	
4409  02dc 1e01          	ldw	x,(OFST-5,sp)
4410  02de 1c0001        	addw	x,#1
4411  02e1 1f01          	ldw	(OFST-5,sp),x
4413  02e3 2011          	jra	L5062
4414  02e5               L1262:
4415                     ; 310 					moto_flag_count = 0;
4417  02e5 5f            	clrw	x
4418  02e6 1f01          	ldw	(OFST-5,sp),x
4419                     ; 311 					if(moto_sleep > 250) {
4421  02e8 1e05          	ldw	x,(OFST-1,sp)
4422  02ea a300fb        	cpw	x,#251
4423  02ed 2507          	jrult	L5062
4424                     ; 312 						moto_sleep--;
4426  02ef 1e05          	ldw	x,(OFST-1,sp)
4427  02f1 1d0001        	subw	x,#1
4428  02f4 1f05          	ldw	(OFST-1,sp),x
4429  02f6               L5062:
4430                     ; 292 			while(moto_flag < 600) {
4432  02f6 1e03          	ldw	x,(OFST-3,sp)
4433  02f8 a30258        	cpw	x,#600
4434  02fb 25a7          	jrult	L1062
4435                     ; 316 			en_seat = 0;
4437  02fd 72135000      	bres	_OPA1
4438                     ; 317 			return 0x02;
4440  0301 a602          	ld	a,#2
4442  0303 ac600260      	jpf	L61
4477                     ; 323 void SetLed(u8 cmd) {
4478                     	switch	.text
4479  0307               _SetLed:
4483                     ; 324 	OPB1 = cmd;
4485  0307 4d            	tnz	a
4486  0308 2602          	jrne	L62
4487  030a 2006          	jp	L22
4488  030c               L62:
4489  030c 72125005      	bset	_OPB1
4490  0310 2004          	jra	L42
4491  0312               L22:
4492  0312 72135005      	bres	_OPB1
4493  0316               L42:
4494                     ; 325 }
4497  0316 81            	ret
4525                     ; 334 void Eeprom_Init(void)
4525                     ; 335 {
4526                     	switch	.text
4527  0317               _Eeprom_Init:
4531                     ; 336 	FLASH_CR1 = 0X00;
4533  0317 725f505a      	clr	_FLASH_CR1
4534                     ; 337 	FLASH_CR2 = 0X00;
4536  031b 725f505b      	clr	_FLASH_CR2
4537                     ; 338 	FLASH_NCR2 = 0XFF;
4539  031f 35ff505c      	mov	_FLASH_NCR2,#255
4540                     ; 339 	FLASH_DUKR = 0XAE;
4542  0323 35ae5064      	mov	_FLASH_DUKR,#174
4543                     ; 340 	FLASH_DUKR = 0X56;
4545  0327 35565064      	mov	_FLASH_DUKR,#86
4547  032b               L1662:
4548                     ; 341 	while(!(FLASH_IAPSR&0X08));
4550  032b c6505f        	ld	a,_FLASH_IAPSR
4551  032e a508          	bcp	a,#8
4552  0330 27f9          	jreq	L1662
4553                     ; 342 }
4556  0332 81            	ret
4610                     ; 350 void Eeprom_Write(u8 addr,u8 dat)
4610                     ; 351 {
4611                     	switch	.text
4612  0333               _Eeprom_Write:
4614  0333 89            	pushw	x
4615  0334 89            	pushw	x
4616       00000002      OFST:	set	2
4619                     ; 353 	p = (u8 *)(0x4000+addr);
4621  0335 a640          	ld	a,#64
4622  0337 97            	ld	xl,a
4623  0338 a600          	ld	a,#0
4624  033a 1b03          	add	a,(OFST+1,sp)
4625  033c 2401          	jrnc	L43
4626  033e 5c            	incw	x
4627  033f               L43:
4628  033f 02            	rlwa	x,a
4629  0340 1f01          	ldw	(OFST-1,sp),x
4630  0342 01            	rrwa	x,a
4631                     ; 354 	*p = dat;
4633  0343 7b04          	ld	a,(OFST+2,sp)
4634  0345 1e01          	ldw	x,(OFST-1,sp)
4635  0347 f7            	ld	(x),a
4637  0348               L7172:
4638                     ; 355 	while(!(FLASH_IAPSR&0X40));
4640  0348 c6505f        	ld	a,_FLASH_IAPSR
4641  034b a540          	bcp	a,#64
4642  034d 27f9          	jreq	L7172
4643                     ; 356 }
4646  034f 5b04          	addw	sp,#4
4647  0351 81            	ret
4691                     ; 364 u8 Eeprom_Read(u8 addr)
4691                     ; 365 {
4692                     	switch	.text
4693  0352               _Eeprom_Read:
4695  0352 88            	push	a
4696  0353 89            	pushw	x
4697       00000002      OFST:	set	2
4700                     ; 367 	p = (u8 *)(0x4000+addr);
4702  0354 a640          	ld	a,#64
4703  0356 97            	ld	xl,a
4704  0357 a600          	ld	a,#0
4705  0359 1b03          	add	a,(OFST+1,sp)
4706  035b 2401          	jrnc	L04
4707  035d 5c            	incw	x
4708  035e               L04:
4709  035e 02            	rlwa	x,a
4710  035f 1f01          	ldw	(OFST-1,sp),x
4711  0361 01            	rrwa	x,a
4712                     ; 368 	return *p;
4714  0362 1e01          	ldw	x,(OFST-1,sp)
4715  0364 f6            	ld	a,(x)
4718  0365 5b03          	addw	sp,#3
4719  0367 81            	ret
4764                     ; 371 void eeprom_count(u8 ad)
4764                     ; 372 {
4765                     	switch	.text
4766  0368               _eeprom_count:
4768  0368 88            	push	a
4769  0369 88            	push	a
4770       00000001      OFST:	set	1
4773                     ; 373 	u8 i = Eeprom_Read(ad);
4775  036a ade6          	call	_Eeprom_Read
4777  036c 6b01          	ld	(OFST+0,sp),a
4778                     ; 374 	if(i == 9)
4780  036e 7b01          	ld	a,(OFST+0,sp)
4781  0370 a109          	cp	a,#9
4782  0372 2703          	jreq	L44
4783  0374 cc0407        	jp	L7672
4784  0377               L44:
4785                     ; 376 		Eeprom_Write(ad,0);
4787  0377 5f            	clrw	x
4788  0378 7b02          	ld	a,(OFST+1,sp)
4789  037a 95            	ld	xh,a
4790  037b adb6          	call	_Eeprom_Write
4792                     ; 377 		i = Eeprom_Read(ad+1);
4794  037d 7b02          	ld	a,(OFST+1,sp)
4795  037f 4c            	inc	a
4796  0380 add0          	call	_Eeprom_Read
4798  0382 6b01          	ld	(OFST+0,sp),a
4799                     ; 378 		if(i == 9)
4801  0384 7b01          	ld	a,(OFST+0,sp)
4802  0386 a109          	cp	a,#9
4803  0388 266f          	jrne	L1772
4804                     ; 380 			Eeprom_Write(ad+1,0);
4806  038a 5f            	clrw	x
4807  038b 7b02          	ld	a,(OFST+1,sp)
4808  038d 4c            	inc	a
4809  038e 95            	ld	xh,a
4810  038f ada2          	call	_Eeprom_Write
4812                     ; 381 			i = Eeprom_Read(ad+2);
4814  0391 7b02          	ld	a,(OFST+1,sp)
4815  0393 ab02          	add	a,#2
4816  0395 adbb          	call	_Eeprom_Read
4818  0397 6b01          	ld	(OFST+0,sp),a
4819                     ; 382 			if(i == 9)
4821  0399 7b01          	ld	a,(OFST+0,sp)
4822  039b a109          	cp	a,#9
4823  039d 264b          	jrne	L3772
4824                     ; 384 				Eeprom_Write(ad+2,0);
4826  039f 5f            	clrw	x
4827  03a0 7b02          	ld	a,(OFST+1,sp)
4828  03a2 ab02          	add	a,#2
4829  03a4 95            	ld	xh,a
4830  03a5 ad8c          	call	_Eeprom_Write
4832                     ; 385 				i = Eeprom_Read(ad+3);
4834  03a7 7b02          	ld	a,(OFST+1,sp)
4835  03a9 ab03          	add	a,#3
4836  03ab ada5          	call	_Eeprom_Read
4838  03ad 6b01          	ld	(OFST+0,sp),a
4839                     ; 386 				if(i == 9)
4841  03af 7b01          	ld	a,(OFST+0,sp)
4842  03b1 a109          	cp	a,#9
4843  03b3 2626          	jrne	L5772
4844                     ; 388 					Eeprom_Write(ad+3,0);
4846  03b5 5f            	clrw	x
4847  03b6 7b02          	ld	a,(OFST+1,sp)
4848  03b8 ab03          	add	a,#3
4849  03ba 95            	ld	xh,a
4850  03bb cd0333        	call	_Eeprom_Write
4852                     ; 389 					i = Eeprom_Read(ad+4);
4854  03be 7b02          	ld	a,(OFST+1,sp)
4855  03c0 ab04          	add	a,#4
4856  03c2 ad8e          	call	_Eeprom_Read
4858  03c4 6b01          	ld	(OFST+0,sp),a
4859                     ; 390 					if(i == 9)
4861  03c6 7b01          	ld	a,(OFST+0,sp)
4862  03c8 a109          	cp	a,#9
4863  03ca 2746          	jreq	L1103
4865                     ; 396 						i++;
4867  03cc 0c01          	inc	(OFST+0,sp)
4868                     ; 397 						Eeprom_Write(ad+4,i);
4870  03ce 7b01          	ld	a,(OFST+0,sp)
4871  03d0 97            	ld	xl,a
4872  03d1 7b02          	ld	a,(OFST+1,sp)
4873  03d3 ab04          	add	a,#4
4874  03d5 95            	ld	xh,a
4875  03d6 cd0333        	call	_Eeprom_Write
4877  03d9 2037          	jra	L1103
4878  03db               L5772:
4879                     ; 402 					i++;
4881  03db 0c01          	inc	(OFST+0,sp)
4882                     ; 403 					Eeprom_Write(ad+3,i);
4884  03dd 7b01          	ld	a,(OFST+0,sp)
4885  03df 97            	ld	xl,a
4886  03e0 7b02          	ld	a,(OFST+1,sp)
4887  03e2 ab03          	add	a,#3
4888  03e4 95            	ld	xh,a
4889  03e5 cd0333        	call	_Eeprom_Write
4891  03e8 2028          	jra	L1103
4892  03ea               L3772:
4893                     ; 408 				i++;
4895  03ea 0c01          	inc	(OFST+0,sp)
4896                     ; 409 				Eeprom_Write(ad+2,i);
4898  03ec 7b01          	ld	a,(OFST+0,sp)
4899  03ee 97            	ld	xl,a
4900  03ef 7b02          	ld	a,(OFST+1,sp)
4901  03f1 ab02          	add	a,#2
4902  03f3 95            	ld	xh,a
4903  03f4 cd0333        	call	_Eeprom_Write
4905  03f7 2019          	jra	L1103
4906  03f9               L1772:
4907                     ; 414 			i++;
4909  03f9 0c01          	inc	(OFST+0,sp)
4910                     ; 415 			Eeprom_Write(ad+1,i);
4912  03fb 7b01          	ld	a,(OFST+0,sp)
4913  03fd 97            	ld	xl,a
4914  03fe 7b02          	ld	a,(OFST+1,sp)
4915  0400 4c            	inc	a
4916  0401 95            	ld	xh,a
4917  0402 cd0333        	call	_Eeprom_Write
4919  0405 200b          	jra	L1103
4920  0407               L7672:
4921                     ; 420 		i++;
4923  0407 0c01          	inc	(OFST+0,sp)
4924                     ; 421 		Eeprom_Write(ad,i);
4926  0409 7b01          	ld	a,(OFST+0,sp)
4927  040b 97            	ld	xl,a
4928  040c 7b02          	ld	a,(OFST+1,sp)
4929  040e 95            	ld	xh,a
4930  040f cd0333        	call	_Eeprom_Write
4932  0412               L1103:
4933                     ; 423 }
4936  0412 85            	popw	x
4937  0413 81            	ret
4950                     	xdef	_eeprom_count
4951                     	xdef	_Eeprom_Read
4952                     	xdef	_Eeprom_Write
4953                     	xdef	_Eeprom_Init
4954                     	xdef	_SetLed
4955                     	xdef	_robot_mode
4956                     	xdef	_Addr_Read
4957                     	xdef	_BSP_Init
4958                     	xdef	_delayus
4959                     	xdef	_delayms
4978                     	end
