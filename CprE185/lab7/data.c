// 185 Lab 7
#include <stdio.h>
#define MAXPOINTS 10000

// compute the average of the first num_items of buffer
double avg(double buffer[], int num_items);

//update the max and min of the first num_items of array
void maxmin(double array[], int num_items, double* max, double* min);

//shift length-1 elements of the buffer to the left and put the 
//new_item on the right.
void updatebuffer(double buffer[], int length);


int main(int argc, char* argv[]) {
	
	/* DO NOT CHANGE THIS PART OF THE CODE */

	double x[MAXPOINTS], y[MAXPOINTS], z[MAXPOINTS];
	int lengthofavg = 0;
	if (argc>1) {
		sscanf(argv[1], "%d", &lengthofavg );
		//printf("You entered a buffer length of %d\n", lengthofavg);
	}
	else {
		printf("Enter a length on the command line\n");
		return -1;
	}
	if (lengthofavg < 1 || lengthofavg > MAXPOINTS) {
		printf("Invalid length\n");
		return -1;
	}

	double gx,gy,gz;
	int B_X, B_C, B_T;
	int i = 0;
	int B_S = 0;
	double xAvg, yAvg, zAvg;
	double max, min;
	
	
	while(B_S != 1){
		fflush(stdout);
		if(i > lengthofavg - 1){
			i = lengthofavg - 1;
		}
		scanf("%lf, %lf, %lf, %d, %d, %d, %d", &gx, &gy, &gz, &B_T, &B_C, &B_X, &B_S);
		x[i] = gx;
		y[i] = gy;
		z[i] = gz;

		if(i == lengthofavg - 1){
			
			xAvg = avg(x, lengthofavg);
			yAvg = avg(y, lengthofavg);
			zAvg = avg(z, lengthofavg);
			printf("%8.6lf, %8.6lf, %8.6lf\n", xAvg, yAvg, zAvg);
		
			updatebuffer(x, lengthofavg);
			updatebuffer(y, lengthofavg);
			updatebuffer(z, lengthofavg);
		}
		i++;
	}
	
}
double avg(double buffer[], int num_items){
	int i; 
	double total;
	for(i = 0; i < num_items; i++){
		total += buffer[i];
	}
	total = total / num_items;
	return total;
}
void maxmin(double array[], int num_items, double* max, double* min){
	int i;
	*max = -5;
	*min = 5;
	for(i = 0; i < num_items; i++){
		if(*max < array[i]){
			*max = array[i];
		}
		if(*min > array[i]){
			*min = array[i];
		}
	}
}
void updatebuffer(double buffer[], int length){
	int i;
	for(i = 0; i < length - 1; ++i){
		buffer[i] = buffer [i + 1];
	}
}