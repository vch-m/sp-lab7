.586
.model flat, c
.code

Add_576_LONGOP proc
    push ebp
	mov ebp,esp

	mov esi, [ebp+16]				; ESI = адреса A
	mov ebx, [ebp+12]				; EBX = адреса B
	mov edi, [ebp+8]				; EDI = адреса результату

	mov ecx, 6						; ECX = потрібна кількість повторень
	mov edx, 0
	clc								; обнулює біт CF регістру EFLAGS
	cycle:
	mov eax, dword ptr[esi+4*edx]
	adc eax, dword ptr[ebx+4*edx]	; додавання групи з 32 бітів
	mov dword ptr[edi+4*edx], eax

	inc edx
	dec ecx							; лічильник зменшуємо на 1
	jnz cycle
	pop ebp
	ret 12
Add_576_LONGOP endp

Sub_544_LONGOP proc
    push ebp
	mov ebp,esp

	mov esi, [ebp+16]				; ESI = адреса A
	mov ebx, [ebp+12]				; EBX = адреса B
	mov edi, [ebp+8]				; EDI = адреса результату

	mov ecx, 29						; ECX = потрібна кількість повторень
	mov edx, 0
	clc								; обнулює біт CF регістру EFLAGS
	cycle:
	mov eax, dword ptr[esi+4*edx]
	sbb eax, dword ptr[ebx+4*edx]	; віднімання групи з 32 бітів
	mov dword ptr[edi+4*edx], eax

	inc edx
	dec ecx							; лічильник зменшуємо на 1
	jnz cycle
	pop ebp
	ret 12
Sub_544_LONGOP endp

End
