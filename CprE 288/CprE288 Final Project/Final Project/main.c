/*
 * main.c
 *
 * Main function for the final project. It uses UART interrupts to complete specific tasks. I.e. 'W' corresponds to moving forward num * 10 centimeters.
 *
 *  Created on: Apr 20, 2023
 *      Author: Team 10D
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
void sendData(double distData[], int degData[], int length);

int main () {
    timer_init();
    lcd_init();
    uart_interrupt_init();
    servo_init();
    adc_init();
    ping_init();

    oi_t *sensor_data = oi_alloc();
    oi_init(sensor_data);

    bool notDone = true;
    double distancemm;
    char c;
    char message[50];
    double angleDeg;
    int startScan;
    int endScan;
    int i;
    double distance;
    char lineOfData[50];
    int angle;
    int firstNum;
    double distData[100];
    int degData[100];
    int index;
    int length;

    while (notDone) {
        if (command_flag == 1) {    //Corresponds to 'W', after hitting 'W' hit a digit (num) and the bot will move forward num * 10 centimeters.
            waitForNum();
            distancemm = ((double)num) * 100.0;
            c = move_forward(sensor_data, distancemm);

            if (c == 's') {
                sprintf(message, "Successx");   //The x after each message is for the GUI. MatLAB reads input for each message until it hits an x
                uart_sendStr(message);          //in which case, the message is done and it is printed to the GUI.
            }
            num = 0;
        }

        if (command_flag == 2) {    //Corresponds to 'w', only moves forward the digit you entered in centimeters.
            waitForNum();
            distancemm = ((double)num) * 10.0;
            c = move_forward(sensor_data, distancemm);
            if (c == 's') {
                sprintf(message, "Successx");
                uart_sendStr(message);
            }
            num = 0;
        }

        if (command_flag == 3) {    //Corresponds to 'S', moves back num * 10 centimeters.
            waitForNum();
            distancemm = ((double)num) * 100.0;
            move_backward(sensor_data, distancemm);
            num = 0;
        }

        if (command_flag == 4) {    //Corresponds to 's', moves back num centimeters.
            waitForNum();
            distancemm = ((double)num) * 10.0;
            move_backward(sensor_data, distancemm);
            num = 0;
        }

        if (command_flag == 5) {    //Corresponds to 'A', turns left num * 10 degrees.
            waitForNum();
            angleDeg = ((double)num) * 10.0;
            turn_left(sensor_data, angleDeg);
            num = 0;
        }

        if (command_flag == 6) {    //Corresponds to 'a', turns left num degrees.
            waitForNum();
            angleDeg = ((double)num);
            turn_left(sensor_data, angleDeg);
            num = 0;
        }

        if (command_flag == 7) {    //Corresponds to 'D', turns right num * 10 degrees.
            waitForNum();
            angleDeg = ((double)num) * 10.0;
            turn_right(sensor_data, angleDeg);
            num = 0;
        }

        if (command_flag == 8) {    //Corresponds to 'd', turns right num degrees.
            waitForNum();
            angleDeg = ((double)num);
            turn_right(sensor_data, angleDeg);
            num = 0;
        }

        if (command_flag == 9) {    //Corresponds to 'p', ends the program.
            notDone = false;
            play_song(2);
        }

        if (command_flag == 10) {   //Corresponds to 'f', starts a scan.
            waitForNum();   //num = 1 scans from 10-170 degrees, num = 2 scans from 20-160 degrees, etc.
            startScan = num * 10;
            endScan = 180 - startScan;
            i = startScan;
            index = 0;
            servo_move(i);
            timer_waitMillis(250);
            for (i = startScan; i <= endScan; i += 2) {
                servo_move(i);
                distance = adc_getDistance();
                if (distance > 100) {
                    distance = 100;
                }
                distData[index] = distance;
                degData[index] = i;
                index++;
            }
            length = ((endScan - startScan) / 2) + 1;
            sendData(distData, degData, length);
            num = 0;
        }

        if (command_flag == 11) {   //Corresponds to 'j', plays first part of default dance.
            play_song(3);
            timer_waitMillis(5600);
            play_song(1);
        }

        if (command_flag == 13) {   //Corresponds to 'g', gets a distance at the angle of next two digits.
            while(num == 0) {}
            firstNum = num;
            c = (char)num;
            uart_sendChar(c);
            num = 0;
            waitForNum();
            angle = firstNum * 10 + num;
            servo_move(angle);
            timer_waitMillis(500);
            distance = ping_getDistance();
            sprintf(lineOfData, "Distance: %.1f\n\r", distance);
            uart_sendStr(lineOfData);
            uart_sendChar('x');
            num = 0;
        }

        if (command_flag == 14) {   //Corresponds to 'F', scans faster.
            waitForNum();   //num = 1 scans from 10-170 degrees, num = 2 scans from 20-160 degrees, etc.
            startScan = num * 10;
            endScan = 180 - startScan;
            i = startScan;
            index = 0;
            servo_move(i);
            timer_waitMillis(250);
            for (i = startScan; i <= endScan; i += 5) {
                servo_move(i);
                distance = adc_getDistance();
                if (distance > 100) {
                    distance = 100;
                }
                distData[index] = distance;
                degData[index] = i;
                index++;
            }
            length = ((endScan - startScan) / 2) + 1;
            sendData(distData, degData, length);
            num = 0;
        }

        command_flag = 0;
        while (command_flag == 0 && notDone) {}
    }

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

/*
 * This function sends scan data collected from the CyBot to the MatLab GUI.
 */
void sendData(double distData[], int degData[], int length) {
    int i;
    char data[100];

    for (i = 0; i < length; ++i) {
        sprintf(data, "%f", distData[i]);
        uart_sendStr(data);
        uart_sendChar('n');
    }

    uart_sendChar('x');

    for (i = 0; i < length; ++i) {
        sprintf(data, "%d", degData[i]);
        uart_sendStr(data);
        uart_sendChar('n');
    }

    uart_sendChar('x');
}
