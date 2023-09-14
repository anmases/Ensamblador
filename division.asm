;Este es un programa que hace una división sencilla y la muestra por pantalla
DATA SEGMENT
    cociente DB "El cociente es: ",0, 13D, 10D, '$'    ; Almacenar el cociente como carácter ASCII
    resto DB "El resto es: ",0, 13D, 10D, '$'     ; Almacenar el resto como carácter ASCII
DATA ENDS

STACKS SEGMENT STACK
; No es necesario en este caso
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX

    MOV AX, 10D   ; Coloca el dividendo en AX
    MOV BX, 3D    ; Coloca el divisor en un registro de propósito general, como BX
    XOR DX, DX     ; Limpia DX para prepararlo para la división
    DIV BX         ; Divide lo que haya en AX por el registro que le indiquemos

    ; Convierte el cociente y el resto a caracteres ASCII
    ADD AL, '0'   ; Convertir cociente a carácter ASCII
    MOV cociente+17, AL

    ADD DL, '0'   ; Convertir resto a carácter ASCII
    MOV resto+14, DL

    MOV AH, 09H    ; Servicio para imprimir una cadena
    LEA DX, cociente ; Cargar la dirección de cociente en DX
    INT 21H

    LEA DX, resto ; Cargar la dirección de resto en DX
    INT 21H

    MOV AH, 4CH
    INT 21H
CODES ENDS
END START