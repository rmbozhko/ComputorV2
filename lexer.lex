%{
	#include "../headers/parser.hpp"
    #include <string>
    int yylex();
    int yyparse ();
    unsigned 	linenum = 0;
    //.90, 12. aren't allowed
%}

FLOAT       [-+]?([0-9]+\.[0-9]+|[0-9]+)
INT         [-+]?[0-9]+
COMPLEX     (?=[iI.\d+-])([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?![iI.\d]))?([+-]?(?:(?:\d+(?:\.\d*)?|\.\d+))?[iI])?
CHAR        [^iI][a-zA-Z]
MATRIX     (\[+([-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?,?)+[\]\,]+)+


%%

[ \t]+          
{CHAR}+"("{CHAR}+")"  {yylval.data = strdup(yytext); return FUNC_NAME; }
{CHAR}+         {yylval.data = strdup(yytext); return VAR_NAME; }
"**"            { yylval.data = strdup(yytext); return M_MULT; }
"*"				{ yylval.data = strdup(yytext); return MULT; }
"-"             { yylval.data = strdup(yytext); return SUB; }
"+"             { yylval.data = strdup(yytext); return ADD; }
"=?"            { yylval.data = strdup(yytext); return EVAL; }
"="             { yylval.data = strdup(yytext); return ASSIGN; }
"[["MATRIX"]]"  { yylval.data = strdup(yytext); return MATRIX; }
#.* 			
%%
