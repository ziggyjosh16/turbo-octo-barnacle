#include <string>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netdb.h>
#include <stdlib.h>
#include <strings.h>
#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <netinet/ip.h>
using namespace std;
#ifndef MYSOCKET
#define MYSOCKET
const int MAXHOSTNAME=255;

class MyConnection //represents the communication connection between child process and client
{
  private:
  int connectionFD;
  public:
  MyConnection(); //print error, exit(-1); must construct with fd
  MyConnection(int fd); //MyConnection is just a wrapper for the fd to allow overloading << and >>
  int read(const char* s); //return bytes read, -1 on error; will be used in >>
  int write(const char* s); //return bytes written, -1 on error; will be used in <<
  void close(); //close the connection
};


class MySocket
{
  private:
  struct  sockaddr_in sock;
  int socketFD;
  int portNumber;

  public:
  MySocket(); //print error, exit(-1); must construct with port #
  MySocket(int portNumber); //creates the server listening socket
  //must implement  =, copy, destructor
  MySocket& operator=(MySocket&);
  MySocket(const MySocket&);
  ~MySocket();
  int listen(); //call once to start listening
  MyConnection accept(); //call repeatedly when connecting to client; returns client stream
  void close();
};


MyConnection& operator<<(MyConnection& myC, const char* s);
MyConnection& operator>>(MyConnection& myC, const char* s);
#endif

