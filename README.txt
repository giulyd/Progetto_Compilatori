# compilatori
AUTORE: DORO GIULIA 
DATA CONSEGNA: 11 LUGLIO 2022

ESERCIZIO TAXI:

Per lanciare il programma:
yacc -d taxy.y
lex taxy.l
gcc lex.yy.c  y.tab.c -lfl
./a.out

Come input richiedo due interi che userò come ascissa e ordinata del punto B
Questi due interi mi serviranno per capire se il taxy è giunto a destinazione o meno.
Una volta digitati i due interi, vengono utilizzati come X e Y del piano cartesiano
In seguito si può digitare il percorso voluto. Il compilatore accetta solo interi e le parole "UP, DOWN, RIGHT, LEFT" scritte in stampatello maiuscolo.
Dopo aver effettuato i vari controlli si stamperà a video se la sequenza è corretta o meno. 
Per terminare il programma: CTRL+D che non causerà errori.
Esempi di input validi:
Fisso X e Y.
X = 10
Y = 12
RIGHT 10  UP 10 UP 2
LEFT 5 RIGHT 10 DOWN 10 UP 22

ESERCIZIO ALBERI:

Per lanciare un programma 
yacc -d ast1.y
lex ast1.l
gcc lex.yy.c  y.tab.c -lfl
./a.out

Come input do una serie di numeri e di operatori (compresi gli operatori unari) seguiti da un ;
Il ; serve per far capire al compilatore che la stringa da me inserita è conclusa e di conseguenza crea l'albero.
Per terminare il programma: CTRL+D che non causerà errori.
Definisco varie funzioni che serviranno per la costruzione, l'inizializzazione e l'aggiunta di un figlio all'albero esistente.
Vi sono anche due funzioni che servono per stampare a video l'albero e per liberare la memoria da esso occupata.
Per creare la calcolatrice mi servo della grammatica per le espressioni regolari classica.
Solo che al posto di stampare i risultati delle operazioni, creo i vari "pezzi" dell'albero.
Esempi di input validi:
1+2;
(1+2+3)*-(10+23/4);

