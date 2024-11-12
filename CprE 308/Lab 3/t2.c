/* t2.c
   synchronize threads through mutex and conditional variable 
   To compile use: gcc -o t2 t2.c -lpthread 
*/ 

#include <stdio.h>
#include <pthread.h>

void* 	hello();    // define two routines called by threads    
void* 	world();   
void*   again();    //ADDED BY ME      	

/* global variable shared by threads */
pthread_mutex_t 	mutex;  		// mutex
pthread_cond_t 		done_hello; 	// conditional variable
pthread_cond_t      done_world;     //conditional variable added by ME
int 			done = 0;      	// testing variable

int main (int argc, char *argv[]){
    pthread_t 	tid_hello, // thread id  
    		tid_world, tid_again; //added tid_again 
    /*  initialization on mutex and cond variable  */ 
    pthread_mutex_init(&mutex, NULL);
    pthread_cond_init(&done_hello, NULL);
    pthread_cond_init(&done_world, NULL); //ADDED THIS 
    
    pthread_create(&tid_hello, NULL, (void*)&hello, NULL); //thread creation
    pthread_create(&tid_world, NULL, (void*)&world, NULL); //thread creation 
    pthread_create(&tid_again, NULL, (void*)&again, NULL); //ADDED THIS

    /* main waits for the two threads to finish */
    pthread_join(tid_hello, NULL);  
    pthread_join(tid_world, NULL);
    pthread_join(tid_again, NULL); //ADDED THIS

    printf("\n");
    return 0;
}

void* hello() {
    pthread_mutex_lock(&mutex);
    printf("hello ");
    fflush(stdout); 	// flush buffer to allow instant print out
    done = 1;
    pthread_cond_signal(&done_hello);	// signal world() thread
    pthread_mutex_unlock(&mutex);	// unlocks mutex to allow world to print
    return ;
}


void* world() {
    pthread_mutex_lock(&mutex);

    /* world thread waits until done == 1. */
    while(done == 0) 
	pthread_cond_wait(&done_hello, &mutex);

    printf("world");
    fflush(stdout);

    done = 2;                               //ADDED
    pthread_cond_signal(&done_world);       //THESE

    pthread_mutex_unlock(&mutex); // unlocks mutex

    return ;
}


//Added this function
void* again(){
    pthread_mutex_lock(&mutex);
    while(done != 2){  //makes sure world is done
        pthread_cond_wait(&done_world, &mutex);
    }
    printf(" again!");
    fflush(stdout);
    pthread_mutex_unlock(&mutex);
}