/*
 * servo.c
 *
 *  Created on: Apr 6, 2023
 *      Author: atgull26
 */
#include "Timer.h"
#include "lcd.h"
#include "button.h" //285645 bot 6
void servo_init(void)
{
      //GPIO
      SYSCTL_RCGCGPIO_R |= 0x02;
      while((SYSCTL_PRGPIO_R & 0x02) == 0){};
      SYSCTL_RCGCTIMER_R |= 0x02;
      while((SYSCTL_PRTIMER_R & 0x02) == 0){};
      GPIO_PORTB_DEN_R |= 0x20;
      GPIO_PORTB_DIR_R |= 0x20;
      GPIO_PORTB_AFSEL_R |= 0x20;
      GPIO_PORTB_PCTL_R = (GPIO_PORTB_PCTL_R & ~0x00700000) | 0x00700000;
      //timer
      TIMER1_CTL_R &= ~0x100;
      TIMER1_CFG_R |= 0x4;
      TIMER1_TBMR_R &= ~0x4;
      TIMER1_TBMR_R |= 0x0A;
      TIMER1_CTL_R |= 0xC00;
      TIMER1_TBILR_R = 0xE200;
      TIMER1_TBPR_R = 0x04;
      TIMER1_CTL_R |= 0x100;
      servo_move(0);
}
void servo_move(uint16_t degrees)
{
//    uint32_t lowPulse = 312512 - ((312512 - 285645) / 180) * degrees;   //cybot 6
//    uint32_t lowPulse = 312019 - ((312019 - 284798) / 180) * degrees;     //cybot 6
    uint32_t lowPulse = 313464 - ((313464 - 286420) / 180) * degrees;       //cybot 07
    TIMER1_TBMATCHR_R = lowPulse & 0x00FFFF;
    TIMER1_TBPMR_R = 0x04;
    timer_waitMillis(100);
}

void calibrate(void) {
    int x = 0;
    uint32_t value;
    uint32_t value2;
    servo_move(0);
//    TIMER1_TBMATCHR_R = 0xE200;
//    TIMER1_TBPMR_R = 0x4;
    int count = 0;
    char array[40];
    lcd_printf("Button1: move left\nButton2: move right\nButton3: get value1\nButton4: get value2");
    while (x == 0) {
        int y = 0;
        while (y == 0) {
            y = button_getButton();
            timer_waitMillis(100);
        }
        if (y == 1) {
            count++;
            servo_move(count);
        }
        else if (y == 2) {
            count--;
            servo_move(count);
        }
        else if (y == 3) {
            value = TIMER1_TBMATCHR_R;
            value += 262144;
            sprintf(array, "Value 1: %d\n", value);
            lcd_printf(array);
        }
        else if (y == 4) {
            value2 = TIMER1_TBMATCHR_R;
            value2 += 262144;
            sprintf(array, "Value 1: %d\nValue 2: %d", value, value2);
            lcd_printf(array);
            x = 1;
        }
    }
}


