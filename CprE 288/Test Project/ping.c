/**
 * Driver for ping sensor
 * @file ping.c
 * @author
 */

#include "ping.h"
#include "Timer.h"
#include "lcd.h"

volatile unsigned long START_TIME = 0;
volatile unsigned long END_TIME = 0;
volatile enum{LOW, HIGH, DONE} STATE = LOW; // State of ping echo pulse

void ping_init (void){
    SYSCTL_RCGCGPIO_R |= 0x02;
    while((SYSCTL_RCGCGPIO_R & 0x02) ==0){};
    SYSCTL_RCGCTIMER_R |= 0x08;
    while((SYSCTL_PRTIMER_R & 0x08) == 0){};
    GPIO_PORTB_DEN_R |= 0x08;
    GPIO_PORTB_DIR_R |= ~0x08;
    GPIO_PORTB_AFSEL_R |= 0x08;
    GPIO_PORTB_PCTL_R = ( GPIO_PORTB_PCTL_R & 0x00007000) | 0x00007000;


    // Configure and enable the timer
    TIMER3_CTL_R &= ~0x100;
    TIMER3_CFG_R |= 0x00000004;
    TIMER3_TBMR_R |= 0x07;
    TIMER3_CTL_R |= 0xC00;
    TIMER3_TBPR_R |= 0xFF;
    TIMER3_TBILR_R |= 0xFFFF;
    TIMER3_IMR_R |= 0x400;
    TIMER3_ICR_R |= 0x400;
    //Nvic
    NVIC_EN1_R = 0x00000010;
    NVIC_PRI9_R = (NVIC_PRI9_R & 0xFFFFFF0F ) | 0x00000020;

    IntRegister(INT_TIMER3B, TIMER3B_Handler);

    IntMasterEnable();
    TIMER3_CTL_R |= 0x100;
}

void ping_trigger (void){
    STATE = LOW;
    // Disable timer and disable timer interrupt
    TIMER3_CTL_R &= ~0x100;
    TIMER3_IMR_R &= ~0x400;
    // Disable alternate function (disconnect timer from port pin)
    GPIO_PORTB_AFSEL_R &= ~0x08;
    GPIO_PORTB_DIR_R |= 0x08;

    GPIO_PORTB_DATA_R &= 0x07;
    timer_waitMicros(5);

    GPIO_PORTB_DATA_R |= 0x08;
    timer_waitMicros(5);

    GPIO_PORTB_DATA_R &= 0x07;
    GPIO_PORTB_DIR_R &= ~0x08;


    // Clear an interrupt that may have been erroneously triggered
    TIMER3_ICR_R |= 0x400;
    // Re-enable alternate function, timer interrupt, and timer
    GPIO_PORTB_AFSEL_R |= 0x08;
    TIMER3_IMR_R |= 0x400;
    TIMER3_CTL_R |= 0x100;
}

void TIMER3B_Handler(void){
    if(TIMER3_MIS_R & 0x400){
        TIMER3_ICR_R |= 0x400;
        if(STATE == LOW){
            START_TIME = TIMER3_TBR_R;
            STATE = HIGH;
        }
        else if (STATE == HIGH) {
            END_TIME = TIMER3_TBR_R;
            STATE = DONE;
        }
    }
}

float ping_getDistance (void){
    char result [100];
    ping_trigger();
    while(STATE != DONE){};
    int flow = (START_TIME < END_TIME);
    float temp;
    if(flow == 1){
        temp = (((unsigned long) 0xFFFFFF) - END_TIME) + START_TIME;
        temp /= 16000000;
        temp = (temp*343)*50;
        sprintf(result, "%f\n",temp);
        lcd_printf(result);
      //  temp = (temp*343)*50;
    } else {
        temp = START_TIME - END_TIME;
        temp /= 16000000;
        temp = (temp*343)*50;
        sprintf(result, "%f\n",temp);
        lcd_printf(result);
       // temp = (temp*343)*50;
    }
    return temp;
}
