# README: Programa en ensamblador x86-64 para intercambiar valores entre RAX y RBX usando XOR

Este programa en ensamblador x86-64 demuestra cómo intercambiar los valores de los registros `RAX` y `RBX` utilizando la operación XOR sin necesidad de un registro temporal adicional. Además, muestra los valores iniciales y finales de ambos registros en formato hexadecimal mediante llamadas al sistema.

## Contenido del programa

### 1. **Descripción general**
El programa realiza las siguientes tareas:
- Carga valores iniciales en los registros `RAX` y `RBX`.
- Muestra los valores iniciales de `RAX` y `RBX` en formato hexadecimal.
- Intercambia los valores de `RAX` y `RBX` utilizando la operación XOR.
- Muestra los valores finales de `RAX` y `RBX` después del intercambio.
- Finaliza el programa con un código de salida `0`.

### 2. **Estructura del código**

#### Sección `.data`
Contiene los datos utilizados por el programa:
- `msg_inicial`: Mensaje que indica los valores iniciales de `RAX` y `RBX`.
- `msg_final`: Mensaje que indica los valores finales de `RAX` y `RBX`.
- `msg_rbx`: Separador para mostrar el valor de `RBX`.
- `newline`: Salto de línea para mejorar la legibilidad de la salida.
- `hex_chars`: Cadena que contiene los caracteres hexadecimales (`0-9`, `A-F`).
- `buffer`: Espacio reservado para almacenar temporalmente los dígitos hexadecimales generados.

#### Sección `.text`
Contiene el código ejecutable del programa:
- **Etiqueta `_start`**: Punto de entrada del programa.
- **Intercambio de valores**: Se utiliza una secuencia de tres operaciones XOR para intercambiar los valores de `RAX` y `RBX`.
- **Función `print_hex`**: Convierte un valor hexadecimal en una cadena imprimible y la muestra en la salida estándar.

### 3. **Flujo del programa**

1. **Inicialización**:
   - Se cargan los valores iniciales `0x1234` y `0x5678` en los registros `RAX` y `RBX`, respectivamente.
   - Estos valores se copian a los registros `R12` y `R13` para preservarlos durante el programa.

2. **Mostrar valores iniciales**:
   - Se imprime el mensaje inicial seguido de los valores de `RAX` y `RBX` en formato hexadecimal.

3. **Intercambio de valores**:
   - Se utiliza la siguiente secuencia de operaciones XOR para intercambiar los valores:
     ```
     xor rax, rbx
     xor rbx, rax
     xor rax, rbx
     ```
   - Después del intercambio, `RAX` contiene el valor original de `RBX` y viceversa.

4. **Mostrar valores finales**:
   - Se imprime el mensaje final seguido de los nuevos valores de `RAX` y `RBX`.

5. **Finalización**:
   - Se añade un salto de línea para mejorar la presentación.
   - El programa termina con una llamada al sistema `exit` con código de salida `0`.

### 4. **Función `print_hex`**

La función `print_hex` convierte un valor hexadecimal en una cadena imprimible:
- Divide el valor en 4 dígitos hexadecimales (16 bits).
- Convierte cada dígito en su representación ASCII utilizando la tabla `hex_chars`.
- Almacena los caracteres en el `buffer` y los imprime en la salida estándar.

### 5. **Compilación y ejecución**

Para compilar y ejecutar este programa, sigue estos pasos:

1. **Guardar el código fuente**:
   Guarda el código en un archivo llamado `swap_xor.asm`.

2. **Compilar con NASM**:
   ```bash
   nasm -f elf64 swap_xor.asm -o swap_xor.o
   ```

3. **Enlazar con LD**:
   ```bash
   ld swap_xor.o -o swap_xor
   ```

4. **Ejecutar el programa**:
   ```bash
   ./swap_xor
   ```

### 6. **Salida esperada**

La salida del programa será similar a la siguiente:
```
Valores iniciales: RAX = 0x1234, RBX = 0x5678
Valores finales: RAX = 0x5678, RBX = 0x1234
```

### 7. **Notas adicionales**

- Este programa utiliza llamadas al sistema (`syscall`) para escribir en la salida estándar y salir del programa.
- La operación XOR es una técnica eficiente para intercambiar valores sin usar memoria adicional.
- El programa asume un entorno Linux x86-64 con soporte para llamadas al sistema.

### 8. **Contribuciones**

Si encuentras algún error o tienes sugerencias para mejorar este programa, no dudes en contribuir. ¡Toda ayuda es bienvenida!

---

**Fin del README**
