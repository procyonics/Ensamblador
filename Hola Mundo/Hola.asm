;=============================================================================
;   Información del proyecto
;=============================================================================
;Nombre:        Hola Mundo
;Descripción:   El microcontrolador parpadeará el LED en el bit RB0
;Modelo:        PIC16F886 - Oscilador interno - 4MHz
;Autor:         robblack00_7@procyonics.com
;Fecha:         22-Julio-2013
;Versión:       0.1
;=============================================================================
;   Configuración para el compilador
;=============================================================================
                LIST    p=16F886        ; Procesador utilizado
                INCLUDE "P16F886.INC"   ; Libreria de direcciones
                                        ; correspondientes al PIC
;=============================================================================
;   Área de equivalencias
;=============================================================================
MASCARA         EQU     B'00000011'
;=============================================================================
;   Inicialización del microcontrolador
;=============================================================================
                ORG     0x0000          ; Vector RESET, Dirección en la
                                        ; memoria FLASH
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
                BTFSS   PORTB, RB0      ; Si RB0 es 1, saltara una linea
                GOTO    PRENDER         ; Salta a la etiquita APAGAR
                GOTO    APAGAR          ; Salta a la etiqueta PRENDER

PRENDER
                MOVLW   B'00000001'     ; Mueve el valor a W
                MOVWF   PORTB           ; Mueve el valor de W a PORTB
                GOTO    ESPERA          ; Salta a la etiqueta ESPERA

APAGAR
                CLRF    PORTB           ; Borra el puerto de salida
                GOTO    ESPERA          ; Salta a la etiqueta ESPERA

ESPERA
                NOP
                NOP
                NOP
                NOP
                GOTO    INICIO          ; Salta a la etiqueta INICIO
;=============================================================================
;   Palabras de configuración del microcontrolador
;=============================================================================
                ORG     0x2007          ; Dirección en la memoria FLASH de la
                                        ; configuración
                DATA    H'20C4'         ; Valor de la palabra de configuración
                ORG     0x2008          ; Watchdog OFF, Oscilador Interno, RA6
                DATA    H'0600'         ; y RA7 I/O, protección OFF, etc.
;=============================================================================
;   Fin del programa
;=============================================================================
                END
