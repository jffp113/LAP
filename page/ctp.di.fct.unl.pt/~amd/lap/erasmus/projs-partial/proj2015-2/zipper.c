
/*
Zipper module implementation

Autores: Fulano (99998), Sicrano (99999)


O ficheiro "Zipper.c" tem de incluir, logo nas primeiras linhas, um comentário
inicial contendo: o nome e número dos dois alunos que realizaram o projeto;
indicação de quais as partes do trabalho que foram feitas e das que não foram
feitas (para facilitar uma correção sem enganos); ainda possivelmente alertando
para alguns aspetos da implementação que possam ser menos óbvios para o avaliador.

*/


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "zipper.h"


ChunksFile cfOpen(const char *filename, const char *mode) { return NULL; }
void cfClose(ChunksFile cf) { }
size_t cfGet(ChunksFile cf, Chunk *chunk, size_t len) { return 0; }
size_t cfPut(ChunksFile cf, Chunk chunk, size_t len) { return 0; }
Bit cfGetBit(ChunksFile cf) { return 0; }
size_t cfPutBit(ChunksFile cf, Bit b) { return 0; }


FreqTable newFreqTable(size_t symLength) { return NULL; }
void freeFreqTable(FreqTable ft) { }
void increment(FreqTable ft, Symbol s) { }
size_t getFreq(FreqTable ft, Symbol s) { return 0; }
void fillFreqTable(FreqTable ft, ChunksFile cf) { }


Dictionary newDictionary(size_t symLength) { return NULL; }
void freeDictionary(Dictionary d) { }
void insertSymbol(Dictionary d, Symbol s, Code c, size_t len) { }
size_t lookupSymbol(Dictionary d, Symbol s, Code *c) { return 0; }


ZipperInfo newZipperInfo() { return NULL; }
void freeZipperInfo(ZipperInfo zi) { }
void fillZipperInfo(ZipperInfo zi, FreqTable ft) { }
void writeZipperInfo(ChunksFile cf, ZipperInfo zi) { }
ZipperInfo readZipperInfo(ChunksFile cf) { return NULL; }


size_t encode(ChunksFile cf, ZipperInfo zi, Code *c) { return 0; }
size_t decode(ChunksFile cf, ZipperInfo zi, Symbol *s) { return 0; }


void zip(const char *namein, const char *nameout, size_t symLength) { }
void unzip(const char *namein, const char *nameout) { }
