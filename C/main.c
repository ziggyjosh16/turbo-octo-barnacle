/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Joshua Sharkey
 *
 * Created on December 2, 2018, 3:24 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <time.h>
#include <limits.h>

/*
 * 
 */
pthread_t threads[5];
int count = 0;
int sexit = 5;
pthread_mutex_t arrived_mutex = PTHREAD_MUTEX_INITIALIZER;
sem_t synchronization_semaphore1;
sem_t synchronization_semaphore2;

void *increment() {
    pthread_t pid = pthread_self();
    for (int i = 0; i < 10; i++) {
        pthread_mutex_lock(&arrived_mutex);
        count += 1;
        if (count == 5) {
            sem_wait(&synchronization_semaphore2);
            sem_post(&synchronization_semaphore1);
        }

        pthread_mutex_unlock(&arrived_mutex);


        sem_wait(&synchronization_semaphore1);
        sem_post(&synchronization_semaphore1);

        //CRITICAL START
        for (int j = 0; j < (0.1 * INT_MAX); j++) {
            //just counting
        }
        printf("Thread #%d: Iteration #:%d Finished.\n", pid, i + 1);


        pthread_mutex_lock(&arrived_mutex);
        count -= 1;
        if (count == 0) {
            sem_wait(&synchronization_semaphore1);
            sem_post(&synchronization_semaphore2);
        }
        pthread_mutex_unlock(&arrived_mutex);
        //Throttle all threads
        sem_wait(&synchronization_semaphore2);
        sem_post(&synchronization_semaphore2);
    }
    
    pthread_mutex_lock(&arrived_mutex);
    sexit-=1;
    pthread_mutex_unlock(&arrived_mutex);

}

int main(int argc, char** argv) {
    //initialize an unnamed semaphore shared between threads
    if (sem_init(&synchronization_semaphore1, 0, 0) != 0 ||
            sem_init(&synchronization_semaphore2, 0, 1) != 0) {
        printf("Semaphore not initialized successfully.\n");
        return (EXIT_FAILURE);
    } else {
        for (int i = 0; i < 5; i++) {
            pthread_create(&threads[i], NULL, increment, NULL);
        }
        for(int i = 0; i < 5; i++){
            pthread_join(threads[i], NULL);
        }
    }
    while(sexit > 0){
        
    }
    return (EXIT_SUCCESS);
}

