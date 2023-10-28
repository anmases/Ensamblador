;Para crear archivo: 3ch
;Para abrir un archivo:  3dh
;Para leer un archivo: 3fh
;Para escribir sobre un archivo: 40h
;Para cerrar un archivo: 3eh
;Eliminar un archivo: 41h 

data SEGMENT
    nombre db "C:\Users\anton\Desktop\hola.txt", 0    ;nombre del fichero, 0 es el caracter terminador. no termina en $, porque esta es propia de la función 9H
data ENDS

code SEGMENT
          ASSUME CS:code, DS:data
    start:
          MOV    AX, data            ; Cargar el segmento de datos en AX
          MOV    DS, AX
      
    ;Borrar el fichero:
          MOV    AH, 41h             ;función eliminar fichero.
          LEA    DX, nombre
          INT    21h

          JC     error


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