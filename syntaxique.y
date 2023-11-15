%token idf cst aff pvg mc_code mc_h mc_int mc_real mc_start mc_end
%%
s:mc_code idf DEC mc_start INST cst pvg {printf("syntaxe correct");
                   YYACCEPT;}
;
DEC:mc_int idf pvg|mc_real idf pvg
;
INST:cst
;
%%

int main(){
    yyparse();
    return 0; 
}
yywrap()
{}

int yyerror(char *msg){
    printf("%s error syntaxique",msg);
    return 1;
}