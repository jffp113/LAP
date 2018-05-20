#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include "LinkedList.h"

typedef double Data;

typedef struct Node {
    Data data;
    struct Node *right,*left;

} Node , *Tree;



Tree newTreeNode(Tree right , Tree left , Data a) {
    Tree n = malloc(sizeof(Node));

    if(n == NULL)
        return NULL;

    n->data = a;
    n->right = right;
    n->left = left;

    return n;
}

int treeLength(Tree t) {
    if(t == NULL)
        return 0;

    return 1 + treeLength(t->right) + treeLength(t->left);
}

void treePrint(Tree t,int l, int r)
{
    
}


void treeTest(void) {
    Tree t = newTreeNode(NULL,NULL,10.5);
    t = newTreeNode(t,NULL,9.0);
    t = newTreeNode(NULL,t,8.5);
    printf("size %d\n", treeLength(t));
    treePrint(t,0,0);

}
void main(void) {
    treeTest();
}