/*
 * servo.h
 *
 *  Created on: Apr 6, 2023
 *      Author:  Sullivan Fair / Aidan Gull
 */

#ifndef SERVO_H_
#define SERVO_H_

void servo_init(void);

void servo_move(uint16_t degrees);

void calibrate(void);

#endif /* SERVO_H_ */
