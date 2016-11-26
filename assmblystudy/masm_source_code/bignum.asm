;练习adc指令，大数据加法
assume cs:code, ds:data, ss:stack

data segment
		dw 2233H, 4455H, 6677H, 8899H, 0099H
		dw 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFH, 0H 
		dw 5 dup (0)	
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
					mov ds, ax
					
					call add_big_number
					
					mov ax, 4C00H
					int 21H


add_big_number:
					push di	
					push si	
					push cx

					mov cx, 5
					mov di, 0
					mov si, 0
					sub si, di		;清空cf为0

			add_number:
					mov ax, [si]
					adc ax, [si+10] 
					mov [si+20], ax
					inc si			;inc不会影响 标志寄存器，add可能会影响标志寄存器
					inc si
					inc di
					inc di
					loop add_number

					pop cx
					pop si
					pop di

					ret

code ends
end start 
