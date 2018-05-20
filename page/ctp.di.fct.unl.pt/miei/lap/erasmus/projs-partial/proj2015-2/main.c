#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "zipper.h"

void usage() {
    printf("Usage: zipper [-c|-d] <file>\n");
    exit(0);
}

int main(int argc, const char *argv[]) {
    char outfile[256];
    
    if(argc != 3)
        usage();
    else if(strcmp(argv[1], "-c") == 0) {
        strcpy(outfile, argv[2]);
        strcat(outfile, ".compressed");
        zip(argv[2], outfile, 8);
    }
    else if(strcmp(argv[1], "-d") == 0) {
        strcpy(outfile, argv[2]);
        strcat(outfile, ".decompressed");
        unzip(argv[2], outfile);
    }
    else
        usage();
     return 0;
}

