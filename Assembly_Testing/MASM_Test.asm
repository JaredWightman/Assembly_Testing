; TESTING OUT STANDARD FUNCTIONS IN ASSEMBLY
; JARED WIGHTMAN

.386	                                              ; TYPE OF PROCESSOR
.model flat, stdcall								  ; ACCESS TO 32-BIT INSTRUCTIONS/REGISTERS
.stack 4096											  ; RESERVES 4096 BYTES OF UNINITIALIZED STORAGE
ExitProcess proto,dwExitCode:dword					  ; EXIT FUNCTION PROTOTYPE

include irvine32.inc								  ; INCLUDES IRVINE LIBRARY, SO WE CAN DISPLAY AND GET DATA FROM THE CONSOLE


.data											      ; SECTION WHERE PRE-SET VARIABLES ARE INITIALIZED IN THE MEMORY

result dword ?										  ; VARIABLE CREATION, SIZE: DOUBLE-WORD (32 bits, 4 bytes), ASSIGNED ? (unknown)
num1 dword 2
num2 dword 6
num3 dword 1
num4 dword 3
expresult dword ?
x dword ?

msg1 db "Hello World!", 0							  ; STORING STRING AS DATABYTE WITH IMPLICIT LENGTH, ENDS WITH TERMINATOR (null)
msg2 db "Wassup!", 0
inp1 db 10 DUP (?)


.code												  ; SECTION WHERE CODE IS RUN

myFunc proc										      ; SETTING UP CUSTOM PROCEDURE (function)
	mov eax, 99d									  ; DOING STUFF IN PROCEDURE
	ret												  ; RETURN TO PREVIOUS SPOT IN CODE
myFunc endp										      ; CLOSING PROCEDURE


main proc											  ; MAIN PROCEDURE/FUNCTION

	; ADD/SUBTRACT
	mov eax, 3000h	                                  ; MOVES VALUE TO REGISTER EAX (General purpose register, initialized to hold 1 word/2 bytes of data, each hex digit is 4 bits)
	add eax, 101110b								  ; ADDS VALUE TO REGISTER
	sub eax, 31d									  ; SUBTRACTS VALUE FROM REGISTER
	mov result, eax 								  ; MOVES REGISTER VALUE TO VARIABLE IN MEMORY

	; EXPRESSION
	mov eax, num1									  ; EXPRESSION: (num1 + num2) - (num3 + num4)
	add eax, num2
	mov ebx, num3
	add ebx, num4
	sub eax, ebx
	mov expresult, eax

	; IF-STATEMENT
	mov eax, num1
	cmp eax, 2										  ; COMPARE EAX TO 2
	jne l1											  ; JUMP NOT EQUAL (goes straight to l1)
	mov x,1											  ; MOVES PAST IF JUMP ISN'T EXECUTED
	jmp l2											  ; JUMP (unconditional)
	l1: mov x, 2									  ; EXECUTE THIS THEN CONTINUE PAST
	l2: 

	; WHILE LOOP WITH INCREMENTOR (like FOR LOOP), WHILE num1 != num2, num1 += 1
	mov eax, num1
	mov ebx, num2

	top:											  ; TOP OF LOOP
	cmp eax, ebx									  ; COMPARE, CHECK LOOP CONDITION
	jae next										  ; JUMP ABOVE OR EQUAL (exits loop by going to "next:")
	inc eax											  ; INCREMENT EAX BY 1
	jmp top											  ; JUMP BACK TO TOP
	next:											  ; EXIT LOOP

	; CALLING A PROCESS
	call myFunc										  ; IMPLIMENTS FUNCTION MYFUNC, DECLARED ABOVE "main proc"

	; IRVINE LIBRARY I/O
	mov edx, offset msg1							  ; SETTING ADDRESS FOR "msg1" IN REGISTER EDX
	call writestring								  ; CALLING IRVINE LIBRARY FUNCTION FOR CONSOLE OUTPUT, GETS STRING FROM ADDRESS IN EDX 
	call Crlf										  ; OUTPUTS A NEW LINE
	mov edx, offset msg2
	call writestring
	call Crlf
	mov edx, offset inp1
	mov ecx, sizeof inp1							  ; SETS ADDRESS FOR LENGTH OF "inp1" IN REGISTER ECX
	call readstring									  ; CALLING IRVINE LIBRARY FUNCTION FOR CONSOLE INPUT, LOADS STRING INTO ADDRESS STORED IN EDX WITH MAX LENGTH OF ECX
	mov edx, offset inp1
	call writestring
	; END IRVINE LIBRARY I/O

	; STACK 
	mov eax, 69h
	push eax										  ; PUTS VALUE IN EAX ONTO THE STACK (stack is LIFO)
	pop ebx											  ; TAKES LAST VALUE OUT OF STACK, PUTS INTO EBX

	;mov edx, offset eax
	;call writestring
	call Crlf


	invoke ExitProcess, 0							  ; CALLS FUNCTION TO EXIT PROGRAM


main endp
end main