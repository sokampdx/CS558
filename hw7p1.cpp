/*
Anthony So (KAM PUI)
CS558 Fall 2014
Homework 7 Problem 1

*/

/*
Problem 1
Code in Java or C++ a method that takes an array of integers and either returns the minimum even number of the array or throws a user-defined exception if the array contains only odd numbers.

Code a driver that calls the above method and prints the result of the call. Your driver should call the method with an input that results in normal termination of the method and with an input that results in the exception.
*/

#include <iostream>

using namespace std;


int minEven(int * array, int size) {
	int minVal = array[0];
	
	for (int i = 1; i < size; ++i) {
		if ((array[i] < minVal) && (array[i]%2 == 0))
			minVal = array[i];	
	}
	
	try {
		if (minVal % 2 != 0)
			throw minVal;
	} catch (int i) {
		cout << "No even number in the array." << endl;
	}

	return minVal;
}

int main() {
	int good[] = {1,6,9,3,5,-2,1};
  int bad[] = {9,7,5,3,1,-5,11};
	int size = 7;

	cout << "Normal Execution: " << endl;
	cout << minEven(good, size) << endl;
	
	cout << "Exception Execution: " << endl;		
	cout << minEven(bad, size) << endl;

	return 0;
}

/* Output

$ g++ -Wall hw7p1.cpp
$ ./a.out
Normal Execution: 
-2
Exception Execution: 
No even number in the array.
9

*/
