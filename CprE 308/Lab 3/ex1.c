#include <pthread.h>
#include <stdio.h>

void* thread1();
void* thread2();


int main(int argc, char *argv[]){
    pthread_t i1;
    pthread_t i2;

    //Creates thread 1 and 2
    pthread_create(&i1, NULL, (void*)&thread1, NULL); 
    pthread_create(&i2, NULL, (void*)&thread2, NULL); 

    //Waits for thread 1 and 2 to complete
    pthread_join(i1, NULL);
    pthread_join(i2, NULL);

    printf("Hello from main");
}

// Thread 1
void* thread1(){
    sleep(5);
    printf("Hello from thread1");
}

//Thread 2
void* thread2(){
    sleep(5);
    printf("Hello from thread2");
}

