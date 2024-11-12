/*
 * movement.c
 *
 *  Created on: Feb 2, 2023
 *      Author: scurlock
 */

#include "open_interface.h"
#include "lcd.h"
#include "math.h"
#include "stdbool.h"

char move_forward(oi_t *sensor_data, double distance_mm) {
    double distance = 0;
    oi_setWheels(200, 200);
    lcd_init();

    while (distance < distance_mm) {
        oi_update(sensor_data);
        distance += sensor_data -> distance;
        if (sensor_data -> bumpLeft == 1 || sensor_data -> bumpRight) {
            oi_setWheels(0,0);
            return 'b';     //If it bumped into something return b
        }
        if ((sensor_data -> cliffLeftSignal > 2500) || (sensor_data -> cliffRightSignal > 2500) || (sensor_data -> cliffFrontRightSignal > 2500) || (sensor_data -> cliffFrontLeftSignal > 2500)) {
            oi_setWheels(0,0);
            return 't';     //If it went over tape return t
        }
        if ((sensor_data -> cliffLeftSignal < 1000) || (sensor_data -> cliffRightSignal < 1000) || (sensor_data -> cliffFrontRightSignal < 1000) || (sensor_data -> cliffFrontLeftSignal < 1000)) {
            oi_setWheels(0,0);
            return 'h';     //If it went over hole return h
        }
    }

    oi_setWheels(0,0);
    return 's';
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

char move_forward_slow(oi_t *sensor_data, double distance_mm) {
    double distance = 0;
    oi_setWheels(25, 25);
    lcd_init();

    while (distance < distance_mm) {
        oi_update(sensor_data);
        distance += sensor_data -> distance;
        if (sensor_data -> bumpLeft == 1 || sensor_data -> bumpRight) {
            oi_setWheels(0,0);
            return 'b';
        }
        if ((sensor_data -> cliffLeftSignal > 2500) || (sensor_data -> cliffRightSignal > 2500) || (sensor_data -> cliffFrontRightSignal > 2500) || (sensor_data -> cliffFrontLeftSignal > 2500)) {
            oi_setWheels(0,0);
            return 't';
        }
        if ((sensor_data -> cliffLeftSignal < 1000) || (sensor_data -> cliffRightSignal < 1000) || (sensor_data -> cliffFrontRightSignal < 1000) || (sensor_data -> cliffFrontLeftSignal < 1000)) {
            oi_setWheels(0,0);
            return 'h';
        }
    }

    oi_setWheels(0,0);
    return 's';
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
    oi_setWheels(0,0);
}

void turn_left(oi_t *sensor, double degrees) {
    double angle = 0;
    oi_setWheels(50, -50);
    while (angle < degrees) {
        oi_update(sensor);
        angle += sensor -> angle;
    }
    oi_setWheels(0,0);
}
