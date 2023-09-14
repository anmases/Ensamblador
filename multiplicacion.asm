;En una multiplicación la instrucción MUL (+registro),





DATA SEGMENT
    
DATA ENDS

PILA SEGMENT STACK
    
PILA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:PILA
    START:
          MOV    AX, DATA
          MOV    DS, AX

          MOV    AL, 2
          MOV    BL, 2                        ; toma el valor que haya en AL o AX y lo multiplica por el de dicho registro,
          MUL    BL                           ; almacenando el resultado en AL o AX.
    ; Si el resultado es de 32bits, el resultado se divide entre AL y DH

    ;mostrar el resultado en pantalla:
          mov    DL, AL
          add    DL, '0'
          mov    AH, 2H
          int    21H
    
          MOV    AH, 4CH
          INT    21H
CODE ENDS
END START
