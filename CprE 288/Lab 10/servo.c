/*
 * servo.c
 *
 *  Created on: Apr 6, 2023
 *      Author: connor66
 */

#include "servo.h"
#include "Timer.h"
#include "lcd.h"

void servo_init(void) {

    SYSCTL_RCGCGPIO_R |= 0x02;
    while ((SYSCTL_PRGPIO_R & 0x02) == 0)
    {
    }

    SYSCTL_RCGCTIMER_R |= 0x02;
    while ((SYSCTL_RCGCTIMER_R & 0x02) == 0)
    {
    }

    GPIO_PORTB_DEN_R |= 0x20;
    GPIO_PORTB_AFSEL_R |= 0x20;
    GPIO_PORTB_PCTL_R = (GPIO_PORTB_PCTL_R & 0xFF0FFFFF) | 0x00700000;

    TIMER1_CTL_R &= ~0x100;
    TIMER1_CFG_R = 0x4;
    TIMER1_TBMR_R |= 0xA;
    TIMER1_TBMR_R &= ~0x4;
    TIMER1_CTL_R &= ~0x4000;
    TIMER1_TBILR_R = 0x4E200 & 0xFFFF;
    TIMER1_TBPR_R = 0x4E200 >> 16;
    TIMER1_CTL_R |= 0x100;
}

void servo_move(uint16_t degrees) {
    double mSeconds = (((double) degrees) / 180.0) + 1.0;
    double clockCycles = 16000000.0 * mSeconds / 1000.0;
    uint32_t matchValue = 320000 - ((uint16_t) clockCycles);
    TIMER1_TBMATCHR_R = matchValue & 0xFFFF;
    TIMER1_TBPMR_R = matchValue >> 16;
}
