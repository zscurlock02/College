/**
 * lab5_template.c
 *
 * Template file for CprE 288 Lab 5
 *
 * @author Zhao Zhang, Chad Nelson, Zachary Glanz
 * @date 08/14/2016
 *
 * @author Phillip Jones, updated 6/4/2019
 * @author Diane Rover, updated 2/25/2021, 2/17/2022
 */

#include "button.h"
#include "timer.h"
#include "lcd.h"


#include "cyBot_uart.h"  // Functions for communicating between CyBot and Putty (via UART1)
                         // PuTTy: Baud=115200, 8 data bits, No Flow Control, No Parity, COM1
#include "uart.h"

#include "cyBot_Scan.h"  // Scan using CyBot servo and sensors


//#warning "Possible unimplemented functions"
#define REPLACEME 0



int main(void) {
	button_init();
	timer_init(); // Must be called before lcd_init(), which uses timer functions
	lcd_init();
	char c;

  // initialize the cyBot UART1 before trying to use it

  // (Uncomment ME for UART init part of lab)
	 cyBot_uart_init_clean();  // Clean UART1 initialization, before running your UART1 GPIO init code

	// Complete this code for configuring the GPIO PORTB part of UART1 initialization (your UART1 GPIO init code)
//	 SYSCTL_RCGCGPIO_R |= 0x02;
//	 while ((SYSCTL_PRGPIO_R & 0x02) == 0) {};
//	 GPIO_PORTB_DEN_R |= 0x03;
//	 GPIO_PORTB_AFSEL_R |= 0x03;
     //GPIO_PORTB_PCTL_R &= FIXME;     // Force 0's in the desired locations
     //GPIO_PORTB_PCTL_R |= FIXME;     // Force 1's in the desired locations
//	 GPIO_PORTB_PCTL_R = 0x11;
		 // Or see the notes for a coding alternative to assign a value to the PCTL field

    // (Uncomment ME for UART init part of lab)
		// cyBot_uart_init_last_half();  // Complete the UART device configuration

		// Initialize the scan
	  // cyBOT_init_Scan();
		// Remember servo calibration function and variables from Lab 3

	// YOUR CODE HERE
	 uart_init();

//	 c = uart_receive();
//	 lcd_printf("%c", c);
//	 char data[30];
//	 int i = 0;
//	 int noEnter = 1;
//	while(strlen(data) < 20 && noEnter) {
//	    data[i] = uart_receive();
//	    if (data[i] == '\r') {
//	        noEnter = 0;
//	        break;
//	    }
//	    i++;
//	}
//	int length = 0;
//	if (data[strlen(data) - 1] != '\r') {           part 2 code, not fully functional
//	    length = 20;
//	}
//	else {
//	    length = strlen(data) - 1;
//	}
//	sprintf(data, "%s%d", data, strlen(data) - 1);
//	for (i = 0; i < strlen(data); i++) {
//	    if (data[i] != '\r') {
//	        lcd_putc(data[i]);
//	    }
//	}
	 while (1) {
	     c = uart_receive();
	     if (c == '\r') {
	         uart_sendChar(c);
	         uart_sendChar('\n');
	     }
	     else {
	         uart_sendChar(c);
	     }
	 }
 }
