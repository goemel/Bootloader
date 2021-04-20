bits 16 
org 0x7c00
boot:
	mov si,options
.loop:	
	call print
	jz getOption
	jmp .loop
halt:
	cli 
	hlt 

options:
	db "Heb je de OS opdrachten gemaakt",13,10
	db "1: Ja",13,10
	db "2: Nee",13,10
	db "3: Misschien",13,10,0

print:
	.loop:
		mov ah,0x0e
		lodsb
		int 0x10
		or al,0
		je .done
		jmp .loop
	.done:
		ret

printChar:
	mov bh,0
	mov ah, 0ah
	int 10H
	ret

getOption:
	mov ah,00h
	int 16H
	cmp al,49
	je printOptionJa
	cmp al,50
	je printOptionNee
	cmp al,51
	je printOptionMisschien
	ret

printOptionHawaii:
	mov si,optionJa
	call print
	call halt

printOptionSalami:
	mov si,optionNee
	call print	
	call halt

printOptionKipSpinazie:
	mov si,optionMisschien
	call print
	call halt

optionJa:
	db "",13,10
	db "Nerd",13,10,0

optionNee:
	db "",13,10	
	db "You fucked",13,10,0

optionMisschien:
	db "",13,10
	db "Politiek Correct",13,10,0

times 510 - ($-$$) db 0 
dw 0xaa55 
