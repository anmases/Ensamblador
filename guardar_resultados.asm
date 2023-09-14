

DATOS SEGMENT
    terminador EQU '$'
    numero    DW 1234               ;instanciamos la variable como espacio en memoria de 2bytes (números hasta 65535)
    resultado db 5 DUP(' '), terminador    ;reservamos una cadena de 5 espacios para 4 dígitos y el null-terminator
DATOS ENDS

PILA SEGMENT STACK
         DW 128 DUP(0)
PILA ENDS

CODIGO SEGMENT
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA
    start:    
    ; Inicializar el segmento de datos y también la pila
              MOV  AX, DATOS
              MOV  DS, AX
 
    ; Número a convertir
              XOR  AX, AX       ;limpiamos AX
              MOV  AX, [numero]       ; Número a convertir
              MOV  BX, 10           ;El divisor es 10, al dividir por 10 siempre se obtiene el último número en el resto (1234/10 = cociente 123 y resto 4)
              MOV  DI, 4            ;Esto es un índice para recorrer la cadena, como un contador, que se pone a 0
    descomponer:
    ; Dividir entre 10
              XOR  DX, DX           ; Limpiar DX antes de la división
              DIV  BX               ; Resultado en AX, residuo en DX
    
              ADD  DL, '0'          ; Convertir el residuo a su representación ASCII

              MOV [resultado + DI], DL ;Almacena el residuo en la cadena.
              DEC DI    ;incrementa el contador de la cadena

    ; Comprobar si aún quedan dígitos
              CMP AX, 0          ;si es 0 saltará.
              JNZ  descomponer

              LEA  DX, resultado
              MOV AH, 09H
              INT 21h

    
    ; Salir del programa
              MOV  AH, 4Ch
              MOV  AL, 0
              INT  21h

CODIGO ENDS
END start

; MOV AX, 4: pone el valor 4 en el registro AX, no funciona en variables, No funcionará a menos que sea una constante o un literal. Si es una variable pondría la dirección absoluta.
; MOV AX, [4]: "mira" en la dirección de memoria 4 y añade a AX lo que encuentre allí, el primer byte.
; MOV AX, offset 4: añade en AX la dirección de memoria relativa de la variable 4.
; Cuando se trata de escritura en memoria, sí es equivalente,
; ya sea indicarle que guarde el valor en la dirección de memoria MOV valor, AX,
; que guardarlo en el contenido de la dirección de memoria indicada MOV [valor], AX