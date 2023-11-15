%{
    int nb_ligne=1, Col=1;
%}

%union {
         int     entier;
         char*   str;
         float reel;
}


%token mc_pgm mc_entier  mc_reel  addition mc_char  mc_str  mc_process mc_loop   mc_array  err
 mc_var  eg mc_const  <str>idf <entier>cst  dz  dpts aff division  mult acco accf crov crfm fin sep
%start S
%%
S :  LIST_BIB mc_pgm idf acco  PGM    accf 
   { printf(" Le programme est correcte syntaxiquement"); YYACCEPT; }
;
PGM:  mc_var   LIST_DEC mc_const LIST_DEC_CONST LIST_INST
    | mc_const LIST_DEC_CONST    mc_var   LIST_DEC LIST_INST
;
	
LIST_DEC: DEC  LIST_DEC 
         |
;
DEC: DEC_VAR 
   | DEC_TAB
;

DEC_TAB: idf crov cst crfm fin
;

LIST_DEC_CONST: DEC_CST LIST_DEC_CONST
            |
;			
DEC_CST: TYPE dpts LIST_IDF_CST fin
;

LIST_IDF_CST : idf eg cst sep  LIST_IDF_CST
              | idf eg cst
;
DEC_VAR:  TYPE dpts LIST_IDF fin
;
LIST_IDF: idf sep LIST_IDF 
        | idf
;		
TYPE: mc_entier
      |mc_reel
	  |mc_str
;	  
LIST_INST:INST LIST_INST                  
         |                                
;		                                  
INST: INST_AFF
;

INST_AFF : idf aff EXPRESSION fin 
	   |   idf crov cst crfm aff EXPRESSION fin
;

EXPRESSION: idf 
          | cst
		  | idf crov cst crfm
		  | idf  division cst {
		                          if ($3==0) printf(" Erreur  semantique a ligne %d a la colonne %d: division par 0 \n", nb_ligne,Col);                                   
								  else  printf("la Division de %s par %d \n ", $1,$3);         
		  
		                     }
		      
;
LIST_BIB: BIB LIST_BIB
        | 
;		

BIB: dz NOM_BIB fin
;

NOM_BIB: mc_process
        |mc_loop
		|mc_array
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
 
 