;=============================================================================
;	Información del proyecto
;=============================================================================
;Nombre:		Hola Mundo
;Descripción:	Lee el Dip switch conectado al PC y muestra el valor leído en
;				el PB a través de 8 leds
;Modelo:		PIC16F886 - Oscilador int - 4MHz
;Autor:			robblack00_7
;Fecha:			22-Julio-2013
;Versión:		0.1
;=============================================================================
;	Configuración
;=============================================================================
		LIST   	p=16F886			; Procesador utilizado
		INCLUDE	"P16F886.INC" 		; Libreria de direcciones correspondientes
									; al PIC
;=============================================================================
;	Área de equivalencias
;=============================================================================

PORTA   	EQU     0X05    
PORTB   	EQU     0X06    
ESTADO  	EQU     0X03    
W       	EQU     0
;=============================================================================
;	Inicialización del microcontrolador
;=============================================================================
			ORG		0x0000			; VECTOR RESET (DIR. DE LA MEMORIA FLASH)
INICIALIZA_MC
			BANKSEL	TRISA			; CAMBIO AL BANCO DONDE SE ENCUENTRA TRSIA
			MOVLW	B'11111111'		; ESCRIBE ESTE VALOR EN EL ACUMULADOR
			MOVWF	PORTA			; MUEVE ESTE VALOR A PORTA (ENT 1 - SAL 0)
			MOVLW	B'00000000'		; ESCRIBE ESTE VALOR EN EL ACUMULADOR
			MOVWF	PORTB			; MUEVE ESTE VALOR A PORTB (ENT 1 - SAL 0)
		
			BANKSEL	OSCCON
			MOVLW	B'1100000'		; ESCRIBE ESTE VALOR EN EL ACUMULADOR
			MOVWF	OSCCON			; MUEVE ESTE VALOR AL REG. OSCCON (VEL=4MHz.)

			BANKSEL	ANSEL			; CAMBIO AL BANCO DONDE SE ENCUENTRA EL SFR ANSEL
			CLRF	ANSELH			; CARGA ANSEL CON CEROS PARA CONFIGURAR LAS
			MOVLW	B'0000000'		; ENTRADAS YA SEA COMO DIGITALES
			MOVWF	ANSEL			; MUEVE ESTE VALOR AL REG. ANSEL (1 ANA., O DIG.)
	
			BANKSEL	PORTA			; PASAMOS AL BANCO PARA TRABAJAR CON EL PORTA Y PORTB
			CLRF 	PORTB			; LIMPIA EL REGITRO PORTB
;=============================================================================
;  	Programa principal
;=============================================================================
INICIO	
			MOVF	PORTA,W			; LEE ESTADO DEL PUERTO A Y COPIA EL VALOR EN W
			MOVWF	PORTB			; MUEVE EL VALOR DE W AL PUERTO B
			GOTO	INICIO			; SALTA A LA ETIQUETA "INICIO"
;=============================================================================
;	Palabras de configuración del microcontrolador
;=============================================================================
			ORG    	0x2007			; DIR. DE MEM. FLASH DE LA CONFIGURACION
			DATA	H'20C4'			; VALOR PARA LA PALABRA DE CONFIGURACION
			ORG    	0x2008			; WATCH DOG OFF; OSCILADOR INTERNO RA6 Y RA7 I/O;  
			DATA	H'0600'			; PROTECCIÓN DE CÓDIGO OFF; ETC.
;=============================================================================
;	Fin del programa
;=============================================================================
		END
;=============================================================================
