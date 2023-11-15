%{
    int nb_ligne=1, Col=1;
%}

%union {
         int     entier;
         char*   str;
         float reel;
}

%token <str>idf <entier>cst <str>aff <str>pvg mc_code mc_h mc_int mc_real mc_start mc_end <str>mc_if <str>mc_then <str>mc_endif <str>lt <str>gt <str>po <str>pf err 
%%
s:mc_code mc_h DEC mc_start INST mc_end { printf(" Le programme est correcte syntaxiquement\n"); YYACCEPT; }
;
DEC:mc_int idf pvg DEC | mc_real idf pvg DEC | mc_int idf pvg | mc_real idf pvg
;
INST:mc_if po CONDI pf mc_then INST mc_endif { printf("---> %s %s %s %s %s \n",$1,$2,$4,$5,$7); } | idf aff idf pvg { printf("---> %s %s %s %s \n",$1,$2,$3,$4); }
;
CONDI:idf lt idf { printf("---> %s %s %s \n",$1,$2,$3); } | idf gt idf { printf("---> %s %s %s \n",$1,$2,$3); } | idf aff aff idf { printf("---> %s %s %s \n",$1,$2,$3); }
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