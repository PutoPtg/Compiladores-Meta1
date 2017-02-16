/***********************************************************************************
*Ficheiro "jac.l" 
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciartura em Engenharia Informárica
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 
*Versão 0.0
************************************************************************************/

/*TODO - ainda não reconnhece o -l como argumento apesar de lá estar*/
/*Ainda apenas tem os mais básicos ids do enunciado*/
/*MMA*/

%%
"boolean"							{printf("BOOL\n");}
"true"|"false"						{printf("BOOLLIT\n");}
"class"								{printf("CLASS\n");}
"do"								{printf("DO\n");}
".length"							{printf("DOTLENGTH\n");}
"double"							{printf("DOUBLE\n");}
"else"								{printf("ELSE\n");}
"if"								{printf("IF\n");}
"int"								{printf("INT\n");}
"Integer.parseInt"					{printf("PARSEINT\n");}
"System.out.println"				{printf("PRINT\n");}
"public"							{printf("PUBLIC\n");}
"return"							{printf("RETURN\n");}
"static"							{printf("STATIC\n");}
"String"							{printf("STRING\n");}
"void"								{printf("VOID\n");}
"while"								{printf("WHILE\n");}
"("									{printf("OCURV\n");}
")"									{printf("CCURV\n");}
"{"									{printf("OBRACE\n");}
"}"									{printf("CBRACE\n");}
"["									{printf("OSQUARE\n");}
"]"									{printf("CSQUARE\n");}
"&&"								{printf("AND\n");}
"||"								{printf("OR\n");}
"<"									{printf("LT\n");}
">"									{printf("GT\n");}
"=="								{printf("EQ\n");}
"!="								{printf("NEQ\n");}
"<="								{printf("LEQ\n");}
">="								{printf("GEQ\n");}
"+"									{printf("PLUS\n");}
"-"									{printf("MINUS\n");}
"*"									{printf("STAR0\n");}
"/"									{printf("DIV\n");}
"%"									{printf("MOD\n");}
"!"									{printf("NOT\n");}
"="									{printf("ASSIGN\n");}
";"									{printf("SEMI\n");}
","									{printf("COMMA\n");}

%%
int main(int argc, char* argv[])
{
  if(argc >1)
  {
    if(strcmp(argv[1], "-l") == 0)
    {
        lexical = 1;
    }
  }
  yylex();
  return 0;
}
int yywrap()
{
return 1;
}
