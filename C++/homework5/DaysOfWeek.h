#include<iostream>

using namespace std;

class DaysOfWeek{

public:
	DaysOfWeek();
	DaysOfWeek(istream days);
	DaysOfWeek(const DaysOfWeek& d);
	~DaysOfWeek();

	void setDays(istream days);
	ostream getDays();

	bool isEqual(DaysOfWeek);
	bool isOverlap();
private:
	bool days[6];
};

DaysOfWeek::DaysOfWeek(){
for(int i=0; i<6; i++){
this -> days[i]= false;
}
}
DaysOfWeek::DaysOfWeek(const DaysOfWeek& d){
}

void DaysOfWeek::setDays(istream days){
if (days.gcount() > 6){
cout << "ERROR" << endl;
return;
}
for(int i=0; i<6; i++){
}
}

ostream DaysOfWeek::getDays(){
ostream ret;
char* ref = {'M','T','W','R','S'};
	for( int i=0; i<6; i++){
		if(this->days[i] == true){
 		ret.put(ref[i]);
		}
		else{
		ret.put(' ');
		}
	}
return ret;
}
