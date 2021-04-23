; 循环练习
; 统计字符串中大写字母，小写字母，数字，符号的个数
data segment
str db 'AAAAAaaaa12345###111AAA'
count equ $-str
t dw ?
a dw 30h
b dw 30h
c dw 30h
d dw 30h
e db '$'
data ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    xor ax, ax
    mov cx, count
    mov si, 0
flag1:
    mov bl, str[si]
    cmp bl, 'A'
    jb flag2
    cmp bl, 'Z'
    ja flag2
    mov ax, a
    inc ax
    mov a, ax
    jmp next
flag2:
    cmp bl, 'a'
    jb flag3
    cmp bl, 'z'
    ja flag3
    mov ax, b
    inc ax
    mov b, ax
    jmp next
flag3:
    cmp bl, '0'
    jb flag4
    cmp bl, '9'
    ja flag4
    mov ax, c
    inc ax
    mov c, ax
    jmp next
flag4:
    mov ax, d
    inc ax
    mov d, ax
next:
    inc si
    loop flag1
    lea dx, a 
    mov ah, 09h
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start