%{
#include <stdio.h>
%}

Reservadas         cadena|caracter|else|entero|For|if|real|return|void|while
OpAritmeticos      [\+\-\*\/\$]
OpAsignacion       [~|\+\~|-\~|\*\~|/\~|\$\~]
SimbolosEspeciales [\(\)\{\}\[\]&,:]
OpRelacionales     \^\^|\^\^"|\=\=|\^\^=|^\^"=|<>
Identificadores    [a-zA-Z][a-zA-Z0-9]{0,5}
ConsNum            [+-]?\s?[0-9]{1,6}
ConsReales         ([0-9]+\.[0-9]+|\.[0-9]+|[0-9]+\.)
ConsCadenas        \¨[^\”]{1,38}
ConsCaracter       \'[^\']\'

%%

{Reservadas}         { printf("%s es una reservada\n", yytext); }
{OpAritmeticos}      { printf("%s es un operador aritmetico\n", yytext); }
{OpAsignacion}       { printf("%s es un operador de asignacion\n", yytext); }
{SimbolosEspeciales} { printf("%s es un simbolo especial\n", yytext); }
{OpRelacionales}     { printf("%s es un operador relacional\n", yytext); }
{Identificadores}    { printf("%s es un identificador\n", yytext); }
{ConsNum}            { printf("%s es una constante numerica\n", yytext); }
{ConsReales}         { printf("%s es una constante real\n", yytext); }
{ConsCadenas}        { printf("%s es una constante cadena\n", yytext); }
{ConsCaracter}       { printf("%s es una constante caracter\n", yytext); }
.                    { printf("%s No es ningun elemento reconocible\n", yytext); }

%%

int main (int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Error al abrir el archivo %s\n", argv[1]);
        return 1;
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}

