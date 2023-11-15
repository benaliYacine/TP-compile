%{
#include"Syntaxique.tab.h"
 int nb=1;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
cst {chiffre}+
%%

"CODE" {printf("Mc code");return mc_code;}
"HelloACAD" {printf("Mc HelloACAD");return mc_h;}
"INTEGER" {printf("Mc INTEGER");return mc_int;}
"REAL" {printf("Mc REAL");return mc_real;}
"START" {printf("Mc START");return mc_start;}
"END." {printf("Mc END");return mc_end;}


{idf} {printf("idf\n");return idf;}
{cst} {printf("cst");return cst;}
"=" {printf("aff");return aff;}
";" {printf("pvg");return pvg;}

[ \t]
\n {nb++; return nb;}
. printf("erreur lexical a la ligne %d \n",nb);
%%