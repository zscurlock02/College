/*
 * movement.h
 *
 *  Created on: Feb 2, 2023
 *      Author: Team 10D
 */

#ifndef MOVEMENT_H_
#define MOVEMENT_H_
#include "open_interface.h"
#include "stdbool.h"

void turn_right(oi_t *sensor, double degrees);

bool move_forward(oi_t *sensor_data, double distance_mm);

void turn_left(oi_t *sensor, double degrees);

double move_backward(oi_t *sensor, double distance_mm);

#endif /* MOVEMENT_H_ */
