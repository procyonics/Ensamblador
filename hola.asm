;=============================================================================
;   Información del proyecto
;=============================================================================
;Nombre:        Hola Mundo
;Descripción:   El microcontrolador dará como salida un 1 logico, cuando tenga
;               como entrada 1 logico en dos de sus entradas.
;Modelo:        PIC16F886 - Oscilador interno - 4MHz
;Autor:         robblack00_7
;Fecha:         22-Julio-2013
;Versión:       0.1
;=============================================================================
;   Configuración para el compilador
;=============================================================================
        LIST    p=16F886            ; Procesador utilizado
        INCLUDE "P16F886.INC"       ; Libreria de direcciones correspondientes
                                    ; al PIC
;=============================================================================
;   Área de equivalencias
;=============================================================================
MASCARA     EQU     B'00000011'
;=============================================================================
;   Inicialización del microcontrolador
;=============================================================================
            ORG     0x0000          ; Vector RESET, Dirección en la memoria
                                    ; FLASH
INICIALIZA_MC
            BANKSEL TRISA           ; Cambio al banco del registro TRISA
            MOVLW   B'11111111'     ; Escribe este valor en el acumulador
            MOVWF   TRISA           ; Mueve este valor a TRISA (TRISB)
            MOVLW   B'00000000'     ; Entrada - 1
            MOVWF   TRISB           ; Salida - 0
        
            BANKSEL OSCCON          ; Cambio al banco del registro OSCCON
            MOVLW   B'1100000'      ; Escribe este valor en el acumulador
            MOVWF   OSCCON          ; Mueve este valor al registro OSCCON
                                    ; '11000000' = 4 MHz

            BANKSEL ANSELH          ; Cambio al banco del registro ANSELH,
            CLRF    ANSELH          ; se borra el registro ANSELH y ANSEL
            MOVLW   B'0000000'      ; lo que configura las entradas como
            MOVWF   ANSEL           ; digitales
    
            BANKSEL PORTB           ; Cambio al banco del registro PORTB
            CLRF    PORTB           ; Se borra el puerto de salida
;=============================================================================
;   Programa principal
;=============================================================================
INICIO
            MOVF    PORTA, W        ; Lee el estado de PORTA y lo copia en W
            ANDLW   MASCARA         ; Enmascara los 2 primeros bits de W
            SUBLW   MASCARA         ; Restamos estos bits a W
            BTFSS   STATUS, Z       ; Si la resta fue exacta saltara una linea
            CLRF    PORTB           ; Borra el puerto de salida
            MOVLW   B'00000001'     ; Mueve el valor a W
            MOVWF   PORTB           ; Mueve el valor de W a PORTB
            GOTO    INICIO          ; Salta a la etiqueta INICIO
;=============================================================================
;   Palabras de configuración del microcontrolador
;=============================================================================
            ORG     0x2007          ; Dirección en la memoria FLASH de la
                                    ; configuración
            DATA    H'20C4'         ; Valor de la palabra de configuración
            ORG     0x2008          ; Watchdog OFF, Oscilador Interno, RA6 y
            DATA    H'0600'         ; RA7 I/O, protección de código OFF, etc.
;=============================================================================
;   Fin del programa
;=============================================================================
            END
