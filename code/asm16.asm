; 显示十进制数
data segment
    res DB '00000$'
    num dw 39271
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume ds:data, cs: code, ss:stack1
start:
    mov ax, data
    mov ds, ax
    mov bx, offset res
    mov si, 0005h
    mov ax, num
cyc:
    sub si, 01h
    mov cx, 000ah
    xor dx, dx
    div cx
    add dl, 48
    mov [bx][si], dl
    cmp si, 0000h
    ja cyc
    mov dx, offset res
    mov ah, 09h
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start