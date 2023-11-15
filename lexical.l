%{
 int nb=1;
%}

lettre [a-zA-Z]
chiffre [0-9]
idf {lettre}({lettre}|{chiffre})*
cst {chiffre}+
%%

{idf} printf("idf\n");
{cst} printf("cst");
"=" printf("aff");
";" printf("pvg");
[\t]
\n {nb++;}
. printf("erreur lexical a la ligne %d \n",nb);
%%

void main(){
yylex();
}