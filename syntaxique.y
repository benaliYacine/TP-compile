%{
    int nb_ligne=1, Col=1;
%}

%union {
         int     entier;
         char*   str;
         float reel;
}

%token idf cst aff pvg mc_code mc_h mc_int mc_real mc_start mc_end err 
%%
s:mc_code idf DEC mc_start INST cst pvg {printf("syntaxe correct");
                   YYACCEPT;}
;
DEC:mc_int idf pvg|mc_real idf pvg
;
INST:cst
;
%%

int main ()
{
   initialisation();
   yyparse(); 
   afficher();
   return 0;
 }
 yywrap ()
 {}
 int yyerror ( char*  msg )  
 {
    printf ("Erreur Syntaxique a ligne %d a colonne %d \n", nb_ligne,Col);
  }