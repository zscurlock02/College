/*
 * checkpoints.c
 *
 *  Created on: Feb 2, 2023
 *      Author: scurlock
 */

#include "Timer.h"
#include "lcd.h"
#include "movement.h"
#include "open_interface.h"
#include "cyBot_uart.h"
#include "cyBot_Scan.h"

void printToPutty(char data[]);

//int main(void) {
//    oi_t *sensor_data = oi_alloc();
//    oi_init(sensor_data);
////    lcd_init();
//    cyBot_uart_init();
//
////    char c = (char)cyBot_getByte();
////    lcd_putc(c);
////    cyBot_sendByte(c);
////    char c = 'k';
////    while (c != 'f') {
////        c = (char)cyBot_getByte();
////        if (c == 'w') {
////            move_forward(sensor_data, 100);
////        }
////        if (c == 'a') {
////            turn_left(sensor_data, 90);
////        }
////        if (c == 's') {
////            move_backward(sensor_data, 100);          CHECKPOINT 1
////        }
////        if (c == 'd') {
////            turn_right(sensor_data, 90);
////        }
////    }
//
////    timer_init();
////    lcd_init();
////    cyBOT_init_Scan(0b0111);
////    cyBOT_SERVO_cal();
//
//    cyBOT_Scan_t getScan;
//    cyBOT_init_Scan(0b0011);
//
//    right_calibration_value = 243250;
//    left_calibration_value = 1225000;
//
////    printToPutty("Degrees   PING Distance\n\r");
////    char data[50];
////    int i;
////    for (i = 0; i <= 180; i++) {
////        cyBOT_Scan(i, &getScan);
////        sprintf(data, "%d        %f\n\r", i, getScan.sound_dist);    // CHECKPOINT 2
////        printToPutty(data);
////    }
//
//    int i, j;
//    int initialAngle;
//    int finalAngle;
//    int degreeWidthSmallest = 1000000;
//    int degreeWidthCompare;
//    int smallestObjAngle;
//    double currentDist;
//    int counter;
//    int objNumber = 0;
//    int objAngle;
//    double smallestObjDist = 1000000;
//    double objDist;
//    char data[50];
//
//    for (i = 0; i <= 180; ++i) {
//        cyBOT_Scan(i, &getScan);
//        if (getScan.sound_dist < 50) {      //if the distance is less than 50 then it might be the start of the object
//            initialAngle = i;
//            currentDist = getScan.sound_dist;
//            if (i <= 175) {
//                counter = 0;
//                for (j = i; currentDist > getScan.sound_dist - 5 && currentDist < getScan.sound_dist + 5; ++j) {
//                    currentDist = getScan.sound_dist;       //count the degree width of the object as long as the next distances are within 5 degrees of previous
//                    cyBOT_Scan(j, &getScan);
//                    ++counter;
//                    if (counter == 5) {
//                        objDist = currentDist;
//                    }
//                }
//                i = i + counter;
//                finalAngle = j;
//                degreeWidthCompare = finalAngle - initialAngle;
//            }
//            if (degreeWidthCompare > 5) {       //if the object greater than 5 degrees wide
//                ++objNumber;
//                objAngle = (finalAngle - initialAngle) / 2 + initialAngle;
//                sprintf(data, "Object %d:\r\n", objNumber);
//                printToPutty(data);
//                sprintf(data, "Angle: %d\r\n", objAngle);
//                printToPutty(data);
//                sprintf(data, "Distance: %f\r\n", objDist);
//                printToPutty(data);
//                sprintf(data, "Radial Width: %d\r\n\n", degreeWidthCompare);
//                printToPutty(data);
//                if (degreeWidthCompare < degreeWidthSmallest) {
//                    degreeWidthSmallest = degreeWidthCompare;
//                    smallestObjAngle = (finalAngle - initialAngle) / 2 + initialAngle;
//                }
//                if (objDist < smallestObjDist) {
//                    smallestObjDist = objDist;
//                }
//            }
//        }
//    }
//    cyBOT_Scan(smallestObjAngle, &getScan);
//    if (smallestObjAngle > 90) {
//        turn_left(sensor_data, smallestObjAngle - 90);
//        move_forward(sensor_data, (smallestObjDist * 100) - 100);
//    }
//    else if (smallestObjAngle <= 90) {
//        turn_right(sensor_data, 90 - smallestObjAngle);
//        move_forward(sensor_data, (smallestObjDist * 100) - 100);
//    }
//
//    oi_free(sensor_data);
//    return 0;
//}
//
//void printToPutty(char data[]) {
//    int i;
//    for (i = 0; i < strlen(data); ++i) {
//        cyBot_sendByte(data[i]);
//    }
//}

