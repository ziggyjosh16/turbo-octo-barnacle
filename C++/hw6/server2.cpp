#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <netdb.h>
#include <netinet/in.h>
#include "MySocket.h"
#include "MySocket.cpp"
#include <string.h>
#include <iostream>
using namespace std;

void doprocessing (MyConnection& c);

int main( int argc, char *argv[] ) {
int pid;
MySocket m(16630);
m.listen();
   while (1) {
      MyConnection c = m.accept();
      /* Create child process */
      pid = fork();
      if (pid < 0) {
         perror("ERROR on fork");
         exit(1);
      }
      if (pid == 0) {
         /* This is the client process */
         m.close();
         doprocessing(c);
         exit(0);
      }
      else {
         c.close();
      }

   } /* end of while */
}

void doprocessing (MyConnection& c) {
   int n;
   char *inS;
   cout <<  "Eliza> Hello, and welcome (Q to quit)" << endl;
   while (!strcmp(inS,"Q"))
   {
   cin >> inS;
   c << "I got your message: " << inS << "\n";
   }
   exit(0);
}
