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
					mov si, 0			;数据段基址
					mov di, 0			;表格基址
					mov dx, 0
					mov bx, 0
					
		insertToTable:
					;保存year
					mov ax, [si]
					mov es:[di], ax
					mov ax, [si+2]
					mov es:[di+2], ax
					
					;保存收入
					mov ax, [si+84]
					mov es:[di][5], ax
					mov ax, [si+84+2]
					mov es:[di][7], ax
					
					;保存人数
					mov ax, [bx+84+84]
					mov es:[di][10], ax
					add bx, 2
					
					;平均工资
					mov ax, [si+84]
					mov dx, [si+84+2]
					div word ptr es:[di][10]
					mov es:[di][13], ax
					
					add si, 4
					add di, 10H
					
					loop insertToTable
					
					mov ax, 4C00H
					int 21H
code ends
end start