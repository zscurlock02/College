/*
 * servo.h
 *
 *  Created on: Apr 6, 2023
 *      Author: connor66
 */

#include "Timer.h"
#include "lcd.h"

#ifndef SERVO_H_
#define SERVO_H_

void servo_init(void);

void servo_move(uint16_t degrees);

#endif /* SERVO_H_ */
