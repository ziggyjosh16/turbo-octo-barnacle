#include "MySocket.h"
#include <unistd.h>
#include <sys/socket.h>
#include <string.h>
using namespace std;

MySocket::MySocket(){
perror("Must construct socket with a port number"); exit(-1);}


MySocket::MySocket(int p):portNumber(p){
  socketFD = socket(AF_INET, SOCK_STREAM, 0);
 if(socketFD < 0){
	perror("Problem creating the socket");
 	exit(2);
   }
 //create
 memset(&sock, 0, sizeof(sock));
 sock.sin_family = AF_INET;
 sock.sin_addr.s_addr = INADDR_ANY;
 sock.sin_port = htons(portNumber);
 //bind
 if(bind(socketFD, (struct sockaddr*) &sock, sizeof(sock)) <0){
	perror("Error binding");
	exit(1);
  }
return;
}
MyConnection::MyConnection(){exit(-1);}
MyConnection::MyConnection(int fd):connectionFD(fd){}
//using pointers, must write =, copy, destructor
MySocket& MySocket::operator=(MySocket& m){return m;}
MySocket::MySocket(const MySocket& myS){}
MySocket::~MySocket(){}
int MyConnection::read(const char* s){return 0;}
int MyConnection::write(const char* s){return 0;}
int MySocket::listen(){
//return the code from listen for error checking
::listen(socketFD,5);
return socketFD;
}

MyConnection MySocket::accept(){
socklen_t size= sizeof(sock);
 MyConnection c = ::accept(socketFD,(struct sockaddr*) &sock, &size);
 return c;
}
void MySocket::close(){::close(socketFD);}
void MyConnection::close(){::close(connectionFD);}

MyConnection& operator<<(MyConnection& me, const char* s){me.write(s);}
MyConnection& operator>>(MyConnection& me, const char* s){me.read(s);}
