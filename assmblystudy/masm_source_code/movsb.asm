;调用子例程
assume cs:code, ds:data, ss:stack

data segment
		db 'Welcome to assm!'
		db 16 dup (0)
data ends

stack segment stack
		db 256 dup (0)
stack ends

code segment
		start:
					mov ax, stack
					mov ss, ax
					mov sp, 256
					
					mov ax, data
					mov es, ax
					mov ds, ax
					mov si, 0
					mov di, 16
					
					mov cx, 16
					cld
					rep movsb

					mov ax, 4C00H
					int 21H

code ends
end start 
