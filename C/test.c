#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

static int interrupts = 0;
static int triggered = 0;

void h(int signo)
{
    switch (signo)
    {
    case SIGINT:
        interrupts++;
        break;
    case SIGALRM:
        printf("Flag:%d\n", triggered);
        if (triggered == 1)
        {
            exit(0);
        }
        //print the iterrupts
        for (int i = 0; i < interrupts; i++)
        {
            printf("hello\n");
        }
        //ignore subsequent interrupts
        struct sigaction lastact = {SIG_IGN};
        sigaction(SIGINT, &lastact, NULL);
        triggered++;
        alarm(100);
        break;
    }
}

int main()
{
    struct sigaction action = {h};
    struct sigaction action2 = {h};
    //set up handlers
    sigaction(SIGINT, &action, NULL);
    sigaction(SIGALRM, &action2, NULL);

    alarm(100);
    while (1)
    {
    }
    return 0;
}