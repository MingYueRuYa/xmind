;大写转为小写，小写转为大写
assume cs:code, ds:data

data segment
		db	'UNIXE'
		db	'linux'
data ends

code segment
	start:
				mov ax, data
				mov ds, ax
				
				mov cx, 5
loopout:	
				mov dl, [bx]
				or dl, 00100000B
				mov [bx], dl
				
				mov dl, [bx+5]
				and dl, 11011111B
				mov [bx+5], dl
				inc bx
				loop loopout
				
				mov ax, 4c00H
				int 21H
code ends
end start
