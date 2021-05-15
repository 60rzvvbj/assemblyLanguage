; 多分支程序设计
; 地址表法：通过将有一定规律的要跳转的代码连续存放到内存中，通过跳转条件计算出对应的要跳转的代码段
; 程序功能：
; 根据X的取值，输出对应的字符
; 1 - a
; 2 - e
; 3 - i
; 4 - o
; 5 - u

data segment
    X dw 2 ; 定义一个值为2的dw类型的变量X和
    addrtab dw flag1, flag2, flag3, flag4, flag5 ; 一个dw类型的数组addrtab，其值为五段代码的地址(1)
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    ; 正文部分
    mov bx, offset addrtab ; 使用offset关键字将addrtab的地址存入bx寄存器中(2)

    ; 因为addrtab是dw类型的
    ; 所以flag1, flag2...的地址为
    ; bx + 0, bx + 2, bx + 4, bx + 6, bx + 8
    ; 也就是bx + (X - 1) * 2
    mov ax, X ; 将X的值存入ax寄存器中
    sub ax, 1 ; 计算X - 1
    sal ax, 1 ; 左移相当于乘2，计算(X - 1) * 2
    add bx, ax ; 计算出对应的存放flag的地址
    jmp ds:[bx] ; 使用了寄存器间接寻址的方式(3)，跳转到对应的代码段
    ; flag2的值是一个指向了flag2处的代码地址
    ; bx的值存储的是flag2的地址
    ; 所以[bx]就可以找到flag2的值也就是flag2对应的代码的地址，所以通过jmp可以跳转到对应位置

flag1:
    mov dl, 'a' ; 将字符a存入dl寄存器中，以供02号功能调用，下面同理
    jmp show ; 跳转到show
flag2:
    mov dl, 'e'
    jmp show
flag3:
    mov dl, 'i'
    jmp show
flag4:
    mov dl, 'o'
    jmp show
flag5:
    mov dl, 'u'
    jmp show
show:
    mov ah, 02h ; 调用2号系统功能打印dl寄存器中的字符
    int 21h
    mov ah, 4ch ; 结束程序
    int 21h
code ends
end start

; (1)
; 在定义变量的时候，可以一个变量名后面有多个数据，这多个数据的地址是连续的，和高级语言中的数组类似
; 我们通过变量名可以访问到这一串数据的首地址，也就是第一个数据
; 通过首地址和每个元素的大小可以计算出每个元素的地址，例如本例中
; dw是两个字节，flag3的地址就是addrtab对应的地址 + 2(数组中第2号位置) * 2(数组中每个元素的大小两个字节)

; (2) offset X 可以获取变量X的地址，在最开始asm1.asm文件中有用过，不过当时入门没讲那么多

; (3) 常用的寻址方式
; 立即寻址：例如 mov ah, 02h这种直接获取代码中的数值的方式称为立即寻址
; 寄存器寻址：例如 mov ds, ax这种获取寄存器中的数值的方式称为寄存器寻址
; 直接寻址：例如 mov ax, ds:[0000h] 这种通过偏移量获取对应位置的数据的方法称为直接寻址
; 寄存器间接寻址：例如 mov ax, ds:[bx] 通过寄存器中记录的偏移量获取对应位置的数据的方法称为寄存器间接寻址
; 变址寻址：例如 mov ax, arr[bx] <=> mov ax, ds:arr[bx] <=> mov ax, ds:[arr + bx]这些称为变址寻址
; 基址变址：例如 mov ax, ds:arr[bx][si] 这种称为基址变址，它和mov ax, ds:[bx + si]效果一样
; 其实别看有这么多花里胡哨的寻址方式，其实理解起来和高级语言的都差不多的
; 具体你用的这个寻址方式叫啥名不重要的，只要你凭着感觉来能拿到你的数据就好了