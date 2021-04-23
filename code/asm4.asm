; 多分支程序设计
; 判断一个数是正数，负数还是0
; 地址表法
data segment
    X dw 0f001h
    addrtab dw flag1, flag2, flag3
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
    jmp sub2
sub0:
    mov si, 0
    jmp sub3
sub1:
    mov si, 2
    jmp sub3
sub2:
    mov si, 4
    jmp sub3
sub3:
    mov bx, addrtab[si]
    jmp bx
flag1:
    mov dl, 30h
    jmp show
flag2:
    mov dl, 2dh
    jmp show
flag3:
    mov dl, 2bh
    jmp show
show:
    mov ah, 2
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start