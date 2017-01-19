;利用中断将小写字母转换为大写字母
assume cs:code,ds:data,ss:stack

data segment
	db	'conversation', 0
data ends

stack segment stack
	db	128 dup (0)
stack ends

code segment

	start:	
		mov ax,stack
		mov ss,ax
		mov sp,128
		
		mov bx, data
		mov ds, bx

		call cpy_new_int7CH
		call set_new_int7C
		int 7CH

		mov ax,4C00H
		int 21H
		
;----------------------------------------------------
set_new_int7C:
		mov bx, 0
		mov es, bx
		
		cli
		mov word ptr  es:[7CH*4], 07E00H
		mov word ptr  es:[7CH*4+2], 0
		sti
		
		ret
;----------------------------------------------------

;----------------------------------------------------
new_int7CH:		
		mov bx, data
		mov ds, bx
		
		mov bx, 0B800H
		mov es, bx
		mov di, 160*10+30*2
		
		mov si, 0
				
capital:
		mov dl, ds:[si]
		cmp dl, 0
		je capitalRet
		mov es:[di], dl
		and dl, 11011111B
		mov es:[di].160, dl
		add di, 2
		inc si
		jmp capital
capitalRet:
		iret
		
new_int7CH_end:
		nop
;----------------------------------------------------

;----------------------------------------------------		
cpy_new_int7CH:
		mov bx, cs
		mov ds, bx
		mov si, OFFSET new_int7CH
		
		mov bx, 0
		mov es, bx
		mov di, 07E00H
		
		mov cx, OFFSET new_int7CH_end - new_int7CH
		cld
		rep movsb
		
		ret
;----------------------------------------------------
		
code ends
end start


