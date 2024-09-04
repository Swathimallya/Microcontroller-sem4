#include <msp430.h>
//problem statement:the green led is continuously blinking,interval of 3 seconds,when push button is pressed the red led should turn on for five seconds and then turn off without disturbing green led(using polling).
//resouces required:msp430 board,inbuilt red and green leds and push button on board.

#include <stdio.h>

/**
 * main.c
 */
volatile long long i;
volatile long long j;
volatile long long x;
volatile long long y;
int red_on(x) // function to toggle red light and handle green light
{
    P1OUT ^= 0x40; // toggle red light
    for (j = 0; j < 5000; j++)
    {
        if ((3000 - j) == x) // first toggle for green light, within 3s of button press
        {
            P1OUT ^= 0x01;
            x = j + 3000; // set the next toggle time for green light
        }
        if (j > 3000 && j == x)
        {
            P1OUT ^= 0x01; // toggle green light
            x = 5000 - i; // set the next toggle time for green light
        }
    }
    P1OUT ^= 0x40; // toggle red light
    return x;     // return time left for green light
}

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;
    P1DIR |= 0x41;
    P1OUT = 0x01; // stop watchdog timer
    while (1)
    {

        P1OUT ^= 0x01; // toggle green light
        for (i = 0; i < 3000; i++)
        {

            if (((P1IN & BIT3) == 0)) // polling for button press
            {
                y = red_on(i); // call red light function, returning time left for green light
                i = y;
            }
        }
    }
}
#include <stdio.h>

/**
 * main.c
 */
volatile long long i;
volatile long long j;
volatile long long x;
volatile long long y;
int red_on(x) // function to toggle red light and handle green light
{
    P1OUT ^= 0x40; // toggle red light
    for (j = 0; j < 5000; j++)
    {
        if ((3000 - j) == x) // first toggle for green light, within 3s of button press
        {
            P1OUT ^= 0x01;
            x = j + 3000; // set the next toggle time for green light
        }
        if (j > 3000 && j == x)
        {
            P1OUT ^= 0x01; // toggle green light
            x = 5000 - i; // set the next toggle time for green light
        }
    }
    P1OUT ^= 0x40; // toggle red light
    return x;     // return time left for green light
}

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;
    P1DIR |= 0x41;
    P1OUT = 0x01; // stop watchdog timer
    while (1)
    {

        P1OUT ^= 0x01; // toggle green light
        for (i = 0; i < 3000; i++)
        {

            if (((P1IN & BIT3) == 0)) // polling for button press
            {
                y = red_on(i); // call red light function, returning time left for green light
                i = y;
            }
        }
    }
}
#include <stdio.h>

/**
 * main.c
 */
volatile long long i;
volatile long long j;
volatile long long x;
volatile long long y;
int red_on(x) // function to toggle red light and handle green light
{
    P1OUT ^= 0x40; // toggle red light
    for (j = 0; j < 5000; j++)
    {
        if ((3000 - j) == x) // first toggle for green light, within 3s of button press
        {
            P1OUT ^= 0x01;
            x = j + 3000; // set the next toggle time for green light
        }
        if (j > 3000 && j == x)
        {
            P1OUT ^= 0x01; // toggle green light
            x = 5000 - i; // set the next toggle time for green light
        }
    }
    P1OUT ^= 0x40; // toggle red light
    return x;     // return time left for green light
}

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;
    P1DIR |= 0x41;
    P1OUT = 0x01; // stop watchdog timer
    while (1)
    {

        P1OUT ^= 0x01; // toggle green light
        for (i = 0; i < 3000; i++)
        {

            if (((P1IN & BIT3) == 0)) // polling for button press
            {
                y = red_on(i); // call red light function, returning time left for green light
                i = y;
            }
        }
    }
}


/**
 * main.c
 */
volatile long long i;//declare volatile variables(as they are loop variables,need to be constantly changed)i,j,x,y,long long as large values required.
volatile long long j;
volatile long long x;
volatile long long y;
int red_on(x) // function to toggle red light and handle green light
{
    P1OUT ^= 0x40; // toggle red light
    for (j = 0; j < 5000; j++)
    {
        if ((3000 - j) == x) // first toggle for green light, within 3s of button press
        {
            P1OUT ^= 0x01;
            x = j + 3000; // set the next toggle time for green light
        }
        if (j > 3000 && j == x)
        {
            P1OUT ^= 0x01; // toggle green light
            x = 5000 - i; // set the next toggle time for green light
        }
    }
    P1OUT ^= 0x40; // toggle red light
    return x;     // return time left for green light
}

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD;
    P1DIR |= 0x41;
    P1OUT = 0x01; // stop watchdog timer
    while (1)
    {

        P1OUT ^= 0x01; // toggle green light
        for (i = 0; i < 3000; i++)
        {

            if (((P1IN & BIT3) == 0)) // polling for button press
            {
                y = red_on(i); // call red light function, returning time left for green light
                i = y;//update value of i if function called
            }
        }
    }
}
