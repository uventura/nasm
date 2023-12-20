; nasm -f elf64 -o [object_name].o [source_name].asm
; ld [object_name].o -o [executable_name]

section .data
    txt db "Hello world.", 10
    len EQU $-msg

section .text
    global example

example:
    mov rsi, msg
    mov rax, 1
    mov rdi, 1
    mov rdi, len    ; Correct: "mov rdx, len"

    syscall         ; Linux x86-64

    mov rax, 60
    mov rdi, 0

    syscall
