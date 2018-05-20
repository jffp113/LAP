#include <stdio.h>
int a;      // variável a-global
int b;      // variável b-global

void p(void) { a = b; }

void f(int b) {   // parâmetro b-local
    int a = b;    // variável a-local
    p();   /* aqui */
}

int main(void) {
    a = 5; b = 6; f(7);
    printf("%d %d\n", a, b);
    return 0;
}