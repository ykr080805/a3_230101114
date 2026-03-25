%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *tok_fp;   // file pointer for token output
FILE *st_fp;    // file pointer for symbol table output

// symbol table - stores all unique identifiers
char *sym_tab[500];
int sym_cnt = 0;

// search for an identifier in the symbol table, return index or -1
int find_sym(char *name) {
    int i;
    for (i = 0; i < sym_cnt; i++) {
        if (strcmp(sym_tab[i], name) == 0)
            return i;
    }
    return -1;
}

// insert identifier into symbol table if not already present
int add_sym(char *name) {
    int idx = find_sym(name);
    if (idx != -1) return idx;  // already exists
    sym_tab[sym_cnt] = strdup(name);
    return sym_cnt++;
}

%}

%option yylineno
%option noyywrap

%%

 /* keywords - all nanoC keywords */
"break"      { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"case"       { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"char"       { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"continue"   { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"default"    { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"do"         { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"double"     { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"else"       { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"float"      { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"for"        { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"if"         { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"int"        { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"long"       { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"return"     { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"short"      { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"signed"     { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"static"     { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"unsigned"   { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"void"       { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"while"      { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }
"_Bool"      { fprintf(tok_fp, "<KEYWORD, %s, %d>\n", yytext, yylineno); }

 /* identifiers - also added to symbol table */
[a-zA-Z_][a-zA-Z0-9_]*   { fprintf(tok_fp, "<IDENTIFIER, %s, %d>\n", yytext, yylineno); add_sym(yytext); }

 /* integer constant: nonzero followed by digits, or just 0 */
[1-9][0-9]*   { fprintf(tok_fp, "<INTEGER_CONSTANT, %s, %d>\n", yytext, yylineno); }
"0"           { fprintf(tok_fp, "<INTEGER_CONSTANT, %s, %d>\n", yytext, yylineno); }

 /* floating constant: handles both 3.14 and 10. and .75 forms */
[0-9]*"."[0-9]+   { fprintf(tok_fp, "<FLOATING_CONSTANT, %s, %d>\n", yytext, yylineno); }
[0-9]+"."          { fprintf(tok_fp, "<FLOATING_CONSTANT, %s, %d>\n", yytext, yylineno); }

 /* character constant with escape sequence support */
\'([^'\\\n]|\\['\"\?\\abfnrtv])+\'   { fprintf(tok_fp, "<CHARACTER_CONSTANT, %s, %d>\n", yytext, yylineno); }

 /* string literal with escape sequence support */
\"([^"\\\n]|\\['\"\?\\abfnrtv])*\"   { fprintf(tok_fp, "<STRING_LITERAL, %s, %d>\n", yytext, yylineno); }

 /* multi-char punctuators - need to match these before single-char ones */
"->"|"++"|"--"|"<<"|">>"|"<="|">="|"=="|"!="|"&&"|"||"|"..."  { fprintf(tok_fp, "<PUNCTUATOR, %s, %d>\n", yytext, yylineno); }
"<<="|">>="|"*="|"/="|"%="|"+="|"-="|"&="|"^="|"|="           { fprintf(tok_fp, "<PUNCTUATOR, %s, %d>\n", yytext, yylineno); }

 /* single character punctuators */
[\[\]\(\)\{\}\.\&\*\+\-\~\!\/\%\<\>\^\|\?\:\;\=\,\#]   { fprintf(tok_fp, "<PUNCTUATOR, %s, %d>\n", yytext, yylineno); }

 /* single line comment */
"//".*                              ;
 /* multi line comment */
"/*"([^*]|\*+[^*/])*\*+"/"         ;

 /* skip whitespace */
[ \t\n]+   ;

 /* anything unrecognized is a lexical error */
.   { fprintf(stderr, "Lexical error at line %d: unexpected character '%s'\n", yylineno, yytext);
      fprintf(tok_fp, "<ERROR, %s, %d>\n", yytext, yylineno); }

%%

int main(int argc, char **argv) {
    int i;

    if (argc < 2) {
        printf("Usage: ./a3_230101114 <input_file>\n");
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Cannot open file: %s\n", argv[1]);
        return 1;
    }

    tok_fp = fopen("a3_230101114_token.txt", "w");
    st_fp = fopen("a3_230101114_st.txt", "w");

    yylex();  // run the lexer

    // dump the symbol table to file
    fprintf(st_fp, "Symbol Table\n");
    fprintf(st_fp, "------------\n");
    for (i = 0; i < sym_cnt; i++) {
        fprintf(st_fp, "%d\t%s\n", i+1, sym_tab[i]);
    }

    fclose(tok_fp);
    fclose(st_fp);
    fclose(yyin);

    printf("Done! Check a3_230101114_token.txt and a3_230101114_st.txt\n");
    return 0;
}
