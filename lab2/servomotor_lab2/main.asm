;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;//problem statement:Run the servo motor using assembly code as in Lab 1
//resources required:msp430,registers P1DIR and P1OUT,register R15,R14 and R13 for counters.pin P1.0 as output,vcc and gnd to power the motor.
//calculations same as lab 1.
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
          			mov.b #0x01,&P1DIR//set direction of p1.0 as output
inc_pwm   			mov.w #334,R15//set value corresponding to 1ms in register R15 to increment pwm
increment_pwm		inc.b R15//increment R15(outer for loop)
high_delay_inc  	mov.b #0x01,&P1OUT//set value of output to high(for incrementing on period)
					mov.b R15,R14//move current value of R15 to R14(for nested for loop)
decrement_high_inc	dec.b R14//decrement R14
           			jnz decrement_high_inc//if not zero jump to label decrement_high_inc
low_delay_inc 		mov.b #0x00,&P1OUT//set value of output to low(for decrementing off period)
          			mov.b R15,R13//move value of R15 to R13
         			sub.b #6670,R13//subtract R13 corresponding to on time from time corresponding to total time to get off time.
          			mov.b R13,R14//move the above value to R14
decrement_low_inc 	dec.b R14//decrement value of R14
          			jnz decrement_low_inc//if not zero jump to label decrement_low_inc.
        			cmp.b #667,R15//compare R15 value to time corresponding to 2ms to move to next iteration of outer for loop.
          			jne increment_pwm//if not equal jump to label increment_pwm

dec_pwm 			mov.b #667,R15//set value corresponding to 2ms in register R15 to decrement pwm
decrement_pwm 		dec.b R15//decrement R15(outer for loop)
high_delay_dec 		mov.b #0x01,&P1OUT//set value of output to high(for deccrementing on period)
           			mov.b R15,R14//move current value of R15 to R14(for nested for loop)
decrement_high_dec  dec.b R14//decrement R14
          			jnz decrement_high_dec//if not zero jump to label decrement_high_dec
low_delay_dec 		mov.b #0x00,&P1OUT//set value of output to low(for incrementing off period)
         			mov.b R15,R13//move value of R15 to R13
         			sub.b #6670,R13//subtract R13 corresponding to on time from time corresponding to total time to get off time.
          			mov.b R13,R14//move the above value to R14
decrement_low_dec 	dec.b R14//decrement value of R14
          			jnz decrement_low_dec//if not zero jump to label decrement_low_dec.
          			cmp.b #334,R15//compare R15 value to time corresponding to 1ms to move to next iteration of outer for loop.
          			jnz decrement_pwm//if not zero jump to label decrement_pwm.
          			jmp inc_pwm//repeat the whole sequence by jumping to label inc_pwm










                                            

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
            
