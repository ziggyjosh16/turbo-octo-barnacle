/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * File:   main.c
 * Author: Joshua Sharkey
 *
 * Created on December 9, 2018, 4:11 PM
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
//student threads
static pthread_t gteam[10];
static pthread_t steam[10];
static pthread_t rhteam[10];
static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

//number of students
int gs = 0;
int ss = 0;
int rhs = 0;
// queues
sem_t gsem;
sem_t ssem;
sem_t rhsem;

void *castSpells() {
    pthread_mutex_lock(&mutex);
    ss +=1;
    int isShotgun = 0;

    if ( gs >= 1 && rhs >= 2) {
        ss -=1;
        gs -=1;
        rhs -=2;
        sem_post(&gsem);
        sem_post(&ssem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("1 Slytherin, 1 Gryffindor, and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( rhs >= 3 ) {
        ss -=1;
	rhs -=3;
	sem_post(&ssem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("1 Slytherin and 3 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( ss >= 2 && rhs >= 2) {
        ss -=2;
        rhs -=2;
        sem_post(&ssem);
        sem_post(&ssem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("2 Slytherin and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( ss >= 3 && rhs >= 1){
	ss -=3;
	rhs -=1;
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("3 Slytherin and 1 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( ss >= 4 ) {
        ss -=4;
        for (int i = 0; i < 4; i++) {
            sem_post(&ssem);
        }
        isShotgun ++;
        printf("4 Slytherin have boarded.\n");
    } else {
        pthread_mutex_unlock(&mutex);
    }
    //get into the queue
    if (isShotgun == 1){
      printf("Departing.\n\n");
//      pthread_mutex_unlock(&mutex);
    } else {
        sem_wait(&ssem);
    }
    pthread_mutex_unlock(&mutex);
}

void *castSpellg() {
    pthread_mutex_lock(&mutex);
    gs +=1;
    int isShotgun = 0;
    if ( ss >= 1 && rhs >= 2) {
        ss -=1;
        gs -=1;
        rhs -=2;
        sem_post(&gsem);
        sem_post(&ssem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("1 Slytherin, 1 Gryffindor, and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( rhs >= 3 ) {
        gs -=1;
	rhs -=3;
	sem_post(&gsem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("1 Gryffindor and 3 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( gs >= 2 && rhs >= 2) {
        gs -=2;
        rhs -=2;
        sem_post(&gsem);
        sem_post(&gsem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("2 Gryffindor and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( gs >= 3 && rhs >= 1){
	gs -=3;
	rhs -=1;
	sem_post(&gsem);
	sem_post(&gsem);
	sem_post(&gsem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("3 Gryffindor and 1 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( gs >= 4 ) {
        gs -=4;
        for (int i = 0; i < 4; i++) {
            sem_post(&gsem);
        }
        isShotgun ++;
        printf("4 Gryffindor have boarded.\n");
    } else {
        pthread_mutex_unlock(&mutex);
    }
     //get into the queue
    if (isShotgun == 1){
      printf("Departing.\n\n");
  //    pthread_mutex_unlock(&mutex);
    } else {
        sem_wait(&ssem);
    }
    pthread_mutex_unlock(&mutex);
}

void *castSpellrh() {
    pthread_mutex_lock(&mutex);
    rhs +=1;
    int isShotgun = 0;
    if (ss >= 1 && gs >= 1 && rhs >= 2) {
        ss -=1;
        gs -=1;
        rhs -=2;
        sem_post(&gsem);
        sem_post(&ssem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("1 Slytherin, 1 Gryffindor, and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if ( rhs >= 2 && gs >= 2 ) {
	rhs -=2;
	gs -=2;
	sem_post(&gsem);
	sem_post(&gsem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("2 Gryffindor and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if (rhs >=2 && ss >=2) {
	ss -=2;
	rhs -=2;
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&rhsem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("2 Slytherin and 2 Ravenclaw/Hufflepuff have boarded.\n");
    } else if (gs >= 2 && rhs >= 2) {
        gs -=2;
        rhs -=2;
        sem_post(&ssem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        sem_post(&rhsem);
        isShotgun ++;
        printf("2 Slytherin and 2 Ravenclaw/Hufflepuff have boarded..\n");
    } else if (ss >= 3 && rhs >= 1) {
	ss -=3;
	rhs -=1;
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&rhsem);
	isShotgun ++;
	printf("3 Slytherin and 1 Ravenclaw/Hufflepuff have boarded.\n");
    } else if (gs >= 3 && rhs >= 1) {
	gs -=3;
	rhs -=1;
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&ssem);
	sem_post(&ssem);
	isShotgun ++;
	printf("3 Gryffindoor and 1 Ravenclaw/Hufflepuff have boarded..\n");
    } else if ( rhs  >= 4 ) {
        ss -=4;
        for (int i = 0; i < 4; i++) {
            sem_post(&ssem);
        }
        isShotgun ++;
        printf("4 Slytherin have boarded.\n");
    } else {
        pthread_mutex_unlock(&mutex);
    }
    //get into the queue
    if (isShotgun == 1) {
      printf("Departing.\n\n");
//      pthread_mutex_unlock(&mutex);
    } else {
        sem_wait(&ssem);
    }
    pthread_mutex_unlock(&mutex);

}

int main(int argc, char** argv) {
    if (sem_init(&gsem, 0, 0) != 0 ||
            sem_init(&ssem, 0, 0) != 0 ||
            sem_init(&rhsem, 0, 0) != 0) {
        printf("Semaphore not initialized successfully.\n");
        return (EXIT_FAILURE);
    } else {
        for (int i = 0; i < 10; i++) {
            pthread_create(&steam[i], NULL, castSpells, NULL);
            pthread_create(&gteam[i], NULL, castSpellg, NULL);
            pthread_create(&rhteam[i], NULL, castSpellrh, NULL);
        }
        for (int i = 0; i < 10; i++) {
            pthread_join(&steam[i], NULL);
            pthread_join(&gteam[i], NULL);
            pthread_join(&rhteam[i], NULL);
        }
    }
    printf("OK!");
    pthread_mutex_destroy(&mutex);
    return (EXIT_SUCCESS);
}


