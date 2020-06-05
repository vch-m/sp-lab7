.586
.model flat, stdcall
option casemap :none
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\windows.inc
include module.inc
include longop.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
.const
.data

.data
Caption1 db "A+B 1",0
Caption3 db "A+B 2",0
Caption2 db "A-B",0

TextBuf1 db 576 dup(?)
TextBuf3 db 576 dup(?)
TextBuf2 db 544 dup(?)

ValueA1 dd 576 dup(?) 
ValueB1 dd 576 dup(?) 

ValueA3 dd 16h, 17h, 18h, 19h, 20h, 21h
ValueB3 dd 80000001h, 80000001h, 80000001h, 80000001h, 80000001h, 80000001h

ValueA2 dd 544 dup(0)
ValueB2 dd 16h, 17h, 18h, 19h, 20h, 21h, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh, 10h, 22h, 23h, 24h, 25h, 26h, 27h, 28h, 29h, 30h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh, 1Fh, 31h

Result1 dd 576 dup(0)
Result3 dd 576 dup(0)
Result2 dd 544 dup(0)  

.code
main:
	;A+B 1
	mov eax, 80000001h
	mov ecx, 18   ; ECX = потрібна кількість повторень
	mov edx, 0
cycleAB1:	
	mov DWord ptr[ValueA1+4*edx], eax
	mov DWord ptr[ValueB1+4*edx], 80000001h
	add eax, 10000h
	inc edx
	dec ecx        ; зменшуємо лічильник на 1 
	jnz cycleAB1

	push offset ValueA1
	push offset ValueB1
	push offset Result1
	call Add_576_LONGOP
	push offset TextBuf1 
	push offset Result1
	push 576
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf1, ADDR Caption1,0

	;A+B 2
	push offset ValueA3
	push offset ValueB3
	push offset Result3
	call Add_576_LONGOP
	push offset TextBuf3 
	push offset Result3
	push 576
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf3, ADDR Caption3,0

	;A-B 
	push offset ValueA2
	push offset ValueB2
	push offset Result2
	call Sub_544_LONGOP
	push offset TextBuf2 
	push offset Result2
	push 544
	call StrHex_MY 
	invoke MessageBoxA, 0, ADDR TextBuf2, ADDR Caption2,0


	invoke ExitProcess, 0
	end main
