;安装0号中断 0:200 - 0:3FF为安全地址 0:7E00H也是安全地址 0:B800为显卡地址
assume cs:code, ds:data, ss:stack

data segment
		db 'dived error!',  0
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
					
					call cpy_new_int0
					call set_new_int
					
					mov ax, 0
					mov dx, 1
					mov bx, 1
					div bx 
					
					mov ax, 4C00H
					int 21H
					
	set_new_int:
					mov bx, 0
					mov es, bx
					mov word ptr es:[0*4], 7E00H
					mov word ptr es:[0*4+2], 0
					ret
	new_int0:		jmp newInt0
		string:		db 'divide error!!!', 0
	
	newInt0:		mov bx, 0B800H
						mov es, bx
						
						mov bx, 0
						mov ds, bx
						
						mov di, 160*10+30*2
						mov si, 7E00H+OFFSET string-new_int0
						
	showString:	mov dl, ds:[si]
						cmp dl, 0
						je showStringRet
						mov es:[di], dl
						add di, 2
						inc si
						jmp showString
	showStringRet:	mov ax, 4C00H
							int 21H
						
	new_init0_end: nop
					
	cpy_new_int0:
						mov bx, cs
						mov ds, bx
						mov si, OFFSET new_int0
						
						mov bx, 0
						mov es, bx
						mov di, 7E00H
						
						mov cx, OFFSET new_init0_end -new_int0
						cld
						rep movsb
						
					ret
					
code ends
end start 