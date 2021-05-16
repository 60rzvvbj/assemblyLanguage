; 综合练习输出从1到n的所有整数
data segment
    res db '00000$'
    n dw 30
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
    mov cx, 0
cyc:
    add cx, 1
    push cx
    call printInt
    mov dx, offset line
    mov ah, 09h
    int 21h
    cmp cx, n
    je over
    jmp cyc
over:
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
    sub bx, 1
printIntJudge:
    add bx, 1
    cmp bx, 0005h
    je printIntOver
    mov al, [bx]
    cmp al, 48
    je printIntJudge
printIntOver:
    mov dx, bx
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