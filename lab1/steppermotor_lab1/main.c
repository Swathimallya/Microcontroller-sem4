#include <msp430.h> 
//problem statement:Drive the stepper motor such that it emulates the �second� hand of a clock. It must complete one revolution in 60 seconds.The driver board has LEDs that will indicate if the output is high or low.
/*stepper motor has four coils to be energized. Each coil will rotate the motor by an angle of 90degrees.
 To rotate he motor by 360 degrees, we need to energize all the four coils one after the other.
 Thus, this code will use four output pins, driving one pin high at a time for the required delay.
 The ULn is used for current amplification as the board gives low current which is not enough to drive a motor.
 */
//resources required:ULN driver board,MSP, output pins P1.0,P1.1,P1.2,P1.3,registers P1IN and P1DIR
/*delay calculation:
 * from the datasheet,in one excitation it travels an angle of 5.625 and gear ratio is 64. So in one rotation, gear will by an angle of 5.625 and the motor rotates by an angle 1/64 of it.
 * so, 5.625*x/64=90 where x is the number of excitations per coil. x=1024. for one rpm 1024 pulses per coil in one minute.
 * So one excitation in 60/1024sec.
 * 1for loop=3clock cycles for 1Mhz 3/10^6sec
 * number of iterations =(1*10^6*60)/(3*1024)=19532 */


/**
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;// stop watchdog timer
	P1DIR|=0x0F;//set direction of first for pins in pin 1 as output(high value in register P1DIR means that the pin is set as an output.
	P1OUT=0x00;//initializing value of output as 0.
	volatile unsigned int i;//declare i as volatile(as it needs to be constantly updated for the loop)and unsigned integer.
	while(1){//while loop to repeat the sequence continuously.
	    P1OUT=0x01;//driving the first pin high and all others low.
	    for(i=19532;i>0;i--);//waiting for delay
	    P1OUT=0x02;//driving second pin high and all others back to low.
	    for(i=19532;i>0;i--);//waiting for the delay
	    P1OUT=0x04;//driving third pin high and all others back to low.
	    for(i=19532;i>0;i--);//waiting for the delay
	    P1OUT=0x08;//driving fourth pin high and all others back to low.
	    for(i=19532;i>0;i--);//waiting for the delay
	}
	return 0;
}
