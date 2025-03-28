; Programa para intercambiar valores entre RAX y RBX usando XOR
; y mostrar los valores usando llamadas al sistema

section .data
    msg_inicial db "Valores iniciales: RAX = 0x", 0
    msg_final db 10, "Valores finales: RAX = 0x", 0
    msg_rbx db ", RBX = 0x", 0
    newline db 10, 0
    hex_chars db "0123456789ABCDEF", 0
    buffer times 16 db 0

section .text
    global _start

_start:
    ; Cargar valores iniciales en los registros 
    mov rax, 0x1234        ; RAX = 0x1234
    mov rbx, 0x5678        ; RBX = 0x5678
    
    ; Guardar valores iniciales en otros registros para preservarlos
    mov r12, rax           ; R12 = valor inicial de RAX
    mov r13, rbx           ; R13 = valor inicial de RBX
    
    ; Mostrar mensaje inicial
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, msg_inicial    ; mensaje a imprimir
    mov rdx, 24             ; longitud del mensaje
    syscall
    
    ; Mostrar valor de RAX en hexadecimal
    mov rax, r12            ; Recuperar valor original de RAX
    call print_hex
    
    ; Mostrar mensaje de RBX
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, msg_rbx        ; mensaje a imprimir
    mov rdx, 10             ; longitud del mensaje
    syscall
    
    ; Mostrar valor de RBX en hexadecimal
    mov rax, r13            ; Recuperar valor original de RBX
    call print_hex
    
    ; Intercambiar valores usando XOR
    mov rax, r12            ; Recuperar valor original de RAX
    mov rbx, r13            ; Recuperar valor original de RBX
    
    xor rax, rbx           ; RAX = RAX XOR RBX
    xor rbx, rax           ; RBX = RBX XOR RAX (ahora RBX = valor original de RAX)
    xor rax, rbx           ; RAX = RAX XOR RBX (ahora RAX = valor original de RBX)
    
    ; Guardar los nuevos valores intercambiados
    mov r12, rax           ; R12 = nuevo valor de RAX (antes RBX)
    mov r13, rbx           ; R13 = nuevo valor de RBX (antes RAX)
    
    ; Mostrar mensaje final
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, msg_final      ; mensaje a imprimir
    mov rdx, 24             ; longitud del mensaje
    syscall
    
    ; Mostrar valor final de RAX en hexadecimal
    mov rax, r12            ; Recuperar nuevo valor de RAX
    call print_hex
    
    ; Mostrar mensaje de RBX
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, msg_rbx        ; mensaje a imprimir
    mov rdx, 10             ; longitud del mensaje
    syscall
    
    ; Mostrar valor final de RBX en hexadecimal
    mov rax, r13            ; Recuperar nuevo valor de RBX
    call print_hex
    
    ; Mostrar salto de línea
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, newline        ; mensaje a imprimir
    mov rdx, 1              ; longitud del mensaje
    syscall
    
    ; Salir del programa
    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; exit code 0
    syscall

; Función para imprimir un valor en hexadecimal
print_hex:
    ; Guardar registros que se usarán
    push rbx
    push rcx
    push rdx
    push rsi
    
    ; Preparar para la conversión
    mov rcx, 4              ; Vamos a procesar 4 dígitos (16 bits)
    mov rsi, buffer         ; Dirección del buffer para almacenar caracteres

hex_loop:
    ; Extraer dígito hexadecimal más significativo
    mov rbx, rax            ; Copiar valor actual
    shr rbx, 12             ; Desplazar 12 bits a la derecha para obtener el dígito más significativo
    and rbx, 0x0F           ; Mantener solo los 4 bits menos significativos
    
    ; Convertir a carácter ASCII
    mov dl, byte [hex_chars + rbx]  ; Obtener carácter hexadecimal
    mov [rsi], dl                   ; Almacenar en el buffer
    inc rsi                         ; Avanzar puntero del buffer
    
    ; Desplazar para el siguiente dígito
    shl rax, 4              ; Desplazar 4 bits a la izquierda
    
    ; Repetir para cada dígito
    dec rcx
    jnz hex_loop
    
    ; Imprimir la cadena hexadecimal
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; file descriptor: stdout
    mov rsi, buffer         ; buffer con la cadena hexadecimal
    mov rdx, 4              ; longitud (4 dígitos)
    syscall
    
    ; Restaurar registros
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    
    ret