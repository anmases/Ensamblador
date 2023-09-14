; Segmento de datos
DATOS SEGMENT
    mensaje1 db "se cumple la condicion$"
    mensaje2 db "no se cumple la condicion$"
    variable1 db 10
    variable2 db 10
DATOS ENDS

; Segmento de pila
PILA SEGMENT STACK
    db 64 dup(0)
PILA ENDS

; Segmento de código
CODIGO SEGMENT
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA

    ; Punto de entrada del programa
    START:
        ; Inicialización de los registros de segmento
        MOV AX, DATOS
        MOV DS, AX

        ; Comparar variable1 y variable2
        MOV AL, variable1
        CMP AL, variable2

        ; Si variable1 = variable2, saltar a la etiqueta "HacerAlgo"
        JE HacerAlgo
        ; Si no, el programa sigue ejecutando las instrucciones que vengan después, en este caso, salta a "continuar"
        JMP continuar

    HacerAlgo:
        ; Código para ejecutar si la condición se cumple (variable1 = variable2)
    LEA DX, mensaje1        ;imprimir el primer mensaje en pantalla
    MOV AH, 9h
    INT 21H
    JMP finalizar    
    
    continuar: 
    LEA DX, mensaje2         ;imprimir el segundo mensaje en pantalla
    MOV AH, 9h
    INT 21H

    finalizar:             ; Finalizar el programa
        MOV AH, 4Ch
        INT 21h

CODIGO ENDS

    END START