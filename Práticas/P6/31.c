#include <stdio.h> 
int x;

int f(int a){
	x = a + 1;
	return x;
}

int g(int a){
	x = a - 1;
	return x;
}

int main(void) {

x = 10;
int s1 = f(x) + g(x);
x = 10;
int s2 = g(x) + f(x);
printf("s1 = %d , s2 = %d\n", s1,s2);

}
