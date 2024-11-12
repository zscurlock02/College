/*
 * movement.c
 *
 *  Created on: Feb 2, 2023
 *      Author: Team 10D
 */

#include "open_interface.h"
#include "lcd.h"
#include "math.h"
#include "stdbool.h"
#include "uart-interrupt.h"

char movementMessage[80];

/**
 * The move command will automatically stop the robot if it hits either the hole, or the boundary.
 * It also gives the user additional information saying which sensor the hole or boundary was detected on.
 * If it hits a hole or boundary, the actual distance traveled is also sent to the user.
 */
char move_forward(oi_t *sensor_data, double distance_mm) {
    double distance = 0;
    oi_setWheels(200, 200);

    while (distance < distance_mm) {
        oi_update(sensor_data);
        distance += sensor_data -> distance;
        if (sensor_data -> bumpLeft == 1) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Bumped into something, LEFT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'b';     //If it bumped into something return b
        }
        if (sensor_data -> bumpRight == 1) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Bumped into something, RIGHT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'b';     //If it bumped into something return b
        }
        if (sensor_data -> cliffLeftSignal > 2700) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the boundary, LEFT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 't';     //If it went over tape return t
        }
        if (sensor_data -> cliffRightSignal > 2700) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the boundary, RIGHT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 't';     //If it went over tape return t
        }
        if (sensor_data -> cliffFrontRightSignal > 2700) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the boundary, FRIGHT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 't';     //If it went over tape return t
        }
        if (sensor_data -> cliffFrontLeftSignal > 2700) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the boundary, FLEFT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 't';     //If it went over tape return t
        }
        if (sensor_data -> cliffLeftSignal < 1000) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the hole, LEFT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'h';     //If it went over hole return h
        }
        if (sensor_data -> cliffRightSignal < 1000) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the hole, RIGHT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'h';     //If it went over hole return h
        }
        if (sensor_data -> cliffFrontRightSignal < 1000) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the hole, FRIGHT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'h';     //If it went over hole return h
        }
        if (sensor_data -> cliffFrontLeftSignal < 1000) {
            oi_setWheels(0,0);
            sprintf(movementMessage, "Hit the hole, FLEFT, %.1fx", distance / 10.0);
            uart_sendStr(movementMessage);
            return 'h';     //If it went over hole return h
        }
    }

    oi_setWheels(0,0);
    return 's';     //If it finished return s
}

/**
 * Moves backward the given amount then sends "Done" when it is done.
 */
double move_backward(oi_t *sensor, double distance_mm) {
    double distance = 0;
    oi_setWheels(-200, -200);

    while (distance < distance_mm) {
        oi_update(sensor);
        distance += abs(sensor -> distance);
    }
    sprintf(movementMessage, "Donex");
    uart_sendStr(movementMessage);
    oi_setWheels(0,0);
    return distance;
}

/**
 * Turns right the given amount then sends "Done" when it is done.
 */
void turn_right(oi_t *sensor, double degrees) {
    double angle = 0;
    oi_setWheels(-50, 50);
    while (abs(angle) < degrees) {
        oi_update(sensor);
        angle -= sensor -> angle;
    }
    sprintf(movementMessage, "Donex");
    uart_sendStr(movementMessage);
    oi_setWheels(0,0);
}

/**
 * Turns left the given amount then sends "Done" when it is done.
 */
void turn_left(oi_t *sensor, double degrees) {
    double angle = 0;
    oi_setWheels(50, -50);
    while (angle < degrees) {
        oi_update(sensor);
        angle += sensor -> angle;
    }
    sprintf(movementMessage, "Donex");
    uart_sendStr(movementMessage);
    oi_setWheels(0,0);
}
