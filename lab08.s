@Diana Zaray Corado Lopez #191025 & Jose Javier Hurtarte 

.data
.align 2

mresult:	.asciz ">> %d\n"

.text
.align 2

.global operacionSuma
operacionSuma:
	push {lr}
	ldr r2,[r0]			/*Guarda el resultado acumulativo*/
	ldr r1,[r1]			/*Guarda el nuevo valor ingresado por el usuario*/
	add r3,r2,r1
	str r3,[r0]			/*Carga el nuevo resultado a r0*/
	mov r1,r3
	ldr r0,=mresult					
	bl printf
	pop {pc}


.global operacionModulo
operacionModulo:
	push {lr}
	add r3,#-1
	ldr r2,[r0]			/*Guarda el resultado acumulativo*/
	ldr r1,[r1]			/*Guarda el nuevo valor ingresado por el usuario*/
	cmp r2,r1
	blt	propia
	division:
		sub r2,r2,r1
		cmp r2,#0
		bgt division 	/*Si r1 > 0 hace la resta otra vez*/
		add r2,r2,r1
	propia:
		str r2,[r0]			/*Carga el nuevo resultado a r4*/
		ldr r0,=mresult	
		mov r1,r2
		bl printf
	pop {pc}

