#include <iostream>
#include <DaysOfWeek.h>
#include <string>

using namespace std;

class Course{

public:
	Course();
	Course(DaysOfWeek d);
	Course(int sec);
	Course(char* cc);
	Course(char* i, int s, char* c, DaysOfWeek d); 
	Course(const Course&);
	~Course();


	void setDays(DaysOfWeek d);
	void setSection(int sec);
	void setCode(char *code);
	void setInstructor(char * inst);


	DaysOfWeek getDays();
	int getSection();
	char* getCode();
	char* getInstructor();

	bool isOverlap(Course a);
	bool isMatch(Course a);

	// overlap some operators or whatever here
private:
	int section;
	DaysOfWeek days;
	char *instructor;
	char *courseCode;
};
Course::Course(){
section = 0;
days =  new DaysofWeek();
instructor= "jsharkey";
courseCode = "None";
}
Course::~Course(){
//not sure what to delete
}
DaysOfWeek Course::getDays(){
return this -> days;
}
int Course::getSection(){
return this -> section;
}
char* Course::getCode(){
return this -> courseCode;
}
char* Course::getInstructor(){
return this -> instructor;
}
bool Course::isOverlap(Course a){

}
bool Course:: isMatch(Course a){
return ( (a.getSection() == section) && (a.getCode() == code)
 && (a.getInstructor() == instructor) && (a.getDays() == days));
}
void Course::setDays(DaysOfWeek d){
this-> DaysOfWeek = d;
}
void Course::setSection(int sec){
this -> section = sec;
}
void Course::setCode(char* code){
this -> courseCode = code;
}
void Course::setInstructor(char* inst){
this ->  instructor = inst
}


