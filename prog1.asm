TITLE Program Template     (template.asm)

; Author: Jessica Calnan
; Course / Project ID         CS271 Program 1        Date: 04/12/17
; Description: Write and test a MASM program to perform the following tasks:
; 1. Display your name and program title on the output screen.
; 2. Display instructions for the user.
; 3. Prompt the user to enter two numbers.
; 4. Calculate the sum, difference, product, (integer) quotient and remainder of the numbers.
; 5. Display a terminating message. 

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

header BYTE "Elemntary Arithmetic     by Jessica Calnan",0
do_this BYTE "Enter 2 numbers, and I'll show you the sum, difference,",0
do_this2 BYTE "product, quotient, and remainder.",0

get1 BYTE "Enter the first number, not equal to zero.",0
get2 BYTE "Enter the second number, not equal to zero.",0

plus BYTE " + ",0
minus BYTE " - ",0
multiply BYTE " x ",0
divide BYTE " / ",0
equal BYTE " = ",0
remainder BYTE " remainder ",0

num1 BYTE "Number1= ",0
num2 BYTE "Number2 = ",0

lastq1 BYTE "Impressed?",0
lastq2 BYTE "Bye!",0

first_num SDWORD ?
sec_num SDWORD ?

quot SDWORD ?
prod SDWORD ?
diff SDWORD ?
sum SDWORD ?
remain SDWORD ?
; (insert variable definitions here)

.code
main PROC

Introduction:
;	Prints directions to the screen.
	call Crlf
	mov  edx,OFFSET header
	call WriteString
	call Crlf
	call Crlf
	call Crlf
	
	mov  edx,OFFSET do_this
	call WriteString
	call Crlf
	mov  edx, OFFSET do_this2
	call WriteString
	call Crlf
	call Crlf
	
Input1:

;	Gets input for the operations.
	call Crlf
	mov  edx,OFFSET get1
	call WriteString
	call Crlf
	mov edx,OFFSET num1
	call WriteString
	call ReadInt
	cmp  eax,0
	JE Input1
	call Crlf
	mov first_num,eax

Input2:

;	Input1	repeated
	mov  edx,OFFSET get2
	call WriteString
	call Crlf
	mov edx,OFFSET num2
	call WriteString
	call ReadInt
	cmp  eax,0
	JE Input2
	call Crlf
	mov sec_num,eax
	call Crlf
	call Crlf
	
Calculate:
;	Performs the required arithmetic.

	mov  eax,first_num
	mov  ebx,sec_num
	imul ebx
	mov  prod,eax ;following multiplication of first_num and sec_num, stores the result as product value.
	
	mov  eax,first_num
	mov  edx,0
	mov  ebx,sec_num
	cdq
	idiv ebx
	mov  quot,eax   ;stores quotient as quot variable.
	mov  remain,edx ;following division of first_num by sec_num, stores remainder as remain value,
	
	mov  eax,first_num
	add  eax,sec_num
	mov  sum,eax        ;following addition of sec_num to first_num, stores result as sum value.
	
	mov  eax,first_num
	sub  eax,sec_num
	mov  diff,eax      ;following subtraction of sec_numb from first_num, stores result as diff value.
	
Results:

;	Addition output
	mov  eax,first_num
	call WriteInt
	mov  edx,OFFSET plus
	call WriteString
	mov  eax,sec_num
	call WriteInt
	mov  edx,OFFSET equal
	call WriteString
	mov  eax,sum
	call WriteInt
	call Crlf
	
;	Subtraction output
	mov  eax,first_num
	call WriteInt
	mov  edx,OFFSET minus
	call WriteString
	mov  eax,sec_num
	call WriteInt
	mov  edx,OFFSET equal
	call WriteString
	mov  eax,diff
	call WriteInt
	call Crlf
	
;	Multiplication output
	mov  eax,first_num
	call WriteInt
	mov  edx,OFFSET multiply
	call WriteString
	mov  eax,sec_num
	call WriteInt
	mov  edx,OFFSET equal
	call WriteString
	mov  eax,prod
	call WriteInt
	call Crlf
	
;	Division output
	mov  eax,first_num
	call WriteInt
	mov  edx,OFFSET divide
	call WriteString
	mov  eax,sec_num
	call WriteInt
	mov  edx,OFFSET equal
	call WriteString
	mov  eax,quot
	call WriteInt
	mov  edx,OFFSET remainder
	call WriteString
	mov  eax,remain
	call WriteInt
	call Crlf
	call Crlf
	call Crlf
	
SayGoodbye:

;	Prints goodbye message
	mov  edx,OFFSET lastq1
	call WriteString
	call Crlf
	mov  edx,OFFSET lastq2
	call WriteString
	call Crlf
	call Crlf
	
	
; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
