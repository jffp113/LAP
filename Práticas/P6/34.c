#include <stdio.h>
#include <math.h>
#include <stdlib.h>

typedef enum { LINE, CIRCLE, RECTANGLE, TRIANGLE } ShapeKind ;
typedef struct { double x, y; } Point;
typedef struct { Point p1, p2; } Line;
typedef struct { Point centre; int radius; } Circle;
typedef struct { Point top_left; double width, height; } Rectangle;
typedef struct { Point a; Point b; Point c;} Triangle;

typedef struct {   // Isto é um tipo SOMA, programado com a ajuda duma UNION
    ShapeKind kind;
    int color;
    union {
        Line line; 
        Circle circle;
        Rectangle rectangle; 
        Triangle triangle;
    } u;
} Shape;

Point point(double x, double y) // construtor de pontos
{
    Point p = {x, y};
    return p;
}

Shape line(Point p1, Point p2, int color) // construtor de linhas
{
    Line l = {p1, p2};
    Shape s = {LINE, color};
    s.u.line = l;
    return s;
}

Shape rectangle(Point top_left, double width, double height,int color){
	Rectangle r = {top_left,width,height};
	Shape shape = {RECTANGLE,color};
	shape.u.rectangle = r;
	return shape;
}

Shape circle(Point p, int radius, int color){
    Circle c = {p,radius};
    Shape shape = {CIRCLE,color};
    shape.u.circle = c;
    return shape;
}

Shape triangle(Point p1, Point p2, Point p3, int color) {
	Triangle t = {p1,p2,p3};
	Shape shape = {TRIANGLE,color};
	shape.u.triangle = t;
    return shape;
}

double area (Shape s) {
	double value;
	Point a;
	Point b; 
	Point c;

		switch(s.kind){
			case TRIANGLE:
				a = s.u.triangle.a;
				b = s.u.triangle.b;
				c = s.u.triangle.c;
				value = abs((a.x * (b.y-c.y) + b.x * (c.y - a.y)  + c.x * (a.y - b.y)))/2;
				break;
				
			case CIRCLE:
				value = M_PI * pow(s.u.circle.radius,2);
				break;

			case RECTANGLE:
				value = s.u.rectangle.width * s.u.rectangle.height;
				break;

			default:
				value = 0;
				break;
		}

	return value;
}

int main(void)
{
    Shape c = circle(point(0,0), 1, 99);
    printf("%lf\n", area(c));
    Shape t = triangle(point(0,0), point(5,10), point(10,5), 99);
    printf("%lf\n", area(t));
    return 0;
}