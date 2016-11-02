assume cs:code
code segment
	db "Welcome to masm!"
	db "................"
	start:
				mov cx, 10H
				mov si, 0H
				mov ax, 0B800H
				mov ds, ax
				mov bx, 0
copyString: 
				mov al, cs:[si]
				mov [bx+100H], al		;拷贝字符串
				inc si
				inc bx
				mov al, 2
				mov [bx+100H], al		;设置字符串的前景色
				inc bx
				loop copyString
				
				mov ax, 4c00H
				int 21H
code ends
end start