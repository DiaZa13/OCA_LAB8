#Diana Zaray Corado Lopez #191025 & Jose Javier Hurtarte #19707
#LAB_08 Calculadora Innovadora
.text
.align 2
.global main
.type main,%function

main:

	stmfd sp!, {lr}	/* SP = R13 link register */
	/* valor1 */
	
	
menu:		
	@impresion de menu
	ldr r0,=fcadena				/*Carga la direccion del formato a imprimir*/
	ldr r1,=menu_principal		/*Carga la direccion del mensaje a imprimir*/
	bl printf
	
repeticion:
	@lectura de dato ingresado por el usuario y comparacion del mismo
	ldr r0,=fcadena				/*Carga la direccion del formato a imprimir*/
	ldr r1,=ingreso				/*Carga la direccion del mensaje a imprimir*/
	bl printf
	ldr r0,=fcadena				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=entradam			/*Guarda la direccion en donde se almacenara el valor ingresado*/
	bl scanf
	
	ldr r1,=entradam				
	ldrb r1,[r1]
	suma:
		cmp r1,#43				/*Compara R1 con +*/
		beq opSuma				/*Si R1 == '+' redirecciona a opMulti sino continua comparando*/
		
		cmp r1,#42				/*Compara R1 con * */
		beq opMulti				/*Si R1 == '*' redirecciona a opMulti sino continua comparando*/
		
		cmp r1,#77				/*Compara R1 con M*/
		beq opModu				/*Si R1 == 'M' redirecciona a opModu sino continua comparando*/
		
		cmp r1,#80				/*Compara R1 con P*/
		beq opPotencia			/*Si R1 == 'P' redirecciona a opPotencia sino continua comparando*/
		
		cmp r1,#61				/*Compara R1 con =*/
		beq opResultado			/*Si R1 == '=' redirecciona a opResultado sino continua comparando*/
		
		cmp r1,#113				/*Compara R1 con q*/
		beq opSalir				/*Si R1 == * redirecciona a opSalir*/
		bne ingresoMal			/*Sino redireccina a ingreso de comando o valor incorrecto*/

	
opSuma:
	@ingres de datos
	ldr r0,=fcadena				/*Carga el formato a imprimir*/
	ldr r1,=ingresov			/*Carga la direccion del mensaje a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se almacenara el valor ingresado*/
	bl scanf
	
	@programacion defensiva
	cmp r0,#0					/*Compara el formato ingresado con el formato esperado*/
	bne scorrecto				/*Si todo esta correcto, redirecciona a scorrecto*/
	bleq getchar 				/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal				/*Informa al usuario que ingreso un dato mal*/
	
	@llamado a subrutina
	scorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionSuma		/*Llama a la subrutina de suma*/		
	
	@ciclo de menu
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
	bne mcorrecto
	bleq getchar 					/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal
	
	@llamado a subrutina
	mcorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionMultiplicacion		/*Llama a la subrutina de multiplicacion*/
	
	b repeticion	
	
opModu:
	@ingreso de datos 
	ldr r0,=fcadena				/*Carga el formato a imprimir*/
	ldr r1,=ingresov			/*Carga la direccion del mensaje a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se almacenara el valor ingresado*/
	bl scanf
	
	@programacion defensiva
	cmp r0,#0					/*Compara el formato ingresado con el formato esperado*/
	bne mocorrecto				/*Si todo esta correcto, redirecciona a scorrecto*/
	bleq getchar 				/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal				/*Informa al usuario que ingreso un dato mal*/
	
	@llamado a subrutina
	mocorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionModulo		/*Llama a la subrutina de modulo*/
	
	@ciclo de menu
	b repeticion				/*Al finalizar todo el proceso regresa el menu_principal*/	

	
opPotencia:
	ldr r0,=fcadena				/*Carga la direccion a imprimir*/
	ldr r1,=ingresov			/*Carga la direccion a imprimir*/
	bl printf
	ldr r0,=fnumero				/*Guarda formato que se espera que ingrese el usuario*/
	ldr r1,=nvalor				/*Guarda la direccion en donde se guardara el valor ingresado*/
	bl scanf
	
	@verificacion de datos ingresados
	cmp r0,#0						/*Compara el formato ingresado con el formato esperado*/
	bne pocorrecto
	bleq getchar 					/*Si el formato ingresado es incorrecto borra la informacion del buffer de teclado*/
	beq ingresoMal
	
	@llamado a subrutina
	pocorrecto:
		ldr r0,=result			/*Guarda en R4 la direccion del resultado anidado*/	
		ldr r1,=nvalor			/*Guarda en R2 la direccion del nuevo valor ingresado*/
		bl operacionPotencia		/*Llama a la subrutina de potencia*/
	
	b repeticion	
	
opResultado:
	ldr r0,=mresult				/*Carga la direccion del formato a imprimir*/
	ldr r1,=result					
	ldr r1,[r1]					/*Carga el valor a imprimir a R1*/
	bl printf
	bl getchar					/*Limpia el buffer del teclado*/
	b repeticion				/*Ciclo de menu*/

	
ingresoMal:	
	@programacion defensiva
	ldr r0,=mal					/*Carga la direccion del mensaje de dato incorrecto*/
	bl puts 						
	bl getchar					/*Borra la informacion del buffer del teclado*/
	b repeticion				/*Ciclo de menu*/


	/*--SALIDA--*/
opSalir:
	@mensaje de despedida
	ldr r0,=fcadena				/*Carga la direccion del formato a imprimir*/
	ldr r1,=salida				/*Carga la direccion del mensaje a imprimir*/
	bl printf
	
	@salida correcta del programa
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
fcadena:	.asciz "%s"
fcaracter:	.asciz "%c"
fnumero:	.asciz " %d"
result:		.word 0
nvalor:		.word 0
entradam:	.asciz " "
