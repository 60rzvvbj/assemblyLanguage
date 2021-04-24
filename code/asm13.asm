; 子程序练习
; 编写一个子程序，入口参数为两个地址，若前者的值大于后者的值，则交换两个地址的值
data segment
    x dw 5
    y dw 3
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume ds:data, cs: code, ss:stack1
start:
    mov ax, data
    mov ds, ax
    mov ax, offset x
    push ax
    mov ax, offset y
    push ax
    call swap
    pop ax
    pop ax
    mov ah, 4ch
    int 21h
swap proc
    push bx
    push si
    push ax
    push dx
    push bp
    mov bp, sp
    mov bx, [bp + 12]
    mov si, [bp + 14]
    mov ax, [bx]
    mov dx, [si]
    cmp ax, dx
    ja over
    mov [bx], dx
    mov [si], ax
over:
    pop bp
    pop dx
    pop ax
    pop si
    pop bx
    ret
swap endp
code ends
end start