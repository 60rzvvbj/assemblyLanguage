; DOS功能调用
; 输入一个字符，输出该字符
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
    mov dl, al
    mov ah, 02h
    int 21h
    mov ah, 4ch
    int 21h
code ends
end start