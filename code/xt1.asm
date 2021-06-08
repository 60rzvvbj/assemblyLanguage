data segment
    A dw 20
    B dw 30
data ends
stack1 segment para stack
    dw 20h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    ; 在此处编写你的代码
    mov ah, 4ch
    int 21h
code ends
end start