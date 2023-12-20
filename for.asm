section .data
    var db 'loop '
    size equ $ - var

%macro loopFor 4
    pusha                   ;Preservar os valores dos registradores antes de qq coisa
    .loopfor:
        %2                  ; comparação do for
        je .end_loop        ; sair do loop se a comparação for falsa
        %3                  ; corpo do for
        %4                  ; incrementação do for
        jmp .loopfor        ; chamada recursiva da função
        .end_loop:          ; restaura todos os registradores de propósito geral da pilha. Isso reverte o efeito da instrução pusha para garantir que os registradores tenham seus valores originais.
    popa
%endmacro

%macro comparacao 0
    cmp ebx, 5              ;Contador FINAL do laço for
%endmacro

%macro imprime 0
    pusha                   ;preservar Registradores de propósito geral 
    mov eax, 4              ;SysWrite   
    mov ebx, 1              ;Stdout       
    mov ecx, var              
    mov edx, size              
    int 0x80                ;Syscall-Interruptor
    popa                    ;Desempilha tudo, garantindo os valores iniciais
%endmacro
    

%macro adiciona_ao_contador 0
    inc ebx                 ;Incrementa o contador
%endmacro



global _start               ; Inicialização do programa...
_start:
    mov ebx, 1              ; Contador INICIAL do laço for(Número de laços será linha 31 - 41)

    loopFor ebx, comparacao, imprime, adiciona_ao_contador

    mov eax, 1               ; Coloca o valor 1 no registrador eax. Este valor é usado como argumento para a syscall de saída 
    xor ebx, ebx             ; Limpa o registrador ebx, garantindo que ele contenha zero antes de chamar a syscall de saída
    int 0x80                 ; Chama syscall : sys_exit para encerrar o programa.