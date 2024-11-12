/**
 * @file lab9_template.c
 * @author
 * Template file for CprE 288 Lab 9
 */

#include <ping.h>
#include "Timer.h"
#include "lcd.h"

// Uncomment or add any include directives that are needed

#define REPLACEME 0

int main(void) {

    float distance =0;
	timer_init(); // Must be called before lcd_init(), which uses timer functions
	lcd_init();
	ping_init();
//	ping_trigger();
	// YOUR CODE HERE

	while(1)
	{
        distance = ping_getDistance();
	    lcd_printf("Distance: %5.2f cm", distance);
	    timer_waitMillis(500);
	}

}
