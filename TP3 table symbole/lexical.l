%{
   extern nb_ligne;
   extern Col;
   #include "syntaxique.tab.h"
    #include "ts.h"
	extern YYSTYPE yylval;
%}
lettreM [A-Z]
lettre [a-zA-Z]
chiffre[0-9]
IDF{lettreM}({lettre}|{chiffre})*
cst{chiffre}+
%%
Programme { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_pgm;  }
INTEGER   { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_entier; }
REAL      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_reel; }
CHAR      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_char; }
STRING    { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_str; }
PROCESS   { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_process; }
LOOP      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); return mc_loop; }
ARRAY     { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); return mc_array;}
VAR       { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); return mc_var ;}
CONST     { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); return mc_const; }
{IDF}     { 
              yylval.str=strdup(yytext);
			  rechercher(yytext,"IDF"," ",0,0);  
              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne, Col);
              printf (" L entite lexicale reconnue est %s \n", yytext); 
			  return idf;
		  }
{cst}     { 
              yylval.entier=atoi(yytext);
              rechercher(yytext,"Cst entiere","INTEGER",atof(yytext),0); 
			  Col= Col + strlen(yytext); 
			  printf (" L entite lexicale reconnue est %s \n", yytext);
			  return cst;
		  }
"/"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return division;}
"+"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return addition;}
"##"      { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return dz;}
"::"      { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return dpts;}
"="       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return eg; }
":="      { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return aff;}
"*"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return mult;}
"{"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return acco;}
"}"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return accf;}
"["       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return crov;}
"]"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return crfm;}
"$"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return fin;}
"//"      { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return sep;}
[ \t]     Col= Col + strlen(yytext);
\n        {Col= 1; nb_ligne++;} 
. printf ("Entité lexicale non reconnue a ligne %d a la colonne %d \n", nb_ligne, Col); return err;
