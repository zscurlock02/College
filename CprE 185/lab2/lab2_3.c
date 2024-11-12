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
    int integerResult;
    double decimalResult;

    integerResult = 77 / 5;
    printf("The value of 77/5 is %d, using integer math\n", integerResult); // %d was previously %lf. This is incorrect because %lf should only be used when double

    integerResult = 2 + 3;
    printf("The value of 2+3 is %d\n", integerResult); // This line of code was missing "integerResult," causing 2+3=0 rather than 5

    decimalResult = 1.0 / 22.0;
    printf("The value 1.0/22.0 is %lf\n", decimalResult); // %d was initially used rather than %lf, causing the program to run integer math rather than math yielding a decimal result

    return 0;
}

