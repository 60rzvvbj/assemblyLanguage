data segment
    res db '00000$'
    num dw 3
data ends
stack1 segment para stack
    dw 20h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    mov ax, num
    push ax
    call printInt
    mov ah, 4ch
    int 21h
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