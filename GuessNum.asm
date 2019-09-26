include Irvine32.inc
.data
welcome BYTE "Welcome to my game! It is so cool.", 0
think BYTE "Think of a number between 1 and 100", 0

guess DWORD ?
lowest DWORD 0
highest DWORD 100
guesssum DWORD 0

tries DWORD 0
guessIs BYTE "My guess is: ", 0
response BYTE 10 DUP(0)
directions BYTE "(yes) or no (too high / too low): ", 0
success BYTE "YAYYYY. I did it!", 0
yesStr BYTE "yes", 0
tooHighStr BYTE "too high", 0
tooLowStr BYTE "too low",0

triesStr BYTE "It only took ", 0
triesStr2 BYTE " tries.", 0

.code
main proc
	
	mov edx, OFFSET welcome
	call WriteString
	call Crlf

	mov edx, OFFSET think
	call WriteString
	call Crlf

	;initial guess
	mov eax, lowest
	add guesssum, eax
	mov eax, highest
	add guesssum, eax
	mov eax, guesssum
	
	xor edx,edx ;set edx to zero
	mov ebx, 2
	div ebx ;quotient is in eax, remainder is in edx
	mov guess, eax

TELLGUESS:
	inc tries
	mov edx, OFFSET guessIs
	call WriteString

	mov eax, guess
	call WriteInt
	call Crlf

	mov edx, OFFSET directions
	call WriteString
	
	mov edx, OFFSET response
	mov ecx, 9
	call ReadString

	INVOKE Str_compare, ADDR response, ADDR yesStr
	je YES

	INVOKE Str_compare, ADDR response, ADDR tooLowStr
	je TOOLOW

	INVOKE Str_compare, ADDR response, ADDR tooHighStr
	je TOOHIGH

TOOLOW:
	;adjust range
	mov eax, guess
	mov lowest, eax


	mov guesssum, 0
	mov eax, lowest
	add guesssum, eax
	mov eax, highest
	add guesssum, eax
	mov eax, guesssum
	
	xor edx,edx ;set edx to zero
	mov ebx, 2
	div ebx ;quotient is in eax, remainder is in edx

	;pick something inside the range
	mov guess, eax

	jmp TELLGUESS

TOOHIGH:
	;adjust range
	mov eax, guess
	mov highest, eax


	mov guesssum, 0
	mov eax, lowest
	add guesssum, eax
	mov eax, highest
	add guesssum, eax
	mov eax, guesssum
	
	xor edx,edx ;set edx to zero
	mov ebx, 2
	div ebx ;quotient is in eax, remainder is in edx

	;pick something inside the range
	mov guess, eax


	jmp TELLGUESS

YES:
	mov edx, OFFSET success
	call WriteString

	call Crlf

	mov edx, OFFSET triesStr
	call WriteString

	mov eax, tries
	call WriteInt

	mov edx, OFFSET triesStr2
	call WriteString

	call Crlf
	invoke ExitProcess,0
main endp
end main