#Diana Zaray Corado Lopez #191025 & Jose Javier Hurtarte...
#LAB_08 Calculadora Innovadora
.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* valor1 */
	
	/*--INICIALIZAR REGISTROS--*/
	and r5,#0		/* Clear R5*/
	and r6,#0		/* Clear R6*/
	and r7,#0		/* Clear R4*/
	and r8,#0		/* Clear R8*/
	and r9,#0		/* Clear R9*/
	
menu:		
	@impresion de menu y lectura de dato ingresado por el usuario
	ldr r0,=fcadena					/*Carga la direccion a imprimir*/
	ldr r1,=menu_principal			/*Carga la direccion a imprimir*/
	bl printf
	
repeticion:
	ldr r0,=fcadena					/*Carga la direccion a imprimir*/
	ldr r1,=ingreso
	bl printf
	ldr r0,=fcadena				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=entradam				/*Guarda la direccion en donde se guardara el valor ingresado*/
	bl scanf
	
	ldr r1,=entradam				/*En caso de que el dato ingresado este correcto inicia la comparacion*/
	ldrb r1,[r1]
	suma:
		cmp r1,#43
		beq opSuma
		bne multi
	multi:
		cmp r1,#42
		beq opMulti
		bne modu
	modu:
		cmp r1,#77
		beq opModu
		bne potencia
	potencia:
		cmp r1,#80
		beq opPotencia
		bne resultado
	resultado:
		cmp r1,#61
		beq opResultado
		bne salir
	salir:
		cmp r1,#113
		beq opSalir
		bne ingresoMal

	
opSuma:
	ldr r0,=fcadena				/*Carga el formato a imprimir*/
	ldr r1,=ingresov			/*Carga la direccion del mensaje a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se almacenara el valor ingresado*/
	bl scanf
	
	cmp r0,#0					/*Compara el formato ingresado con el formato esperado*/
	bne scorrecto				/*Si todo esta correcto, redirecciona a scorrecto*/
	bleq getchar 				/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal				/*Informa al usuario que ingreso un dato mal*/
	
	scorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionSuma		/*Llama a la subrutina de suma*/		
		
	b repeticion				/*Al finalizar todo el proceso regresa el menu_principal*/

	
opMulti:
	@ingreso de datos
	ldr r0,=fcadena					/*Carga la direccion a imprimir*/
	ldr r1,=ingresov					/*Carga la direccion a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se guardara el valor ingresado*/
	bl scanf
	
	@verificacion de datos ingresados
	cmp r0,#0						/*Compara el formato ingresado con el formato esperado*/
	bleq getchar 					/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal
	
	@impresion de resultados
	ldr r0,=mresult					/*Carga la direccion a imprimir*/
	ldr r1,=result					/*Carga la direccion a imprimir*/
	ldr r1,[r1]
	#bl printf
	bl getchar
	b repeticion	
	
opModu:
	ldr r0,=fcadena				/*Carga el formato a imprimir*/
	ldr r1,=ingresov			/*Carga la direccion del mensaje a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se almacenara el valor ingresado*/
	bl scanf
	
	cmp r0,#0					/*Compara el formato ingresado con el formato esperado*/
	bne mocorrecto				/*Si todo esta correcto, redirecciona a scorrecto*/
	bleq getchar 				/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal				/*Informa al usuario que ingreso un dato mal*/
	
	mocorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionModulo		/*Llama a la subrutina de modulo*/
		
	b repeticion				/*Al finalizar todo el proceso regresa el menu_principal*/	

	
opPotencia:
	ldr r0,=fcadena					/*Carga la direccion a imprimir*/
	ldr r1,=ingresov				/*Carga la direccion a imprimir*/
	bl printf
	ldr r0,=fnumero					/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor					/*Guarda la direccion en donde se guardara el valor ingresado*/
	bl scanf
	cmp r0,#0						/*Compara el formato ingresado con el formato esperado*/
	bleq getchar 					/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal
	ldr r0,=mresult					/*Carga la direccion a imprimir*/
	ldr r1,=result					/*Carga la direccion a imprimir*/
	ldr r1,[r1]
	#bl printf
	bl getchar
	b repeticion	
	
opResultado:
	ldr r0,=mresult					/*Carga la direccion a imprimir*/
	ldr r1,=result					/*Carga la direccion a imprimir*/
	ldr r1,[r1]
	#bl printf
	bl getchar
	b repeticion

	
ingresoMal:							/*Redireccion cuando el usuario ingresa mal un dato*/
	ldr r0,=mal
	bl puts 						
	bl getchar						@para que borre la informacion del buffer de teclado
	b repeticion


	
	/*--SALIDA--*/
opSalir:
	ldr r0,=fcadena					/*Carga la direccion a imprimir*/
	ldr r1,=salida					/*Carga la direccion a imprimir*/
	bl printf
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

.data
.align 2
menu_principal:
	.asciz "\n--Bienvenido a la calculadora innovadora--\n  Operacion -> Comando\n  Suma -> +.\n  Multiplicacion -> * \n  Modulo -> M\n  Potencia -> P\n  Resultado almacenado -> =\n  Salir -> q\n"
ingreso:	.asciz ">Ingrese un comando: "
ingresov:	.asciz ">Ingrese un valor: "
mal:		.asciz ">SEGMENTATION FAULT. Comando o Valor incorrecto\n"
salida: 	.asciz "Gracias por utilizar la calculadora!\n"
mresult:	.asciz ">> %d\n"
prueba:		.asciz "Prueba: \n"
fcadena:	.asciz "%s"
fcaracter:	.asciz "%c"
fnumero:	.asciz " %d"
result:		.word 0
nvalor:		.word 0
entradam:	.asciz " "
