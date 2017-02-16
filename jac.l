/***********************************************************************************
*Ficheiro "jac.l" 
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciartura em Engenharia Informárica
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 2013153577
*Versão 0.1
************************************************************************************/


/*FIXED - já está com a flag -l e -1 */
/*TODO - adicionar palavras reservadas, mas à medida que nos vamos lembrando */

%{
	int valorL = 1;
%}

reserved	break|case|"++"|"--"

%%
{reserved}							{if(valorL)printf("RESERVED(%s)\n", yytext);}					
"boolean"							{if(valorL)printf("BOOL\n");}
"true"|"false"						{if(valorL)printf("BOOLLIT\n");}
"class"								{if(valorL)printf("CLASS\n");}
"do"								{if(valorL)printf("DO\n");}
".length"							{if(valorL)printf("DOTLENGTH\n");}
"double"							{if(valorL)printf("DOUBLE\n");}
"else"								{if(valorL)printf("ELSE\n");}
"if"								{if(valorL)printf("IF\n");}
"int"								{if(valorL)printf("INT\n");}
"Integer.parseInt"					{if(valorL)printf("PARSEINT\n");}
"System.out.println"				{if(valorL)printf("PRINT\n");}
"public"							{if(valorL)printf("PUBLIC\n");}
"return"							{if(valorL)printf("RETURN\n");}
"static"							{if(valorL)printf("STATIC\n");}
"String"							{if(valorL)printf("STRING\n");}
"void"								{if(valorL)printf("VOID\n");}
"while"								{if(valorL)printf("WHILE\n");}
"("									{if(valorL)printf("OCURV\n");}
")"									{if(valorL)printf("CCURV\n");}
"{"									{if(valorL)printf("OBRACE\n");}
"}"									{if(valorL)printf("CBRACE\n");}
"["									{if(valorL)printf("OSQUARE\n");}
"]"									{if(valorL)printf("CSQUARE\n");}
"&&"								{if(valorL)printf("AND\n");}
"||"								{if(valorL)printf("OR\n");}
"<"									{if(valorL)printf("LT\n");}
">"									{if(valorL)printf("GT\n");}
"=="								{if(valorL)printf("EQ\n");}
"!="								{if(valorL)printf("NEQ\n");}
"<="								{if(valorL)printf("LEQ\n");}
">="								{if(valorL)printf("GEQ\n");}
"+"									{if(valorL)printf("PLUS\n");}
"-"									{if(valorL)printf("MINUS\n");}
"*"									{if(valorL)printf("STAR0\n");}
"/"									{if(valorL)printf("DIV\n");}
"%"									{if(valorL)printf("MOD\n");}
"!"									{if(valorL)printf("NOT\n");}
"="									{if(valorL)printf("ASSIGN\n");}
";"									{if(valorL)printf("SEMI\n");}
","									{if(valorL)printf("COMMA\n");}
[a-zA-Z_$][a-zA-Z0-9_$]*			{if(valorL)printf("ID(%s)\n", yytext);}
"\n"								{}
[ ]									{}
"\t"								{}

%%
int main(int argc, char* argv[])
{
  if(argv[1] == NULL)
  	valorL = 0;
  yylex();
  return 0;
}
int yywrap()
{
return 1;
}
