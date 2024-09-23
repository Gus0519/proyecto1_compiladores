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
    Token cad;
    cad.clase = 8;
    cad.valor = cadenaPos; 
    agregarLiteralCadena(yytext);  // Agregar a la tabla de literales de cadena
    agregarToken(cad);
}
{Reservadas}         {

	int pos=-1;

	Token res;

	res.valor = buscarReservada(yytext);
	res.clase = 0;
	agregarToken(res);

}
{OpAritmeticos}      { 
	Token arit;
	arit.clase = 1;
	arit.valor = yytext[0];
	agregarToken(arit);
}
{OpAsignacion}       {

	Token asig;
	asig.clase = 2;
	asig.valor = buscarAsignacion(yytext);
	agregarToken(asig);

}
{SimbolosEspeciales} { 
	Token esp;
	esp.clase = 3;
	esp.valor = yytext[0];
	agregarToken(esp);
	
 }
{OpRelacionales}     { 

	Token rel;
	rel.clase = 4;
	rel.valor = buscarRelacional(yytext);
	agregarToken(rel);

}
{Identificadores} {
    printf("%s es un identificador\n", yytext);
    if (buscarSimbolo(yytext) == -1) {
        agregarSimbolo(yytext, -2);  // Agregar el identificador si no está ya en la tabla
    } else {
        printf("%s ya existe en la tabla de símbolos\n", yytext);
    }

    Token id;
    id.clase = 5;
    id.valor = posSimb;
    agregarToken(id);

}

{ConsNum}            { 
     	Token num;
	num.clase = 6;
	num.valor = numPos;
	agregarLiteralNumerica(atof(yytext));  // Agregar a la tabla de literales numéricas
        agregarToken(num);
}
{ConsReales}         { 
    Token real;
    real.clase = 7;
    real.valor = numPos; 
    agregarLiteralNumerica(atof(yytext));  // Agregar a la tabla de literales numericas
    agregarToken(real);
}
{ConsCaracter}       { 

	Token car;
	car.clase = 9;
	car.valor = yytext[0];
	agregarToken(car);


}
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
    imprimirTablaTokens();
    return 0;
}

int yywrap() {
    return 1;
}

