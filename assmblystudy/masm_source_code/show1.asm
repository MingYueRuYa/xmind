;调用子例程
;dh表示行号，dl表示列号
;cl表示颜色，ds:si指向字符串的首地址,字符串0结束
assume cs:code, ds:data, ss:stack

data segment
		db 'Welcome to masm!', 0
data ends

stack segment stack
		db 256 dup (0)
stack ends

code segment
		start:
				mov ax, data
				mov ds, ax

				mov ax, 0B800H
				mov es, ax

				mov si, 0
				mov di, 0

				mov dh, 12		;8行
				mov dl, 20 		;3列
				mov ch, 0
				mov cl, 2		;颜色

				call show_str
				
				mov ax, 4C00H
				int 21H

		show_str:
				call get_position
				;push register
				push ax
				push si
				push di
				push cx
				push bx
				push dx
		showStr:			
				mov bl, cl
				mov al, [si]
				mov es:[di], al	
				mov es:[di+1], cl
				mov cl, es:[di]
				jcxz Copy_Over
				add si, 1
				add di, 2
				mov cl, bl
				jmp showStr

		Copy_Over:
				;pop register
				pop dx
				pop bx
				pop cx
				pop di
				pop si
				pop ax
				ret

		;注意这种方法不好，因为最后修改了di 寄存器中的值
		;TODO 这种方法要完善
		get_position:
				;push di
				push ax
				push bx
				push dx 	;因为16位的乘法 会覆盖dx value

				mov ax, 0
				mov al, dh
				mov bx, 160
				mul bx
				pop dx

				push ax
				mov al, dl
				mov bl, 2
				mul bl		;进行8位乘法的时候，ax完全可以的装得下
				mov di, ax
				pop ax

				add di, ax

				pop bx
				pop ax
				;pop di
				ret

code ends
end start 
