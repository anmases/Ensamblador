;Directivas del programa en MAYÚSCULA
;Las directivas son instrucciones para el ensamblador, indicándole cómo debe generar el código objeto. No se convierten en instrucciones de máquina y, por lo tanto, no tienen una representación en el código de máquina final.

             ;la directiva EQU se usa para declarar constantes en tiempo de compilación, cuando vea la etiqueta sustituirá por su valor.
retornoCarro EQU 13D
salto EQU 10D


     ;La directiva segment y ends definen el bloque de un segmento (ubicación de memoria con dirección de inicio y tamaño o desplazamiento (offset)).
datos SEGMENT
     ;aquí van las variables

     ;Existen 4 directivas para declarar variables según el espacio de memoria que reserven:
     ; db (define byte) reserva 1 byte / dw (define word) reserva 2 bytes / dd (define doubleword) reserva 4 bytes / dq (quadword) reserva 8 bytes

     nulo     db ?                                                   ; declara una variable sin valor.

     mensaje  db "hola mundo$", 0                                    ;se coloca al final un byte nulo (podría ser también un $) para indicar que la cadena está terminada. Los sucesivos caracteres se almacenan consecutivamente en la memoria en direcciones de 1 byte.
     mensaje2 db 'H','o','l','a',' ','m','u','n','d','o', '$', 0     ;Esto funcionaría igual como lo anterior, en realidad es como un array.
     ;la etiqueta mensaje solo apunta a la dirección de memoria del primer elemento de la secuencia desde el que se parte a recorrer el Array.
datos ENDS
             ; se debe indicar que este segmento es de pila.
pila SEGMENT STACK
     ;aquí la pila
     ;dup se usa para duplicar n veces x. En este caso 2000 bytes.
          db 1000 DUP(2)
pila ENDS

codigo SEGMENT
            comienzo:                                 ;aquí fijamos la etiqueta de inicio del programa.
            ASSUME   CS:CODIGO, DS:DATOS, SS:PILA     ;con la directiva assume, que no es una instrucción le indicamos al ensamblador hacia dónde deben apuntar los registros de segmento. Su función principal es informar al ensamblador cómo debería interpretar el uso de los registros de segmento en el código, no añade nada a los registros.
     ;aquí las instrucciones  (mnemónico + operandos):
                      
            mov      AX, datos                        ;la directiva assume solo declara que DS es un segmento de datos, pero aquí se carga la dirección base (dirección absoluta en memoria de comienzo) en dicho registro, para ello se emplea un registro intermedio AX. Esto le indica al procesador
            mov      DS, AX                           ;tras esto DS ya apunta al segmento de datos. Ahora el CPU sabe dónde están los datos.
     ;por cuestión de arquitectura no se puede añadir directamente a los registros de datos y debe emplearse un registro intermedio AX.
     ;no es necesario direccionar los otros segmentos, de pila y código, pues ya lo hace el DOS.
            mov      DX, OFFSET mensaje               ;Con esto añadimos en el registro DX la dirección de memoria relativa, desplazamiento u offset (conociendo ya DS) del mensaje. Se puede usar LEA.
            mov      AH, 9H                           ;colocando el 9 en el registro AH le indicamos a DOS que ejecute la salida estandar, para mostrar lo que haya en DX
            int      21H                              ;hace una interrupción llamando al SO para que ejecute la instrucción (salida estándar).

     ;tras haber realizado las instrucciones, se termina el programa y se devuelve el control al sistema operativo.
           mov       AH, 4CH                          ;con esto le indicamos al DOS que debe terminar el programa.
           mov       AL, 0                            ;con esto le indicamos que muestre un código de salida, 0 en caso de que el programa termine correctamente.
           int       21H                              ;llamamos otra vez al SO.       

codigo ENDS

END comienzo          ;aquí le indicamos al ensamblador en qué punto comienza la ejecución del programa.
