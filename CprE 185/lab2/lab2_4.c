/*-----------------------------------------------------------------------------
-					          CPRE 185 Lab 02
-	Name:	 Zachary Scurlock	
- 	Section: 2
-	NetID:	 scurlock	
-	Date:	 September 10, 2021
-----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
-	                            Includes
-----------------------------------------------------------------------------*/
#include <stdio.h>
#include <math.h>


/*-----------------------------------------------------------------------------
-	                            Defines
-----------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------
-	                            Prototypes
-----------------------------------------------------------------------------*/


/*-----------------------------------------------------------------------------
-							 Implementation
-----------------------------------------------------------------------------*/
int main()
{
int a, b, e, f, j;
double c, d, g, h, i, k;

	a = 6427 + 1725;
	printf("The value of 6427 + 1725 is %d\n", a);
	
	b = (6971 * 3925) - 95;
	printf("The value of (6971 * 3925) - 95 is %d\n", b);
	
	c = 79 + 12 / 5;
	printf("The value of 79 + 12 / 5 is %.02lf\n", c);
    
	d = 3640.0 / 107.9;
	printf("The value of 3640.0 / 107.9 is %.02lf\n", d);
	
	e = (22 / 3) * 3;
	printf("The value of (22 / 3) * 3 is %d\n", e);
	
	f = 22 / (3 * 3);
	printf("The value of 22 / (3 * 3) is %d\n", f);
	
	g = 22 / (3 * 3);
	printf("The value of 22 / (3 * 3) is %.02lf\n", g);
	
	h = 22 / 3 * 3;
	printf("The value of 22 / 3 * 3 is %.02lf\n", h);
	
	i = (22.0 / 3) * 3.0;
	printf("The value of (22.0 / 3) * 3.0 is %.02lf\n", i);
	
	j = 22.0 / (3 * 3.0);
	printf("The value of 22.0 / (3 * 3.0) is %d\n", j);
	
	k = 22.0 / 3.0 * 3.0;
	printf("The value of 22.0 / 3.0 * 3.0 is %.02lf\n", k);
	
double circumference = 23.567;
double radius;
double area;
double pi = 3.14159265359;
	
	radius = circumference / (2 * pi);
	
	area = (2 * pi) * (radius * radius);
	
	return 0;

}

