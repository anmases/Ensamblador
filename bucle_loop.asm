; El bucle loop no usa instrucciones de comparación ni condicionales,
; se basa solamente en el decremento del registro CX cada vez que se ejecuta la instrucción LOOP.
; este bucle se asemeja a un bucle for de alto nivel.
DATOS SEGMENT
    
DATOS ENDS

PILA SEGMENT STACK
PILA ENDS


CODIGO SEGMENT
           ASSUME CS:CODIGO, DS:DATOS

    INICIO:
           MOV    AX, DATOS              ; Cargar el segmento de datos en AX
           MOV    DS, AX                 ; Mover AX a DS

           MOV    CX, 5                  ; Inicializar el contador CX a 5

    BUCLE:                               ; Etiqueta de inicio del bucle
    ; Aquí el cuerpo del bucle.
           MOV    DL, CL
           ADD    DL, "0"                ; Carácter a imprimir
           MOV    AH, 02h                ; Función para imprimir un solo carácter
           INT    21h                    ; Llamar al sistema operativo

           LOOP   BUCLE                  ; Saltar a BUCLE si CX != 0

    ; Finalizar el programa
           MOV    AH, 4Ch                ; Servicio para terminar el programa
           MOV    AL, 0                  ; fin del programa con código 0
           INT    21h                    ; Llamar al SO

CODIGO ENDS
END INICIO