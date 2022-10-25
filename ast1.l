%{

#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

char *getpastr(char *l);

%}

spazi      [ \t\n\r]

%%

0|[1-9]+[0-9]*   {yylval.str=getpastr(yytext); return INTERO;}
[/|%|*]*         {yylval.str=getpastr(yytext); return OP;}	
[-]*			 {yylval.str=getpastr(yytext); return MENO;} 
[+]*			 {yylval.str=getpastr(yytext); return PIU;} 

{spazi}+  	  ;

[;]	          {return SC;}

.             return yytext[0];

%%

