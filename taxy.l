%{
#include<stdio.h>
#include "y.tab.h"

%}
%%

[0-9]+    {yylval.number=atoi(yytext); return NUMERO;}

"UP" 	{yylval.string=strndup(yytext,yyleng); return ALTO;}
"DOWN"	{yylval.string=strndup(yytext,yyleng); return BASSO;}
"RIGHT"	{yylval.string=strndup(yytext,yyleng); return DESTRA;}
"LEFT"  {yylval.string=strndup(yytext,yyleng); return SINISTRA;}

[ \t\r]		;

\n  	{return END;}


%%
