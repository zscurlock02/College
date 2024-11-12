/*-----------------------------------------------------------------------------
-					         SE/CprE 185 Lab 04
-             Developed for 185-Rursch by T.Tran and K.Wang
-----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
-	                            Includes
-----------------------------------------------------------------------------*/
#include <stdio.h>
#include <math.h>

/*-----------------------------------------------------------------------------
-	                            Defines
-----------------------------------------------------------------------------*/


double mag( int ax, int ay, int az);
int close_to(double tolerance, double point, double value);
int TRIANGLE(int b1);
/*-----------------------------------------------------------------------------
-							  Implementation
-----------------------------------------------------------------------------*/
int main(void) {
    int t, b1, b2, b3, b4;
    double ax, ay, az, gx, gy, gz;
	int stop = 0;
	
    while (1) {
        scanf("%d, %lf, %lf, %lf, %lf, %lf, %lf, %d, %d, %d, %d", &t, &ax, &ay, &az, &gx, &gy, &gz, &b1, &b2, &b3, &b4 );
		
		if(close_to(0.2, 1, gy) && (stop != 1)){
			printf("Top\n");
			stop = 1;
		}
		else if(close_to(0.2, -1, gy) && (stop != 2)){
			printf("Bottom\n");
			stop = 2;
		}
		else if(close_to(0.2, -1, gx) && (stop != 3)){
			printf("Right\n");
			stop = 3;
		}
		else if(close_to(0.2, 1, gx) && (stop != 4)){
			printf("Left\n");
			stop = 4;
		}
		else if(close_to(0.2, 1, gz) && (stop != 5)){
			printf("Back\n");
			stop = 5;
		}
		else if(close_to(0.2, -1, gz) && (stop != 6)){
			printf("Front\n");
			stop = 6;
		}
		else if(TRIANGLE(b1)){
			break;
		}
		
		fflush(stdout);
		
    }

    return 0;
}
double mag( int ax, int ay, int az){
double magofaccel;
double filler;
	
	magofaccel = (ax * ax) + (ay * ay) + (az * az);
	filler = sqrt(magofaccel);
}
int close_to(double tolerance, double point, double value){
	if(value > point - tolerance && value < tolerance + point ){
		return 1;
	}
	else{
		return 0;
	}
}
int TRIANGLE(int b1){
	int temp;
	if(b1 == 1) {
		temp = 1;
	}
	else {
		temp = 0;
	}
	return temp;
}