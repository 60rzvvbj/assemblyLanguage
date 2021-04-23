; 入门
assume cs:p1
p1 SEGMENT                     
  info db 'Hello!','$'
start:
    mov ax , p1 
    mov ds , ax 
    mov dx , offset info
    mov ax, 0900h
    int 21h
    mov ax, 4c00h
    int 21h
p1 ENDS
end start