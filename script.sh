lex jac.l
cc -o jac lex.yy.c -ll
./jac -1 < Echo.ja
