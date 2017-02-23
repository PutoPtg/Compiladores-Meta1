/***********************************************************************************
*Ficheiro "xperiments.l"
*Analisador Lexical da linguagem Ja - Sub-conjunto de Java
*Cadeira de Compiladores - 2017 - Licenciatura em Engenharia Informática
*Manuel Madeira Amado - 2006131282
*Xavier Silva - 2013153577
*Versão 0.2
************************************************************************************/

/*TODO - invalid escape sequence*/

%X STRLIT

%{
	int valorL = 1;
	long long int contaLinha = 1;
	long long int contaColuna = 1;
	int commentcoluna, commentlinha;
%}

digito		[0-9]|[0-9]+[0-9_]*[0-9]?
reserved	case|"++"|"--"|abstract|assert|break|byte|case|catch|char|const|continue|default|enum|extends|final|finally|float|for|goto|implements|import|instanceof|interface|long|native|new|package|protected|short|strictfp|super|switch|synchronized|this|throw|throws|transient|try|volatile|Integer|System
seqEscape	"\\f"|"\\n"|"\\r|"\\t"|"\\\\"|"\\""
seqEscInv	"\\."
expoente 	("e"|"E")("+"|"-")*[0-9]+


%%
\"								{BEGIN STRLIT; commentcoluna=yyleng;commentlinha=0;}
<STRLIT>[^\\"\n]*				{commentcoluna+=yyleng;}
<STRLIT>\\n 					{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\f						{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\r						{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\t						{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\\\					{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\\"					{{printf("FOUND escSeq(%s)\n", yytext);}commentcoluna+=yyleng;}
<STRLIT>\\.						{printf("Line %lld, col %lld: invalid escape sequence\n", contaLinha, contaColuna);} /*erro de unterminated comment*/
<STRLIT>\"						{BEGIN 0;}

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

/*\"([^\"\r\n\\]|{seqEscape})*\"		{if(valorL){printf("STRLIT(%s)\n", yytext);}contaColuna+=yyleng;}*/
