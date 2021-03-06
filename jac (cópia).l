/***********************************************************************************
*Ficheiro "jac.l"
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciatura em Engenharia Informática
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 2013153577
*Versão 0.4
************************************************************************************/

/*TODO - à bulha com as sequências de escape*/

%X COMMENT
%X JAVACOMMENT
%X ESCAPESEQ
%X STRLIT

%{
	#include <string.h>

	int valorL = 0;
	long long int contaLinha = 1;
	long long int contaColuna = 1;
	int commentcoluna, commentlinha;
	long long ustringcoluna, ustringlinha;
%}

digito		[0-9]|[0-9]+[0-9_]*[0-9]?
reserved	"++"|"--"|Integer|System|abstract|continue|for|new|null|switch|assert|default|package|synchronized|goto|private|this|break|implements|protected|throw|byte|import|throws|case|enum|instanceof|transient|catch|extends|short|try|char|final|interface|finally|long|strictfp|volatile|const|float|native|super
seqEscape	"\\n"|"\\t"|"\\r|"\\\\"|"\\\"|"\\f"
seqEscInv	"\\."
endline		"\\r"|"\\n"|"\\r\\n
expoente 	("e"|"E")("+"|"-")*[0-9]+


%%

"//"								{BEGIN JAVACOMMENT; commentcoluna=yyleng;commentlinha=0;}
<JAVACOMMENT>\n|\r|\r\n 			{BEGIN 0;contaLinha++;contaColuna=1;}
<JAVACOMMENT>.						{commentcoluna+=yyleng;}
<JAVACOMMENT><<EOF>>				{BEGIN 0;}


"/*"								{BEGIN COMMENT;commentcoluna=yyleng;commentlinha=0;}
<COMMENT>"*/"						{BEGIN 0;contaLinha+=commentlinha; contaColuna+=commentcoluna+yyleng;} /*Comentário*/
<COMMENT>\n|\r|\r\n					{commentlinha++;commentcoluna=0;}	/*incrementa linha*/
<COMMENT>.							{commentcoluna+=yyleng;}	/*incrementa coluna*/
<COMMENT><<EOF>>					{printf("Line %lld, col %lld: unterminated comment\n", contaLinha, contaColuna); BEGIN 0;} /*erro de unterminated comment*/


{digito}"."({digito}|{expoente})?|"."{digito}{expoente}?|{digito}{expoente}		{if(valorL){printf("REALLIT(%s)\n", yytext);}contaColuna+=yyleng;}
0|[1-9]+[0-9_]*[0-9]?				{if(valorL){printf("DECLIT(%s)\n", yytext);}contaColuna+=yyleng;}

\"									{BEGIN STRLIT;ustringcoluna=contaColuna;ustringlinha=contaLinha;}
<STRLIT>\\n							{contaColuna+=1;}
<STRLIT>\\f							{contaColuna+=1;}
<STRLIT>\\r							{contaColuna+=1;}
<STRLIT>\\t							{contaColuna+=1;}
<STRLIT>\\\\						{contaColuna+=1;}
<STRLIT>\\\"						{contaColuna+=1;}
<STRLIT>\\.							{printf("Line %lld, col %lld: invalid escape sequence\n", contaLinha, contaColuna);contaColuna+=1;}
<STRLIT>\n							{printf("Line %lld, col %lld: unterminated string literal\n",ustringlinha,ustringcoluna);BEGIN 0;contaLinha++;contaColuna=1;}
<STRLIT>\"							{contaColuna+=1; BEGIN 0;}
<STRLIT>. 							{contaColuna+=1;}
<STRLIT><<EOF>>						{printf("Line %lld, col %lld: unterminated string literal\n",ustringlinha,ustringcoluna);BEGIN 0;}

\\									{BEGIN ESCAPESEQ; ustringcoluna=contaColuna;ustringlinha=contaLinha;}
<ESCAPESEQ>n 						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>f						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>r						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>t						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>\\						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>\"						{contaColuna+=1;BEGIN 0;}
<ESCAPESEQ>\\n						{contaLinha++;contaColuna=1;BEGIN 0;}
<ESCAPESEQ>.						{printf("Line %lld, col %lld: invalid escape sequence (\\%s)\n", contaLinha, contaColuna, yytext);contaColuna+=1;BEGIN 0;}

{reserved}							{if(valorL){printf("RESERVED(%s)\n", yytext);}contaColuna+=yyleng;}
"boolean"							{if(valorL){printf("BOOL\n");}contaColuna+=yyleng;}
"true"|"false"						{if(valorL){printf("BOOLLIT(%s)\n",yytext);}contaColuna+=yyleng;}
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
"*"									{if(valorL){printf("STAR\n");}contaColuna+=yyleng;}
"/"									{if(valorL){printf("DIV\n");}contaColuna+=yyleng;}
"%"									{if(valorL){printf("MOD\n");}contaColuna+=yyleng;}
"!"									{if(valorL){printf("NOT\n");}contaColuna+=yyleng;}
"="									{if(valorL){printf("ASSIGN\n");}contaColuna+=yyleng;}
";"									{if(valorL){printf("SEMI\n");}contaColuna+=yyleng;}
","									{if(valorL){printf("COMMA\n");}contaColuna+=yyleng;}
[a-zA-Z_$][a-zA-Z0-9_$]*			{if(valorL){printf("ID(%s)\n", yytext);}contaColuna+=yyleng;}
"\n"								{contaLinha++;contaColuna=1;}
"\r"								{contaLinha++;contaColuna=1;}
[ ]									{contaColuna+=1;}
"\t"								{contaColuna+=1;}
"\f"								{contaColuna+=1;}
.									{printf("Line %lld, col %lld: illegal character (%s)\n",contaLinha,contaColuna,yytext);contaColuna++;}


%%
int main(int argc, char* argv[])
{
  if(strcmp(argv[1],"-l") == 0 || strcmp(argv[1],"-1") == 0)
  	valorL = 1;
  yylex();
  return 0;
}
int yywrap()
{
return 1;
}
