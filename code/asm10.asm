; 子程序练习
; 设计一个子程序，通过主程序传入一个整数n，循环输出n次字符串
; 用栈传递参数
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
    mov ax, 0005h
    push ax
    call show
    pop ax
    mov ax, 4c00h
    int 21h
show proc
    push ax
    push dx
    push cx
    push bp
    mov bp, sp
    mov cx, [bp + 10]
cyc:
    dec cx
    mov dx, offset str
    mov ax, 0900h
    int 21h
    cmp cx, 0000h
    je over
    jmp cyc
over:    
    pop bp
    pop cx
    pop dx
    pop ax
    ret
code ends
show endp
end start