#include <math.h>
#include <stdio.h>

double mag(double gx, double gy, double gz);
int close_to(double tolerance, double point, double value);

int main(void) {
	double gy, gx, gz, t, timeElapsed, fallDistance;
	int iTime;
	
	printf("First and Last Name: Zachary Scurlock\n");
	printf("Net ID: scurlock\n");
	
	scanf("%lf, %lf, %lf, %lf", &t, &gx, &gy, &gz);
	printf("Ok, I'm now receiving data.\n");
	printf("I'm waiting ");
	timeElapsed = 0;
	
	while(close_to(0.15, 1.0, mag(gx, gy, gz))){
		scanf("%lf, %lf, %lf, %lf", &t, &gx, &gy, &gz);
		timeElapsed = timeElapsed + 1;
		if(timeElapsed == 10) {
			printf(".");
			timeElapsed = 0;
		}
		fflush(stdout);
	}	

	iTime = t;
	printf("\n");
	printf("Help me! I'm falling!");
	timeElapsed = 0;
	
	double AirResistDistance, percentDifference, velocity;
	double previousDistance;
	double previousVelocity;
	double pTime = iTime / 1000.0;
	
	while(mag(gx, gy, gz) < 1.5){
		scanf("%lf, %lf, %lf, %lf", &t, &gx, &gy, &gz);
		timeElapsed = timeElapsed + 1;
		if(timeElapsed == 10) {
			printf("!");
			timeElapsed = 0;
		}
		velocity = previousVelocity + 9.8 * (1 - mag(gx, gy, gz)) * ((t / 1000.0) - pTime);
		//printf("\n%lf", velocity);
		AirResistDistance = previousDistance + velocity * ((t / 1000.0) - pTime);
		//printf("\n%lf", AirResistDistance);
		previousVelocity = velocity;
		pTime = t / 1000.0;
		//printf("\n%lf", pTime);
		previousDistance = AirResistDistance;
		
		fflush(stdout);
	}
	printf("\n");
	t = t - iTime;
	t = t / 1000;
	fallDistance = 0.5 * 9.8 * (pow(t, 2));
	printf("Ouch! I fell %5.3lf meters in %5.3lf seconds\n", fallDistance, t);
	printf("Compensating for air resistance, the fall was %5.3lf meters.\n", AirResistDistance);
	
	percentDifference = 100 - ((AirResistDistance / fallDistance) * 100);
	printf("This is %5.3lf percent less than computed before.", percentDifference);
	
	return 0;
}
double mag(double gx, double gy, double gz){
	return sqrt(gx*gx + gy*gy + gz*gz); 
}
int close_to(double tolerance, double point, double value){
	if(value > point - tolerance && value < tolerance + point ){
		return 1;
	}
	else{
		return 0;
	}
}