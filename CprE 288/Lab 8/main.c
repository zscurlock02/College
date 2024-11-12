

/**
 * main.c
 */
#include "adc.h"
#include "stdint.h"
#include <stdbool.h>
#include "Timer.h"
#include "lcd.h"
#include "uart.h"

int main(void) {
    adc_init();
    timer_init();
    lcd_init();
    int adding;
    double result;
    double distCM;
    while (1) {
        adding = 0;
        int i;
        for (i = 0; i < 16; ++i) {
            adding += adc_read();
            timer_waitMillis(10);
        }
        result = (double)adding / 16.0;

        distCM = 243 + (-0.298 * result) + (1.32 * 0.0001 * result * result) + (-1.97 * 0.00000001 * result * result * result);
        lcd_printf("%.2f, %.2f", result, distCM);
        //timer_waitMillis(1000);
    }

}
