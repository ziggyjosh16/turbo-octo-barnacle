#include <iostream>
using namespace std;



 int main(){

 int min = 10000000;
 int max = -10000000;
 int sum=0;
 int num=0;


cout << "Statistics Program" << endl;
cout << "-------------------------------------" << endl;
 while ( num<1 || num>100){
 cout << "Please enter the size of the dataset of integers (1-100): ";
 cin >> num;
}
for (int i=0; i<num; i++){
	cout << "Enter Value " << i+1  << ": " << endl;
	int input;
	cin >> input;
	if (input<min){
	min = input;
	}
	if (input > max){
	max = input;
	}
	sum += input;
	}

cout << "Min: " << min << endl;
cout << "Max: " << max << endl;
cout << "Mean: " << (double)sum/num << endl;
return 0;

}
