/***********************************************************************************
*Ficheiro "jac.l" 
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciatura em Engenharia Informárica
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 2013153577
*Versão 0.2
************************************************************************************/

/*TODO - adicionar palavras reservadas, mas à medida que nos vamos lembrando */
/*TODO - fazer comentário de Java // */

%X COMMENT
%X STRINGUNTERMINATED
%X JAVACOMMENT

%{
	int valorL = 1;
	long long int contaLinha = 1;
	long long int contaColuna = 1;
	int commentcoluna, commentlinha;
%}

digito		[0-9]|[0-9]+[0-9_]*[0-9]?
reserved	break|case|"++"|"--"
seqEscape	"\\n"|"\\t"|"\\r|"\\\\"|"\\\"|"\\f"
expoente 	("e"|"E")("+"|"-")*[0-9]+
	

%%

"//"								{BEGIN JAVACOMMENT; commentcoluna=yyleng;commentlinha=0;}
<JAVACOMMENT>.						{commentcoluna+=yyleng;}
<JAVACOMMENT>\n 					{BEGIN 0;contaLinha++;contaColuna=1;}
<JAVACOMMENT><<EOF>>				{BEGIN 0;}


"/*"								{BEGIN COMMENT;commentcoluna=yyleng;commentlinha=0;}
<COMMENT>"*/"						{BEGIN 0;contaLinha+=commentlinha; contaColuna+=commentcoluna+yyleng;} /*Comentário*/
<COMMENT>.							{commentcoluna+=yyleng;}	/*incrementa coluna*/
<COMMENT>"\n"						{commentlinha++;commentcoluna=0;}	/*incrementa linha*/
<COMMENT><<EOF>>					{printf("Line %lld, col %lld: unterminated comment\n", contaLinha, contaColuna); BEGIN 0;} /*erro de unterminated comment*/

\"([^\"\r\n\\]|{seqEscape})*\"		{if(valorL){printf("STRLIT(%s)\n", yytext);}contaColuna+=yyleng;}

{digito}"."({digito}|{expoente})?|"."{digito}{expoente}?|{digito}{expoente}		{if(valorL){printf("REALLIT(%s)\n", yytext);}contaColuna+=yyleng;}
0|[1-9]+[0-9_]*[0-9]?				{if(valorL){printf("DECLIT(%s)\n", yytext);}contaColuna+=yyleng;}

\"									{BEGIN STRINGUNTERMINATED;}
<STRINGUNTERMINATED><<EOF>>			{printf("Line %lld, col %lld: unterminated string literal\n",contaLinha,contaColuna);BEGIN 0;}
<STRINGUNTERMINATED>\n				{printf("Line %lld, col %lld: unterminated string literal\n",contaLinha,contaColuna);BEGIN 0;contaLinha++;contaColuna=1;}
<STRINGUNTERMINATED>. 				{;}

{reserved}							{if(valorL){printf("RESERVED(%s)\n", yytext);}contaColuna+=yyleng;}				
"boolean"							{if(valorL){printf("BOOL\n");}contaColuna+=yyleng;}
"true"|"false"						{if(valorL){printf("BOOLLIT\n");}contaColuna+=yyleng;}
"class"								{if(valorL){printf("CLASS\n");}contaColuna+=yyleng;}
"do"								{if(valorL){printf("DO\n");}contaColuna+=yyleng;}
".length"							{if(valorL){printf("DOTLENGTH\n");}contaColuna+=yyleng;}
"double"							{if(valorL){printf("DOUBLE\n");}contaColuna+=yyleng;}
"else"								{if(valorL){printf("ELSE\n");}contaColuna+=yyleng;}
"if"								{if(valorL){printf("IF\n");}contaColuna+=yyleng;}
"int"								{if(valorL){printf("INT\n");}contaColuna+=yyleng;}
"Integer.parseInt"					{if(valorL){printf("PARSEINT\n");}contaColuna+=yyleng;}
"System.out.println"				{if(valorL){printf("PRINT\n");}contaColuna+=yyleng;}
"public"							{if(valorL){printf("PUBLIC\n");}contaColuna+=yyleng;}
"return"							{if(valorL){printf("RETURN\n");}contaColuna+=yyleng;}
"static"							{if(valorL){printf("STATIC\n");}contaColuna+=yyleng;}
"String"							{if(valorL){printf("STRING\n");}contaColuna+=yyleng;}
"void"								{if(valorL){printf("VOID\n");}contaColuna+=yyleng;}
"while"								{if(valorL){printf("WHILE\n");}contaColuna+=yyleng;}
"("									{if(valorL){printf("OCURV\n");}contaColuna+=yyleng;}
")"									{if(valorL){printf("CCURV\n");}contaColuna+=yyleng;}
"{"									{if(valorL){printf("OBRACE\n");}contaColuna+=yyleng;}
"}"									{if(valorL){printf("CBRACE\n");}contaColuna+=yyleng;}
"["									{if(valorL){printf("OSQUARE\n");}contaColuna+=yyleng;}
"]"									{if(valorL){printf("CSQUARE\n");}contaColuna+=yyleng;}
"&&"								{if(valorL){printf("AND\n");}contaColuna+=yyleng;}
"||"								{if(valorL){printf("OR\n");}contaColuna+=yyleng;}
"<"									{if(valorL){printf("LT\n");}contaColuna+=yyleng;}
">"									{if(valorL){printf("GT\n");}contaColuna+=yyleng;}
"=="								{if(valorL){printf("EQ\n");}contaColuna+=yyleng;}
"!="								{if(valorL){printf("NEQ\n");}contaColuna+=yyleng;}
"<="								{if(valorL){printf("LEQ\n");}contaColuna+=yyleng;}
">="								{if(valorL){printf("GEQ\n");}contaColuna+=yyleng;}
"+"									{if(valorL){printf("PLUS\n");}contaColuna+=yyleng;}
"-"									{if(valorL){printf("MINUS\n");}contaColuna+=yyleng;}
"*"									{if(valorL){printf("STAR0\n");}contaColuna+=yyleng;}
"/"									{if(valorL){printf("DIV\n");}contaColuna+=yyleng;}
"%"									{if(valorL){printf("MOD\n");}contaColuna+=yyleng;}
"!"									{if(valorL){printf("NOT\n");}contaColuna+=yyleng;}
"="									{if(valorL){printf("ASSIGN\n");}contaColuna+=yyleng;}
";"									{if(valorL){printf("SEMI\n");}contaColuna+=yyleng;}
","									{if(valorL){printf("COMMA\n");}contaColuna+=yyleng;}
[a-zA-Z_$][a-zA-Z0-9_$]*			{if(valorL){printf("ID(%s)\n", yytext);}contaColuna+=yyleng;}
"\n"								{contaLinha++;contaColuna=1;}
[ ]									{contaColuna+=1;}
"\t"								{contaColuna+=1;}
.									{printf("Line %lld, col %lld: illegal character (%s)\n",contaLinha,contaColuna,yytext);contaColuna++;}


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
