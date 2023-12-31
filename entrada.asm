;Este es un programa que almacena una cadena de caracteres de la entrada,
; luego lo convierte a entero y luego lo muestra por salida de nuevo como cadena.
DATOS SEGMENT
  numero DW ?
  buffer db 21 DUP(0), '$'  ; Espacio para 5 caracteres y un byte nulo al final
DATOS ENDS

PILA SEGMENT STACK
       DW 128 DUP(0)
PILA ENDS

CODIGO SEGMENT
                ASSUME CS:CODIGO, DS:DATOS, SS:PILA

  start:        
                MOV    AX, DATOS
                MOV    DS, AX

  ; Leer caracteres en un bucle y almacenarlos en buffer
                MOV    DI, 0                         ; Inicializar el índice en DI a 0
                XOR    EAX, EAX                      ;Limpiar el registro AX

  leer_caracter:
                MOV    AH, 01h                       ; Código de la función para leer un carácter de la entrada estándar
                INT    21h                           ; Realizar la interrupción, Almacenará un solo caracter cada vez en AL
                CMP    AL, 13                        ; Comprobar si el carácter es un retorno de carro (nueva línea)
                JE     fin_lectura                   ; Si es así, finalizar la lectura

  ; Almacenar el carácter en el buffer
                MOV    [buffer + DI], AL             ;Añadimos el caracter, que ya se encuentra en ascii desde la entrada estándar
                INC    DI                            ; Incrementar el índice
                  
                CMP    DI, 19                        ; Verificar si el buffer está lleno
                JE     fin_lectura                   ; Si está lleno, finalizar la lectura

                JMP    leer_caracter                 ; Leer el siguiente carácter
    
  fin_lectura:  
                  
                CALL   toInt                         ;llamamos al método


                LEA    DX, buffer                    ;mostramos la cadena
                MOV    AH, 09H
                INT    21H

  ; Terminar el programa
                MOV    AH, 4Ch
                INT    21h

  ;Procedimientos:
toInt PROC
                XOR    EAX, EAX                      ;iniciamos el acumulador a 0, este registro guardará el número.
                MOV    DI, 0                         ; ponemos el índice de la cadena a 0
                MOV    EBX, 10                       ;el otro factor de la multiplicación por 10.
  covertir:     
                MOV    CL, [buffer + DI]             ;desreferenciar un caracter de SI en AL (añade el caracter indicado.
                CMP    CL, '$'                       ;comprobar que hemos llegado al final
                JZ     fin_metodo                    ;si es 0 salta a fínal del método.

                SUB    CL, '0'                       ;Convierte caractera entero restando '0'
  ;Multiplicas el acumulador por 10 y le sumas el siguiente caracter repetidamente

                MUL    EBX                           ;El producto queda en EAX
                ADD    EAX, CL                       ;Sumar dígito actual al acmulador

                INC    DI                            ;Avanza el contador
                JMP    convertir

  fin_metodo:   
                MOV    [numero], ECX                 ;Guarda el número
                RET
toInt ENDP

CODIGO ENDS

END start