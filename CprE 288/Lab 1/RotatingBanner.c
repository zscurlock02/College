#include "Timer.h"
#include "lcd.h"

void lcd_rotatingBanner(char arr[]);

int main (void) {

    timer_init(); // Initialize Timer, needed before any LCD screen functions can be called
                  // and enables time functions (e.g. timer_waitMillis)

    lcd_init();   // Initialize the LCD screen.  This also clears the screen.

    lcd_rotatingBanner("Hello i am from colifornia");

    // lcd_puts("Hello, world"); // Replace lcd_printf with lcd_puts
        // step through in debug mode and explain to TA how it works

    // NOTE: It is recommended that you use only lcd_init(), lcd_printf(), lcd_putc, and lcd_puts from lcd.h.
       // NOTE: For time functions, see Timer.h

    return 0;
}


void lcd_rotatingBanner(char arr[]) {
    while (1) {
        int totalChars = strlen(arr);
        int totalSpaces = 19;
        int spacesOccupied = 1;
        while (totalSpaces >= 0) {
            char spaces[totalSpaces + 1];
            char message[21 - totalSpaces];
            int i;
            for (i = 0; i < totalSpaces; ++i) {
                strcat(spaces, " ");
            }
            --totalSpaces;
            for (i = 0; i < spacesOccupied; ++i) {
                strncat(message, &arr[i], 1);
            }
            ++spacesOccupied;
            char printThis[21];
            strcpy(printThis, spaces);
            strcat(printThis, message);

            lcd_printf(printThis);
            timer_waitMillis(300);
            lcd_clear();
        }
        int upToChar = 21;
        int length = strlen(arr);
        int startingPoint = 1;
        while (upToChar <= length) {
            int i;
            char otherMessage[21];
            otherMessage[0] = '\0';
            for (i = startingPoint; i < upToChar; ++i) {
                strncat(otherMessage, &arr[i], 1);
            }
            ++upToChar;
            ++startingPoint;
            lcd_printf(otherMessage);
            timer_waitMillis(300);
            lcd_clear();
        }
        spacesOccupied = 19;
        totalSpaces = 1;
        while (spacesOccupied >= 0) {
            char message[21 - totalSpaces];
            char spaces[totalSpaces + 1];
            message[0] = '\0';
            spaces[0] = '\0';
            int i;
            for (i = startingPoint; i < length; ++i) {
                strncat(message, &arr[i], 1);
            }
            ++startingPoint;
            --spacesOccupied;
            for (i = 0; i < totalSpaces; ++i) {
                strcat(spaces, " ");
            }
            ++totalSpaces;
            char printThis[21];
            strcpy(printThis, message);
            strcat(printThis, spaces);
            lcd_printf(printThis);
            timer_waitMillis(300);
        }
    }
}
