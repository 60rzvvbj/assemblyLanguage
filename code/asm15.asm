; 子程序练习，循环练习
; 使用子程序计算每一行的和
; 具体题目需求见asm7.asm
data segment
    line1  dw 1,2,3,4,5,?
    line2  dw 6,7,8,9,10,?
    line3  dw 11,12,13,14,15,?
    line4  dw 21,22,23,24,25,?
    line5  dw 31,32,33,34,35,?
    sum    dw ?
data ends

stack1 segment para stack
    dw 20h dup(0)
stack1 ends

code segment
    assume ds:data, cs: code, ss:stack1
start:
    mov ax, data
    mov ds, ax
    mov bx, 0000h
    xor dx, dx
cyc:
    push bx
    call run
    pop bx
    mov ax, [bx + 10]
    add dx, ax
    add bx, 000ch
    cmp bx, 003ch
    jb cyc
    mov sum, dx
    mov ah, 4ch
    int 21h
run proc
    push ax
    push si
    push dx
    push bp
    push bx
    xor dx, dx
    xor si, si
    mov bp, sp
    mov bx, [bp + 12]
re:
    mov ax, [bx][si]
    add si, 02h
    add dx, ax
    cmp si, 000ah
    jb re
    mov [bx][si], dx
    pop bx
    pop bp
    pop dx
    pop si
    pop ax
    ret
code ends
run endp
end start