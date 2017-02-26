/***********************************************************************************
*Ficheiro "xperiments.l"
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciatura em Engenharia Informática
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 2013153577
*Versão 0.2
************************************************************************************/

/*TODO - invalid escape sequence*/

%X ESCAPESEQ

%{
	#include <string.h>

	int valorL = 0;
	int debug = 0;
	long long int contaLinha = 1;
	long long int contaColuna = 1;
	int commentcoluna, commentlinha;
	long long ustringcoluna, ustringlinha;
%}

digito		[0-9]|[0-9]+[0-9_]*[0-9]?
reserved	case|"++"|"--"|abstract|assert|break|byte|case|catch|char|const|continue|default|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|new|package|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile|Integer|System
seqEscape	"\\f"|"\\n"|"\\r|"\\t"|"\\\\"|"\\""
seqEscInv	"\\."
expoente 	("e"|"E")("+"|"-")*[0-9]+


%%

\\									{BEGIN ESCAPESEQ;}
<ESCAPESEQ>n 						{BEGIN 0;if(debug){printf("ESCAPESEQ EOL NL\n");}}
<ESCAPESEQ>f						{BEGIN 0;}
<ESCAPESEQ>r						{BEGIN 0;if(debug){printf("ESCAPESEQ EOL CR\n");}}
<ESCAPESEQ>t						{BEGIN 0;}
<ESCAPESEQ>\\						{BEGIN 0;}
<ESCAPESEQ>\"						{BEGIN 0;}
<ESCAPESEQ>.						{printf("invalid escape sequence \n");BEGIN 0;}

"\n"|"\r"|"\r\n"							{printf("FOUND EOL\n");}


%%
int main(int argc, char* argv[])
{
  if(strcmp(argv[1],"-l") == 0 || strcmp(argv[1],"-1") == 0 || strcmp(argv[1],"-d") == 0){
  	valorL = 1;
  	if(strcmp(argv[1],"-d") == 0){
  	debug = 1;
  	}
  }
  yylex();
  return 0;
}
int yywrap()
{
return 1;
}
