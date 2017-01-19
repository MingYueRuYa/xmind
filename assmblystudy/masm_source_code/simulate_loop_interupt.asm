;使用7C中断过程，模拟loop功能
assume cs:code,ds:data,ss:stack

data segment
	db	128 dup (0)
data ends

stack segment stack
	db	128 dup (0)
stack ends



code segment

	start:	
		mov ax,stack
		mov ss,ax
		mov sp,128

		call cpy_new_int7C
		call set_nwe_int7C

		mov cx, 80
		mov ax, 0B800H
		mov es, ax
		mov bx, OFFSET s -se
		mov di, 160*12
s:
		mov byte ptr es:[di],'!'
		add di,2
		int 7CH
se:
			
		mov ax,4C00H
		int 21H
		
;------------------------------------------------------				
set_nwe_int7C:
		mov ax, 0
		mov es, ax
		
		cli
		mov word ptr es:[7CH*4+2], 0
		mov word ptr es:[7CH*4], 07E00H
		sti
		
		ret
		
;------------------------------------------------------		
;调用中断的过程中，会进行pushf push cs push ip
new_int7C:
		push bp  			;此时栈中的内容为 bp ip cs flag
		mov bp, sp
		dec cx
		jcxz new_int_ret
		add ss:[bp+2], bx	; 拿到ip的值，在ip的值。bx中保存了相对位移
new_int_ret:
		pop bp
		iret
		
new_int7C_end:
		nop
;------------------------------------------------------
cpy_new_int7C:
		mov bx, 0
		mov es, bx
		mov di, 07E00H
		
		mov bx, cs
		mov ds, bx
		mov si, OFFSET new_int7C
		
		mov cx, OFFSET new_int7C_end - new_int7C
		cld
		rep movsb
		
		ret
;------------------------------------------------------

code ends

end start


