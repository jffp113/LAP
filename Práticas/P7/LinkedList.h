#ifndef _LinkedList_
#define _LinkedList_

#include <stdbool.h>

typedef double Data;
/*typedef struct Node {
    Data data;
    struct Node *next;
} Node, *List;  /* Uma lista e' um apontador para um no' */

typedef bool BoolFun(Data);
typedef struct Node *List;

List listMakeRange(Data a, Data b);
int listLength(List l);
bool listGet(List l, int idx, Data *res);
List listPutAtHead(List l, Data val);
List listPutAtEnd(List l, Data val);
void listPrint(List l);
List listFilter(List l, BoolFun toKeep);
void listTest(void);
#endif