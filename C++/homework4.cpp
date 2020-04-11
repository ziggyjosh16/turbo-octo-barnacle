
#include <iostream>
#include <pwd.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string>
#include <cstring>
using namespace std;

////////////////////////CLASS//////////////////////
class Archive{

public:
Archive(char* filename);
Archive(Archive a1);

void writeArc(char* filename);
void copyDir(char* direct);
void printPer(struct stat buf);
void expandDir(char* dest);

private:

int archive;
int numFiles;
int size;

int errStruct(char*name);
};

////////////////////////////////////////////////////////////


////////////////IMPLEMENATION//////////////////////////
Archive::Archive(char* filename){
this->archive= open(filename, O_RDWR | O_TRUNC, 0664);
this->numFiles=0;
this->size=0;
}
Archive::Archive(Archive a1){
this->archive=a1.archive;
this-numFiles=a1.numFiles;
this->size= a1.size;
}

void Archive::writeArc(char* filename){
int file= open(filename, O_READONLY);
if(file == -1){
return;
}
char buffer[256];
int bytesRead;
while((bytesRead = read(filename, buffer, 256)) != 0){
	write(archive, buffer, bytesRead);
}
write(archive, "endoffile");
}//endwriteArc


void Archive::copyDir(char* direct){
DIR * dir = opendir(direct);
struct direent* item;
while((item = readDir(dir)) != NULL){
	if(errStruct(item->d_name == -1){
	 cout<<"could not access " << item->d_name <<  << endl;
	continue;
	}
	else{
	//if the entry is a dir, call copyDir(item->d_name) again,
	//else copy the file contents
		if(S_ISDIR(/*structname goes here*/.st_mode)){
		copyDir(item->d_name);	
		}
		if(S_ISDIR(/*name*/.st_mode)){
		writeArc(item->d_name);//copy file contents into archive file
		}
	}
}//endwhile
}//endcopyDir


void Archive::printPer(struct stat buf){
string per = "";
if(buf.st_mode & S_IRUSR){
per += "r";
}
else{
per += "_";
}
if(buf.st_mode & S_IWUSR){
per += "w";
}
else{
per += "_";
}
if(buf.st_mode & S_IXUSR){
per += "x";
} 
else{
per += "_";
}
if(buf.st_mode & S_IRGRP){
per += "r";
}
else{
per += "_";
}
if(buf.st_mode & S_IWGRP){
per += "w";
}
else{
per += "_";
}
if(buf.st_mode & S_IXGRP){
per += "x";
}
else{
per += "_";
}
if(buf.st_mode & S_IROTH){
per += "r";
}
else{
per += "_";
}
if(buf.st_mode & S_IWOTH){
per += "w";
}
else{
per += "_";
}
if(buf.st_mode & S_IXOTH){
per += "x";
}
else{
per += "_";
} 

cout << "Access: " << per <<endl;
return;
}//end print per

void Archive::expandDir(char* dest){
} 
int Archive:: errStruct(char* name){
struct stat status;
return stat(name, &status); 
}//end errStruct

/////////////////////////////////////////////////////////////

//////////////////////////MAIN//////////////////////////////////

int main(int argc, char ** argv){
Archive a1;
if(argv[1] == "-c"){
a1= new Archive(argv[3]);
a1.copyDir(argv[2]);
cout << "new Archive file created at " >>  argv[3];
delete a1;
EXIT(0);
}
if(argv[1] == "-e"){
a1= new Archive(argv[2]);
a1.expandDir(argv[3]);//expand contents
cout << "Archive expanded to " << argv[2];
delete a1;
EXIT(0);
}
}


