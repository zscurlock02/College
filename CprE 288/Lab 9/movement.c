/*
 * movement.c
 *
 *  Created on: Feb 2, 2023
 *      Author: scurlock
 */

#include "open_interface.h"
#include "lcd.h"
#include "math.h"

double move_forward(oi_t *sensor_data, double distance_mm) {
    double distance = 0;
    oi_setWheels(200, 200);
    lcd_init();

    while (distance < distance_mm) {
//        lcd_printf("%f", distance);
        oi_update(sensor_data);
        distance += sensor_data -> distance;
        if (sensor_data -> bumpLeft == 1 || sensor_data -> bumpRight) {
            return distance;
        }
    }
 //   lcd_printf("%f", distance);

    oi_setWheels(0,0);
    return distance;
}

double move_backward(oi_t *sensor, double distance_mm) {
    double distance = 0;
    oi_setWheels(-200, -200);

    while (distance < distance_mm) {
        oi_update(sensor);
        distance += abs(sensor -> distance);
    }
    oi_setWheels(0,0);
    return distance;
}

double move_forward_slow(oi_t *sensor_data, double distance_mm) {
    double distance = 0;
    oi_setWheels(25, 25);
    lcd_init();

    while (distance < distance_mm) {
//        lcd_printf("%f", distance);
        oi_update(sensor_data);
        distance += sensor_data -> distance;
        if (sensor_data -> bumpLeft == 1 || sensor_data -> bumpRight) {
            return distance;
        }
    }
 //   lcd_printf("%f", distance);

    oi_setWheels(0,0);
    return distance;
}

double move_backward_slow(oi_t *sensor, double distance_mm) {
    double distance = 0;
    oi_setWheels(-25, -25);

    while (distance < distance_mm) {
        oi_update(sensor);
        distance += abs(sensor -> distance);
    }
    oi_setWheels(0,0);
    return distance;
}

void turn_right(oi_t *sensor, double degrees) {
    double angle = 0;
    oi_setWheels(-50, 50);
    while (abs(angle) < degrees) {
        oi_update(sensor);
        angle -= sensor -> angle;
    }
}

void turn_left(oi_t *sensor, double degrees) {
    double angle = 0;
    oi_setWheels(50, -50);
    while (angle < degrees) {
        oi_update(sensor);
        angle += sensor -> angle;
    }
}
