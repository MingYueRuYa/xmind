;调用子例程
assume cs:code, ds:data, ss:stack

data segment
		db 128 dup (0)
data ends

stack segment stack
		db 256 dup (0)
stack ends

code segment
		start:
					mov ax, stack
					mov ss, ax
					mov sp, 256
					
					
					mov ax, 4C00H
					int 21H

code ends
end start 