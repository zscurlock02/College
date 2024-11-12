/*
 * adc.c
 *
 *  Created on: Mar 23, 2023
 *      Author: Connor Hand / Zachary Scurlock
 */

#include "adc.h"
#include "stdint.h"
#include "uart-interrupt.h"
#include <stdbool.h>

void adc_init(void)
{
    SYSCTL_RCGCADC_R |= 0x0001;
    SYSCTL_RCGCGPIO_R |= 0x02;
    while ((SYSCTL_PRGPIO_R & 0x02) != 0x02)
    {
    }
    GPIO_PORTB_DIR_R &= ~0x10;
    GPIO_PORTB_AFSEL_R |= 0x10;
    GPIO_PORTB_DEN_R &= ~0x10;
    GPIO_PORTB_AMSEL_R |= 0x10;
    ADC0_PC_R &= ~0xF;
    ADC0_PC_R |= 0x1;             // 8) configure for 125K samples/sec
    ADC0_SSPRI_R &= ~0x3333;        // 9) Sequencer 3 is highest priority
    ADC0_SSPRI_R |= 0x0123;
    ADC0_ACTSS_R &= ~0x0008;      // 10) disable sample sequencer 3
    ADC0_EMUX_R &= ~0xF000;       // 11) seq3 is software trigger
    ADC0_SSMUX3_R &= ~0x000F;
    ADC0_SSMUX3_R += 10;           // 12) set channel
    ADC0_SSCTL3_R = 0x0006;       // 13) no TS0 D0, yes IE0 END0
    ADC0_IM_R &= ~0x0008;         // 14) disable SS3 interrupts
    ADC0_ACTSS_R |= 0x0008;       // 15) enable sample sequencer 3
}

uint16_t adc_read(void)
{
    ADC0_PSSI_R = 0x0008;
    while ((ADC0_RIS_R & 0x08) == 0)
    {
    }
    uint16_t result = ADC0_SSFIFO3_R & 0xFFF;
    ADC0_ISC_R = 0x0008;
    return result;
}

double adc_getDistance()
{
    int adding;
    double result;
    double distCM;
    adding = 0;
    int i;
    for (i = 0; i < 16; ++i)
    {
        adding += adc_read();
        timer_waitMillis(10);
    }
    result = (double) adding / 16.0;

    distCM = 243 + (-0.298 * result) + (1.32 * 0.0001 * result * result)
            + (-1.97 * 0.00000001 * result * result * result);

    return distCM;
}
