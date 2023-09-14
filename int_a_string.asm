;Este programa convierte un número entero a caracteres y los muestra por pantalla usando la pila.

DATOS SEGMENT
    numero    DW 12345              ;instanciamos la variable como espacio en memoria de 2bytes (números hasta 65535)
DATOS ENDS

PILA SEGMENT STACK
     DB 128 DUP(0)
PILA ENDS

CODIGO SEGMENT
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA
    start:    
    ; Inicializar el segmento de datos y también la pila
              MOV  AX, DATOS
              MOV  DS, AX
              MOV  AX, PILA ;inicializamos la pila
              MOV  SS, AX
              MOV  SP, 128  ;iniciamos el puntero de pila para que apunte a lo más alto.
    
    ; Número a convertir
              MOV  AX, numero       ; Número a convertir (lo añadimos al que acumulará)
              MOV  BX, 10           ;El divisor es 10, al dividir por 10 siempre se obtiene el último número en el resto (1234/10 = cociente 123 y resto 4)
              

    descomponer:
    ; Dividir entre 10
              XOR  DX, DX           ; Limpiar DX antes de la división
              DIV  BX               ; Resultado en AX, residuo en DX
    
              ADD  DL, '0'          ; Convertir el residuo a su representación ASCII

              PUSH DX               ;añadimos DX a la pila

    ; Comprobar si aún quedan dígitos
              CMP AX, 0          ;si es 0 saltará.
              JNZ  descomponer
    ; Mostrar el resultado 

    mostrar:
    ; aquí se irán sacando de la pila y mostrando en pantalla.
              POP DX
              ; Preparar para la interrupción del sistema que mostrará el caracter individual
              MOV  AH, 02h
              INT  21h

              CMP SP, 128
              JNE  mostrar  ;si su valor no es igual al valor inicial al que apunta       
    
    ; Salir del programa
              MOV  AH, 4Ch
              MOV  AL, 0
              INT  21h

CODIGO ENDS
END start