#include <signal.h>

void my_routine();

int main(){
    //Set signal handler
    signal(SIGFPE, my_routine);
    int a = 69;
    a /= 0;
    return 0;
}

//Signal Handler
void my_routine(){
    printf("Caught a SIGFPE");
    exit(1);
}