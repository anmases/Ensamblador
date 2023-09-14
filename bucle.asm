;Este es un ejemplo de bucle análogo a un bucle do-while.
;Este bucle se realiza con etiqueta + CMP (comparar) y JMP (saltar)

; Segmento de Datos
DATOS SEGMENT
    ; Aquí puedes declarar variables y constantes si las necesitas
    retornoCarro EQU 13D
    salto        EQU 10D
    mensaje      db  '0', salto, retornoCarro, '$'
DATOS ENDS

; Segmento de Código
CODIGO SEGMENT
           ASSUME CS:CODIGO, DS:DATOS

    INICIO:
           MOV    AX, DATOS              ; Cargar el segmento de datos en AX
           MOV    DS, AX                 ; Mover AX a DS

           MOV    CX, 0                  ; Inicializar el contador CX a 0

    BUCLE:                               ; Etiqueta de inicio del bucle
    ; Aquí va el cuerpo del bucle. Por ejemplo, haremos que imprima en pantalla cada iteración.
           mov    AL, CL                 ;añadimos en dx el valor del contador.
           add    AL, "0"                ;lo convertimos a ASCII sumándole el caracter 0
           mov    mensaje+0, AL          ;lo almacenamos en el mensaje, en la primera posición
           lea    DX, mensaje            ; añadimos su dirección de memoria en DX
           mov    AH, 9H
           int    21H                    ;lo imprimimos.
           mov    DX, 0                  ;ponemos el registro de nuevo a 0
    ;aquí la condición que evalúa, en este caso si el contador todavía no ha llegado a 5.
           INC    CX                     ; Incrementar CX
           CMP    CX, 20                 ; Comparar CX con 20
           JL     BUCLE                  ; Saltar a INICIO del BUCLE si CX < 5

    ; Finalizar el programa
           MOV    AH, 4Ch                ; Servicio para terminar el programa
           INT    21h                    ; Llamar al SO

CODIGO ENDS
END INICIO

;Banderas: las banderas actúan como un tipo de "memoria" de muy corto plazo que recuerda ciertos aspectos del último cálculo realizado, y puedes consultarlas para decidir qué hacer a continuación.
;Son bits en registros especiales, que cambian su estado tras realizar operaciones de comparación (CMP), de suma o resta (ADD o SUB).
;Las banderas pueden estar activadas o desactivadas (alzadas o bajadas). Algunas de estas banderas son:
    ;Zero Flag (ZF): Se establece si el resultado de una operación es cero.

    ;Sign Flag (SF): Se establece si el resultado de una operación es negativo.

    ;Overflow Flag (OF): Se establece si una operación aritmética produce un resultado que es demasiado grande para que se ajuste en el destino asignado.

    ;Carry Flag (CF): Se establece si una operación produce un acarreo hacia fuera o un préstamo hacia un bit de orden superior.

    ;Parity Flag (PF): Se establece si el número de bits establecidos en el resultado es par.
;Según el estado en que se encuentren las banderas, existen operaciones de evaluación que saltan al inicio del bucle (donde está la etiqueta de inicio en el código)
;o, por el contrario, salen del mismo. Operaciones de evaluación son JE (jump if equal), JNE (jump if not equal), JL (jump if less), JG (jump ig great), JZ (jump if zero) y JNZ (jump if not zero).