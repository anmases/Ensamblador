;Suma que da como resultado números de una cifra
datos SEGMENT
    num1 db 5
    num2 db 2
    resultado db ?
    texto db "el resultado es: ",0,0,'$'       ;reservamos espacio en el array para colocar el caracter, que será la posición 17
datos ENDS

pila SEGMENT STACK
    db 1000 DUP(2)
pila ENDS

codigo SEGMENT
           ASSUME CS:codigo, DS:datos, SS:pila
main PROC
           MOV    AX, datos
           MOV    DS, AX
           
           ;Aquí se realiza la suma:
           mov   AL, num1             ;se añade el número al registro. El registro puede ser cualquiera, pero de 1byte, ya que la variable es de 1 byte
           add   AL, num2             ;se le suma el otro número al que haya en el registro
           mov   resultado, AL        ;se mueve el resultado del registro a la variable resultado en memoria
           ;Aquí convertimos el resultado numérico en ascii, sumando el valor del caracter ascii "0":
           mov   AL, resultado        ;recuperamos el valor almacenado, aunque no haría falta porque no se ha sobreescrito.
           add   AL, "0"
           ;Aquí insertaremos el resultado en uno de los espacios reservados con 0:
           mov   texto+17, AL

           lea DX, texto              ;lo añadimos a DX, su dirección, para mostrar en pantalla.
           mov AH, 9D
           int 21H
           ;terminamos el programa
           MOV    AH, 4CH
           mov    AL, 0
           INT    21H
main ENDP
codigo ENDS
END main