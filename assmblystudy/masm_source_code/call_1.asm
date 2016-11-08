;练习使用call指令
;清屏 子程序
assume cs:code, ds:data, ss:stack

data segment
			db 'Welcome to masm!', 0
data ends

stack segment stack
stack ends

code segment
				start:
							
						call clearScreen
						call showString
;					loopInit:
;						jmp loopInit
						mov ax, 4C00H
						int 21H
;清屏 子程序
				clearScreen:
						push di
						push ax
						push es
						push cx
						
						mov cx, 2000
						mov di, 0
						mov ax, 0B800H
						mov es, ax
					clear_screen:
							mov es:[di], 0700H
							add di, 2
							loop clear_screen
						pop cx
						pop es
						pop ax
						pop di
						
						ret
						
				showString:
						push si
						push di
						push es
						push cx
				
						mov si, 0
						mov di, 0
						mov ax, 0B800H
						mov es, ax
						mov ax, data
						mov ds, ax
						mov ch, 0
						show_string:
								mov al, [si]
								mov es:[di+100H], al
								mov byte ptr es:[di+1+100H], 02
								mov cl,al
								jcxz Over
								inc si
								add di, 2
						jmp show_string
					Over:
						pop cx
						pop es
						pop di
						pop si
					
						ret
						
code ends
end start 