/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Joshua Sharkey
 *
 * Created on November 22, 2018, 3:34 PM
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
//include <Stdbool.h>

typedef enum {
    false,
    true
} bool;

static bool caught_snitch = false;


static int playerThreadIds[14];
static pthread_t main_thread;
static pthread_t team1[8];
static pthread_t team2[8];
static pthread_t balls[4];
static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

static int score1 = 0;
static int score2 = 0;

bool isTeam1() {
    //thread will check each team array for its own PID
    /*if it finds the pid then select a random team member from the
     * same array and send it a signal (SIGUSR1)
     **/
    pthread_t pid = pthread_self();
    int i;
    pthread_mutex_lock(&mutex);
    for (i = 0; i < 8; i++) {
        if (team1[i] == pid) {
            pthread_mutex_unlock(&mutex);
            return true;
        } else {
            continue;
        }
    }
    pthread_mutex_unlock(&mutex);
    return false;
}

void *bludger() {
    sleep(1);
    char name[256];
    pthread_t pid = pthread_self();
    srand(pid);
    int err;
    err = pthread_setname_np(pid, "Bludger");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    int target;
    while (1) {
        sleep(10);
        //send an interrupt signal to a random pthread
        target = rand() % 7;
        if (rand() % 2 == 0) {
            if (pthread_kill(team1[target], SIGINT) == 0) {
            } else {
                // printf("Bludger: Signal Not Sent.\n");
            }
        } else {
            if (pthread_kill(team1[target], SIGINT) == 0) {
            } else {
                // printf("Bludger: Signal Not Sent.\n");
            }
        }

    }
}

void *beater() {
    sleep(1);
    int err;
    char name[256];
    pthread_t pid = pthread_self();
    srand(pid);
    err = pthread_setname_np(pid, "Beater");

    int target;
    bool use = isTeam1();
    while (1) {
        sleep(1);
        target = rand() % 7;
        if (use == true) {
            if (pthread_kill(team1[target], SIGUSR1) == 0) {
            } else {
                // printf("Beater: Signal Not Sent.\n");
            }
        } else {
            if (pthread_kill(team2[target], SIGUSR1) == 0) {
            } else {
                // printf("Beater: Signal Not Sent.\n");
            }
        }

    }
}

void *quaffle() {
    sleep(1);
    pthread_t pid = pthread_self();
    srand(pid);
    int err;
    char name[256];
    err = pthread_setname_np(pid, "Quaffle");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    int i;
    int target;
    while (1) {
        i = rand() % 5;
        sleep(i);
        target = rand() % (4 + 1 - 2) + 2;
        if (rand() % 2 == 0) {
            target = rand() % 7;
            pthread_kill(team1[target], SIGUSR2);
        } else {
            pthread_kill(team2[target], SIGUSR2);
        }
    }
}

void *snitch() {
    sleep(5);
    pthread_t pid = pthread_self();
    int err;
    char name[256];
    err = pthread_setname_np(pid, "Snitch");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    int secs;
    while (1) {
        secs = rand() % 10;
        sleep(secs);
        pthread_mutex_lock(&mutex);
        caught_snitch = true;
        pthread_mutex_unlock(&mutex);
        sleep(1);
        pthread_mutex_lock(&mutex);
        caught_snitch = false;
        pthread_mutex_unlock(&mutex);
    }
}

void *seeker() {
    sleep(1);
    pthread_t pid = pthread_self();
    srand(pid);
    int err;
    char name[256];
    err = pthread_setname_np(pid, "Seeker");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    int secs;
    bool is1 = isTeam1();
    while (1) {
        secs = rand() % 20;
        sleep(secs);
        pthread_mutex_lock(&mutex);
        if (caught_snitch == true) {
            printf("Snitch found!\n");
            if (is1 == true) {
                score1 += 150;
            } else {
                score2 += 150;
            }
            pthread_kill(main_thread, SIGINT);
        }
        pthread_mutex_unlock(&mutex);
    }
}

void *keeper() {
    sleep(1);
    pthread_t pid = pthread_self();
    int err;
    char name[256];

    err = pthread_setname_np(pid, "Keeper");
    err = pthread_getname_np(pid, name, 256);

    printf("%s joined the game!\n", name);
    int i;
    bool is1 = isTeam1();
    while (1) {
        i = rand() % 10;
        sleep(i);
        if (is1 == true) {
            pthread_kill(team1[7], SIGUSR1);
        } else {
            pthread_kill(team2[7], SIGUSR1);
        }
    }
}

void *chaser() {
    sleep(1);
    pthread_t pid = pthread_self();
    int err;
    char name[256];
    err = pthread_setname_np(pid, "Chaser");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    while (1) {
        //nothing is done here
    }
}

void *goalPost() {
    sleep(1);
    pthread_t pid = pthread_self();
    int err;
    char name[256];
    err = pthread_setname_np(pid, "Goal Post");
    err = pthread_getname_np(pid, name, 256);
    printf("%s joined the game!\n", name);
    while (1) {
        // nothing done here
    }
}

/*
 * this function executes when a signal is sent, the type of signal as well as 
 * the source dictates the action that will be taken
 */
void handler(int signo, siginfo_t *info, void *extra) {
    char name[256];

    pthread_t pid = pthread_self();
    pthread_getname_np(pid, name, 256);

    //clear signalset and add new signals depending on the process
    sigset_t signals;
    sigemptyset(&signals);
    bool is1 = isTeam1();
    switch (signo) {
        case SIGINT:; // ';' - empty statement to allow declaration
            struct timespec time;
            if (pid == main_thread) {
                //game over
                printf("\n\nGame Over!\n Scores: Team 1:%d Team2:%d\n", score1, score2);
                exit(EXIT_SUCCESS);
            } else if (pid == team1[7] || pid == team2[7]) {
                printf("Shot taken on Goal.\n", pid);
                time.tv_sec = 2;
                time.tv_nsec = 0;
                sigaddset(&signals, SIGUSR1);
                if (sigtimedwait(&signals, NULL, &time) == SIGUSR1) {
                    printf("Shot was saved by the Keeper!\n");
                } else {
                    //Goal was scored
                    if (is1 == true) {
                        pthread_mutex_lock(&mutex);
                        score2 += 10;
                        pthread_mutex_unlock(&mutex);
                    } else {
                        pthread_mutex_lock(&mutex);
                        score1 += 10;
                        pthread_mutex_unlock(&mutex);
                    }
                    printf("Goal was scored!\n Scores:\n"
                            " Team 1: %d     Team  2: %d\n\n", score1, score2);

                }
            } else {
                printf("Bludger is going for %s:%d!\n", name, pid);
                sigaddset(&signals, SIGUSR1);

                time.tv_sec = 3;
                time.tv_nsec = 0;
                if (sigtimedwait(&signals, NULL, &time) == SIGUSR1) {
                    printf("%s:%d was saved by a beater!\n", name, pid);
                } else {
                    printf("%s:%d was knocked off by bludger!\n", name, pid);
                    pthread_exit(NULL);
                }
            }
            break;
        case SIGUSR1:
            break;
        case SIGUSR2:
            if (is1 == true) {
                pthread_kill(team2[7], SIGINT);
            } else {
                pthread_kill(team1[7], SIGINT);
            }
            break;
        default:
            printf("Huh?: %d\n", signo);
    }
}

//this function assigns the handler function to a certain signal
void setHandlers() {
    struct sigaction action = {handler};
    if (sigaction(SIGINT, &action, NULL) == -1) {
        perror("error while creating action handler.");
    }
    if (sigaction(SIGUSR1, &action, NULL) == -1) {
        perror("error while creating action handler.");
    }
    if (sigaction(SIGUSR2, &action, NULL) == -1) {
        perror("error while creating action handler.");
    }
}

//initialization and run main thread
int main(int argc, char** argv) {
    int err;
    main_thread = pthread_self();
    setHandlers();
    //balls
    for (int i = 0; i < 4; i++) {
        if (i == 1 || i == 0) {
            err = pthread_create(&balls[i], NULL, bludger, NULL);
            continue;
        }
        if (i == 2) {
            err = pthread_create(&balls[i], NULL, quaffle, NULL);
            continue;
        }
        if (i == 3) {
            err = pthread_create(&balls[i], NULL, snitch, NULL);
            continue;
        }
    }
    //players and goals
    for (int i = 0; i < 8; i++) {
        if (i == 0) {
            err = pthread_create(&team1[i], NULL, seeker, NULL);
            err = pthread_create(&team2[i], NULL, seeker, NULL);
            continue;
        }
        if (i == 1) {
            err = pthread_create(&team1[i], NULL, keeper, NULL);
            err = pthread_create(&team2[i], NULL, keeper, NULL);
            continue;
        }
        if (i == 2 || i == 3 || i == 4) {
            err = pthread_create(&team1[i], NULL, chaser, NULL);
            err = pthread_create(&team2[i], NULL, chaser, NULL);
            continue;
        }
        if (i == 5 || i == 6) {
            err = pthread_create(&team1[i], NULL, beater, NULL);
            err = pthread_create(&team2[i], NULL, beater, NULL);
            continue;
        } else {
            err = pthread_create(&team1[i], NULL, goalPost, NULL);
            err = pthread_create(&team2[i], NULL, goalPost, NULL);
            continue;
        }


    }

    while (1) {

    }

    return (EXIT_SUCCESS);
}
