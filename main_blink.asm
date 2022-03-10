.include "m328pdef.inc"

	.def	mask 	= r16		; mask register
	.def	ledR 	= r17		; led register
	.def	nVel	= r18		; velocity register
	.def	num	= r19
	.def	oLoopRl	= r24		; outer loop register
	.def	oLoopRh	= r25		; outer loop register
	.def	iLoopRl = r26		; inner loop register low
	.def	iLoopRh = r27		; inner loop register high

	.equ	oVal 	= 1000		; outer loop value
	.equ	Vel_1 	= 400		; inner loop value .1sec
	.equ	Vel_5 	= 2000		; inner loop value .5sec
	.equ	Vel1 	= 4000		; inner loop value  1sec
	.equ	Vel5 	= 20000		; inner loop value  5sec
	.equ	Vel10 	= 40000		; inner loop value 10sec

	.cseg
	.org	0x00
	clr	ledR			; clear led register
	ldi	mask,0xFF
	out     DDRD,mask
	ldi	mask,0xFC
        out     DDRC,mask
	ldi	mask,0xFF
        out     DDRB,mask
	ldi	nVel,0x03		; set nVel to the default value 1sec (Vel1)
	ldi	num, 0x04		; set num to the default value 9

start:	;ldi	mask,0x00
	;cp	num,mask
    	;brne	decre
	;dec	num
	;rjmp	comp

;decre:	ldi	num,0x09
	
comp:	sbic    PINC,0
	rjmp	decr
	sbic    PINC,1
	rjmp	incr
	rjmp	velo1
	
incr:	ldi	mask,0x05
	cp	nVel,mask
    	brne	incr_i
	rjmp	velo1

incr_i: inc	nVel
	rjmp	velo1

decr:	ldi	mask,0x01
	cp	nVel,mask
    	brne	decr_d
	rjmp	velo1

decr_d:	dec	nVel
	
velo1:	ldi	mask,0x01
	cp	nVel,mask
	brne	velo2
	ldi	mask,0x01
	out	PORTB,mask
	ldi	oLoopRl,LOW(Vel_1)
	ldi	oLoopRh,HIGH(Vel_1)
	rjmp	oLoop
	
velo2:	ldi	mask,0x02
	cp	nVel,mask
	brne	Velo3
	ldi	mask,0x02
	out	PORTB,mask
	ldi	oLoopRl,LOW(Vel_5)
	ldi	oLoopRh,HIGH(Vel_5)
	rjmp	oLoop

Velo3:	ldi	mask,0x03
	cp	nVel,mask
	brne	Velo4
	ldi	mask,0x04
	out	PORTB,mask
	ldi	oLoopRl,LOW(Vel1)
	ldi	oLoopRh,HIGH(Vel1)
	rjmp	oLoop

Velo4:	ldi	mask,0x04
	cp	nVel,mask
	brne	velo5
	ldi	mask,0x08
	out	PORTB,mask
	ldi	oLoopRl,LOW(Vel5)
	ldi	oLoopRh,HIGH(Vel5)
	rjmp	oLoop
	
velo5:	ldi	mask,0x10
	out	PORTB,mask
	ldi	oLoopRl,LOW(Vel10)
	ldi	oLoopRh,HIGH(Vel10)

oLoop:	ldi	iLoopRl,LOW(oVal)	; intialize inner loop count in inner
	ldi	iLoopRh,HIGH(oVal)	; loop high and low registers

iLoop:	sbiw	iLoopRl,1		; decrement inner loop registers
	brne	iLoop			; branch to iLoop if iLoop registers != 0
	
	sbiw	oLoopRl,1		; decrement outer loop register
	brne	oLoop			; branch to oLoop if outer loop register != 0

zero:	ldi	mask, 0x00
	cp	num, mask
	brne	one
	ldi	mask,0x40
	out	PORTD,mask
	ldi	num,0x09
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


one:	ldi	mask, 0x01
	cp	num, mask
	brne	two
	ldi	mask,0xF9
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


two:	ldi	mask, 0x02
	cp	num, mask
	brne	three
	ldi	mask,0xA4
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


three:	ldi	mask, 0x03
	cp	num, mask
	brne	four
	ldi	mask,0xB0
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


four:	ldi	mask, 0x04
	cp	num, mask
	brne	five
	ldi	mask,0x99
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


five:	ldi	mask, 0x05
	cp	num, mask
	brne	six
	ldi	mask,0x92
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


six:	ldi	mask, 0x06
	cp	num, mask
	brne	seven
	ldi	mask,0x82
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


seven:	ldi	mask, 0x07
	cp	num, mask
	brne	eight
	ldi	mask,0xF8
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


eight:	ldi	mask, 0x08
	cp	num, mask
	brne	nine
	ldi	mask,0x00
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start


nine:	ldi	mask, 0x09
	cp	num, mask
	brne	jump
	ldi	mask,0x90
	out	PORTD,mask
	dec	num
	ldi	mask, (1<<PINC3)
	eor	LedR, mask
	out	PORTC, LedR
	rjmp	start
	
jump:	rjmp	start

