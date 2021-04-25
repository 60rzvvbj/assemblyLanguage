; 子程序练习
data segment
    arr dw 5, 3 ,1, 4, 2
    len equ $-arr
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume ds:data, cs: code, ss:stack1
start:
    mov ax, data
    mov ds, ax
    mov cx, offset arr
outer:
    mov bx, offset arr
inner:
    push bx
    add bx, 2h
    push bx
    call swap
    pop ax
    pop ax
    cmp bx, len - 2
    jb inner
    jmp innerover
innerover:
    add cx, 2h
    cmp cx, len
    jb outer
    jmp outerover
outerover:
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