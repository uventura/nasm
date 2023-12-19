section .data
    var db 'loop '    ; Definição da variável 'var' que armazena a string 'loop '
    size equ $ - var   ; Cálculo do tamanho da string

section .text
    extern exit        ; Declaração externa da função 'exit'

%macro loopFor 4       ; Definição da macro 'loopFor' com 4 argumentos
    pusha             ; Empurra todos os registradores na pilha
    .loopfor:         ; Rótulo do loop
        %2            ; Executa a instrução fornecida como o segundo argumento
        je .end_loop  ; Se ebx for igual a 5, pula para .end_loop
        %3            ; Executa a instrução fornecida como o terceiro argumento
        %4            ; Executa a instrução fornecida como o quarto argumento
        jmp .loopfor  ; Salto de volta para .loopfor (chamada recursiva)
    .end_loop:        ; Rótulo de término do loop
    popa              ; Restaura todos os registradores
%endmacro

%macro comparacao 0    ; Definição da macro 'comparacao' sem argumentos
    cmp ebx, 5        ; Compara o valor em ebx com 5
%endmacro

%macro imprime 0       ; Definição da macro 'imprime' sem argumentos
    pusha             ; Empurra todos os registradores na pilha
    mov eax, 4        ; Configura o número da chamada de sistema para imprimir
    mov ebx, 1        ; Configura o descritor de arquivo para saída padrão
    mov ecx, var      ; Configura o ponteiro para a string a ser impressa
    mov edx, size     ; Configura o comprimento da string
    int 0x80          ; Chama a interrupção de sistema para imprimir
    popa              ; Restaura todos os registradores
%endmacro

%macro adiciona_ao_contador 0  ; Definição da macro 'adiciona_ao_contador' sem argumentos
    inc ebx                    ; Incrementa o valor em ebx
%endmacro

global _start                ; Define o ponto de entrada do programa
section .text
_start:
    mov ebx, 1                ; Inicializa ebx com o valor 1

    loopFor ebx, comparacao, imprime, adiciona_ao_contador  ; Chama a macro 'loopFor'

    mov eax, 1                ; Configura o número da chamada de sistema para sair
    xor ebx, ebx              ; Zera ebx
    int 0x80                  ; Chama a interrupção de sistema para sair
