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

int main(void) {
    oi_t *sensor_data = oi_alloc();
    oi_init(sensor_data);
    lcd_init();

//    SQUARE CHECKPOINT
//    move_forward(sensor_data, 500);
//    turn_right(sensor_data, 90);
//    move_forward(sensor_data, 500);
//    turn_right(sensor_data, 90);
//    move_forward(sensor_data, 500);
//    turn_right(sensor_data, 90);
//    move_forward(sensor_data, 500);
//    turn_right(sensor_data, 90);
//    oi_update(sensor_data);
//    int right = sensor_data -> bumpRight;
//    int left = sensor_data -> bumpLeft;
//    while (right == 0) {
//        oi_update(sensor_data);
//        left = sensor_data -> bumpLeft;
//        lcd_printf("%d", left);
//
//    }

    double distanceLeft = 2000;
    while (distanceLeft > 0) {
        distanceLeft -= move_forward(sensor_data, distanceLeft);
        if (distanceLeft > 0) {
            if (sensor_data -> bumpRight == 1 && sensor_data -> bumpLeft == 1) {
                distanceLeft += move_backward(sensor_data, 150);
                turn_left(sensor_data, 90);
                move_forward(sensor_data, 250);
                turn_right(sensor_data, 90);
            }
            else if (sensor_data -> bumpRight == 1) {
                distanceLeft += move_backward(sensor_data, 150);
                turn_left(sensor_data, 90);
                move_forward(sensor_data, 250);
                turn_right(sensor_data, 90);
            }
            else if (sensor_data -> bumpLeft == 1) {
                distanceLeft += move_backward(sensor_data, 150);
                turn_right(sensor_data, 90);
                move_forward(sensor_data, 250);
                turn_left(sensor_data, 90);
            }
        }
    }


    oi_free(sensor_data);
    return 0;
}



