/**
 * lab4_template.c
 *
 * Template file for CprE 288 lab 4
 *
 * @author Zhao Zhang, Chad Nelson, Zachary Glanz
 * @date 08/14/2016
 */

#include "button.h"
#include "Timer.h"
#include "lcd.h"
#include "cyBot_uart.h"  // Functions for communicating between CyBot and Putty (via UART)
                         // PuTTy: Baud=115200, 8 data bits, No Flow Control, No Parity, COM1

//#warning "Possible unimplemented functions"
#define REPLACEME 0

void printToPutty(char data[]);

int main(void) {
	button_init();
	timer_init(); // Must be called before lcd_init(), which uses timer functions
	lcd_init();
	cyBot_uart_init();

	char data[50];
	int button = 0;
	int currentButton;
	while(1) {
	    button = button_getButton();
	    currentButton = button;
	    lcd_printf("Button: %d", button);

	    if (button == 1) {
	        sprintf(data, "Button 1\r\n");
	        printToPutty(data);
	    }
	    else if (button == 2) {
	        sprintf(data, "Button 2\r\n");
	        printToPutty(data);
        }
	    else if (button == 3) {
	        sprintf(data, "Button 3\r\n");
	        printToPutty(data);
	    }
	    else if (button == 4) {
	        sprintf(data, "Button 4\r\n");
	        printToPutty(data);
	    }
	    while(currentButton == button) {
	        button = button_getButton();
	    }
	}
}

void printToPutty(char data[]) {
    int i;
    for (i = 0; i < strlen(data); ++i) {
        cyBot_sendByte(data[i]);
    }
}
