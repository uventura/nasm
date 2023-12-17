section .data
    argument_message db "    %s", 10, 0

section .text
    extern printf
    global display_parameters   ; Make "display_parameters" available for linker

display_parameters:
    enter 0, 0

    mov ecx, [esp + 8]
    mov edi, [esp + 12]
    mov edi, [edi]

loop_words:
    push ecx

    push edi
    push argument_message
    call printf

    pop ecx
    pop ecx
    pop ecx

    call get_next_string

    add edi, esi
    loop loop_words

end_display_parameters:
    leave
    ret

get_next_string:
    push edi
    mov esi, 0

while_not_null:
    mov bl, [edi]
    cmp bl, 0
    je end
    inc edi
    inc esi
    jmp while_not_null
end:
    inc esi
    pop edi

    ret
