;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
/*problem statement:Explain what happens when the following instructions are executed on the MSP430. Any illegal
instructions can be considered as comments, and you have to proceed as if they were not present as
instructions.
resources required:msp430 in debug mode*/
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
	mov.w #0x12e4,R15//moves the value 12e4 to R15;immediate addressing mode;PC=C00A(points to next instruction);SP=0x0400
	mov.w #0x7C02,R14//moves the value 7C02 to R14;immidiate mode;PC=C00E
	add R14,R15//adds the values in values in register R14 and R15 and stores it in R15;R15=8EE6;PC=0xC012
	sub #0x02, R10//subtracts the constant value 0x02 from register R10 and stores it in R10;PC=0xC014
	;sub R10, #0x02//illegal as destination cannot be a constant value
	mov.b #0x3A, R15//moves the value 3A in register R15, so R15 value changes from 8ee6 to 003A;PC=0xC014
	;mov.w R8, #0x1000//illegal as destination cannot be a constant value
	mov 2(R15),6(R14)//move value that's in memory location (adress contained R15+2)(from 003C)to value that's in memory location (adress contained R14+6);indirect mode;PC=0xC016
	mov #0x4444, R11//moves the value 4444 to R11;immidiate mode;Pc=0xC01A
	mov.b R15,R11//moves value contained in register R15 to R11;register mode;R11=0x003A(byte operation);Pc=)xC020
	mov R15,R12//moves value in R15 to R12;register mode;R12=0x003A;pc=0xC026
	mov &0x2222,&0x3333//moves value in memory location 2222 to memory location 3333;absolute mode;pc=0xC028
    mov 0x2222,0x3333//moves contents of 2222-Pc(2222-c032) to location 3333-pc(3333-c032)
	mov @R12,0(R14)//moves contents at address in register R12 to the address in R14
	mov 0(R14),@R12//moves contents at address in register R14 to the address in R12
	mov R14,R10//moves contents of register R14 to registor R10
	mov R14,R11//moves contents of register R14 to registor R11
	mov @R10+,0(R11)//rest shown in picture attached in the folder
	mov @R10, @(R11)
	cmp R11,R10
	cmp #0x6789,R14
	cmp R14, #0x6789
	and R10,R11
	rrc R15
	rra R15
	push R15
	pop R14

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
