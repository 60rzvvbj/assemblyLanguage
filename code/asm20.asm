; 判断一个数是否为素数
data segment
    num dw 100
    res db '00000$'
    line db 0dh, 0ah, '$'
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    mov cx, 1
cyc:
    add cx, 1
    push cx
    call judgePrime
    cmp dx, 1
    je show
showEnd:
    cmp cx, num
    je over
    jmp cyc
show:
    push cx
    call printInt
    mov dx, offset line
    mov ah, 09h
    int 21h
    jmp showEnd
over:
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
    je primeTrue
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
printInt proc
    ; 保存状态
    push ax
    push bx
    push cx
    push dx
    push si
    push bp
    ; 开始
    mov bx, offset res
    mov si, 0005h
    mov bp, sp
    mov ax, [bp + 14]
    ; 循环
printIntCyc:
    sub si, 01h
    mov cx, 000ah
    xor dx, dx
    div cx
    add dl, 48
    mov [bx][si], dl
    cmp si, 0000h
    ja printIntCyc
    ; 结束循环
    mov bx, offset res
    mov si, -1
printIntJudge:
    add si, 1
    cmp si, 0004h
    je printIntOver
    mov al, [bx][si]
    cmp al, 48
    je printIntJudge
printIntOver:
    mov dx, bx
    add dx, si
    mov ah, 09h
    int 21h
    ; 恢复状态
    pop bp
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret 2
printInt endp
code ends
end start