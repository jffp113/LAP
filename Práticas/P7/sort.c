#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#define N_ELEMS     30

void fill(int vect[], int n) {
    srand(time(NULL));

    for(int i = 0; i < n ; i++)
        vect[i] = rand() % 101;
}

int compar(const void* a, const void * b){
    return *(int*)a - *(int*)b;
}

void sort(int vect[], int n) {
    qsort(vect,n,sizeof(int),*compar);
}

void show(int vect[], int n) {
    int i;
    printf("----------------\n");
    for( i = 0 ; i < n ; i++ )
        printf("%12d\n", vect[i]);
    printf("----------------\n");
}

int main() {
    int vect[N_ELEMS];
    fill(vect, N_ELEMS);
    show(vect, N_ELEMS);
    sort(vect, N_ELEMS);
    show(vect, N_ELEMS);
    return 0 ;
}