/*
 * WCompact.c
 *
 *  Created on: May 3, 2018
 *      Author 1: Sicrano (88888)
 *      Author 2: Beltrano (99999)
 */


#include "WCompact.h"

/* STRINGS */


/* LETTERS */

static char letterFirst(void)
{
    return 'A';
}

static char letterNext(char letter)
{
    if( letter == 'Z' )
        return 'a';
    else if( letter == 'z' )
        return ' ';
    else
        return letter + 1;
}

static int order(char c)
{
    if( 'A' <= c && c <= 'Z' )
        return c - 'A';
    else if( 'a' <= c && c <= 'z' )
        return ('Z'-'A'+1) + c - 'a';
    else
        return -1;
}

static bool isLetter(char c)
{
    return order(c) != -1;
}


/* CODES */

void codeNext(String code)
{
}


/* WORDS */

WordInfo words[MAX_WORDS];
int wordsN = 0;        /* number of slots filled */


/* LEXICAL TREE */

static Node root = { NULL, {}};
Tree tree = &root;
static int sorted[MAX_WORDS];


/* COMPRESS */

void processWord(String word)
{
}

void processLine(String line)
{
}

void processTable(void)
{
}

char *translateWord(String word)
{
    return NULL;
}

void compress(String inFilename, String outFilename)
{
}


/* DECOMPRESS */

void insertCode(String code, String word)
{
}

char *translateCode(String code)
{
    return NULL;
}

void decompress(String inFilename, String outFilename)
{
}



