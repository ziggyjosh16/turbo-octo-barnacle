#include <iostream> 
#include <cstdlib>
#include <ctime>
#include <cstring>

using namespace std; 

int main(){
int numcards=0;
while( numcards > 100 || numcards < 10){
cout << "Please enter the number of cards (10-100 inclusive): " << endl;
cin >> numcards;
}
int *deck=  new int[numcards];
//fill
for (int i=0; i< numcards; i++){
deck[i] = i;
}
//shuffle
srand(time(0));
int random;
for (int i= 0; i<= numcards; i++){
random = (rand() % numcards);
int hol= deck[random];
deck[random]= deck[i];
deck[i] = hol;
}
for ( int i=0; i<numcards; i++){
cout <<  deck[i] << " " ;
}
//play
int score =0;
char res;
char h = 'h';
char l = 'l';
for (int i =0; i<=numcards-1; i++){
res=0;
cout << "Score: " << score << " Current card:  " << deck[i] << endl;

while( res != h && res != l){
cout << "Will the next card be higher or lower? (h/l) " << endl;
cin >> res;
}
if (res == h && deck[i+1] > deck[i] ){
score= score + 1;
}

if (res == l && deck[i+1] < deck[i] ){
score = score + 1;
}

}
cout << "Final Score: " << score << endl;
}


