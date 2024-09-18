%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "literales.h"  // Incluye el archivo donde defines las estructuras
%}

Reservadas         cadena|caracter|else|entero|For|if|real|return|void|while
OpAritmeticos      [\+\-\*\/\$]
OpAsignacion       [+\-*/$]~
SimbolosEspeciales [\(\)\{\}\[\]&,:]
OpRelacionales     (\^\^)|(\^\^")|(==)|(\^\^=)|(\^\^"=)|<>
Identificadores    [a-zA-Z][a-zA-Z0-9]{0,5}
ConsNum            [+-]?\s?[0-9]{1,6}
ConsReales         ([0-9]+\.[0-9]+|\.[0-9]+|[0-9]+\.)
ConsCadenas        \"[^\"]{1,38}\"  
ConsCaracter       \'[^\']\' 

%%

{ConsCadenas}        { 
    printf("%s es una constante cadena\n", yytext); 
    agregarLiteralCadena(yytext);  // Agregar a la tabla de literales de cadena
}
{Reservadas}         { printf("%s es una reservada\n", yytext); }
{OpAritmeticos}      { printf("%s es un operador aritmetico\n", yytext); }
{OpAsignacion}       { printf("%s es un operador de asignacion\n", yytext); }
{SimbolosEspeciales} { printf("%s es un simbolo especial\n", yytext); }
{OpRelacionales}     { printf("%s es un operador relacional\n", yytext); }
{Identificadores} {
    printf("%s es un identificador\n", yytext);
    if (buscarSimbolo(yytext) == -1) {
        agregarSimbolo(yytext, -2);  // Agregar el identificador si no está ya en la tabla
    } else {
        printf("%s ya existe en la tabla de símbolos\n", yytext);
    }
}

{ConsNum}            { 
    printf("%s es una constante numerica\n", yytext); 
    agregarLiteralNumerica(atof(yytext));  // Agregar a la tabla de literales numéricas
}
{ConsReales}         { 
    printf("%s es una constante real\n", yytext); 
    agregarLiteralNumerica(atof(yytext));  // Agregar a la tabla de literales numericas
}
{ConsCaracter}       { printf("%s es una constante caracter\n", yytext); }
[ \t\n]+             { /* Ignorar espacios, tabulaciones y saltos de línea */ }
. {
    printf("Error: %s no es ningún elemento reconocible\n", yytext);
    FILE *f = fopen("errores.txt", "a");
    if (f != NULL) {
        fprintf(f, "Error: %s no es ningún elemento reconocible\n", yytext);
        fclose(f);
    } else {
        printf("Error al abrir errores.txt\n");
    }
}


%%

int main (int argc, char *argv[]) {
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Error al abrir el archivo %s\n", argv[1]);
        return 1;
    }
    yylex();
    

    imprimirTablaNumerica();
    imprimirTablaCadenas();
    imprimirTablaSimbolos();
    return 0;
}

int yywrap() {
    return 1;
}

