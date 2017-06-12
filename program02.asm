TITLE Programming Assignment #2     (prog2.asm)

; Author: Jessica Calnan
; Course / Project ID: CS 271 Program #2             Date: 04/19/2017
; Description: A program to calculate Fibonacci numbers.
; This program will display the program title and programmer’s name. Then get the user’s name, and greet the user.
; It will prompt the user to enter the number of Fibonacci terms to be displayed. (An integer ranging from 1 to 46)
; The program will get and validate the user input (n).
; Then calculate and display all of the Fibonacci numbers up to and including the nth term.
; The result will be displayed 5 terms per line with at least 5 spaces between terms.
; It will display a parting message that includes the user’s name, and terminate the program.

INCLUDE Irvine32.inc

NAME_LENGTH = 24

; (insert constant definitions here)

.data

;string inputs
intro1	 	BYTE 	"Fibonacci Numers",0
intro2 		BYTE 	"Programmed by Jessica Calnan",0
q1		 	BYTE	"What's your name? ",0
q2  		BYTE 	"Hello, ",0 
get1	 	BYTE 	"Enter the number of Fibonacci terms to be displayed.",0
get2	 	BYTE 	"Give the number as an integer in the range [1 ... 46].",0
endInput	BYTE	"!",0 
fibNum	 	BYTE 	"How many Fibonacci terms do you want? ",0
error 		BYTE 	"Out of range. Enter a number in [1 ... 46]",0
certified 	BYTE 	"Results certified by Jessica Calnan",0
goodbye 	BYTE 	"Goodbye, ",0
userName 	BYTE 	NAME_LENGTH DUP(?)

;integer inputs
userNum 	DWORD 	?
fib1 		DWORD	0
fib2 		DWORD 	1


; (insert variable definitions here)

.code
main PROC

introduction:
; 	Writes the title and programmer's name, and the intent of the program.
	call 	Crlf
	mov 	edx, OFFSET intro1
	call 	WriteString
	call	Crlf
	mov 	edx, OFFSET intro2
	call 	WriteString
	call 	Crlf
	call 	Crlf
	
userInstruction:
;	Asks the user for his/her name, reads input, and displays the name.
;	Asks user to input a number (integer) within a certain range.
	mov 	edx, OFFSET q1
	call	WriteString
	mov 	edx, OFFSET userName
	mov 	ecx, NAME_LENGTH
	call 	ReadString
	call 	Crlf
	mov 	edx, OFFSET q2
	call 	WriteString
	mov		edx, OFFSET userName
	call 	WriteString
	mov 	edx, OFFSET endInput
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET get1
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET get2
	call 	WriteString
	call 	Crlf
	call 	Crlf
	
getUserData:
;	Gets integer the user inputs, checks if it's a number, and if in range. Reports error and asks for a new number, if not.
	mov 	edx, OFFSET fibNum
	call 	WriteString
	call 	ReadInt
	mov 	userNum, eax
	cmp 	userNum, 46
	jle 	inRange1
	jmp 	errorNum
	
inRange1:
;	Part of the getUserData section, if input is less than or equal to 46, goes to inRange2 section
	cmp 	userNum, 1
	jge 	inRange2
	jmp 	errorNum
	

inRange2:
;	If kicked here, the integer is <=46 and >=1, and will continue to complete Fibonacci sequence.
	jmp 	displayFibs

errorNum:
;	Displays an error message about range of integer, prompts user again for a number in range.
	mov 	edx, OFFSET error
	call 	WriteString
	call 	Crlf
	jmp 	getUserData

displayFibs:
;	; Calculates then displays all Fibonacci numbers up to and including the nth term. Results
; displayed 5 terms per line.
	mov 	eax, 1
	call 	WriteDec
	call 	Crlf
	dec 	userNum
	cmp 	userNum, 0
	je		farewell
	mov 	ecx, userNum
	
	
fibMath:
; Continuation of calculations with loop to check all satisfied
	mov 	eax, fib1
	mov 	ebx, fib2
	mov 	fib1, ebx
	add 	eax, ebx
	mov 	fib2, eax
	call 	WriteDec
	call	Crlf
	loop 	fibMath

	
farewell:
; 	Displays certification, user name, goodbye.
	call 	Crlf
	mov 	edx, OFFSET certified
	call 	WriteString
	call 	Crlf
	mov 	edx, OFFSET goodbye
	call 	WriteString
	mov 	edx, OFFSET userName
	call 	WriteString
	mov 	edx, OFFSET endInput
	call	WriteString
	call 	Crlf
	call 	Crlf
	
	

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
