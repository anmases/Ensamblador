;Para crear archivo: 3ch
;Para abrir un archivo:  3dh
;Para leer un archivo: 3fh
;Para escribir sobre un archivo: 40h
;Para cerrar un archivo: 3eh
;Eliminar un archivo: 41h 

data SEGMENT
    nombre db "C:\Users\anton\Desktop\hola.txt", 0    ;nombre del fichero, 0 es el caracter terminador. no termina en $, porque esta es propia de la función 9H.
    texto  db "Hola mundo", 0                         ;texto a escribir en el fichero.
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
          JC     error
          MOV    BX, AX              ;Cambiamos el handler, que está en AX a BX, para tener libre AX

    ;Escribir en el fichero (El handler debe estar en BX):
          MOV    AH, 40h             ;Llamamos a la función escritura.
          LEA    DX, texto           ;ponemos el puntero al texto en DX.
          MOV    CX, 11              ;hay que definir el número de bytes a escribir en CX. Si no conocemos el número de caracteres, se tendría que recorrer la cadena con un bucle y almacenar en un registro contador (SI) la cantidad de caracteres.
          INT    21h
    ;Cerrar el archivo:
          MOV    AH, 3EH             ;función para cerrar archivo. El handler ya está en BX.
          INT    21H
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