; 简单的循环练习(1)
; 输出从1到5
data segment
    x db '1', 0dh, 0ah, '$' ; 定义一个字符串'1\r\n$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    ; 正文
    mov cl, x ; 将x存入cl中
cyc:
    mov dx, offset x ; 使用09号功能打印字符串x
    mov ah, 09h
    int 21h
    add cl, 1h ; 将x的第一个字符加1
    mov x, cl ; 再存入x中
    cmp cl, '6' ; 使用cmp je 组合判断x和字符6是否相等
    je over ; 如果相等则结束循环
    jmp cyc ; 继续循环
over:
    mov ah, 4ch ; 结束程序
    int 21h
code ends
end start

; (1) 将代码向后跳转一般是分支功能，将代码跳转到之前执行过的地方一般是循环功能