;����������
;dh��ʾ�кţ�dl��ʾ�к�
;cl��ʾ��ɫ��ds:siָ���ַ������׵�ַ,�ַ���0����
assume cs:code, ds:data, ss:stack

data segment
		db 'Welcome to masm!', 0
data ends

stack segment stack
		db 256 dup (0)
stack ends

code segment
		start:
				mov ax, data
				mov ds, ax

				mov ax, 0B800H
				mov es, ax

				mov si, 0
				mov di, 0

				mov dh, 12		;8��
				mov dl, 20 		;3��
				mov ch, 0
				mov cl, 2		;��ɫ

				call show_str
				
				mov ax, 4C00H
				int 21H

		show_str:
				call get_position
				;push register
				push ax
				push si
				push di
				push cx
				push bx
				push dx
		showStr:			
				mov bl, cl
				mov al, [si]
				mov es:[di], al	
				mov es:[di+1], cl
				mov cl, es:[di]
				jcxz Copy_Over
				add si, 1
				add di, 2
				mov cl, bl
				jmp showStr

		Copy_Over:
				;pop register
				pop dx
				pop bx
				pop cx
				pop di
				pop si
				pop ax
				ret

		;ע�����ַ������ã���Ϊ����޸���di �Ĵ����е�ֵ
		;TODO ���ַ���Ҫ����
		get_position:
				;push di
				push ax
				push bx
				push dx 	;��Ϊ16λ�ĳ˷� �Ḳ��dx value

				mov ax, 0
				mov al, dh
				mov bx, 160
				mul bx
				pop dx

				push ax
				mov al, dl
				mov bl, 2
				mul bl		;����8λ�˷���ʱ��ax��ȫ���Ե�װ����
				mov di, ax
				pop ax

				add di, ax

				pop bx
				pop ax
				;pop di
				ret

code ends
end start 
