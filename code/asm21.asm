; 已知数组A包含20个互不相等的整数，数组B包含20个互不相等的整数。
; 编程，把既在数组A中又在数组B中出现的整数存放与数组C，并显示数组C中数据的个数。（用十进制显示）
data segment
    A dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
    ; A dw 1, 2, 3
    Alen equ $-A
    B dw 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    ; B dw 3, 4
    Blen equ $-B
    C dw 20 dup(0)
    printIntRes db '00000$'
    AIndex dw ?
    BIndex dw ?
    CIndex dw ?
data ends
stack1 segment para stack
    dw 20h dup(0)
stack1 ends
code segment
    assume cs: code, ds: data, ss: stack1
start:
    mov ax, data
    mov ds, ax
    mov ax, 0h
    mov AIndex, ax
    mov CIndex, ax
outer:
    mov ax, 0h
    mov BIndex, ax
    mov si, AIndex
    mov ax, A[si]
inner:
    mov si, BIndex
    mov bx, B[si]

    cmp ax, bx
    jne nowCycOver
    mov si, CIndex
    mov C[si], ax
    add si, 2
    mov CIndex, si

nowCycOver:
    mov si, BIndex
    add si, 2
    mov BIndex, si
    cmp si, Blen
    jne inner

    mov si, AIndex
    add si, 2
    mov AIndex, si
    cmp si, Alen
    jne outer

    mov ax, CIndex
    shr ax, 1
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
    mov bx, offset printIntRes
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
    mov bx, offset printIntRes
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