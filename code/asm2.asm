; 基本命令练习
; 计算 2(a+b)-c
data segment
; 这里(data segment和data ends之间)是在内存中定义变量的地方，这里定义的数据可以在内存中看到
a	db	25	
b	db	43	
c	db	76 	
y	db	? 	; 本例中定义了四个类型为db的数据，y的值为?代表没有给y赋初始值
data	ends

stack1 	segment	para stack
		dw 20h	dup(0)
stack1	ends

coseg	segment
		assume  cs:coseg,ds:data,ss:stack1
start:	mov ax , data	
		mov ds , ax
        ; 以上看不懂的一坨代码为固定写法，每次复制粘贴一下就好了，现在不需要知道它们都是干啥的
        ; 你要敲得代码在这里开始写，一直到coseg ends处结束
		mov al , a		; 将a存入al寄存器(1)
        ; 关于下面计算相关的指令的用法，功能，请参考后面的注释(2)
		add al , b		; 将al和b中的数加起来，即计算(a+b)
		sal	al , 1		; 将al寄存器中的数值左移1位，左移1位相当于乘2，即计算 2(a+b)
		sub	al , c		; 将al寄存器中数和c相减，即计算 2(a+b)-c
		mov	y , al		; 将al中存放的结果存入y中
		mov	ah, 4ch	    ; 将4c存放到ah寄存器中(3)
		int	21h         ; 调用4c号系统功能结束程序
        ; 结束
coseg	ends
		end	start

; (1)ax寄存器可以存放两个字节的数据，为了方便，将ax寄存器分为al寄存器和ah寄存器
; al, ah每个可以存放一个字节，存在al寄存器中的数据可以再ax的低位中看到，ah -> ax的高位
; al, ah一般用来转换数据的类型(以后会讲)
; 不止ax可以分为al, ah两个寄存器，bx, cx, dx也同理

; (2)
; mov x, y 将y存入x中
; add x, y 计算x + y并将结果存入x中
; sub x, y 计算x - y并将结果存入x中
; sal x, y 将x左移y位
; int 21h 执行系统命令
