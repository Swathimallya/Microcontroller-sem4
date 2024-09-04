#include <msp430.h> 
//problem statement:Drive the servomotor such that it oscillates between the maximum angle and the minimum angle continuously, the time of one to and fro oscillation being 10 seconds. The movement must be smooth and there should not be any dwell period in between or at the end of the swing
/*servomotor needs to rotate from 0 to 180 with gradual increase of speed. From the datasheet, on period can vary from 1ms to 2ms.
 * therefore, for driving the motor, we need pwm of time period of 20ms,where on period varies from 1ms to 2ms*/
/**resources required:msp430, vcc and gnd port,pin 1.0,registers:P1DIR,P1OUT
 *calculations:total time period 20ms. 1 for loop iteration=3/10^6seconds. 2ms=(10^6/3)*(2*10^-3)seconds=667 for 1ms=334,20ms=6670.
 * main.c
 */
int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer
	P1DIR|=0x0f;
	P1OUT=0x00;
	volatile unsigned int i;
	volatile unsigned int j;
	while(1){
	    for(i=334;i<667;i++){ //loop for increasing the on period
	        P1OUT=0x01;//on period
	        for(j=i;j>0;j--);//wait time for on period,every iteration of the outer for loop the on period will be more.
	        P1OUT=0x00;//off period
	        for(j=6670-i;j>0;j++);//wait time for off period,every iteration of the outer for loop the off period will be less.
	        }//second for loop condition is total (20ms) minus on time.
	    for(i=667;i>334;i++){//loop for decreasing the on period
	        P1OUT=0x01;//on period
	        for(j=i;j>0;j--);//wait time for on period,every iteration of the outer for loop the on period will be less.
	        P1OUT=0x00;//off period
	        for(j=6670-i;j>0;j++);//wait time for off period,every iteration of the outer for loop the off period will be more.
	    }
	}
	
	return 0;
}
