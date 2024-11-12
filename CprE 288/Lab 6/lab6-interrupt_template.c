/**
 * lab6-interrupt_template.c
 *
 * Template file for CprE 288 Lab 6
 *
 * @author Diane Rover, 2/15/2020
 *
 */

#include "Timer.h"
#include "lcd.h"
#include "cyBot_Scan.h"  // For scan sensors
#include "uart-interrupt.h"
#include <stdbool.h>
#include "driverlib/interrupt.h"

// Uncomment or add any include directives that you want to use
#include "open_interface.h"
#include "movement.h"
#include "button.h"

// Your code can use the global variables defined in uart-interrupt.c
// They are declared with the extern qualifier in uart-interrupt.h, which makes the variables visible to this file.

//#warning "Possible unimplemented functions"
#define REPLACEME 0


int main(void) {
	timer_init(); // Must be called before lcd_init(), which uses timer functions
	lcd_init();
	uart_interrupt_init();
    oi_t *sensor_data = oi_alloc();
    oi_init(sensor_data);
    cyBOT_Scan_t getScan;
    cyBOT_init_Scan(0b0011);
    right_calibration_value = 243250;
    left_calibration_value = 1225000;

	// OPTIONAL
	//assign a value to command_byte if you want to know whether that ASCII code is received
	//note that command_byte is global shared variable read by the ISR
	//for example, try using a tab character as a command from PuTTY
    int i = 0;
    int flag = 1;
    char c = 0;

    while (c != 'g') {
        c = uart_receive();
    }

	while(1) {

      // YOUR CODE HERE
			//first, try leaving this loop empty and see what happens
			//then add code for your application
			// OPTIONAL
			//test and reset command_flag if your ISR is updating it
			//for example, if the flag is 1, do something, like send a message to PuTTY or LCD, or stop a sensor scan, etc.
			//be sure to reset command_flag so you don't keep responding to an old flag

	    cyBOT_Scan(i, &getScan);
	    if (flag == 1) {
	        i += 5;
	        if (i > 180) {
	            i -= 5;
	            flag = 2;
	        }
	    }
	    if (flag == 2) {
	        i -= 5;
	        if (i < 0) {
	            i += 5;
	            flag = 1;
	        }
	    }

	    if (command_flag == 1) {
	        command_flag = 0;
	        break;
	    }

	}

}
