#include <msp430.h>
//problem statement:blink the led at an interval of 0.1seconds. what will be the change if it has to be done for half a second?

//Resources requires:MSP430,pin P1.3 as LED; registers;P1DIR and P1OUT

/**
 * main.c
 */
void main(void)
{
    WDTCTL = WDTPW | WDTHOLD;// stop watchdog timer
    P1DIR|=0x01 //set P1.0 as output (bit 1 in register P1DIR== output; or with one will set it as one without disturbing other bits)
    P1OUT=0x00;// initialize output value as 0 using register P1OUT
    volatile unsigned int i;//declare variable i as volatile(as needs to be constantly updated in the for loop)and unsigned integer.
while(1){//while loop to repeat the sequence continuously.
        P1OUT^= 0x01; //toggle the LED and hold for the delay as specified by the for loop
        for(i=10000;i>0;i--);// board active mode so 1Mhz; toggle every 0.1sec delay =0.1*1Mega=10000 iterations;
        //for half a second 0.5*1Mega=50000 iterations

    }

