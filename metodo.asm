
retornoCarro EQU 13D
salto EQU 10D

datos SEGMENT
    mensaje  db "hola mundo$", 0                                   ;se coloca al final un byte nulo (podría ser también un $) para indicar que la cadena está terminada. Los sucesivos caracteres se almacenan consecutivamente en la memoria en direcciones de 1 byte.
    mensaje2 db 'H','o','l','a',' ','m','u','n','d','o', '$', 0    ;Esto funcionaría igual como lo anterior, en realidad es como un array.
datos ENDS

pila SEGMENT STACK
         db 1000 DUP(2)
pila ENDS

codigo SEGMENT
    main PROC                                         ;con la directiva PROC-ENDP le indicamos un bloque que es un método. Puiede contener la directiva RET de return.
           ASSUME CS:CODIGO, DS:DATOS, SS:PILA
           mov    AX, datos                       ;la directiva assume solo declara que DS es un segmento de datos, pero aquí se carga la dirección base (dirección absoluta en memoria de comienzo) en dicho registro, para ello se emplea un registro intermedio AX. Esto le indica al procesador
           mov    DS, AX                          ;tras esto DS ya apunta al segmento de datos. Ahora el CPU sabe dónde están los datos.
           lea    DX, mensaje
           mov    AH, 9H                          ;colocando el 9 en el registro AH le indicamos a DOS que ejecute la salida estandar, para mostrar lo que haya en DX
           int    21H                             ;hace una interrupción llamando al SO para que ejecute la instrucción (salida estándar).
           mov    AH, 4CH                         ;con esto le indicamos al DOS que debe terminar el programa.
           mov    AL, 0                           ;con esto le indicamos que muestre un código de salida, 0 en caso de que el programa termine correctamente.
           int    21H                             ;llamamos otra vez al SO.
    main ENDP
codigo ENDS

END main                                          ;aquí le indicamos que el punto de entrada es el método main.