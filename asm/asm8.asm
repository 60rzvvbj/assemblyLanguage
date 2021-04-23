; 子程序练习
; 设计一个子程序，其功能为输字符串，主程序中通过循环来多次调用子程序
data segment
    str db 'hello world!', 0dh, 0ah, '$'
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume cs: code , ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    xor dx, dx
cyc:
    inc dx
    call show
    cmp dx, 0005h
    je over
    jmp cyc
over:   
    mov ax, 4c00h
    int 21h
show proc
    push ax
    push dx
    mov dx, offset str
    mov ax, 0900h
    int 21h
    pop dx
    pop ax
    ret
code ends
show endp
end start