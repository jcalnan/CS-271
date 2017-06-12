TITLE Program 4: Composite Numbers    (prog4.asm)

; Author: Jessica Calnan
; Course / Project ID  CS 271 Project #4               Date: 05/09/2017
; Description: This program introduces the programmer, the program itself and gives the user instructions.
;	The user will be asked to enter an integer, n, within the range [1, 400].  
;	The program will verify that n is in the appropriate range and will calculate and display composites.  If not in range, the program will ask for a new integer that is in range.
;	Upon calculation, the program will display all of the composite numbers up to and including the nth composite.  
;	The results will be displayed with 10 composites per line and at least 3 spaces between each number. 
;	The program will then say goodbye to the user.
;	**EC: Align the output columns 

INCLUDE Irvine32.inc

; upper limit defined as a constant
UPLIM	EQU	400
LOWLIM	EQU	1
COLUMNMAX	EQU	10

.data
programIntro	BYTE	"Composite Numbers", 13, 10
		BYTE	"*EC: Align the output columns", 0
instructions	BYTE	"Enter the number of composite numbers you would like "
		BYTE	"to see.", 10, 13
		BYTE	"I will accept orders for up to 400 composites.", 0
promptInt	BYTE	"Enter the number of composites to display "
		BYTE	"[1 ... 400]: ", 0
rangeError	BYTE	"Out of range. Try again.", 0
spaces		BYTE	"   ", 9, 0
exitMsg		BYTE	"Goodbye!", 0

inputInt	DWORD	?

; helper variables for isComposite
column		DWORD	?
curNum	DWORD	?
factorTry	DWORD	?
factorTryMax	DWORD	?

.code
main	PROC
	call	introduction
	call	getUserData	; validate will be called as part of getUserData
	call	showComposites ;isComposite will be called as part of showComposites
	call	farewell
	exit	; exit to OS
main	ENDP

; introduction - Displays an intro to the user. Introduces programmer and program itself

introduction	PROC
	; display program and programmer name
		mov	edx, OFFSET programIntro
		call	WriteString
		call	Crlf
		call	Crlf
	; display instructions
		mov	edx, OFFSET instructions
		call	WriteString
		call	Crlf
		call	Crlf

	ret
introduction	ENDP


; getUserData - Asks for a number from the user, from [1 ... 400]. Verifies
;	input is within range. Displays error message for
;	invalid integers.  If invalid response, repeats prompt until a valid number is given.

getUserData	PROC
	; prompt user
		mov	edx, OFFSET promptInt
		call	WriteString
		call	ReadInt
		mov	inputInt, eax
		call	validate

	ret
getUserData	ENDP

; validate - Verifies user input is within the range [1, 400].

validate	PROC
	; validate data
		mov	eax, inputInt
		cmp	eax, LOWLIM
		jl	displayError
		cmp	eax, UPLIM
		jg	displayError
		jmp	validated	; number passed test for 1 <= n <= 400

	; print error, call getUserData to ask for another number
	displayError:
		mov	edx, OFFSET rangeError
		call	WriteString
		call	Crlf
		call	getUserData

	validated:
		ret
validate	ENDP


; showComposites - Displays calculated composite numbers. Calls isComposite for calc of
;	composite numbers. Displays 10 composite numbers per row and at least 3 spaces between numbers. (EC: with aligned columns.)

showComposites	PROC
	; starts loop counter at inputInt
	; sets first composite number = 4
		mov	ecx, inputInt
		mov	curNum, 4
		mov	column, 1

	; decides next composite number to display
	calculateLoop:
		call	isComposite

	; display number with spaces after, and decides if new row is necessary
	printNum:
		mov	eax, curNum
		call	WriteDec
		mov	edx, OFFSET spaces
		call	WriteString
		inc	curNum
		cmp	column, COLUMNMAX
		jge	newRow
		inc	column
		jmp	continueLoop

	; skip to new line if necessary
	newRow:
		call	Crlf
		mov	column, 1

	continueLoop:
		loop	calculateLoop

	ret
showComposites	ENDP


; isComposite - Calculates next composite number to be printed, by dividing a
;	number x by 2, 3, ..., x - 1 until remainder of 0 is found, which shows
;	x is a composite number. If factoring reaches x - 1 w/o
;	remainder of 0, then x is incremented and process is repeated.

isComposite	PROC
	; set first integer to try factoring by 2, and set upper limit for
	;	integers to attempt factoring of curNum - 1
	resetFactoring:
		mov	eax, curNum
		dec	eax
		mov	factorTry, 2
		mov	factorTryMax, eax

	; tryFactoring - tries to factor curNum by the factorTry
	; 	If remainder is 0, then a composite is found 
	;	If not, then increments factorTry, checks if factorTry is
	;	greater than the factoring upper limit (curNum - 1), and attempts again
	;   if no factors are found (factorTry > factorTryMax), then increment
	; 	curNum and reset factoring
	tryFactoring:
		mov	eax, curNum
		cdq
		div	factorTry
		cmp	edx, 0
		je	compositeFound	; factorTry is a factor of curNum
		inc	factorTry
		mov	eax, factorTry
		cmp	eax, factorTryMax
		jle	tryFactoring	; attempt factoring again w/ new factor
		inc	curNum	; no factors found
		jmp	resetFactoring	; try new # to factor

	compositeFound:
		ret
isComposite	ENDP

;------------------------------------------------------------------------------
; farewell - Prints a goodbye message to user.

farewell	PROC
	; display farewell
		call	Crlf
		call	Crlf
		mov	edx, OFFSET exitMsg
		call	WriteString
		call	Crlf

	ret
farewell	ENDP

END	main