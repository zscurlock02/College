#include "Timer.h"
#include "lcd.h"
#include "cyBot_Scan.h"
//#include "uart-interrupt.h"
#include <stdbool.h>
#include "driverlib/interrupt.h"
#include "movement.h"
#include "open_interface.h"
//#include "cyBot_uart.h"
#include "math.h"
#include "uart.h"
#include "stdbool.h"

void printToPutty(char data[]);

int main(void) {

    oi_t *sensor_data = oi_alloc();
    oi_init(sensor_data);
  //  cyBot_uart_init();
    uart_init();

    cyBOT_Scan_t getScan;
    cyBOT_init_Scan(0b0111);
    right_calibration_value = 243250;
    left_calibration_value = 1225000;

    char data[50];
    int i, j, initialAngle, finalAngle, angleWidth, centerAngle, smallestObjAngle;
    double avgIRValue, prevIRValue, avgDistance, linearWidth, smallestObjDist;
    double smallestLinearWidth = 100000000.0;

    for (i = 10; i <= 170; i += 2) {
        avgIRValue = 0;
        for (j = 0; j < 5; ++j) {
            cyBOT_Scan(i, &getScan);            //scan 5 times and get average
            avgIRValue += getScan.IR_raw_val;
        }
        avgIRValue /= 5;
//        sprintf(data, "%d IR Value: %f\r\n", i, avgIRValue);
//        printToPutty(data);
        if (prevIRValue + 70 < avgIRValue && i >= 1 && avgIRValue > 700 && avgIRValue < 2500) {        //if new value is at least 80 greater than last, its start of object
            initialAngle = i;
            i += 2;
            while(avgIRValue + 100 > prevIRValue && i <= 170) {  //while it's still an object
                prevIRValue = avgIRValue;
                avgIRValue = 0;
                for (j = 0; j < 5; ++j) {
                    cyBOT_Scan(i, &getScan);            //scan 5 times and get average
                    avgIRValue += getScan.IR_raw_val;
                }
                avgIRValue /= 5;
//                sprintf(data, "%d IR Value: %f\r\n", i, avgIRValue);
//                printToPutty(data);
                ++i;
            }
            finalAngle = i;
            if (i % 2 != 0) {       //if i isn't even anymore subtract 1
                --i;
            }
            angleWidth = finalAngle - initialAngle;
            centerAngle = (finalAngle + initialAngle) / 2;
            sprintf(data, "Object width: %d\r\n", angleWidth);
           // printToPutty(data);
            uart_sendStr(data);
            sprintf(data, "Object angle: %d\r\n", centerAngle);
           // printToPutty(data);
            uart_sendStr(data);
            avgDistance = 0;
            for (j = 0; j < 5; ++j) {
                cyBOT_Scan(initialAngle + 3, &getScan);      //change to initialAngle + 3, prev centerAngle
                avgDistance += getScan.sound_dist;
            }
            avgDistance /= 5;
            sprintf(data, "Object distance: %0.2f cm\r\n", avgDistance);
         //   printToPutty(data);
            uart_sendStr(data);
            linearWidth = 2.0 * M_PI * avgDistance * (((double)angleWidth) / 360.0);
            sprintf(data, "Linear width: %0.2f cm\r\n\n", linearWidth);
          //  printToPutty(data);
            uart_sendStr(data);
            if (linearWidth < smallestLinearWidth && linearWidth > 6 && linearWidth < 20) {
                smallestLinearWidth = linearWidth;
                smallestObjDist = avgDistance;
                smallestObjAngle = centerAngle;
            }
        }
        prevIRValue = avgIRValue;
    }
    bool rightSide;
    if (smallestObjAngle < 90) {
        turn_right(sensor_data, 90 - smallestObjAngle);
        rightSide = true;
    }
    else {
        turn_left(sensor_data, smallestObjAngle - 90);
        rightSide = false;
    }
    smallestObjDist *= 10;
    while (smallestObjDist > 300) {
        smallestObjDist -= move_forward(sensor_data, smallestObjDist - 299);
        if (sensor_data -> bumpRight == 1|| sensor_data -> bumpLeft == 1) {
            move_backward(sensor_data, 100);
            if (rightSide) {
                turn_right(sensor_data, 90 - (90 - smallestObjAngle));
                move_forward(sensor_data, 350);
                turn_left(sensor_data, 90);
            }
            else {
                turn_left(sensor_data, 90 - (smallestObjAngle - 90));
                move_forward(sensor_data, 350);
                turn_right(sensor_data, 90);
            }

            //////////////////////////////////////////////////////////////////////////////////////////////////////////
            for (i = 60; i <= 120; i += 4) {
                avgIRValue = 0;
                for (j = 0; j < 5; ++j) {
                    cyBOT_Scan(i, &getScan);            //scan 5 times and get average
                    avgIRValue += getScan.IR_raw_val;
                }
                avgIRValue /= 5;
        //        sprintf(data, "%d IR Value: %f\r\n", i, avgIRValue);
        //        printToPutty(data);
                if (prevIRValue + 70 < avgIRValue && i >= 1 && avgIRValue > 700 && avgIRValue < 2500) {        //if new value is at least 80 greater than last, its start of object
                    initialAngle = i;
                    i += 2;
                    while(avgIRValue + 100 > prevIRValue && i <= 170) {  //while it's still an object
                        prevIRValue = avgIRValue;
                        avgIRValue = 0;
                        for (j = 0; j < 5; ++j) {
                            cyBOT_Scan(i, &getScan);            //scan 5 times and get average
                            avgIRValue += getScan.IR_raw_val;
                        }
                        avgIRValue /= 5;
        //                sprintf(data, "%d IR Value: %f\r\n", i, avgIRValue);
        //                printToPutty(data);
                        ++i;
                    }
                    finalAngle = i;
                    if (i % 2 != 0) {       //if i isn't even anymore subtract 1
                        --i;
                    }
                    angleWidth = finalAngle - initialAngle;
                    centerAngle = (finalAngle + initialAngle) / 2;
                    sprintf(data, "Object width: %d\r\n", angleWidth);
                   // printToPutty(data);
                    uart_sendStr(data);
                    sprintf(data, "Object angle: %d\r\n", centerAngle);
                   // printToPutty(data);
                    uart_sendStr(data);
                    avgDistance = 0;
                    for (j = 0; j < 5; ++j) {
                        cyBOT_Scan(initialAngle + 3, &getScan);      //change to initialAngle + 3, prev centerAngle
                        avgDistance += getScan.sound_dist;
                    }
                    avgDistance /= 5;
                    sprintf(data, "Object distance: %0.2f cm\r\n", avgDistance);
                 //   printToPutty(data);
                    uart_sendStr(data);
                    linearWidth = 2.0 * M_PI * avgDistance * (((double)angleWidth) / 360.0);
                    sprintf(data, "Linear width: %0.2f cm\r\n\n", linearWidth);
                  //  printToPutty(data);
                    uart_sendStr(data);
                    if (linearWidth < smallestLinearWidth && linearWidth > 6 && linearWidth < 20) {
                        smallestLinearWidth = linearWidth;
                        smallestObjDist = avgDistance;
                        smallestObjAngle = centerAngle;
                    }
                }
                prevIRValue = avgIRValue;
            }
            smallestObjDist *= 10;
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        }
    }

    double tempDistance = 0;
    double newDistance = 1000000;
    if (smallestObjDist <= 300) {
        for (i = 85; i <= 95; ++i) {
            for (j = 0; j < 5; ++j) {
                cyBOT_Scan(i, &getScan);
                tempDistance += getScan.sound_dist;
            }
            tempDistance /= 5.0;
            if (tempDistance <= newDistance) {
                newDistance = tempDistance;
            }
        }
    move_forward(sensor_data, (newDistance * 10) - 45);
    }







//    bool goRight;
//    double xDist, yDist, angleForComputation, smallestObjAngleRad;
//    if (smallestObjAngle <= 90) {
//        goRight = true;
//        angleForComputation = smallestObjAngle;
//    }
//    else {
//        goRight = false;
//        angleForComputation = 180 - smallestObjAngle;
//    }
//    smallestObjAngleRad = smallestObjAngle * 0.0174533;
//    xDist = smallestObjDist * cos(smallestObjAngleRad);
//    yDist = smallestObjDist * sin(smallestObjAngleRad);
//    double xDistLeft = xDist * 10;
//    double yDistLeft = yDist * 10;
//    if (goRight) {
//        turn_right(sensor_data, 90);
//
//        while (xDistLeft > 0) {
//            xDistLeft -= move_forward(sensor_data, xDistLeft);
//            if (sensor_data -> bumpRight == 1 || sensor_data -> bumpLeft == 1) {
//                move_backward(sensor_data, 100);
//                xDistLeft += 100;
//                turn_right(sensor_data, 90);
//                move_forward(sensor_data, 400);
//                turn_left(sensor_data, 90);
//                xDistLeft -= move_forward(sensor_data, 800);
//                turn_left(sensor_data, 90);
//                move_forward(sensor_data, 400);
//                turn_right(sensor_data, 90);
//            }
//        }
//
//        turn_left(sensor_data, 90);
//
//        while (yDistLeft > 200) {
//            yDistLeft -= move_forward(sensor_data, yDistLeft);
//            if (sensor_data -> bumpRight == 1 || sensor_data -> bumpLeft == 1) {
//                move_backward(sensor_data, 100);
//                yDistLeft += 100;
//                turn_right(sensor_data, 90);
//                move_forward(sensor_data, 400);
//                turn_left(sensor_data, 90);
//                yDistLeft -= move_forward(sensor_data, 800);
//                turn_left(sensor_data, 90);
//                move_forward(sensor_data, 400);
//                turn_right(sensor_data, 90);
//            }
//        }
//
//        if (xDistLeft < -50) {
//            turn_left(sensor_data, 90);
//            move_forward(sensor_data, abs(xDistLeft));
//            turn_right(sensor_data, 90);
//        }
//        double tempY;
//        int lastAngle;
//        for (i = 85; i <= 95; i += 2) {
//            tempY = 0;
//            for (j = 0; j < 5; ++j) {
//                cyBOT_Scan(i, &getScan);
//                tempY += getScan.sound_dist;
//            }
//            tempY /= 5.0;
//            if (tempY < yDistLeft) {
//                yDistLeft = tempY;
//                lastAngle = i;
//            }
//        }
//
//        if (lastAngle > 90) {
//            turn_left(sensor_data, lastAngle - 90);
//        }
//        else {
//            turn_right(sensor_data, 90 - lastAngle);
//        }
//        move_forward_slow(sensor_data, yDistLeft - 50);
//    }
//    else {
//        turn_left(sensor_data, 90);
//    }

    oi_free(sensor_data);

    return 0;
}

//void printToPutty(char data[]) {
//    int i;
//    for (i = 0; i < strlen(data); ++i) {
//        cyBot_sendByte(data[i]);
//    }
//}
