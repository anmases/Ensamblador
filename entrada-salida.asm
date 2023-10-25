;Este es un programa que almacena una cadena de caracteres de la entrada,
; luego lo convierte a entero y luego lo muestra por salida de nuevo como cadena.
DATOS SEGMENT
  numero Dw ?              ;Aquí es donde se almacenará el número.
  buffer db 21 DUP('$')    ; Espacio para 5 caracteres y un byte nulo al final
  cadena db 5 DUP(0), '$'  ;se reserva espacio para la cadena.
DATOS ENDS

PILA SEGMENT STACK
       DW 128 DUP(0)
PILA ENDS


CODIGO SEGMENT
                ASSUME CS:CODIGO, DS:DATOS, SS:PILA

  start:        
                MOV    AX, DATOS                     ;inicializamos el segmento de datos
                MOV    DS, AX

                MOV    DI, 0                         ; Inicializar el indice en DI a 0
                XOR    AX, AX                        ;Limpiar el registro AX
  ; Leer caracteres en un bucle y almacenarlos en buffer
  leer_caracter:
                MOV    AH, 01h                       ; Codigo de la funcion para leer un caracter de la entrada estandar
                INT    21h                           ; Realizar la interrupcion, Almacenara un solo caracter cada vez en AL
                CMP    AL, 13                        ; Comprobar si el caracter es un retorno de carro (nueva linea)
                JE     fin_lectura                   ; Si es asi, finalizar la lectura

  ; Almacenar el carácter en el buffer
                MOV    [buffer + DI], AL             ;Añadimos el caracter, que ya se encuentra en ascii desde la entrada estándar
                INC    DI                            ; Incrementar el índice
                  
                CMP    DI, 19                        ; Verificar si el buffer está lleno
                JE     fin_lectura                   ; Si está lleno, finalizar la lectura

                JMP    leer_caracter                 ; Leer el siguiente carácter
    
  fin_lectura:  
                  
                CALL   toInt                         ;llamamos al método que convierte a entero

                CALL   toString                      ;llamamos al método que guarda en número en forma de cadena

                LEA    DX, cadena                    ;mostramos la cadena
                MOV    AH, 09H
                INT    21H

  ; Terminar el programa
                MOV    AH, 4Ch
                INT    21h

  ;Procedimientos:
toInt PROC
                XOR    AX, AX                        ; Inicializar el acumulador a 0.
                MOV    DI, 0                         ; Inicializar el índice de la cadena a 0.
                MOV    BX, 10                        ; Factor para la multiplicación.

  convertir:    
                MOV    CL, [buffer + DI]             ; Cargar el carácter actual en CL.
                CMP    CL, '$'                       ; Comprobar si hemos llegado al final.
                JZ     fin_metodo                    ; Si es así, ir al final.

                SUB    CL, '0'                       ; Convertir el carácter en CL a su valor entero.
  
                MUL    BX                            ; Multiplicar AX por 10. El resultado queda en AX.
                ADD    AX, CX                        ; Sumar el dígito actual (en CX) a AX.
    

                INC    DI                            ; Incrementar el contador de la cadena.
                JMP    convertir

  fin_metodo:   
                MOV    [numero], AX                  ; Guardar el resultado en 'numero'.
                RET
toInt ENDP

toString PROC                                        ;procedimiento para convertir número a cadena.
                XOR    AX, AX                        ;Limpiamos el registro.
                MOV    AX, [numero]                  ;añadimos el valor de antes para operar con él.
                MOV    BX, 10                        ;El divisor es 10, al dividir por 10 siempre se obtiene el último número en el resto (1234/10 = cociente 123 y resto 4)
                MOV    DI, 4                         ;Esto es un índice para recorrer la cadena, como un contador, que se pone a 0 (los 5 espacios de la cadena 0,1,2,3,4)
  descomponer:  
  ; Dividir entre 10
                XOR    DX, DX                        ; Limpiar DX antes de la división
                DIV    BX                            ; Resultado en AX, residuo en DX
    
                ADD    DL, '0'                       ; Convertir el residuo a su representación ASCII

                MOV    [cadena + DI], DL             ;Almacena el residuo en la cadena. Se usa DI y no CX, porque no puede usarse CX por cuestión de arquitectura x86 como índice
                DEC    DI                            ;incrementa el contador de la cadena

  ; Comprobar si aún quedan dígitos
                CMP    AX, 0                         ;si es 0 saltará.
                JNZ    descomponer
  ; Abandonar el método
                RET

toString ENDP
CODIGO ENDS

END start