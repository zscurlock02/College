/*
 * main.c
 *
 * Main function for the final project. It uses UART interrupts to complete specific tasks. I.e. 'W' corresponds to moving forward num * 10 centimeters.
 *
 *  Created on: Apr 20, 2023
 *      Author: Connor Hand
 */
#include "adc.h"
#include "button.h"
#include "lcd.h"
#include "movement.h"
#include "open_interface.h"
#include "ping.h"
#include "Timer.h"
#include "uart-interrupt.h"
#include "stdbool.h"
#include "servo.h"
#include "music.h"
#include "string.h"

void waitForNum();

int main () {
    adc_init();
    button_init();
    timer_init();
    lcd_init();
    ping_init();
    uart_interrupt_init();
    servo_init();

    oi_t *sensor_data = oi_alloc();
    oi_init(sensor_data);

//    while (command_flag != 9) {
////        oi_update(sensor_data);
////        lcd_printf("%d", sensor_data -> cliffFrontRightSignal);
//        double distance = ping_getDistance();
//        lcd_printf("%.2f", distance);
//        timer_waitMillis(300);
//    }
//    calibrate();

    oi_free(sensor_data);
    return 0;
}

/*
 * This function waits for the num variable to change from 0 to some other digit. Used when waiting
 * for the user to type in a digit. It also prints the number pressed on PuTTy.
 */
void waitForNum() {
    while (num == 0) {}
    uart_sendChar(num);
    uart_sendChar('\n');
    uart_sendChar('\r');
}
