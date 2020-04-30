@Diana Zaray Corado Lopez #191025 & Jose Javier Hurtarte 

.data
.align 2

mresult:	.asciz ">> %d\n"


.text
.align 2

.global operacionSuma
operacionSuma:
	push {lr}
	ldr r1,[r4]			/*Guarda el resultado acumulativo*/
	ldr r2,[r2]			/*Guarda el nuevo valor ingresado por el usuario*/
	add r3,r1,r2
	str r3,[r4]			/*Carga el nuevo resultado a r4*/
	ldr r0,=mresult					
	ldr r1,[r4]
	bl printf
	pop {pc}


