%{
extern nb_ligne;
extern Col;
#include "Syntaxique.tab.h"
 #include "ts.h"
 extern YYSTYPE yylval;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
cst {chiffre}+
%%

"CODE" {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_code;}
"HelloACAD" {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_h;}
"INTEGER" {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_int;}
"REAL" {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_real;}
"START" {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_start;}
"END." {rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext);return mc_end;}

{idf} {yylval.str=strdup(yytext);
			  rechercher(yytext,"IDF"," ",0,0);  
              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne, Col);
              printf (" L entite lexicale reconnue est %s \n", yytext); 
			  return idf;}
{cst} {yylval.entier=atoi(yytext);
              rechercher(yytext,"Cst entiere","INTEGER",atof(yytext),0); 
			  Col= Col + strlen(yytext); 
			  printf (" L entite lexicale reconnue est %s \n", yytext);
			  return cst;}
"=" {rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return aff;}
";" {rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return pvg;}

[ \t]   Col= Col + strlen(yytext);
\n {Col= 1; nb_ligne++;}
. {printf ("Entité lexicale non reconnue a ligne %d a la colonne %d \n", nb_ligne, Col);return err;}
%%