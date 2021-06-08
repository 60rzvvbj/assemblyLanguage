; 输出九九乘法表
data segment
    newLineData db 0dh, 0ah, '$'
    printIntRes db '00000$'
data ends
stack1 segment para stack
    dw 200h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    xor cx, cx
    mov ax, 1
outter:
    inc cx
    push cx
    call printHL
    xor dx, dx
    xor ax, ax
    call printSepar
inner:
    inc dx
    add ax, cx
    push dx
    push cx
    push ax
    call printMul

    call printSepar

    cmp dx, cx
    jne inner

    call newLine

    cmp cx, 9
    jne outter
over:
    mov ax, 9
    push ax
    call printHL
    mov ah, 4ch
    int 21h
printMul proc
    ; 保存状态
    push ax
    push bx
    push cx
    push dx
    push bp
    ; 开始
    mov bp, sp
    ; 输出第一个乘数
    mov ax, [bp + 16]
    push ax
    mov ax, 1
    push ax
    call printInt
    ; 输出 x 
    ; call printSpace
    mov dl, 'x'
    mov ah, 02h
    int 21h
    ; call printSpace
    ; 输出第二个乘数
    mov ax, [bp + 14]
    push ax
    mov ax, 1
    push ax
    call printInt
    ; 输出 = 
    ; call printSpace
    mov dl, '='
    mov ah, 02h
    int 21h
    ; call printSpace
    ; 输出积
    mov ax, [bp + 12]
    push ax
    mov ax, 2
    push ax
    call printInt
    ; 恢复状态
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret 6
printMul endp
newLine proc
    ; 保存状态
    push ax
    push dx
    ; 开始
    mov dx, offset newLineData
    mov ah, 09h
    int 21h
    ; 恢复状态
    pop dx
    pop ax
    ret
newLine endp
printSepar proc
    ; 保存状态
    push ax
    push dx
    ; 开始
    mov dl, '|'
    mov ah, 02h
    int 21h
    ; 恢复状态
    pop dx
    pop ax
    ret
printSepar endp
printHL proc
    ; 保存状态
    push ax
    push bx
    push cx
    push dx
    push bp
    ; 开始
    mov dl, '+'
    mov ah, 02h
    int 21h
    mov bp, sp
    mov cx, [bp + 12]
printHLOutter:
    sub cx, 1
    xor bx, bx
printHLInner:
    inc bx
    mov dl, '-'
    mov ah, 02h
    int 21h
    cmp bx, 6
    jne printHLInner
    mov dl, '+'
    mov ah, 02h
    int 21h
    cmp cx, 0
    jne printHLOutter

    call newLine
    ; 恢复状态
    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret 2
printHL endp
printInt proc
    ; 保存状态
    push ax
    push bx
    push cx
    push dx
    push si
    push bp
    ; 开始
    mov bx, offset printIntRes
    mov si, 0005h
    mov bp, sp
    mov ax, [bp + 16]
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
    mov bx, offset printIntRes
    mov si, -1
    mov cx, 5
    sub cx, [bp + 14]
printIntJudge:
    add si, 1
    cmp si, cx
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
    ret 4
printInt endp
code ends
end start