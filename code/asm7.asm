; 双重循环练习
; 计算每行的和并存入最后一个位置
; 计算所有数的和存在sum中
data   segment
    line1  dw 1,2,3,4,5,?
    line2  dw 6,7,8,9,10,?
    line3  dw 11,12,13,14,15,?
    line4  dw 21,22,23,24,25,?
    line5  dw 31,32,33,34,35,?
    sum    dw ?
data   ends

code segment
    assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
    add dx, 000ah
cyc:
    mov ax, [bx]
    add cx, ax
    add bx, 2h
    cmp bx, dx
    je recode
    jmp cyc
recode:
    mov [bx], cx
    mov ax, sum
    add ax, cx
    mov sum, ax
    xor ax, ax
    add bx, 2h
    cmp bx, 003ch
    je over
    xor cx, cx
    add dx, 000ch
    jmp cyc
over:
    mov ah, 4ch
    int 21h
code ends
end start