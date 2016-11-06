assume cs:code, ds:data

data segment
		db 'Welcome to masm!'
		db 00000010B	;绿色
		db 00100100B	;绿底红色
		db 01110001B	;白底蓝色
data ends

code segment
		start:
				mov ax, data
				mov ds, ax
				
				;显卡内存地址
				mov ax, 0B800H
				mov es, ax
				
				jmp showString

		programEnd:
				mov ax, 4C00H
				int 21H
				
		showString:
				mov si, 0
				mov di, 0
				mov dx, 0
				mov cx, 3
				mov bx, 0
		showMasm:
				push cx
				push di
				mov cx, 16
				mov si, 0
		loopString:
				mov dl, [si]
				mov dh, [bx+16]
				mov es:[di+64+160*11], dx
				add di, 2
				inc si
				loop loopString
				pop di
				pop cx
				add di, 160
				inc bx
				loop showMasm
				
				
				jmp programEnd
code ends
end start