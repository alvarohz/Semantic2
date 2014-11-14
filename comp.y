%{
#include "tabsim.c"
void yyerror(char *);
int yylex(void);
extern simbolo *t;
%}
%union 	{
	int numero;
	simbolo * ptr_simbolo;
	}
%start programa		
%token <numero> NUMERO
%token <ptr_simbolo> ID
%type <numero> expr sentencia sentencias
%token PRINT EXIT_COMMAND IN END LET STRING INTEGER
%left '+' '-'
%left '*' '/'
%%
programa: 
		LET
			'(' declaraciones ')'
		IN 
			'{' sentencias '}'
		END	{;}
		| error ';'	{ yyerrok;}
		;
declaraciones:
		|	declaraciones ',' decl		{;}
		|	decl				{;}
		;
decl:
		tipo ID	{
				simbolo *s = buscarEnBloque(t, $2->nombre, level);		     
				if (s==NULL){
					$2->valor=0;					       	
					insertar(&t, $2);
				}
			}
		;
tipo:
		INTEGER				{;}
		|STRING				{;}
		;
sentencias: /* cadena vacia */				{;}
		| sentencias sentencia ';'		{;}
		| sentencias programa 			{;}
		;
sentencia: 
		expr			{ printf("%d\n", $1); }
		| EXIT_COMMAND		{ exit(EXIT_SUCCESS);}
		| PRINT expr		{ printf("%d\n", $$); }
		| ID '=' expr		{ 
						$$ = $3;
						simbolo *s = buscar(t, $1->nombre);
						s->valor = $3; 												  }
		| decl			{;}
		;
expr:
        NUMERO	       	    { $$ = $1;}
        | ID                { $$ = $1->valor; }		
        | expr '+' expr     { $$ = $1 + $3; }
        | expr '-' expr     { $$ = $1 - $3; }
        | expr '*' expr     { $$ = $1 * $3; }
        | expr '/' expr     { $$ = $1 / $3; }
        | '(' expr ')'      { $$ = $2; }
        ;				
		
%%
void yyerror(char *s)
{
	extern int yylineno;	// predefinida en lex.c
	extern char *yytext;	// predefinida en lex.c
	
	printf("ERROR: %s en simbolo \"%s\" en linea %d \n",s,yytext,yylineno); 
}
void main()
{ 
	t = crear();
	yyparse();
	//eliminarBloque(&t);
	//eliminarBloque(&t);
	imprimir(t);
}
