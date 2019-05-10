%{
	#include "../headers/parser.hpp"
    #include <string>
    int yylex();
    int yyparse ();
    unsigned 	linenum = 0;
    //.90, 12. aren't allowed
%}

FLOAT_NUM       [-+]?([0-9]+\.[0-9]+|[0-9]+)
INT_NUM         [-+]?[0-9]+
COMPLEX_NUM     (?=[iI.\d+-])([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?![iI.\d]))?([+-]?(?:(?:\d+(?:\.\d*)?|\.\d+))?[iI])?
CHAR            [^iI][a-zA-Z]
NUMBER          ([-+]?[0-9]+|([-+]?[0-9]+\.[0-9]+))
MATRIX          (\[+([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?,?)+[\]\,]+)+


%%
[ \t]+         
"+"             { return ADD; }
"-"             { return SUB; }
"/"             { return DIV; }
"%"             { return MOD; }
"**"            { return M_MULT; }
"*"				{ return MULT; }
"=?"            { return EVAL; }
"="             { return ASSIGN; }
"[["{MATRIX}"]]"  { yylval.data = strdup(yytext); return MATRIX; }
{CHAR}+"("{CHAR}+")"  {yylval.data = strdup(yytext); return FUNC_NAME; }
{CHAR}+         {yylval.data = strdup(yytext); return VAR_NAME; }
{NUMBER}        { yylval.data = strdup(yytext); return NUMBER; }
[\n]+           
#.*             { printf("LOL\n"); } 		    
%%

void    scan_string(const char* str) {
    yy_scan_string(str);
}

void    clear_buffer(void) {
    yy_delete_buffer(YY_CURRENT_BUFFER);
}
