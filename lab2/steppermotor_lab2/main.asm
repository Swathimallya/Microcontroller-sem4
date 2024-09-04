;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;//problem statement:Run the stepper motor using assembly code as in Lab 1.
//resources required:msp430,registers P1DIR,P1OUT,R15(for counter),ports P1.0,P1.1,P1.2,P1.3 as outputs to energize the coils,ul to amplify the current as current provided by the board to the motor won't be enough.
//calculations for delay (same as lab 1)
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
 	mov.b #0x0F,&P1DIR//set first four pins as output.
main mov.b #00000001b,&P1OUT//set output value as high for first coil.
	 call #delay//wait for the delay.
coil2 mov.b #00000010b,&P1OUT//set output value as high for second coil.
      call #delay//wait for the delay.

coil3 mov.b #00000100b,&P1OUT//set output value as high for third coil.
	  call #delay//wait for the delay.
coil4 mov.b #00001000b,&P1OUT//set output value as high for fourth coil.
      call #delay//wait for the delay.

delay mov.w #19532, R15//for delay move integer value to register R15
reduce dec.w R15 //reduce value in register R15
	   jnz reduce//if value in R15 is not zero move to label reduce
	   ret//else return to the line after the delay was called.
	   jmp main//jump to first coil again

                                            

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
            
