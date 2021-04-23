; DOS功能调用，子程序返回值
; 输入一个字符，如果是大写字母，则输出对应的小写字母，否则输出源字符
data segment
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    mov ah, 01h
    int 21h
    push ax
    call change
    pop dx
    mov cl, al
    mov dl, 0ah
    mov ah, 02h
    int 21h
    mov dl, cl
    mov ah, 02h
    int 21h
    mov ah, 4ch
    int 21h
change proc
    push cx
    push bp
    mov bp, sp
    mov cx, [bp + 6]
    cmp cl, 'A'
    jb over
    cmp cl, 'Z'
    ja over
    add cl, 'a' - 'A'
over:
    mov al, cl
    pop bp
    pop cx
    ret
change endp
code ends
end start
