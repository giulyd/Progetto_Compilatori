%{
#include <ctype.h>
#include <stdio.h>
#include <string.h>

  int yylex();
  int yyparse();
  void yyerror(char const*s);
  int X = 5;
  int Y = 6;
  int prevX = 0;
  int prevY = 0;
  int currX = 0;
  int currY = 0;
%}

%union{
	int number;
	char *string;
}

// dichiarazione token
%token <number> NUMERO 
%token <string> ALTO
%token <string> BASSO
%token <string> DESTRA
%token <string> SINISTRA

// token che utilizzo per confermare se il percorso è corretto
%token END
%%

comandi : |comandi comando 
		;
		
		
comando : spostaInAlto
		| spostaInBasso
		| spostaDestra
		| spostaSinistra
		| accettazione
		;

spostaInAlto : ALTO NUMERO {currY = $2;
							if (currY == Y && prevY == 0){
								prevY = Y;	
							}else
								prevY = currY + prevY;	
							// commentato si trovano delle stampe di controllo che mostrano quanto manca per raggiungere il
							// percorso voluto
							/*	if (prevY == Y)
									printf(" B(y = %d) CORRETTO\n",Y);
								else
									printf("Punto B(y = %d) fuori posizione di: %d\n",prevY, Y-prevY);*/
							}
				;

spostaInBasso : BASSO NUMERO {currY = $2;
							  prevY = -(currY - prevY);
							/*	if (prevY == Y)
									printf(" B(y = %d) CORRETTO\n",Y);
								else 
									printf("Punto B(y = %d) fuori posizione di: %d\n",prevY, Y-prevY);*/
							}
							
				;
				
spostaDestra : DESTRA NUMERO {currX = $2;
							  if (currX == X){
								prevX = currX;
							  }else
								 prevX = currX + prevX;
								/* if (prevX == X)
								 	printf(" B(x = %d) CORRETTOOOO\n",X); 
								 else
								 	printf("Punto B(x = %d) fuori posizione di: %d\n", prevX, X-prevX);*/
								}
				;
				
spostaSinistra : SINISTRA NUMERO { currX = $2;
								  prevX = -(currX - prevX);
								/*	if (prevX == X)
										printf(" B(x = %d) CORRETTOOO\n",X);
								 	else
										printf("Punto B(x = %d) fuori posizione di: %d\n",prevX ,X-prevX);*/					
								}		
				;

// comando accettazione utile per confermare se il percorso arriva a destinazione o meno
accettazione : END {if(prevX == X && prevY == Y)
					printf("Sequenza corretta. Obbiettivo centrato\n");
					else
					printf("Sequenza non corretta.\n");
					prevX = 0;
					prevY = 0;
					currX = 0;
					currY = 0;
}

%%
void main(){
	printf("Buongiorno! Di seguito vi si chiederà di inserire ascisse e ordinate per il punto di partenza!\n");
	scanf("%d %d\n",&X,&Y);
	
  yyparse();
 }
// in caso di errore (scrivo male la parola)
void yyerror(char const*s) {
  printf("\nERRORE SINTATTICO, FRASE NON RICONOSCIUTA: %s\n",s);

}
