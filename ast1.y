%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

extern FILE *yyin;
int yylex();
void yyerror(const char* s);

// definizione della struttura per l'albero sintattico
typedef struct SyntaxTree{

   char* tipo;
   int numchild;
   struct SyntaxTree **child;
} SyntaxTree;


char *getpastr(char *s){

	return strcpy((char *)malloc(strlen(s)+1),s);
}

// funzione per inizializzare l'albero
void InitSyntaxTree(SyntaxTree *ST, char *tipo){

   ST->tipo=getpastr(tipo);
   
   ST->numchild=0;
   ST->child=NULL;
}

// funzione per creare l'albero
struct SyntaxTree *CreateSyntaxTree(char *tipo){

	struct SyntaxTree *ST;
	ST=((SyntaxTree *)malloc(sizeof(SyntaxTree)));
	InitSyntaxTree(ST,tipo);
	return ST;

}

// aggiungo il figlio all'albero esistente
void AddChildSyntaxTree(SyntaxTree *ST, SyntaxTree *childST){

	ST->child=(SyntaxTree **) realloc(ST->child,sizeof(SyntaxTree *)*(ST->numchild+1));
    ST->child[ST->numchild]=childST;
	ST->numchild++;
}

// libero la memoria 
void CleanUpSyntaxTree(SyntaxTree *ST)
{
	int i;
	free(ST->tipo);
	for (i=0; i<ST->numchild; i++)
		CleanUpSyntaxTree(ST->child[i]);
	if (ST->numchild) free(ST->child);
}

// funzione per stampare a video l'albero sintattico
void ShowSyntaxTree(SyntaxTree *ST,int indent)
{
   int i;
   
   for (i=0;i<indent;i++) printf(" ");
   if( strcmp(ST->tipo,"fattore") != 0){
   		printf("%s", ST->tipo);
   }
   if (ST->numchild) printf("\n");
   
   for (i=0;i<ST->numchild;i++) 
   {
   	ShowSyntaxTree(ST->child[i],indent+1);
   }
   for (i=0;i<indent;i++) printf(" "); 
   printf("\n");
}


%}

//== Parte dichiarazioni

%union
{
  char   *str;
  struct SyntaxTree *tree;
}


%error-verbose
// token che rappresentano i numeri e le operazioni che si possono eseguire
%token <str> INTERO
%token <str> OP
%token <str> MENO
%token <str> PIU

%token <integer> SC

%type <tree> line
%type <tree> expr
%type <tree> term
%type <tree> factor

// definizione precedenza operatori
%left '*' '/' '%' '+' '-'

%start lines
%%

lines: line SC				{ShowSyntaxTree($1,0); CleanUpSyntaxTree($1);}
	|lines line SC    		{ShowSyntaxTree($2,0); CleanUpSyntaxTree($2);}
	;

line: expr			
	;
	 
expr:expr MENO term 		{$$ = CreateSyntaxTree($2);
							 AddChildSyntaxTree($$,$1);
						     AddChildSyntaxTree($$,$3); 
						    }
						    
	 |expr PIU term 			{$$ = CreateSyntaxTree($2);
							 AddChildSyntaxTree($$,$1);
						     AddChildSyntaxTree($$,$3); 
						    }
						    					    
						    
	 |term 				
	 ;
	 
term:term OP factor 		{$$ = CreateSyntaxTree($2);
							 AddChildSyntaxTree($$,$1); 
							 AddChildSyntaxTree($$,$3);
							}						
	 |factor 			
	 ;
	 
factor:'('expr')' 			{$$= CreateSyntaxTree("fattore");
							 AddChildSyntaxTree($$,$2);
							}
	  |INTERO				{$$ = CreateSyntaxTree($1);}
	   
	  |MENO factor			{$$ = CreateSyntaxTree("(-)");
							 AddChildSyntaxTree($$,$2); 	 
	   						}
	  |PIU factor			{$$ = CreateSyntaxTree("(+)");
							 AddChildSyntaxTree($$,$2); 	 
	   						}									
	  ;


%%

void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }

int main(int argc, char *argv[])
{
  int yyresult;
  return yyparse();
  
}
