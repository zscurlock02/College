/*
 * Driver for ping sensor
 * @file ping.c
 * @author Sullivan Fair / Aidan Gull
 */

#include "ping.h"
#include "Timer.h"

volatile unsigned long START_TIME = 0;
volatile unsigned long END_TIME = 0;
int count = 0;

volatile enum
{
    LOW, HIGH, DONE
} STATE = LOW; // State of ping echo pulse

void ping_init(void)
{
    SYSCTL_RCGCGPIO_R |= 0x02;
    while ((SYSCTL_PRGPIO_R & 0x02) == 0)
    {
    }

    // Configure and enable the timer
    SYSCTL_RCGCTIMER_R |= 0x08;
    while ((SYSCTL_RCGCTIMER_R & 0x08) == 0)
    {
    }
    GPIO_PORTB_DEN_R |= 0x08;
    GPIO_PORTB_AFSEL_R |= 0x08;
    GPIO_PORTB_PCTL_R = (GPIO_PORTB_PCTL_R & 0xFFFF0FFF) | 0x00007000;

    TIMER3_CTL_R &= ~0x100;
    TIMER3_CFG_R = 0x4;
    TIMER3_TBMR_R |= 0x7;
    TIMER3_TBMR_R &= ~0x10;
    TIMER3_CTL_R |= 0xC00;
    TIMER3_TBPR_R = 0xFF;
    TIMER3_TBILR_R = 0xFFFF;
    TIMER3_IMR_R |= 0x400;
    TIMER3_ICR_R |= 0x400;
    TIMER3_CTL_R |= 0x100;
    NVIC_EN1_R |= 0x10;
    NVIC_PRI9_R = (NVIC_PRI9_R & 0xFFFFFF0F) | 0x20;

    IntRegister(INT_TIMER3B, TIMER3B_Handler);

    IntMasterEnable();
}

void ping_trigger(void)
{
    STATE = LOW;
    // Disable timer and disable timer interrupt
    TIMER3_CTL_R &= ~0x100;
    TIMER3_IMR_R &= ~0x400;
    // Disable alternate function (disconnect timer from port pin)
    GPIO_PORTB_AFSEL_R &= ~0x8;

    // YOUR CODE HERE FOR PING TRIGGER/START PULSE
    GPIO_PORTB_DIR_R |= 0x8;
    GPIO_PORTB_DATA_R |= 0x8;
    GPIO_PORTB_DATA_R &= ~0x8;
    timer_waitMicros(5);
    GPIO_PORTB_DATA_R |= 0x8;

    // Clear an interrupt that may have been erroneously triggered
    TIMER3_ICR_R |= 0x400;
    // Re-enable alternate function, timer interrupt, and timer
    GPIO_PORTB_AFSEL_R |= 0x8;
    TIMER3_IMR_R |= 0x400;
    TIMER3_CTL_R |= 0x100;

}

void TIMER3B_Handler(void)
{
    // As needed, go back to review your interrupt handler code for the UART lab.
    // What are the first lines of code in the ISR? Regardless of the device, interrupt handling
    // includes checking the source of the interrupt and clearing the interrupt status bit.
    // Checking the source: test the MIS bit in the MIS register (is the ISR executing
    // because the input capture event happened and interrupts were enabled for that event?
    // Clearing the interrupt: set the ICR bit (so that same event doesn't trigger another interrupt)
    // The rest of the code in the ISR depends on actions needed when the event happens.
    if ((TIMER3_MIS_R & 0x400))
    {
        TIMER3_ICR_R |= 0x400;
        if (STATE == LOW)
        {
            START_TIME = TIMER3_TBR_R;
            STATE = HIGH;
        }
        else if (STATE == HIGH)
        {
            END_TIME = TIMER3_TBR_R;
            STATE = DONE;
        }
    }
}

float ping_getDistance(void)
{      //343 m/s
    unsigned long timerDiff = 0;
    unsigned int overflow = 0;
    float distance = 0.0;
    ping_trigger();
    while (STATE != DONE)
    {
    }
    overflow = END_TIME > START_TIME;
    if (overflow)
    {
        count++;
    }
    timerDiff = (START_TIME - END_TIME) + ((unsigned long) overflow << 24);
    distance = timerDiff * 6.25e-8 * 343 * 100 / 2;
    return distance;
}
