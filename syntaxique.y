%{
    int nb_ligne=1, Col=1;
%}

%union {
         int     entier;
         char*   str;
         float reel;
}

%token idf cst aff pvg mc_code mc_h mc_int mc_real mc_start mc_end mc_if mc_then mc_endif lt gt po pf err 
%%
s:mc_code mc_h DEC mc_start INST mc_end { printf(" Le programme est correcte syntaxiquement\n"); YYACCEPT; }
;
DEC:mc_int idf pvg DEC | mc_real idf pvg DEC | mc_int idf pvg | mc_real idf pvg
;
INST:mc_if po CONDI pf mc_then INST mc_endif | idf aff idf pvg
;
CONDI:idf lt idf | idf gt idf | idf aff aff idf
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