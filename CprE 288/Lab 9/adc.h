/*
 * adc.h
 *
 *  Created on: Mar 23, 2023
 *      Author: connor66
 */
#include "stdint.h"

#ifndef ADC_H_
#define ADC_H_

void adc_init(void);
uint16_t adc_read(void);


#endif /* ADC_H_ */
