
hg2021.elf:     file format elf32-littlearm


Disassembly of section .crt0:

08000000 <__text_start>:
 8000000:	ea00002e 	b	80000c0 <rom_header_end>
	...
 80000b0:	00963130 	.word	0x00963130
	...
 80000bc:	0000f000 	.word	0x0000f000

080000c0 <rom_header_end>:
 80000c0:	ea000006 	b	80000e0 <start_vector>

080000c4 <__boot_method>:
	...

080000c5 <__slave_number>:
	...

080000e0 <start_vector>:
 80000e0:	e3a00301 	mov	r0, #67108864	; 0x4000000
 80000e4:	e5800208 	str	r0, [r0, #520]	; 0x208
 80000e8:	e3a00012 	mov	r0, #18
 80000ec:	e129f000 	msr	CPSR_fc, r0
 80000f0:	e59fd0b8 	ldr	sp, [pc, #184]	; 80001b0 <CIDExit+0x4>
 80000f4:	e3a0001f 	mov	r0, #31
 80000f8:	e129f000 	msr	CPSR_fc, r0
 80000fc:	e59fd0b0 	ldr	sp, [pc, #176]	; 80001b4 <CIDExit+0x8>
 8000100:	e28f0001 	add	r0, pc, #1
 8000104:	e12fff10 	bx	r0
 8000108:	482b      	ldr	r0, [pc, #172]	; (80001b8 <CIDExit+0xc>)
 800010a:	0140      	lsls	r0, r0, #5
 800010c:	d20b      	bcs.n	8000126 <DoEWRAMClear>
 800010e:	4678      	mov	r0, pc
 8000110:	0140      	lsls	r0, r0, #5
 8000112:	d30d      	bcc.n	8000130 <SkipEWRAMClear>
 8000114:	2202      	movs	r2, #2
 8000116:	0612      	lsls	r2, r2, #24
 8000118:	4b28      	ldr	r3, [pc, #160]	; (80001bc <CIDExit+0x10>)
 800011a:	1a9b      	subs	r3, r3, r2
 800011c:	1c16      	adds	r6, r2, #0
 800011e:	0091      	lsls	r1, r2, #2
 8000120:	f000 f83c 	bl	800019c <CopyMem>
 8000124:	4730      	bx	r6

08000126 <DoEWRAMClear>:
 8000126:	2140      	movs	r1, #64	; 0x40
 8000128:	0309      	lsls	r1, r1, #12
 800012a:	01c8      	lsls	r0, r1, #7
 800012c:	f000 f82b 	bl	8000186 <ClearMem>

08000130 <SkipEWRAMClear>:
 8000130:	4823      	ldr	r0, [pc, #140]	; (80001c0 <CIDExit+0x14>)
 8000132:	4924      	ldr	r1, [pc, #144]	; (80001c4 <CIDExit+0x18>)
 8000134:	1a09      	subs	r1, r1, r0
 8000136:	f000 f826 	bl	8000186 <ClearMem>
 800013a:	4823      	ldr	r0, [pc, #140]	; (80001c8 <CIDExit+0x1c>)
 800013c:	4923      	ldr	r1, [pc, #140]	; (80001cc <CIDExit+0x20>)
 800013e:	1a09      	subs	r1, r1, r0
 8000140:	f000 f821 	bl	8000186 <ClearMem>
 8000144:	4922      	ldr	r1, [pc, #136]	; (80001d0 <CIDExit+0x24>)
 8000146:	4a23      	ldr	r2, [pc, #140]	; (80001d4 <CIDExit+0x28>)
 8000148:	4c23      	ldr	r4, [pc, #140]	; (80001d8 <CIDExit+0x2c>)
 800014a:	f000 f826 	bl	800019a <CopyMemChk>
 800014e:	4923      	ldr	r1, [pc, #140]	; (80001dc <CIDExit+0x30>)
 8000150:	4a23      	ldr	r2, [pc, #140]	; (80001e0 <CIDExit+0x34>)
 8000152:	4c24      	ldr	r4, [pc, #144]	; (80001e4 <CIDExit+0x38>)
 8000154:	f000 f821 	bl	800019a <CopyMemChk>
 8000158:	4a23      	ldr	r2, [pc, #140]	; (80001e8 <CIDExit+0x3c>)
 800015a:	4924      	ldr	r1, [pc, #144]	; (80001ec <CIDExit+0x40>)
 800015c:	1a53      	subs	r3, r2, r1
 800015e:	d002      	beq.n	8000166 <CIW0Skip>
 8000160:	4a23      	ldr	r2, [pc, #140]	; (80001f0 <CIDExit+0x44>)
 8000162:	f000 f81b 	bl	800019c <CopyMem>

08000166 <CIW0Skip>:
 8000166:	4923      	ldr	r1, [pc, #140]	; (80001f4 <CIDExit+0x48>)
 8000168:	4a23      	ldr	r2, [pc, #140]	; (80001f8 <CIDExit+0x4c>)
 800016a:	4c24      	ldr	r4, [pc, #144]	; (80001fc <CIDExit+0x50>)
 800016c:	f000 f815 	bl	800019a <CopyMemChk>

08000170 <CEW0Skip>:
 8000170:	4923      	ldr	r1, [pc, #140]	; (8000200 <CIDExit+0x54>)
 8000172:	4824      	ldr	r0, [pc, #144]	; (8000204 <CIDExit+0x58>)
 8000174:	6008      	str	r0, [r1, #0]
 8000176:	4b24      	ldr	r3, [pc, #144]	; (8000208 <CIDExit+0x5c>)
 8000178:	f000 f80e 	bl	8000198 <_blx_r3_stub>
 800017c:	2000      	movs	r0, #0
 800017e:	2100      	movs	r1, #0
 8000180:	4b22      	ldr	r3, [pc, #136]	; (800020c <CIDExit+0x60>)
 8000182:	f000 f809 	bl	8000198 <_blx_r3_stub>

08000186 <ClearMem>:
 8000186:	2203      	movs	r2, #3
 8000188:	1889      	adds	r1, r1, r2
 800018a:	4391      	bics	r1, r2
 800018c:	d003      	beq.n	8000196 <ClearMX>
 800018e:	2200      	movs	r2, #0

08000190 <ClrLoop>:
 8000190:	c004      	stmia	r0!, {r2}
 8000192:	3904      	subs	r1, #4
 8000194:	d1fc      	bne.n	8000190 <ClrLoop>

08000196 <ClearMX>:
 8000196:	4770      	bx	lr

08000198 <_blx_r3_stub>:
 8000198:	4718      	bx	r3

0800019a <CopyMemChk>:
 800019a:	1aa3      	subs	r3, r4, r2

0800019c <CopyMem>:
 800019c:	2003      	movs	r0, #3
 800019e:	181b      	adds	r3, r3, r0
 80001a0:	4383      	bics	r3, r0
 80001a2:	d003      	beq.n	80001ac <CIDExit>

080001a4 <CIDLoop>:
 80001a4:	c901      	ldmia	r1!, {r0}
 80001a6:	c201      	stmia	r2!, {r0}
 80001a8:	3b04      	subs	r3, #4
 80001aa:	d1fb      	bne.n	80001a4 <CIDLoop>

080001ac <CIDExit>:
 80001ac:	4770      	bx	lr
 80001ae:	46c0      	nop			; (mov r8, r8)
 80001b0:	03007fa0 	.word	0x03007fa0
 80001b4:	03007f00 	.word	0x03007f00
 80001b8:	08000000 	.word	0x08000000
 80001bc:	02000000 	.word	0x02000000
 80001c0:	03000000 	.word	0x03000000
 80001c4:	0300002c 	.word	0x0300002c
 80001c8:	02000000 	.word	0x02000000
 80001cc:	02000000 	.word	0x02000000
 80001d0:	0806b360 	.word	0x0806b360
 80001d4:	0300002c 	.word	0x0300002c
 80001d8:	0300004c 	.word	0x0300004c
 80001dc:	0806b360 	.word	0x0806b360
 80001e0:	03000000 	.word	0x03000000
 80001e4:	03000000 	.word	0x03000000
 80001e8:	0806b380 	.word	0x0806b380
 80001ec:	0806b380 	.word	0x0806b380
 80001f0:	0300004c 	.word	0x0300004c
 80001f4:	0806b380 	.word	0x0806b380
 80001f8:	02000000 	.word	0x02000000
 80001fc:	02000000 	.word	0x02000000
 8000200:	03000028 	.word	0x03000028
 8000204:	02040000 	.word	0x02040000
 8000208:	080007a1 	.word	0x080007a1
 800020c:	080005d5 	.word	0x080005d5

Disassembly of section .init:

08000210 <_init>:
 8000210:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000212:	46c0      	nop			; (mov r8, r8)
 8000214:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8000216:	bc08      	pop	{r3}
 8000218:	469e      	mov	lr, r3
 800021a:	4770      	bx	lr

Disassembly of section .text:

08000220 <__do_global_dtors_aux>:
 8000220:	b510      	push	{r4, lr}
 8000222:	4c07      	ldr	r4, [pc, #28]	; (8000240 <__do_global_dtors_aux+0x20>)
 8000224:	7823      	ldrb	r3, [r4, #0]
 8000226:	2b00      	cmp	r3, #0
 8000228:	d107      	bne.n	800023a <__do_global_dtors_aux+0x1a>
 800022a:	4b06      	ldr	r3, [pc, #24]	; (8000244 <__do_global_dtors_aux+0x24>)
 800022c:	2b00      	cmp	r3, #0
 800022e:	d002      	beq.n	8000236 <__do_global_dtors_aux+0x16>
 8000230:	4805      	ldr	r0, [pc, #20]	; (8000248 <__do_global_dtors_aux+0x28>)
 8000232:	e000      	b.n	8000236 <__do_global_dtors_aux+0x16>
 8000234:	bf00      	nop
 8000236:	2301      	movs	r3, #1
 8000238:	7023      	strb	r3, [r4, #0]
 800023a:	bc10      	pop	{r4}
 800023c:	bc01      	pop	{r0}
 800023e:	4700      	bx	r0
 8000240:	03000000 	.word	0x03000000
 8000244:	00000000 	.word	0x00000000
 8000248:	0806b35c 	.word	0x0806b35c

0800024c <frame_dummy>:
 800024c:	4b05      	ldr	r3, [pc, #20]	; (8000264 <frame_dummy+0x18>)
 800024e:	b510      	push	{r4, lr}
 8000250:	2b00      	cmp	r3, #0
 8000252:	d003      	beq.n	800025c <frame_dummy+0x10>
 8000254:	4904      	ldr	r1, [pc, #16]	; (8000268 <frame_dummy+0x1c>)
 8000256:	4805      	ldr	r0, [pc, #20]	; (800026c <frame_dummy+0x20>)
 8000258:	e000      	b.n	800025c <frame_dummy+0x10>
 800025a:	bf00      	nop
 800025c:	bc10      	pop	{r4}
 800025e:	bc01      	pop	{r0}
 8000260:	4700      	bx	r0
 8000262:	46c0      	nop			; (mov r8, r8)
 8000264:	00000000 	.word	0x00000000
 8000268:	03000004 	.word	0x03000004
 800026c:	0806b35c 	.word	0x0806b35c

08000270 <getkey>:
 8000270:	20ff      	movs	r0, #255	; 0xff
 8000272:	4b13      	ldr	r3, [pc, #76]	; (80002c0 <getkey+0x50>)
 8000274:	b570      	push	{r4, r5, r6, lr}
 8000276:	881b      	ldrh	r3, [r3, #0]
 8000278:	4d12      	ldr	r5, [pc, #72]	; (80002c4 <getkey+0x54>)
 800027a:	4398      	bics	r0, r3
 800027c:	2308      	movs	r3, #8
 800027e:	5ee9      	ldrsh	r1, [r5, r3]
 8000280:	4b11      	ldr	r3, [pc, #68]	; (80002c8 <getkey+0x58>)
 8000282:	004c      	lsls	r4, r1, #1
 8000284:	682a      	ldr	r2, [r5, #0]
 8000286:	5ae4      	ldrh	r4, [r4, r3]
 8000288:	260a      	movs	r6, #10
 800028a:	5fab      	ldrsh	r3, [r5, r6]
 800028c:	606a      	str	r2, [r5, #4]
 800028e:	6028      	str	r0, [r5, #0]
 8000290:	2b00      	cmp	r3, #0
 8000292:	d108      	bne.n	80002a6 <getkey+0x36>
 8000294:	4382      	bics	r2, r0
 8000296:	d006      	beq.n	80002a6 <getkey+0x36>
 8000298:	4294      	cmp	r4, r2
 800029a:	d007      	beq.n	80002ac <getkey+0x3c>
 800029c:	812b      	strh	r3, [r5, #8]
 800029e:	4a0b      	ldr	r2, [pc, #44]	; (80002cc <getkey+0x5c>)
 80002a0:	8813      	ldrh	r3, [r2, #0]
 80002a2:	3301      	adds	r3, #1
 80002a4:	8013      	strh	r3, [r2, #0]
 80002a6:	bc70      	pop	{r4, r5, r6}
 80002a8:	bc02      	pop	{r1}
 80002aa:	4708      	bx	r1
 80002ac:	3101      	adds	r1, #1
 80002ae:	0409      	lsls	r1, r1, #16
 80002b0:	1409      	asrs	r1, r1, #16
 80002b2:	8129      	strh	r1, [r5, #8]
 80002b4:	290c      	cmp	r1, #12
 80002b6:	d1f6      	bne.n	80002a6 <getkey+0x36>
 80002b8:	3301      	adds	r3, #1
 80002ba:	816b      	strh	r3, [r5, #10]
 80002bc:	e7f3      	b.n	80002a6 <getkey+0x36>
 80002be:	46c0      	nop			; (mov r8, r8)
 80002c0:	04000130 	.word	0x04000130
 80002c4:	0300001c 	.word	0x0300001c
 80002c8:	0300002c 	.word	0x0300002c
 80002cc:	06000258 	.word	0x06000258

080002d0 <vid_vsync>:
 80002d0:	4a04      	ldr	r2, [pc, #16]	; (80002e4 <vid_vsync+0x14>)
 80002d2:	8813      	ldrh	r3, [r2, #0]
 80002d4:	2b9f      	cmp	r3, #159	; 0x9f
 80002d6:	d8fc      	bhi.n	80002d2 <vid_vsync+0x2>
 80002d8:	4a02      	ldr	r2, [pc, #8]	; (80002e4 <vid_vsync+0x14>)
 80002da:	8813      	ldrh	r3, [r2, #0]
 80002dc:	2b9f      	cmp	r3, #159	; 0x9f
 80002de:	d9fc      	bls.n	80002da <vid_vsync+0xa>
 80002e0:	4770      	bx	lr
 80002e2:	46c0      	nop			; (mov r8, r8)
 80002e4:	04000006 	.word	0x04000006

080002e8 <keydown>:
 80002e8:	b510      	push	{r4, lr}
 80002ea:	0004      	movs	r4, r0
 80002ec:	f7ff ffc0 	bl	8000270 <getkey>
 80002f0:	4020      	ands	r0, r4
 80002f2:	bc10      	pop	{r4}
 80002f4:	bc02      	pop	{r1}
 80002f6:	4708      	bx	r1

080002f8 <keyrelease>:
 80002f8:	b510      	push	{r4, lr}
 80002fa:	0004      	movs	r4, r0
 80002fc:	f7ff ffb8 	bl	8000270 <getkey>
 8000300:	0021      	movs	r1, r4
 8000302:	4b06      	ldr	r3, [pc, #24]	; (800031c <keyrelease+0x24>)
 8000304:	681a      	ldr	r2, [r3, #0]
 8000306:	2000      	movs	r0, #0
 8000308:	4391      	bics	r1, r2
 800030a:	d003      	beq.n	8000314 <keyrelease+0x1c>
 800030c:	6858      	ldr	r0, [r3, #4]
 800030e:	4020      	ands	r0, r4
 8000310:	1e43      	subs	r3, r0, #1
 8000312:	4198      	sbcs	r0, r3
 8000314:	bc10      	pop	{r4}
 8000316:	bc02      	pop	{r1}
 8000318:	4708      	bx	r1
 800031a:	46c0      	nop			; (mov r8, r8)
 800031c:	0300001c 	.word	0x0300001c

08000320 <showtext>:
 8000320:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 8000322:	8802      	ldrh	r2, [r0, #0]
 8000324:	4b0e      	ldr	r3, [pc, #56]	; (8000360 <showtext+0x40>)
 8000326:	24d2      	movs	r4, #210	; 0xd2
 8000328:	801a      	strh	r2, [r3, #0]
 800032a:	4b0e      	ldr	r3, [pc, #56]	; (8000364 <showtext+0x44>)
 800032c:	0006      	movs	r6, r0
 800032e:	2796      	movs	r7, #150	; 0x96
 8000330:	469c      	mov	ip, r3
 8000332:	01e4      	lsls	r4, r4, #7
 8000334:	3401      	adds	r4, #1
 8000336:	4d0c      	ldr	r5, [pc, #48]	; (8000368 <showtext+0x48>)
 8000338:	023f      	lsls	r7, r7, #8
 800033a:	4466      	add	r6, ip
 800033c:	42bc      	cmp	r4, r7
 800033e:	d007      	beq.n	8000350 <showtext+0x30>
 8000340:	5b73      	ldrh	r3, [r6, r5]
 8000342:	802b      	strh	r3, [r5, #0]
 8000344:	05a3      	lsls	r3, r4, #22
 8000346:	d006      	beq.n	8000356 <showtext+0x36>
 8000348:	3502      	adds	r5, #2
 800034a:	3401      	adds	r4, #1
 800034c:	42bc      	cmp	r4, r7
 800034e:	d1f7      	bne.n	8000340 <showtext+0x20>
 8000350:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8000352:	bc01      	pop	{r0}
 8000354:	4700      	bx	r0
 8000356:	f7ff ffbb 	bl	80002d0 <vid_vsync>
 800035a:	3502      	adds	r5, #2
 800035c:	e7f5      	b.n	800034a <showtext+0x2a>
 800035e:	46c0      	nop			; (mov r8, r8)
 8000360:	0600d200 	.word	0x0600d200
 8000364:	f9ff2e00 	.word	0xf9ff2e00
 8000368:	0600d202 	.word	0x0600d202

0800036c <showchara>:
 800036c:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 800036e:	2600      	movs	r6, #0
 8000370:	270f      	movs	r7, #15
 8000372:	4b0c      	ldr	r3, [pc, #48]	; (80003a4 <showchara+0x38>)
 8000374:	4c0c      	ldr	r4, [pc, #48]	; (80003a8 <showchara+0x3c>)
 8000376:	18c5      	adds	r5, r0, r3
 8000378:	0023      	movs	r3, r4
 800037a:	3bd2      	subs	r3, #210	; 0xd2
 800037c:	5aea      	ldrh	r2, [r5, r3]
 800037e:	801a      	strh	r2, [r3, #0]
 8000380:	3302      	adds	r3, #2
 8000382:	42a3      	cmp	r3, r4
 8000384:	d1fa      	bne.n	800037c <showchara+0x10>
 8000386:	4237      	tst	r7, r6
 8000388:	d009      	beq.n	800039e <showchara+0x32>
 800038a:	3d0f      	subs	r5, #15
 800038c:	34e1      	adds	r4, #225	; 0xe1
 800038e:	3601      	adds	r6, #1
 8000390:	3dff      	subs	r5, #255	; 0xff
 8000392:	34ff      	adds	r4, #255	; 0xff
 8000394:	2e40      	cmp	r6, #64	; 0x40
 8000396:	d1ef      	bne.n	8000378 <showchara+0xc>
 8000398:	bcf8      	pop	{r3, r4, r5, r6, r7}
 800039a:	bc01      	pop	{r0}
 800039c:	4700      	bx	r0
 800039e:	f7ff ff97 	bl	80002d0 <vid_vsync>
 80003a2:	e7f2      	b.n	800038a <showchara+0x1e>
 80003a4:	f9ffa5c6 	.word	0xf9ffa5c6
 80003a8:	06005b0c 	.word	0x06005b0c

080003ac <showball>:
 80003ac:	b570      	push	{r4, r5, r6, lr}
 80003ae:	2600      	movs	r6, #0
 80003b0:	4b0e      	ldr	r3, [pc, #56]	; (80003ec <showball+0x40>)
 80003b2:	4c0f      	ldr	r4, [pc, #60]	; (80003f0 <showball+0x44>)
 80003b4:	18c5      	adds	r5, r0, r3
 80003b6:	0023      	movs	r3, r4
 80003b8:	3b0d      	subs	r3, #13
 80003ba:	3bff      	subs	r3, #255	; 0xff
 80003bc:	5aea      	ldrh	r2, [r5, r3]
 80003be:	801a      	strh	r2, [r3, #0]
 80003c0:	3302      	adds	r3, #2
 80003c2:	42a3      	cmp	r3, r4
 80003c4:	d1fa      	bne.n	80003bc <showball+0x10>
 80003c6:	210a      	movs	r1, #10
 80003c8:	0030      	movs	r0, r6
 80003ca:	f000 fa17 	bl	80007fc <____aeabi_idivmod_from_thumb>
 80003ce:	2900      	cmp	r1, #0
 80003d0:	d008      	beq.n	80003e4 <showball+0x38>
 80003d2:	34e1      	adds	r4, #225	; 0xe1
 80003d4:	3601      	adds	r6, #1
 80003d6:	3dd4      	subs	r5, #212	; 0xd4
 80003d8:	34ff      	adds	r4, #255	; 0xff
 80003da:	2e21      	cmp	r6, #33	; 0x21
 80003dc:	d1eb      	bne.n	80003b6 <showball+0xa>
 80003de:	bc70      	pop	{r4, r5, r6}
 80003e0:	bc01      	pop	{r0}
 80003e2:	4700      	bx	r0
 80003e4:	f7ff ff74 	bl	80002d0 <vid_vsync>
 80003e8:	e7f3      	b.n	80003d2 <showball+0x26>
 80003ea:	46c0      	nop			; (mov r8, r8)
 80003ec:	f9fff5ce 	.word	0xf9fff5ce
 80003f0:	06000b3e 	.word	0x06000b3e

080003f4 <throw>:
 80003f4:	b510      	push	{r4, lr}
 80003f6:	480a      	ldr	r0, [pc, #40]	; (8000420 <throw+0x2c>)
 80003f8:	f7ff ff92 	bl	8000320 <showtext>
 80003fc:	4809      	ldr	r0, [pc, #36]	; (8000424 <throw+0x30>)
 80003fe:	f7ff ffb5 	bl	800036c <showchara>
 8000402:	4809      	ldr	r0, [pc, #36]	; (8000428 <throw+0x34>)
 8000404:	f7ff ffb2 	bl	800036c <showchara>
 8000408:	4808      	ldr	r0, [pc, #32]	; (800042c <throw+0x38>)
 800040a:	f7ff ffaf 	bl	800036c <showchara>
 800040e:	4808      	ldr	r0, [pc, #32]	; (8000430 <throw+0x3c>)
 8000410:	f7ff ffcc 	bl	80003ac <showball>
 8000414:	4807      	ldr	r0, [pc, #28]	; (8000434 <throw+0x40>)
 8000416:	f7ff ffa9 	bl	800036c <showchara>
 800041a:	bc10      	pop	{r4}
 800041c:	bc01      	pop	{r0}
 800041e:	4700      	bx	r0
 8000420:	0804d35c 	.word	0x0804d35c
 8000424:	08024e5c 	.word	0x08024e5c
 8000428:	080219dc 	.word	0x080219dc
 800042c:	0801e55c 	.word	0x0801e55c
 8000430:	0801a044 	.word	0x0801a044
 8000434:	080282dc 	.word	0x080282dc

08000438 <fail>:
 8000438:	b510      	push	{r4, lr}
 800043a:	4811      	ldr	r0, [pc, #68]	; (8000480 <fail+0x48>)
 800043c:	f7ff ffb6 	bl	80003ac <showball>
 8000440:	4810      	ldr	r0, [pc, #64]	; (8000484 <fail+0x4c>)
 8000442:	f7ff ffb3 	bl	80003ac <showball>
 8000446:	4810      	ldr	r0, [pc, #64]	; (8000488 <fail+0x50>)
 8000448:	f7ff ffb0 	bl	80003ac <showball>
 800044c:	480f      	ldr	r0, [pc, #60]	; (800048c <fail+0x54>)
 800044e:	f7ff ffad 	bl	80003ac <showball>
 8000452:	480f      	ldr	r0, [pc, #60]	; (8000490 <fail+0x58>)
 8000454:	f7ff ffaa 	bl	80003ac <showball>
 8000458:	480e      	ldr	r0, [pc, #56]	; (8000494 <fail+0x5c>)
 800045a:	f7ff ff61 	bl	8000320 <showtext>
 800045e:	2001      	movs	r0, #1
 8000460:	f7ff ff4a 	bl	80002f8 <keyrelease>
 8000464:	2800      	cmp	r0, #0
 8000466:	d0fa      	beq.n	800045e <fail+0x26>
 8000468:	480b      	ldr	r0, [pc, #44]	; (8000498 <fail+0x60>)
 800046a:	f7ff ff59 	bl	8000320 <showtext>
 800046e:	2001      	movs	r0, #1
 8000470:	f7ff ff42 	bl	80002f8 <keyrelease>
 8000474:	2800      	cmp	r0, #0
 8000476:	d0fa      	beq.n	800046e <fail+0x36>
 8000478:	bc10      	pop	{r4}
 800047a:	bc01      	pop	{r0}
 800047c:	4700      	bx	r0
 800047e:	46c0      	nop			; (mov r8, r8)
 8000480:	08017db8 	.word	0x08017db8
 8000484:	08015b2c 	.word	0x08015b2c
 8000488:	080138a0 	.word	0x080138a0
 800048c:	08011614 	.word	0x08011614
 8000490:	0801c2d0 	.word	0x0801c2d0
 8000494:	0804795c 	.word	0x0804795c
 8000498:	08041f5c 	.word	0x08041f5c

0800049c <trickplay>:
 800049c:	b510      	push	{r4, lr}
 800049e:	480d      	ldr	r0, [pc, #52]	; (80004d4 <trickplay+0x38>)
 80004a0:	f7ff ff3e 	bl	8000320 <showtext>
 80004a4:	2001      	movs	r0, #1
 80004a6:	f7ff ff27 	bl	80002f8 <keyrelease>
 80004aa:	2800      	cmp	r0, #0
 80004ac:	d0fa      	beq.n	80004a4 <trickplay+0x8>
 80004ae:	480a      	ldr	r0, [pc, #40]	; (80004d8 <trickplay+0x3c>)
 80004b0:	f7ff ff36 	bl	8000320 <showtext>
 80004b4:	2001      	movs	r0, #1
 80004b6:	f7ff ff1f 	bl	80002f8 <keyrelease>
 80004ba:	2800      	cmp	r0, #0
 80004bc:	d0fa      	beq.n	80004b4 <trickplay+0x18>
 80004be:	4807      	ldr	r0, [pc, #28]	; (80004dc <trickplay+0x40>)
 80004c0:	f7ff ff2e 	bl	8000320 <showtext>
 80004c4:	2001      	movs	r0, #1
 80004c6:	f7ff ff17 	bl	80002f8 <keyrelease>
 80004ca:	2800      	cmp	r0, #0
 80004cc:	d0fa      	beq.n	80004c4 <trickplay+0x28>
 80004ce:	bc10      	pop	{r4}
 80004d0:	bc01      	pop	{r0}
 80004d2:	4700      	bx	r0
 80004d4:	0803115c 	.word	0x0803115c
 80004d8:	0802b75c 	.word	0x0802b75c
 80004dc:	08036b5c 	.word	0x08036b5c

080004e0 <init>:
 80004e0:	2200      	movs	r2, #0
 80004e2:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 80004e4:	4b1b      	ldr	r3, [pc, #108]	; (8000554 <init+0x74>)
 80004e6:	815a      	strh	r2, [r3, #10]
 80004e8:	23c0      	movs	r3, #192	; 0xc0
 80004ea:	4a1b      	ldr	r2, [pc, #108]	; (8000558 <init+0x78>)
 80004ec:	491b      	ldr	r1, [pc, #108]	; (800055c <init+0x7c>)
 80004ee:	481c      	ldr	r0, [pc, #112]	; (8000560 <init+0x80>)
 80004f0:	04db      	lsls	r3, r3, #19
 80004f2:	e000      	b.n	80004f6 <init+0x16>
 80004f4:	5ac2      	ldrh	r2, [r0, r3]
 80004f6:	801a      	strh	r2, [r3, #0]
 80004f8:	3302      	adds	r3, #2
 80004fa:	428b      	cmp	r3, r1
 80004fc:	d1fa      	bne.n	80004f4 <init+0x14>
 80004fe:	24d2      	movs	r4, #210	; 0xd2
 8000500:	2696      	movs	r6, #150	; 0x96
 8000502:	4a18      	ldr	r2, [pc, #96]	; (8000564 <init+0x84>)
 8000504:	01e4      	lsls	r4, r4, #7
 8000506:	3401      	adds	r4, #1
 8000508:	801a      	strh	r2, [r3, #0]
 800050a:	4d17      	ldr	r5, [pc, #92]	; (8000568 <init+0x88>)
 800050c:	4f14      	ldr	r7, [pc, #80]	; (8000560 <init+0x80>)
 800050e:	0236      	lsls	r6, r6, #8
 8000510:	42b4      	cmp	r4, r6
 8000512:	d007      	beq.n	8000524 <init+0x44>
 8000514:	5b7b      	ldrh	r3, [r7, r5]
 8000516:	802b      	strh	r3, [r5, #0]
 8000518:	05a3      	lsls	r3, r4, #22
 800051a:	d016      	beq.n	800054a <init+0x6a>
 800051c:	3502      	adds	r5, #2
 800051e:	3401      	adds	r4, #1
 8000520:	42b4      	cmp	r4, r6
 8000522:	d1f7      	bne.n	8000514 <init+0x34>
 8000524:	2001      	movs	r0, #1
 8000526:	f7ff fee7 	bl	80002f8 <keyrelease>
 800052a:	2800      	cmp	r0, #0
 800052c:	d0fa      	beq.n	8000524 <init+0x44>
 800052e:	480f      	ldr	r0, [pc, #60]	; (800056c <init+0x8c>)
 8000530:	f7ff fef6 	bl	8000320 <showtext>
 8000534:	2001      	movs	r0, #1
 8000536:	f7ff fedf 	bl	80002f8 <keyrelease>
 800053a:	2800      	cmp	r0, #0
 800053c:	d0fa      	beq.n	8000534 <init+0x54>
 800053e:	480c      	ldr	r0, [pc, #48]	; (8000570 <init+0x90>)
 8000540:	f7ff feee 	bl	8000320 <showtext>
 8000544:	bcf8      	pop	{r3, r4, r5, r6, r7}
 8000546:	bc01      	pop	{r0}
 8000548:	4700      	bx	r0
 800054a:	f7ff fec1 	bl	80002d0 <vid_vsync>
 800054e:	3502      	adds	r5, #2
 8000550:	e7e5      	b.n	800051e <init+0x3e>
 8000552:	46c0      	nop			; (mov r8, r8)
 8000554:	0300001c 	.word	0x0300001c
 8000558:	000077bb 	.word	0x000077bb
 800055c:	0600d200 	.word	0x0600d200
 8000560:	0205875c 	.word	0x0205875c
 8000564:	00002528 	.word	0x00002528
 8000568:	0600d202 	.word	0x0600d202
 800056c:	08052d5c 	.word	0x08052d5c
 8000570:	0803c55c 	.word	0x0803c55c

08000574 <decrypt>:
 8000574:	b5f0      	push	{r4, r5, r6, r7, lr}
 8000576:	46c6      	mov	lr, r8
 8000578:	24d2      	movs	r4, #210	; 0xd2
 800057a:	2696      	movs	r6, #150	; 0x96
 800057c:	4b10      	ldr	r3, [pc, #64]	; (80005c0 <decrypt+0x4c>)
 800057e:	4a11      	ldr	r2, [pc, #68]	; (80005c4 <decrypt+0x50>)
 8000580:	b500      	push	{lr}
 8000582:	01e4      	lsls	r4, r4, #7
 8000584:	801a      	strh	r2, [r3, #0]
 8000586:	4b10      	ldr	r3, [pc, #64]	; (80005c8 <decrypt+0x54>)
 8000588:	3401      	adds	r4, #1
 800058a:	4698      	mov	r8, r3
 800058c:	4d0f      	ldr	r5, [pc, #60]	; (80005cc <decrypt+0x58>)
 800058e:	4f10      	ldr	r7, [pc, #64]	; (80005d0 <decrypt+0x5c>)
 8000590:	0236      	lsls	r6, r6, #8
 8000592:	42b4      	cmp	r4, r6
 8000594:	d00a      	beq.n	80005ac <decrypt+0x38>
 8000596:	4642      	mov	r2, r8
 8000598:	5b7b      	ldrh	r3, [r7, r5]
 800059a:	005b      	lsls	r3, r3, #1
 800059c:	5a9b      	ldrh	r3, [r3, r2]
 800059e:	802b      	strh	r3, [r5, #0]
 80005a0:	05a3      	lsls	r3, r4, #22
 80005a2:	d008      	beq.n	80005b6 <decrypt+0x42>
 80005a4:	3502      	adds	r5, #2
 80005a6:	3401      	adds	r4, #1
 80005a8:	42b4      	cmp	r4, r6
 80005aa:	d1f4      	bne.n	8000596 <decrypt+0x22>
 80005ac:	bc80      	pop	{r7}
 80005ae:	46b8      	mov	r8, r7
 80005b0:	bcf0      	pop	{r4, r5, r6, r7}
 80005b2:	bc01      	pop	{r0}
 80005b4:	4700      	bx	r0
 80005b6:	f7ff fe8b 	bl	80002d0 <vid_vsync>
 80005ba:	3502      	adds	r5, #2
 80005bc:	e7f3      	b.n	80005a6 <decrypt+0x32>
 80005be:	46c0      	nop			; (mov r8, r8)
 80005c0:	0600d200 	.word	0x0600d200
 80005c4:	00002528 	.word	0x00002528
 80005c8:	08000814 	.word	0x08000814
 80005cc:	0600d202 	.word	0x0600d202
 80005d0:	01ff9014 	.word	0x01ff9014

080005d4 <main>:
 80005d4:	2380      	movs	r3, #128	; 0x80
 80005d6:	4a19      	ldr	r2, [pc, #100]	; (800063c <main+0x68>)
 80005d8:	04db      	lsls	r3, r3, #19
 80005da:	b510      	push	{r4, lr}
 80005dc:	601a      	str	r2, [r3, #0]
 80005de:	f7ff ff7f 	bl	80004e0 <init>
 80005e2:	4c17      	ldr	r4, [pc, #92]	; (8000640 <main+0x6c>)
 80005e4:	220a      	movs	r2, #10
 80005e6:	5ea3      	ldrsh	r3, [r4, r2]
 80005e8:	2b00      	cmp	r3, #0
 80005ea:	d105      	bne.n	80005f8 <main+0x24>
 80005ec:	f7ff fe40 	bl	8000270 <getkey>
 80005f0:	220a      	movs	r2, #10
 80005f2:	5ea3      	ldrsh	r3, [r4, r2]
 80005f4:	2b00      	cmp	r3, #0
 80005f6:	d0f9      	beq.n	80005ec <main+0x18>
 80005f8:	f7ff ff50 	bl	800049c <trickplay>
 80005fc:	f7ff fefa 	bl	80003f4 <throw>
 8000600:	f7ff ff1a 	bl	8000438 <fail>
 8000604:	23c0      	movs	r3, #192	; 0xc0
 8000606:	e7ea      	b.n	80005de <main+0xa>
 8000608:	04db      	lsls	r3, r3, #19
 800060a:	801a      	strh	r2, [r3, #0]
 800060c:	4c0d      	ldr	r4, [pc, #52]	; (8000644 <main+0x70>)
 800060e:	e002      	b.n	8000616 <main+0x42>
 8000610:	0020      	movs	r0, r4
 8000612:	f7ff fe85 	bl	8000320 <showtext>
 8000616:	2001      	movs	r0, #1
 8000618:	f7ff fe6e 	bl	80002f8 <keyrelease>
 800061c:	2800      	cmp	r0, #0
 800061e:	d0f7      	beq.n	8000610 <main+0x3c>
 8000620:	4c09      	ldr	r4, [pc, #36]	; (8000648 <main+0x74>)
 8000622:	e002      	b.n	800062a <main+0x56>
 8000624:	0020      	movs	r0, r4
 8000626:	f7ff fe7b 	bl	8000320 <showtext>
 800062a:	2001      	movs	r0, #1
 800062c:	f7ff fe64 	bl	80002f8 <keyrelease>
 8000630:	2800      	cmp	r0, #0
 8000632:	d0f7      	beq.n	8000624 <main+0x50>
 8000634:	46c0      	nop			; (mov r8, r8)
 8000636:	46c0      	nop			; (mov r8, r8)
 8000638:	e7fe      	b.n	8000638 <main+0x64>
 800063a:	46c0      	nop			; (mov r8, r8)
 800063c:	00000403 	.word	0x00000403
 8000640:	0300001c 	.word	0x0300001c
 8000644:	0800bc14 	.word	0x0800bc14
 8000648:	08000814 	.word	0x08000814

0800064c <__divsi3>:
 800064c:	e3510000 	cmp	r1, #0
 8000650:	0a000043 	beq	8000764 <.divsi3_skip_div0_test+0x110>

08000654 <.divsi3_skip_div0_test>:
 8000654:	e020c001 	eor	ip, r0, r1
 8000658:	42611000 	rsbmi	r1, r1, #0
 800065c:	e2512001 	subs	r2, r1, #1
 8000660:	0a000027 	beq	8000704 <.divsi3_skip_div0_test+0xb0>
 8000664:	e1b03000 	movs	r3, r0
 8000668:	42603000 	rsbmi	r3, r0, #0
 800066c:	e1530001 	cmp	r3, r1
 8000670:	9a000026 	bls	8000710 <.divsi3_skip_div0_test+0xbc>
 8000674:	e1110002 	tst	r1, r2
 8000678:	0a000028 	beq	8000720 <.divsi3_skip_div0_test+0xcc>
 800067c:	e311020e 	tst	r1, #-536870912	; 0xe0000000
 8000680:	01a01181 	lsleq	r1, r1, #3
 8000684:	03a02008 	moveq	r2, #8
 8000688:	13a02001 	movne	r2, #1
 800068c:	e3510201 	cmp	r1, #268435456	; 0x10000000
 8000690:	31510003 	cmpcc	r1, r3
 8000694:	31a01201 	lslcc	r1, r1, #4
 8000698:	31a02202 	lslcc	r2, r2, #4
 800069c:	3afffffa 	bcc	800068c <.divsi3_skip_div0_test+0x38>
 80006a0:	e3510102 	cmp	r1, #-2147483648	; 0x80000000
 80006a4:	31510003 	cmpcc	r1, r3
 80006a8:	31a01081 	lslcc	r1, r1, #1
 80006ac:	31a02082 	lslcc	r2, r2, #1
 80006b0:	3afffffa 	bcc	80006a0 <.divsi3_skip_div0_test+0x4c>
 80006b4:	e3a00000 	mov	r0, #0
 80006b8:	e1530001 	cmp	r3, r1
 80006bc:	20433001 	subcs	r3, r3, r1
 80006c0:	21800002 	orrcs	r0, r0, r2
 80006c4:	e15300a1 	cmp	r3, r1, lsr #1
 80006c8:	204330a1 	subcs	r3, r3, r1, lsr #1
 80006cc:	218000a2 	orrcs	r0, r0, r2, lsr #1
 80006d0:	e1530121 	cmp	r3, r1, lsr #2
 80006d4:	20433121 	subcs	r3, r3, r1, lsr #2
 80006d8:	21800122 	orrcs	r0, r0, r2, lsr #2
 80006dc:	e15301a1 	cmp	r3, r1, lsr #3
 80006e0:	204331a1 	subcs	r3, r3, r1, lsr #3
 80006e4:	218001a2 	orrcs	r0, r0, r2, lsr #3
 80006e8:	e3530000 	cmp	r3, #0
 80006ec:	11b02222 	lsrsne	r2, r2, #4
 80006f0:	11a01221 	lsrne	r1, r1, #4
 80006f4:	1affffef 	bne	80006b8 <.divsi3_skip_div0_test+0x64>
 80006f8:	e35c0000 	cmp	ip, #0
 80006fc:	42600000 	rsbmi	r0, r0, #0
 8000700:	e12fff1e 	bx	lr
 8000704:	e13c0000 	teq	ip, r0
 8000708:	42600000 	rsbmi	r0, r0, #0
 800070c:	e12fff1e 	bx	lr
 8000710:	33a00000 	movcc	r0, #0
 8000714:	01a00fcc 	asreq	r0, ip, #31
 8000718:	03800001 	orreq	r0, r0, #1
 800071c:	e12fff1e 	bx	lr
 8000720:	e3510801 	cmp	r1, #65536	; 0x10000
 8000724:	21a01821 	lsrcs	r1, r1, #16
 8000728:	23a02010 	movcs	r2, #16
 800072c:	33a02000 	movcc	r2, #0
 8000730:	e3510c01 	cmp	r1, #256	; 0x100
 8000734:	21a01421 	lsrcs	r1, r1, #8
 8000738:	22822008 	addcs	r2, r2, #8
 800073c:	e3510010 	cmp	r1, #16
 8000740:	21a01221 	lsrcs	r1, r1, #4
 8000744:	22822004 	addcs	r2, r2, #4
 8000748:	e3510004 	cmp	r1, #4
 800074c:	82822003 	addhi	r2, r2, #3
 8000750:	908220a1 	addls	r2, r2, r1, lsr #1
 8000754:	e35c0000 	cmp	ip, #0
 8000758:	e1a00233 	lsr	r0, r3, r2
 800075c:	42600000 	rsbmi	r0, r0, #0
 8000760:	e12fff1e 	bx	lr
 8000764:	e12fff1f 	bx	pc
 8000768:	e1a00000 	nop			; (mov r0, r0)
 800076c:	e3500000 	cmp	r0, #0
 8000770:	c3e00102 	mvngt	r0, #-2147483648	; 0x80000000
 8000774:	b3a00102 	movlt	r0, #-2147483648	; 0x80000000
 8000778:	ea00001c 	b	80007f0 <____aeabi_idiv0_from_arm>

0800077c <__aeabi_idivmod>:
 800077c:	e3510000 	cmp	r1, #0
 8000780:	0afffff7 	beq	8000764 <.divsi3_skip_div0_test+0x110>
 8000784:	e92d4003 	push	{r0, r1, lr}
 8000788:	ebffffb1 	bl	8000654 <.divsi3_skip_div0_test>
 800078c:	e8bd4006 	pop	{r1, r2, lr}
 8000790:	e0030092 	mul	r3, r2, r0
 8000794:	e0411003 	sub	r1, r1, r3
 8000798:	e12fff1e 	bx	lr

0800079c <__aeabi_idiv0>:
 800079c:	4770      	bx	lr
 800079e:	46c0      	nop			; (mov r8, r8)

080007a0 <__libc_init_array>:
 80007a0:	b570      	push	{r4, r5, r6, lr}
 80007a2:	4e0e      	ldr	r6, [pc, #56]	; (80007dc <__libc_init_array+0x3c>)
 80007a4:	4d0e      	ldr	r5, [pc, #56]	; (80007e0 <__libc_init_array+0x40>)
 80007a6:	1b76      	subs	r6, r6, r5
 80007a8:	10b6      	asrs	r6, r6, #2
 80007aa:	d006      	beq.n	80007ba <__libc_init_array+0x1a>
 80007ac:	2400      	movs	r4, #0
 80007ae:	cd08      	ldmia	r5!, {r3}
 80007b0:	3401      	adds	r4, #1
 80007b2:	f000 f81b 	bl	80007ec <__libc_init_array+0x4c>
 80007b6:	42a6      	cmp	r6, r4
 80007b8:	d1f9      	bne.n	80007ae <__libc_init_array+0xe>
 80007ba:	f7ff fd29 	bl	8000210 <_init>
 80007be:	4e09      	ldr	r6, [pc, #36]	; (80007e4 <__libc_init_array+0x44>)
 80007c0:	4d09      	ldr	r5, [pc, #36]	; (80007e8 <__libc_init_array+0x48>)
 80007c2:	1b76      	subs	r6, r6, r5
 80007c4:	10b6      	asrs	r6, r6, #2
 80007c6:	d006      	beq.n	80007d6 <__libc_init_array+0x36>
 80007c8:	2400      	movs	r4, #0
 80007ca:	cd08      	ldmia	r5!, {r3}
 80007cc:	3401      	adds	r4, #1
 80007ce:	f000 f80d 	bl	80007ec <__libc_init_array+0x4c>
 80007d2:	42a6      	cmp	r6, r4
 80007d4:	d1f9      	bne.n	80007ca <__libc_init_array+0x2a>
 80007d6:	bc70      	pop	{r4, r5, r6}
 80007d8:	bc01      	pop	{r0}
 80007da:	4700      	bx	r0
 80007dc:	03000044 	.word	0x03000044
 80007e0:	03000044 	.word	0x03000044
 80007e4:	03000048 	.word	0x03000048
 80007e8:	03000044 	.word	0x03000044
 80007ec:	4718      	bx	r3
 80007ee:	46c0      	nop			; (mov r8, r8)

080007f0 <____aeabi_idiv0_from_arm>:
 80007f0:	e59fc000 	ldr	ip, [pc]	; 80007f8 <____aeabi_idiv0_from_arm+0x8>
 80007f4:	e12fff1c 	bx	ip
 80007f8:	0800079d 	.word	0x0800079d

080007fc <____aeabi_idivmod_from_thumb>:
 80007fc:	4778      	bx	pc
 80007fe:	e7fd      	b.n	80007fc <____aeabi_idivmod_from_thumb>
 8000800:	eaffffdd 	b	800077c <__aeabi_idivmod>
 8000804:	00000000 	andeq	r0, r0, r0

Disassembly of section .fini:

08000808 <_fini>:
 8000808:	b5f8      	push	{r3, r4, r5, r6, r7, lr}
 800080a:	46c0      	nop			; (mov r8, r8)
 800080c:	bcf8      	pop	{r3, r4, r5, r6, r7}
 800080e:	bc08      	pop	{r3}
 8000810:	469e      	mov	lr, r3
 8000812:	4770      	bx	lr
