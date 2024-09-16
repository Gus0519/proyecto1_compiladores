#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructuras para la tabla de literales
typedef struct {
    int posicion;
    int valor;
} LiteralNumerica;

typedef struct {
    int posicion;
    float valor;
} LiteralReal;

typedef struct {
    int posicion;
    char valor[39]; // Hasta 38 caracteres para la cadena
} LiteralCadena;

// Tablas de literales (puedes usar arreglos dinámicos)
LiteralNumerica tablaNumerica[100]; // Limite de 100 literales numéricas
LiteralReal tablaReal[100];         // Limite de 100 literales reales
LiteralCadena tablaCadenas[100];    // Limite de 100 literales de cadena

int numPos = 0, realPos = 0, cadenaPos = 0;

// Funciones para agregar literales a las tablas
void agregarLiteralNumerica(int valor) {
    tablaNumerica[numPos].posicion = numPos;
    tablaNumerica[numPos].valor = valor;
    numPos++;
}

void agregarLiteralReal(float valor) {
    tablaReal[realPos].posicion = realPos;
    tablaReal[realPos].valor = valor;
    realPos++;
}

void agregarLiteralCadena(char *cadena) {
    tablaCadenas[cadenaPos].posicion = cadenaPos;
    strcpy(tablaCadenas[cadenaPos].valor, cadena);
    cadenaPos++;
}

void imprimirTablaNumerica() {
    printf("\nTabla de Literales Numéricas:\n");
    for (int i = 0; i < numPos; i++) {
        printf("Posición: %d, Valor: %d\n", tablaNumerica[i].posicion, tablaNumerica[i].valor);
    }
}

void imprimirTablaReal() {
    printf("\nTabla de Literales Reales:\n");
    for (int i = 0; i < realPos; i++) {
        printf("Posición: %d, Valor: %f\n", tablaReal[i].posicion, tablaReal[i].valor);
    }
}

void imprimirTablaCadenas() {
    printf("\nTabla de Literales de Cadenas:\n");
    for (int i = 0; i < cadenaPos; i++) {
        printf("Posición: %d, Valor: %s\n", tablaCadenas[i].posicion, tablaCadenas[i].valor);
    }
}

