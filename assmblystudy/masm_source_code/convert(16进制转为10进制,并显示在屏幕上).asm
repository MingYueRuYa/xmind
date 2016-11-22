;将数字转为字符串形式，并显示在屏幕上
assume cs:code, ds:data, ss:stack

data segment
		dw 1234,  65535, 6789, 0
data ends

stack segment stack
		db 256 dup (0)
stack ends

code segment
		start:
					mov ax, data
					mov ds, ax
					
					mov ax, stack
					mov ss, ax
					mov sp, 256
					
					mov ax, 0B800H
					mov es, ax
					
					
					call convert_function
					mov ax, 4C00H
					int 21H
			
			convert_function:
					push si
					push di
					push dx
					push cx
					push bx
					
					mov cx, 4
					mov si, 0
					mov di, 10*160+80
			numcount:	
					push cx
					push di
					mov dx, 0
					mov ax, [si]
					mov bx, 10
					
				loop_div_over:
					mov dx, 0
					div bx
					mov cx, dx	;保存余数
					jcxz div_over
					add dx, 30H
					mov es:[di], dx
					mov byte ptr es:[di+1 ], 2
					sub di, 2
					jmp loop_div_over
					
				div_over:
					pop di
					pop cx
					add si, 2
					add di, 160
					loop numcount
				
					pop bx
					pop cx
					pop dx
					pop di
					pop si
					ret
					
code ends
end start 