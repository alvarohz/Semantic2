%{
#include "tabsim.h"
#include "y.tab.h"
#include <string.h>
simbolo *t;
//int yylineno = 1;
%}
%%
"print"		{return PRINT;}
"exit"		{return EXIT_COMMAND;} 
"let"		{entrarBloque();return LET;} 
"in"		{return IN;} 
"end"		{salirBloque();return END;} 
"int"		{return INTEGER;}
"string"	{return STRING;}
[0-9]+		{
		yylval.numero = atoi(yytext);
		return NUMERO;
		}
[-+()=/*;,]	{ return *yytext; }	/* operadores */ 
[{] 		{ return *yytext; }	/* inicio de bloque */ 
[}] 		{ return *yytext; }	/* fin de bloque */ 
[a-zA-Z][a-zA-Z0-9]*	{				
				yylval.ptr_simbolo=(simbolo *) malloc(sizeof(simbolo));
				strcpy(yylval.ptr_simbolo->nombre,yytext); 
				yylval.ptr_simbolo->scope=level;				     
				return ID;
			}
[ \t]       	; /* espacios en blanco */
[\n]		{yylineno++;}
.		yyerror("caracter no valido");
%%
int yywrap(void) {
    return 1;
}
