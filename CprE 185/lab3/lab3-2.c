/* 185 Lab 3 Template */

#include <stdio.h>
#include <math.h>

int totalButtons(int TRIANGLE, int CIRLCE, int X, int SQUARE);

int main(void) {
	double ax, ay, az;
	int TRIANGLE, CIRLCE, X, SQUARE;
	
    while (1) {
		scanf("%d, %d, %d, %d", &TRIANGLE, &CIRLCE, &X, &SQUARE);
		printf("Buttons: %d\n", totalButtons(TRIANGLE, CIRLCE, X, SQUARE));		
		fflush(stdout);
    }

return 0;
}

int totalButtons(int TRIANGLE, int CIRLCE, int X, int SQUARE) {
	int total;
	total = TRIANGLE + CIRLCE + X + SQUARE;
	
	return total;
}
