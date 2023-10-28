;Para crear archivo: 3ch
;Para abrir un archivo:  3dh
;Para leer un archivo: 3fh
;Para escribir sobre un archivo: 40h
;Para cerrar un archivo: 3eh
;Eliminar un archivo: 41h 

data SEGMENT
    nombre db "C:\Users\anton\Desktop\hola.txt", 0    ;nombre del fichero, 0 es el caracter terminador. no termina en $, porque esta es propia de la función 9H
    buffer db 100 DUP(?), '$'                              ;buffer de 100 espacios para almacenar el espacio leído del fichero
data ENDS

code SEGMENT
          ASSUME CS:code, DS:data
    start:
          MOV    AX, data            ; Cargar el segmento de datos en AX
          MOV    DS, AX
    ;Abrir archivo en modo lectura/escritura:
          MOV    AH, 3dh             ;Función para abrir el archivo
          MOV    AL, 2               ; Modo de acceso: 0 = leer, 1 = escribir, 2 = leer/escribir para crear el handler
          LEA    DX, nombre
          INT    21h
          JC     error               ;si hay algún error en su creación salta a la parte error. JC es jump if carry, cuando la función INT 21h produce un error, se enciende la bandea de carry.
          MOV    BX, AX              ;Cambiamos el handler, que está en AX a BX, para tener libre AX.

    ;Lectura del fichero (el handler debe estar en BX):
          MOV    AH, 3fh             ;función para leer archivos.
          LEA    DX, buffer          ;ponemos dónde se guardará el contenido en DX.
          MOV    CX, 100             ;ponemos el número máximo de bytes que se leerán en CX.
          INT    21h

          ;Tras la lectura AX contendría el número REAL de bytes que se han leído. 

    ;Cerrar el archivo:
          MOV    AH, 3EH             ;función para cerrar archivo. El handler ya está en BX
          INT    21H

;*******************Aquí podemos imprimir el contenido del buffer*********************************
          MOV    AH, 09h
          LEA    DX, buffer
          INT    21h

    ; Terminar el programa
          MOV    AH, 4Ch
          INT    21h
    error:
    ; Aquí podemos mostrar un mensaje de error:

    ; Terminar el programa
          MOV    AH, 4Ch
          INT    21h
code ENDS
END start