lex jac.l
cc -o jac lex.yy.c -ll
./jac -l < Echo.ja