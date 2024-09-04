;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
/*problem statement:Read the status of built in push button - P1.3 (Note that P1.3 is "1" when the push button is open and "0" when the
button is closed) Red light if the button is not pushed - P1.0 Green light if the button is pushed*/
/*resources required:msp430,built in LEDs onP1.0 and P1.6,built in push buttons on pin P1.3,registers P1DIR,P1IN,P1IN,R15(for counter)*/
;
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

	     bis.b #01000001b,&P1DIR ; make P1.0 and P1.6 output all others are inputs by default
Mainloop bit.b #00001000b,&P1IN ; read switch at P1.3
         jc Off ; if P1.3 open branch to Off label
On       bic.b #00000001b,&P1OUT ; clear P1.0 (green off)
         bis.b #01000000b,&P1OUT ; set P1.6 ( red on)
         jmp Wait ; branch to a delay routine
Off      bis.b #00000001b,&P1OUT ; set P1.0 (green on)
         bic.b #01000000b,&P1OUT ; clear P1.6 (red off)
Wait     mov.w #1834,R15 ; load R15 with value for delay
L1       dec.w R15 ; decrement R15
         jnz L1 ; if R15 is not zero jump to L1
         jmp Mainloop ; jump to the Mainloop label
                                            

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
            
