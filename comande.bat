flex lexical.l
Bison -d syntaxique.y
gcc lex.yy.c syntaxique.tab.c -lfl -ly -o tp.exe