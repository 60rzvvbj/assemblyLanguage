; 分支语句练习
; 判断一个数是正数，负数还是0
; 条件转移法
data segment
    X dw 00001h
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    mov ax, X
    cmp ax, 0
    je sub0
    shl ax, 1
    jc sub1
    mov dl, 2bh
    jmp sub2
sub0:
    mov dl, 30h
    jmp sub2
sub1:
    mov dl, 2dh
sub2:
    mov ah, 2
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start