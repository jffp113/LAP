#include <stdio.h>
#include <stdint.h>

#if defined(__LP64__)
    typedef uint64_t Word;
#else
    typedef uint32_t Word;
#endif
typedef Word *Ptr;

void f(Word a1, Word a2, Word a3) {
    Word local1 = 55555;
    Word local2 = 66666;
    Word local3 = 77777;
    // ...

    Ptr pt = &local1;

    int i ;

    for(i = -10 ; i < 10 ; i++)
    	printf("%p: %u\n", pt + i, pt[i]);
}

int main(void) {
    f(11111, 22222, 33333);
    return 0;
}