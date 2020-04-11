#include <iostream> 
#include <stdio.h>
#include <stdlib.h>
#include <fstream>
#include <string>
using namespace std;

int main(int argc, char** argv){
int offset= argc;
char buffer[256];
char buffer2[256];
string line;

//printf("Enter the pathname of the source file: ");
//cin >> buffer;

//printf("Enter the pathname of the new file: ");
//cin >> buffer2;

ofstream outFile;
ifstream myFile;


myFile.open(argv[2]);
outFile.open(argv[3]);

if (!myFile.is_open()){
cout << "Error opening file location: " << buffer << endl;
exit (EXIT_FAILURE);
}
if (!outFile.is_open()){
cout << "Error creating output file in location: " << buffer2 << endl;
exit (EXIT_FAILURE);
}


while(offset < -25 || offset > 25){
printf("Enter the offset(-25 - 25): ");
cin >> offset;
}

while(getline(myFile, line)){
for (int i=0; i<line.size(); i++){
	
//	line[i] |= i;

	if(isalpha(line[i]))
	{
	int n= (int) (line[i]) + offset;
	char el= (char) n;
	line[i] = el;
	}
}

outFile << line;
}



myFile.close();
outFile.close();
return 0;

} 


