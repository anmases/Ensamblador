;Para crear archivo: 3ch
;Para abrir un archivo:  3dh
;Para leer un archivo: 3fh
;Para escribir sobre un archivo: 40h
;Para cerrar un archivo: 3eh
;Eliminar un archivo: 41h 

data SEGMENT
      nombre db "C:\Users\anton\Desktop\hola.txt", 0             ;nombre del fichero, 0 es el caracter terminador. no termina en $, porque esta es propia de la función 9H
data ENDS

code SEGMENT
            ASSUME CS:code, DS:data
      start:
            MOV    AX, data               ; Cargar el segmento de datos en AX
            MOV    DS, AX
      ;Crear el archivo:
            MOV    AH, 3ch                ;Función para crear archivo en AH
            MOV    DX, OFFSET nombre      ;cargar el nombre del fichero en DX, ya que la función 3CH espera como argumento el nombre en DX
            MOV    CX, 00h                ;son atributos para el fichero (00h normal, 02h oculto, 04h sistema, 06h oculto y sistema
            INT    21h                    ;interrupción
            JC     error                  ;si hay algún error en su creación salta a la parte error. JC es jump if carry, cuando la función INT 21h produce un error, se enciende la bandea de carry.

      ;Cerrar el archivo:
            MOV    AH, 3EH                ;función para cerrar archivo.
            MOV    BX, AX                 ;AX contiene el "handler" del archivo, generado en una función 3CH por el SO automáticamente. La función 3EH espera que el handler se encuentre en BX.
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