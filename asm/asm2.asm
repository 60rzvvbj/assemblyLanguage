; 基本命令练习
; mov X, Y 将Y存入X中
; add X, Y 计算X + Y并将结果存入X中
; sub X, Y 计算X - Y并将结果存入X中
; sal X, Y 将X左移Y位
; int 21H 执行系统命令
DATA SEGMENT
A	DB	25	
B	DB	43	
C	DB	76 	
Y	DB	? 	
DATA	ENDS

STACK1 	SEGMENT	PARA STACK
		DW 20H	DUP(0)
STACK1	ENDS

COSEG	SEGMENT
		ASSUME  CS:COSEG,DS:DATA,SS:STACK1
START:	MOV AX , DATA	
		MOV DS , AX
		MOV AL , A		;存入A
		ADD AL , B		;计算(A+B)
		SAL	AL , 1		;计算 2(A+B)
		SUB	AL , C		;计算 2(A+B)-C
		MOV	Y , AL		;将结果存入Y中
		MOV	AH,4CH	    ;结束程序
		INT	21H
COSEG	ENDS
		END	START
