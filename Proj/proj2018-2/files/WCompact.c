/*
 * WCompact.c
 *
 *  Created on: May 3, 2018
 *      Author 1: Tiago Fornelos (49780)
 *      Author 2: Jorge Pereira (49771)
 */


#include "WCompact.h"
#include <stdio.h> //apagar
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

void codeNext(String code){
	int i = 0;
	while(code[++i] != '\0' && i < MAX_STRING);

	i -= 1;
	if(letterNext(code[i]) == ' '){
		while((letterNext(code[i]) == ' ') && i >= 0)
			code[i--] = letterFirst(); 

		if(i == -1)
			strcat(code,"A");
		else if (i >= 0)
			code[i] = letterNext(code[i]);

	}
	else
		code[i] = letterNext(code[i]);
}


/* WORDS */

WordInfo words[MAX_WORDS];
int wordsN = 0;        /* number of slots filled */


/* LEXICAL TREE */

static Node root = { NULL, {}};
Tree tree = &root;
int sorted[MAX_WORDS];


/* Reset*/
void reset(void){
	tree = malloc(sizeof(Node));
	memset(&(tree->children), 0, sizeof(tree->children));
	wordsN = 0;
}


/* COMPRESS */

WordInfo *wordBelongs(String word){
	char a;
	int i = 0;
	Tree next = tree;
	if(strcmp(word,"") == 0)
		return NULL;

	while((a = word[i++]) != '\0')
		if((next = next->children[order(a)]) == NULL)
			return NULL;

	return next->wi;
} 


Node *createNode(){
	Node *n = malloc(sizeof(Node));
	memset(&(n->children), 0, sizeof(n->children));
	return n;
}

void newWordTree(WordInfo *wo){
	char a;
	int i = 0;
	Node *n;
	String wd; strcpy(wd,wo->word);
	Tree next = tree;
	Tree prev = NULL;

	while((a = wd[i++]) != '\0'){
		prev = next;
		if((next = next->children[order(a)]) == NULL){
			n = createNode();
			prev->children[order(a)] = n;
			next = n;
		}
	}

	next->wi = wo;
}

void processWord(String wd)
{
	WordInfo *wo;
	wo = wordBelongs(wd);
	

	if(wo != NULL){
		wo->count++;
	}
	else if (strcmp(wd,"") != 0){
		strcpy(words[wordsN].word,wd);
		words[wordsN].count = 1;
		newWordTree(&words[wordsN]);
		wordsN++;
	}
}

void processLine(String line)
{
	String wd;
	//strcpy(cpyline,line);
	int i = 0 , a = 0;
	while(line[i] != '\0'){

		if(isLetter(line[i]))
			wd[a++] = line[i];
		else{
				wd[a] = '\0';
				processWord(wd);
				a = 0;
		}
		i++;
	}
	wd[a] = '\0';
	processWord(wd);
}

bool compare(WordInfo a, WordInfo b){
	if(a.count > b.count)
		return true;
	else if ( a.count == b.count && strcmp(a.word,b.word) < 0)
		return true;

	return false;
}

void sortTable(void) {
	int w = 0;

	for(int k = 0; k < wordsN; k++)
		sorted[k] = k;

	for(int i = 0 ; i < wordsN; i++){
		for (int j = 0; j < wordsN; j++){

			if((j + 1 < wordsN) && compare(words[sorted[j + 1]],words[sorted[j]])){
				w = sorted[j + 1];
				sorted[j + 1] = sorted[j];
	 			sorted[j] = w;
			}

		}
	}

}

void processTable(void)
{
	String a = "A";
	sortTable();

	for(int i = 0 ; i < wordsN; i++){
		strcpy(words[sorted[i]].code,a);
		codeNext(a);
	}
}

//Req: word exist
char *translateWord(String word)
{
	return wordBelongs(word)->code;
}

bool firstProcess(String in){
	String line;
	FILE *f;

	if((f = fopen(in,"r")) == NULL)
		return false;

	while(fgets(line,MAX_STRING,f) != NULL)
			processLine(line);

	fclose(f);
	return true;
}

void convert(String inicial,String final){
	int i = 0 , a = 0, size = 0;
	String wd;
	String code;
	WordInfo *wi;
	if(strlen(inicial) == 0)
		return;

	do{

		if(isLetter(inicial[i])){
			wd[a++] = inicial[i];
		}
		else{
				wd[a] = '\0';
				
				if(strlen(wd)){
					wi = wordBelongs(wd);
					strcpy(code,translateWord(wd));
					size += strlen(code);
					strcat(final,code); final[size] = '\0';
					if(wi->count == 0){
						strcat(final,"=");strcat(final,wi->word);
						size += 1 + strlen(wi->word);
						wi->count= 1;
					}

					final[size++] = inicial[i];
					a = 0;
				}
				else{
					final[size++] = inicial[i];
				}
				final[size] = '\0';
		}
		i++;
	}while(inicial[i-1] != '\0');
}

bool secondProcess(String in,String out){
	String start,final = "";
	FILE *f,*g;

	for(int i = 0 ; i < wordsN; i++){
		words[i].count = 0;
	}

	if((f = fopen(in,"r")) == NULL)
		return false;
	if((g = fopen(out,"w")) == NULL)
		return false;

	while(fgets(start,MAX_STRING,f) != NULL){
		convert(start,final);
		fputs(final,g);
		strcpy(final,"");
	}
	fputs("\n",g);
	fclose(f);
	fclose(g);
	return true;
}

void compress(String inFilename, String outFilename)
{
	
	firstProcess(inFilename);
	processTable();
	secondProcess(inFilename,outFilename);
	reset();
}


/* DECOMPRESS */
void insertCode(String code, String word)
  {		
    //Para facilitar a procura na arvore o codigo tornasse a word
    // e a word o codigo
    strcpy(words[wordsN].code,word);
    strcpy(words[wordsN].word,code);
    newWordTree(&words[wordsN]);
    wordsN++;
     
    
  }

  char *translateCode(String code)
  {
  	WordInfo *wi;
    wi = wordBelongs(code);
      
     if(wi!= NULL) 
  		return wi->code;
 			
      return "";
      
  }

void  convert2(String start, String final){
  	int i = 0,a = 0,b = 0,size = 0;
    String word;
    String code;

    do{
     	if(isLetter(start[i])){
      		code[a++] = start[i];
      		
      	}else{
      		code[a] = '\0';
      		strcpy(word,translateCode(code));

      		if(a != 0 && start[i] == '=' && strlen(word) == 0){
      			i++;
      			do{
      				word[b++]=start[i++];
     			}while(isLetter(start[i]));
      			word[b] = '\0';

      			insertCode(code,word);
      			
      			size += strlen(word);
      			strcat(final,word);
      		}
      		
      		else{
      			if(strlen(code) != 0){
      				strcat(final,word);
      				size += strlen(word);

      			}
      		}
      		a=0;
      		b=0;
      		final[size++] = start[i];
        	final[size] = '\0';
      	}
    	i++;
    }while(start[i - 1] != '\0');
      
  	
  }   
      
    
  void decompress(String inFilename, String outFilename)
  {

    String start;
    String final = "";
    FILE *f,*g;

    if((f = fopen(inFilename,"r")) == NULL)
     	return;
    if((g = fopen(outFilename,"w")) == NULL)
     	return;
    
    while(fgets(start,MAX_STRING,f) != NULL){
    	//strcpy(final,"");
    	convert2(start,final);
    	fputs(final,g);
    	strcpy(final,"");
    }
    fputs("\n",g);
  	fclose(f);
  	fclose(g);
  	reset();
  }