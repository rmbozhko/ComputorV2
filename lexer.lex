%{
	#include "../headers/parser.hpp"
    #include <string>
    int yylex();
    int yyparse ();
    unsigned 	linenum = 0;
    //.90, 12. aren't allowed
    //NUMBER          ([-+]?[0-9]+|([-+]?[0-9]+\.[0-9]+))
    //#.*              		    
    //COMPLEX_NUM     "(?=[iI.\d+-])([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?![iI.\d]))?([+-]?(?:(?:\d+(?:\.\d*)?|\.\d+))?[iI])?"
%}

FLOAT_NUM       [-+]?([0-9]+\.[0-9]+|[0-9]+)
INT_NUM         [-+]?[0-9]+
COMPLEX_NUM     [+-]?[iI]
CHAR            [^iI][a-zA-Z]
MATRIX          (\[+([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?,?)+[\]\,]+)+

%%
[\s]+         
"[["{MATRIX}"]]" { yylval.data = strdup(yytext); return MATRIX; }
{COMPLEX_NUM}   { yylval.data = strdup(yytext); return COMPLEX_NUM; }
{FLOAT_NUM}     { yylval.data = strdup(yytext); return FLOAT_NUM; }
{INT_NUM}       { yylval.data = strdup(yytext); return INT_NUM; }
{CHAR}+         { printf("LOLA"); yylval.data = strdup(yytext); return VAR_NAME; }
"+"             { return ADD; }
"-"             { return SUB; }
"/"             { return DIV; }
"%"             { return MOD; }
"**"            { return M_MULT; }
"*"				{ return MULT; }
"=?"            { return EVAL; }
"="             { return ASSIGN; }
"("             { return LPAREN;}
")"             { return RPAREN;}
%%

void    scan_string(const char* str) {
    yy_scan_string(str);
}

void    clear_buffer(void) {
    yy_delete_buffer(YY_CURRENT_BUFFER);
}
