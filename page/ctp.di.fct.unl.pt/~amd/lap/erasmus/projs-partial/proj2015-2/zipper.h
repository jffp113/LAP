#ifndef __ZIPPER_H__
#define __ZIPPER_H__

/* Zipper module header */

#include <stdint.h>


/*
 ChunksFile file handling
 */

typedef signed char Bit;
typedef uint32_t Chunk;
typedef Chunk Symbol;       // Chunks from the original (unencoded) file
typedef Chunk Code;         // Chunks representing encoded symbols
typedef struct ChunksFileStruct *ChunksFile; // Opaque type

/*
 returns an handle to a ChunksFile file. NULL if file can't be opened
 */
ChunksFile cfOpen(const char *filename, const char *mode);

/*
 closes a ChunksFile file
 */
void cfClose(ChunksFile cf);

/*
 Requests a Chunk of length len nbits from the ChunksFile file. Returns the number of bits effectively read.
 Upon completion chunk will hold the bit sequence just read (right aligned).
 */
size_t cfGet(ChunksFile cf, Chunk *chunk, size_t len);

/*
 Writes a chunk with length len into the Chunks file. Returns the the number of bits written. Bits are written starting at the most significant bit used in the chunk
 */
size_t cfPut(ChunksFile cf, Chunk chunk, size_t len);

/*
 Read a bit from the file. Returns -1 at end of Chunks file.
 */
Bit cfGetBit(ChunksFile cf);

/*
 Writes a bit into the file. Return the number of bits written: 1 if bit was successfully written, 0 otherwise
 */
size_t cfPutBit(ChunksFile cf, Bit b);




/*
 Frequency table: stores frequencies for symbols of the input
 */

typedef struct FreqTable *FreqTable; // Opaque type

/*
 Frequency table operations
 */

FreqTable newFreqTable(size_t symLength);           // Creates a new FreqTable capable of counting frequencies of symbols up to symLength bits in length
void freeFreqTable(FreqTable ft);                   // Free all the dynamically allocated memory used by the table of frequencies
void fillFreqTable(FreqTable ft, ChunksFile cf);    // Processes the input file (reading symbols of size symLength) and builds the table
void increment(FreqTable ft, Symbol s);             // Increments the absolute frequency of symbol s
size_t getFreq(FreqTable ft, Symbol s);             // Returns the number of occurences of the symbol s
//Symbol makeEOF_Symbol(FreqTable ft);                // Returns the special EOF_Symbol



/*
 Dictionary to accelerate the encoding process (Since the tree representation is not the most adequate for the task)
 */

typedef struct Dictionary *Dictionary; // Opaque type

Dictionary newDictionary(size_t symLength);                     // Creates a new dictionary for symbols up to length symLength in bits
void freeDictionary(Dictionary d);                              // Frees the memory used by the dictionary d
void insertSymbol(Dictionary d, Symbol s, Code c, size_t len);  // Inserts the definition of Symbol s as being Code c with length len
size_t lookupSymbol(Dictionary d, Symbol s, Code *c);           // Returns the Code (in *c) and length used to encode Symbol s



/*
 ZipperTree is the data type to represent the compression tree. ZipperNode is an actual node of the tree
 */

typedef struct ZipperNode *ZipperTree; // Opaque type

/*
 ZipperInfo: stores the compression tree (used for decompression) and the dictionary (built from the compression tree)
 */

typedef struct ZipperInfo {
    size_t symLength;   // Number of bits of original symbols
    size_t lastLength;  // Number of bits of the last symbol
    size_t size;        // Number of symbols in the input file
    ZipperTree tree;    // The actual compression tree
    Dictionary d;      // Dictionary used in the actual encoding process (built from the compression tree)
} *ZipperInfo;




/*
 ZipperInfo operations
 */

ZipperInfo newZipperInfo();                         // Creates an empty ZipperInfo
void freeZipperInfo(ZipperInfo zi);                 // Deletes the memory used

void fillZipperInfo(ZipperInfo zi, FreqTable ft);   // Fill ZipperInfo from Frequency Table (also builds the Dictionary)

void writeZipperInfo(ChunksFile cf, ZipperInfo zi); // Writes the structure to a ChunksFile
ZipperInfo readZipperInfo(ChunksFile cf);           // Reads the structure from a ChunksFile (including the Tree). The dictionary is not used in this case.

/*
 Low level Zipper operations
 */
size_t encode(ChunksFile cf, ZipperInfo zi, Code *c);      // Reads a symbol from the ChunksFile cf, returns its code (in *c) and its length
size_t decode(ChunksFile cf, ZipperInfo zi, Symbol *s);    // Reads a code from the ChunksFile cf, returns its symbol (in *s) and its length




/*
 The top level functions to compress and decompress a file
 */

void zip(const char *namein, const char *nameout, size_t symLength);
void unzip(const char *namein, const char *nameout);

#endif /* defined(__ZIPPER_H__) */
