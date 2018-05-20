#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "LinkedList.h"

typedef struct Node {
    Data data;
    List next;
} Node;

static List newNode(Data val, List next)
{
    List n = malloc(sizeof(Node));
    if( n == NULL )
        return NULL;
    n->data = val;
    n->next = next;
    return n;
}

List listMakeRange(Data a, Data b)
{  // TECNICA ESSENCIAL: Ir fazendo crescer a lista no ultimo no'.
    if( a > b )
        return NULL;
    double i;
    List l = newNode(a, NULL), last = l;
    for( i = a + 1 ; i <= b ; i++ )
        last = last->next = newNode(i, NULL);
    return l;
}

/* Outra maneira, mais palavrosa, de escrever a funcao anterior:

List listMakeRange(Data a, Data b)
{
    if( a > b )
        return NULL;
    double i;
    List l = newNode(a, NULL);
    List last = l;
    for( i = a + 1 ; i <= b ; i++ ) {
        List q = newNode(i, NULL);
        last->next = q;
        last = q;
    }
    return l;
}
*/

int listLength(List l) {
    int count;
    for( count = 0 ; l != NULL ; l = l->next, count++ );
    return count;
}

bool listGet(List l, int idx, Data *res)
{
    int i;
    for( i = 0 ; i < idx && l != NULL ; i++, l = l->next );
    if( l == NULL )
        return false;
    else {
        *res = l->data;
        return true;
    }
}

List listPutAtHead(List l, Data val)
{
    return newNode(val, l);
}

List listPutAtEnd(List l, Data val)
{
    if( l == NULL )
        return newNode(val, NULL);
    else {
        List p;
        for( p = l ; p->next != NULL ; p = p->next ); // Stop at the last node
        p->next = newNode(val, NULL);  // Assign to the next of the last node
        return l;
    }
}

List listFilter(List l, BoolFun toKeep)
{  // TECNICA ESSENCIAL: Adicionar um no' auxiliar inicial para permitir tratamento uniforme.
      // Tente fazer sem o no' suplementar e veja como fica muito mais complicado.
    Node dummy;
    dummy.next = l;
    l = &dummy;
    while( l->next != NULL )
        if( toKeep(l->next->data) )
            l = l->next;
        else {
            List del = l->next;
            l->next = l->next->next;
            free(del);
        }
    return dummy.next;
}

List listClone(List l) {//Tecnica 
    List n,tmp;

    if(l == NULL)
        return NULL;

    n = newNode(l->data,NULL);
    tmp = n;
    l = l->next;
    for( ;l != NULL; l = l->next){
        tmp = tmp->next = newNode(l->data,NULL);
    }

    return n;
}

List listAppend(List l1 , List l2) {
    if(l1 == NULL)
        return listClone(l2);

    List l = l1;

    for( ; l->next != NULL; l = l->next);

    l->next = listClone(l2);

    return l1;
}

List ListRev(List l){

    List new = NULL;

    while(l != NULL){
        new = newNode(l->data,new);
         l = l->next;
    }

    return new;
}

void swapNodes(Node *a, Node *b){
    List tmp = a;
    a = b;
    b = tmp;
}

List ListRev2(List l){
    if(l == NULL)
        return NULL;

    List prev = NULL;
    List next = NULL;

    for(;l != NULL;prev=l,l=next){
        next = l->next;
        l->next = prev;
    }


    return prev;
    
}

bool belongs(List l , Data a){

    for(; l != NULL; l = l->next)
        if(l->data == a)
            return true;
    return false;
}

List listUniq(List l) {
    List res = l;
    List prev = NULL;


    for(;l != NULL;prev = l,l = l->next){
        if(belongs(l->next,l->data)){
            if(prev != NULL)
                prev->next = l->next;
            else
                res = l->next;

            free(l);
        }
    }
    return res;
}

void listPrint(List l)
{
    for( ; l != NULL ; l = l->next )
        printf("%lf\n", l->data);
}

static bool isEven(Data data) {
    return (int)data % 2 == 0;
}

static bool isOdd(Data data) {
    return (int)data % 2 != 0;
}

void listTest(void) {
    List l = listMakeRange(1.1, 10.8);
    List new = listClone(l);
    listAppend(new,l);
    List rev = ListRev(new);
    printf("----------\n");
    listPrint(l);
    printf("----------\n");
    l = listFilter(l, isEven);
    listPrint(l);
    printf("----------\n");
    l = listFilter(l, isOdd);
    listPrint(l);
    printf("clone+-----\n");
    listPrint(new);
    printf("----------\n");
    printf("rev-----\n");
    listPrint(rev);
    printf("----------\n");
    printf("rev2-----\n");
    l = listMakeRange(1.1, 10.8);
    l = ListRev2(l);
    listPrint(l);
    printf("uniq--------\n");
    l = listMakeRange(1.1, 10.8);
    l = listPutAtEnd(l,7.1);
    l = listPutAtHead(l,1.1);
    
    //listPrint(l);
    l = listUniq(l);
    listPrint(l);

}
void main(void) {
    listTest();
}