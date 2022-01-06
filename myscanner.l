%{

#include "myscanner.tab.h"
#include<string.h>

%}

delim     [ \t\n\r] 
letter    [A-Za-z] 
digit     [0-9]	

%%

{delim}+                                        {;} 
{digit}+(\.{digit}+)?(E[+\-]?{digit}+)?         {strcpy(yylval.num , yytext); return NUM;}
[+-/*=,;(){}]                                  {return yytext[0];}

"=="                        |
">"                         |
"<"                         |
">="                        |
"<="                        {strcpy(yylval.relo, yytext); return RELOP;}

"int"                       {return INT;}
"float"                     {return FLOAT;}
"double"                    {return DOUBLE;}
"char"                      {return CHAR;}

"if"                        {return IF;}
"else"                      {return ELSE;}
"while"                     {return WHILE;}
"for"                       {return FOR;}

{letter}({letter}|{digit})*                     {strcpy(yylval.id , yytext); return ID;}
.					                            printf("unexpected character\n");

%%


