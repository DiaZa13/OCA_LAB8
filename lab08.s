@Diana Zaray Corado Lopez #191025 & Jose Javier Hurtarte 

.data
.align 2

mresult:	.asciz ">> %d\n"

.text
.align 2

.global operacionSuma
operacionSuma:
	push {lr}			
	ldr r2,[r0]				/*Guarda en R2 el resultado acumulativo*/
	ldr r1,[r1]				/*Guarda en R1 el nuevo valor ingresado por el usuario*/
	add r3,r2,r1			/*Hace la suma de R2+R1 y la guarda en R3*/
	str r3,[r0]				/*Carga el nuevo resultado a la direccion en R0*/
	mov r1,r3				/*Mueve a R1 el valor de R3 para impresion*/
	ldr r0,=mresult			/*Carga la direccion de mensaje a imprimir*/			
	bl printf
	pop {pc}


.global operacionModulo
operacionModulo:
	push {lr}
	add r3,#-1
	ldr r2,[r0]				/*Guarda en R2 el resultado acumulativo*/
	ldr r1,[r1]				/*Guarda en R1 el nuevo valor ingresado por el usuario*/
	cmp r2,r1				/*Compara R1 con R2*/
	blt	propia				/*Si R1 > R2, R2 es el cociente, redirecciona a propia*/
	division:
		sub r2,r2,r1		/*Resta dividendo - divisor*/
		cmp r2,#0			/*Compara R2 (dividendo) con 0*/
		beq propia
		bgt division 		/*Si R2 > 0 repite la resta*/
		add r2,r2,r1		/*Si R2 < 0 le suma el valor de R1 para obtener el cociente*/
	propia:
		str r2,[r0]			/*Carga el nuevo resultado a  la direccion en R0*/
		ldr r0,=mresult	
		mov r1,r2			/*Mueve R2 a R1 para impresion*/
		bl printf
	pop {pc}
	
	
.global operacionMultiplicacion
operacionMultiplicacion:
	push {lr}
	ldr r2, [r0]			/*Guarda el resultado acumulado como operando 1*/
	ldr r1,[r1]				/*Guarda en R1 el valor ingresado por el usuario*/
	mul r3,r2,r1			/*Hace la multiplicacion y la guarda en R3*/
	str r3, [r0]			/*coloca el nuevo valor en r0*/
	mov r1,r3				/*Mueve a R1 el valor de R3 para imprimir*/
	ldr r0,=mresult			/*Carga la direccion de mensaje a imprimir*/			
	bl printf
	pop {pc}				/*se regresa al link register de el programa principal*/
	

	

