#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define PI 3.141592653589

int read_line(int* time, double* g_x, double* g_y, double* g_z, int* Button_T, int* Button_C, int* Button_X, int* Button_S);
double roll(double x_mag);
double pitch(double y_mag);
int scaleRadsForScreen(double rad);
void print_chars(int num, char use);
void graph_line(int number);

int main()
{
	double x, y, z;                             
	int b_Triangle, b_X, b_Square, b_Circle;    
	double roll_rad, pitch_rad;                 
	int scaled_value, time, result;                           
	int stop = 1;
	
	do
	{
		result = read_line(&time, &x, &y, &z, &b_Triangle, &b_Circle, &b_X, &b_Square);  
		roll_rad = roll(x);
		pitch_rad = pitch(y);
		if(b_Triangle == 1){ 
			stop = 1;
		}
		if(b_X == 1){
			stop= 2;
		}
		if (stop == 1){
			scaled_value = scaleRadsForScreen(roll_rad);
		}
		if (stop == 2) {
			scaled_value = scaleRadsForScreen(pitch_rad);
		}
		
		graph_line(scaled_value);
		
		fflush(stdout);
	} while (b_Square != 1); 
	
	return 0;
}
int read_line(int* time, double* g_x, double* g_y, double* g_z, int* Button_T, int* Button_C, int* Button_X, int* Button_S) {
	scanf("%d, %lf, %lf, %lf, %d, %d, %d, %d", time, g_x, g_y, g_z, Button_T, Button_C, Button_X, Button_S);
	
	if (*g_x > 1) {	
		*g_x = 1;
	}
	if (*g_x < -1) {
		*g_x = -1;
	}
	if (*g_y > 1) {
		*g_y = 1;
	}
	if (*g_y < -1) {
		*g_y = -1;
	}
	
	if (*Button_S == 1) {
		return 1;
	}
	else {
		return 0;
	}
}

double roll(double x_mag){
	return asin(x_mag);
}
double pitch(double y_mag){ 
	return asin(y_mag);
}
int scaleRadsForScreen(double rad){  
	rad = sin(rad) * 39; 
	return rad;
}
void print_chars(int num, char use){
	int i;
	for(i = 0; i < num; i++) {
		printf("%c", use);
	}
}
void graph_line(int number) {			
	int temp = 0;
	if (number <= -3) {
		temp = abs(number);
		print_chars(39, ' ');
		print_chars(temp, 'r');
	}
	if ((number < 3) && (number > -3)) {
		print_chars(39, ' ');
		print_chars(1, '0');
	}
	if (number >= 3) {
		temp = 39 - number;
		print_chars(temp, ' ');
		print_chars(number, 'l');
	}
	print_chars(1, '\n');			
}