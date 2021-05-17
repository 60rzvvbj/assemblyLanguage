; 判断一个数是否为素数
data segment
    num dw 7
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    mov cx, num
    push cx
    call judgePrime
    cmp dx, 1
    je yes
    mov dl, '0'
    jmp over
yes:
    mov dl, '1'
over:
    mov ah, 02h
    int 21h
    mov ah, 4ch
    int 21h
judgePrime proc
    ; 保存状态
    push ax
    push cx
    push bp
    push bx
    ; 开始
    mov bp, sp
    mov bx, [bp + 10]
    mov cx, 1
primeCyc:
    mov ax, bx
    xor dx, dx
    div cx
    add cx, 1
    cmp ax, cx
    jb primeTrue
    mov ax, bx
    xor dx, dx
    div cx
    cmp dx, 0
    je primeFalse
    jmp primeCyc
primeFalse:
    mov dx, 0
    jmp primeEnd
primeTrue:
    mov dx, 1
    jmp primeEnd
primeEnd:
    ; 恢复状态
    pop bx
    pop bp
    pop cx
    pop ax
    ret 2
judgePrime endp
code ends
end start