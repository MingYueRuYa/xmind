assume cs:code, ds:data, es:table, ss:stack

data segment
		;年份
		db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983', '1984'
		db '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', '1993', '1994'
		db '1995'
		
		;公司收入
		dd 16, 22, 382, 1356, 2390, 8000, 160000, 24486, 50065, 97479, 140417, 197514
		dd 245980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
		
		;公司人数
		dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
		dw 11542, 14430, 15257, 17800
data ends

table segment
		db 21 dup ('year summ ne ?? ')
table ends

stack segment stack
		dw 128 dup (0)
stack ends

code segment
		start:
					mov ax, data
					mov ds, ax
					
					mov ax, table
					mov es, ax
					
					mov ax, stack
					mov ss, ax
					mov sp, 128
					
					mov cx, 21
					mov si, 0
					mov di, 0
					mov dx, 0
					mov bx, 0
					
		loopout:
					push cx ; 保存外层循环的cx
					mov cx, 2
;------------------------保存year-----------------------------
		loopyear:
					mov ax, [si]
					mov es:[di], ax
					add si, 2
					add di, 2
					loop loopyear
;------------------------保存year-----------------------------
					inc di					;+1 向后面移动一位 留出空格的位置
					push si					;保存si偏移量
					
;------------------------保存收入-----------------------------
					mov cx, 2
					sub si, 4
		loopincome:
					mov ax, [si+84]
					mov es:[di], ax
					add di, 2
					add si, 2
					loop loopincome
;------------------------保存收入-----------------------------
					inc di
					
;------------------------保存人数-----------------------------
					mov ax, [bx+84+84]				;bx作为保存人数的偏移量地址register
					mov es:[di], ax
					add bx, 2
					add di, 2
;------------------------保存人数-----------------------------
					inc di
					
;------------------------计算平均工资-----------------------------
					push dx					;保存ax，dx中的值
					
					mov ax, [si+84-4] 		; 低位ax
					mov dx, [si+84-4+2]		; 高位dx
					div word ptr [bx+84+84-2]
					mov es:[di], ax
					
					pop dx
;------------------------计算平均工资-----------------------------
					
					pop si					;弹出si的偏移量
					
					pop cx
					add dx, 10H			;是为了记住di的值
					mov di, dx				;增加di的值
					loop loopout
					
					mov ax, 4C00H
					int 21H
code ends
end start