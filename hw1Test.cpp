
#include <iostream>
using namespace std;

class Shape {
	protected:
		float width, height;

	public:
		Shape(float w, float h): width(w), height(h) {}
		Shape(float w): width(w), height(0) {}

		virtual float area (void) = 0;

		void printArea() { 
			cout << this->area() << endl;
		}
};

class Rectangle: public Shape {
	public:
		Rectangle(float w, float h) : Shape(w, h) {}
		float area () {
			return width * height;
		}
};

class Triangle: public Shape {
	public:
		Triangle(float b, float h) : Shape(b, h) {}
		float area () {
			return 0.5 * width * height;
		}
};

class Square: public Shape {
	public:
		Square(float s) : Shape(s, s) {}
		float area () {
			return width * width;
		}
};

class Circle: public Shape {
	public:
		Circle(float r): Shape(r) {}
		float area () {
			return 3.14 * width * width;
	}
};


int main() {
	Rectangle rectangle(5,6);
	Triangle triangle(3,8);
	Square square(5);
	Circle circle(5);

	rectangle.printArea();
	triangle.printArea();
	square.printArea();
	circle.printArea();

	return 0;
}





