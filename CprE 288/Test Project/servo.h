/*
 * servo.h
 *
 *  Created on: Apr 6, 2023
 *      Author: atgull26
 */

#ifndef SERVO_H_
#define SERVO_H_



void servo_init(void);


void servo_move(uint16_t degrees);

void calibrate(void);

#endif /* SERVO_H_ */
