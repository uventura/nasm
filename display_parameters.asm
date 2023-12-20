; Commands to be executed:
; nasm -f elf display_parameters.asm
; gcc -m32 -o parameters parameters.c display_parameters.o

section .data
    argument_message db "    %s", 10, 0

section .text
    extern printf               ; Obter definição externa de "printf"
    global display_parameters   ; Torna a funcionalidade de "display_parameters" acessível

display_parameters:
    enter 0, 0

    mov ecx, [esp + 8]          ; Obtém o valor de "argc", será utilizado como o contado
    mov edi, [esp + 12]         ; Obtém o endereço em "char* argv[]"
    mov edi, [edi]              ; Acessa o primeiro elemento

loop_words:
    push ecx                    ; Coloca o contador na pilha.
    push edi                    ; Coloca o parâmetro utilizado na pilha
    push argument_message       ; Coloca o endereço de "argument_message" na pilha

    call printf                 ; Chama printf

    pop ecx                     ; Retira o topo da pilha e coloca em ecx (argument_message)
    pop ecx                     ; Retira o topo da pilha e coloca em ecx (edi)
    pop ecx                     ; Retira o topo da pilha e coloca em ecx (ecx)

    call get_next_string        ; Chama o procedimento que obtém a próxima string

    add edi, esi                ; Soma à string atual um deslocamento em "esi" para a próxima string
    loop loop_words             ; Decrementa ecx e volta para "loop_words"

end_display_parameters:
    leave                       ; Sai do frame atual
    ret                         ; retorna

get_next_string:
    push edi                    ; Coloca "edi" na pilha
    mov esi, 0                  ; Define "esi" como zero

while_not_null:
    mov bl, [edi]               ; Coloca byte de "edi" em bl
    cmp bl, 0                   ; Compara byte com zero, para verificiar se chegou ao fim
    je end                      ; Pula para fim caso esteja correto suceda.
    inc edi                     ; Incrementa edi, para a próxima string
    inc esi                     ; Incrementa esi, que representa o deslocamento
    jmp while_not_null          ; Jump para "while_not_null"
end:
    inc esi                     ; Incrementa "esi"
    pop edi                     ; Elimina topo da pilha(antigo edi) e coloca em edi

    ret                         ; Retorna
