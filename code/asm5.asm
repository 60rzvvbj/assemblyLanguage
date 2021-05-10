; 循环练习
; 输出从1到5
data segment
    ; s db '123456789',0dh, 0ah, '$'
    x db '1', 0dh, 0ah, '$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    xor cx, cx
    mov cx, x
flag:
    mov dx, offset x
    mov ah, 09h
    int 21h
    add cl, 1h
    mov x, cl
    cmp cl, 36h
    je over
    jmp flag
over:
    mov ah, 4ch
    int 21h
code ends
end start