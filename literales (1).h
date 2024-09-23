#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Estructuras para la tabla de literales
typedef struct {
    int posicion;
    float valor;
} LiteralNumerica;


typedef struct {
    int posicion;
    char valor[39]; // Hasta 38 caracteres para la cadena
} LiteralCadena;

//para los identificadores
typedef struct{
	int posicion;
	char nombre[8];
	int tipo;
} Simbolos;

typedef struct {
    int clase;   // Clase del token
    int valor;   // Valor del token
} Token;


// Tablas de literales (puedes usar arreglos dinámicos)
LiteralNumerica tablaNumerica[100]; // Limite de 100 literales numéricas
LiteralCadena tablaCadenas[100];    // Limite de 100 literales de cadena
Simbolos tablaSimbolos[100];
Token tablaTokens[100];
int numPos = 0, cadenaPos = 0,posSimb=0, posToken=0;

// Funciones para agregar literales a las tablas
void agregarLiteralNumerica(float valor) {
    tablaNumerica[numPos].posicion = numPos;
    tablaNumerica[numPos].valor = valor;
    numPos++;
}


void agregarLiteralCadena(char *cadena) {
    tablaCadenas[cadenaPos].posicion = cadenaPos;
    strcpy(tablaCadenas[cadenaPos].valor, cadena);
    cadenaPos++;
}
//para la tabla de simbolos
void agregarSimbolo(char *nombre, int tipo){
    tablaSimbolos[posSimb].posicion = posSimb;     
    strcpy(tablaSimbolos[posSimb].nombre,nombre);
    tablaSimbolos[posSimb].tipo = tipo;
    posSimb++;
}

void imprimirTablaNumerica() {
    FILE *f = fopen("tablas.txt", "w");
    if (f == NULL) {
        printf("Error al abrir tablas.txt\n");
        return;
    }
    fprintf(f, "\nTabla de Literales Numéricas:\n");
    for (int i = 0; i < numPos; i++) {
        fprintf(f, "Posición: %d, Valor: %f\n", tablaNumerica[i].posicion, tablaNumerica[i].valor);
    }
    fclose(f);
}

void imprimirTablaCadenas() {
    FILE *f = fopen("tablas.txt", "a");  // Modo 'a' para añadir
    if (f == NULL) {
        printf("Error al abrir tablas.txt\n");
        return;
    }
    fprintf(f, "\nTabla de Literales de Cadenas:\n");
    for (int i = 0; i < cadenaPos; i++) {
        fprintf(f, "Posición: %d, Valor: %s\n", tablaCadenas[i].posicion, tablaCadenas[i].valor);
    }
    fclose(f);
}
void imprimirTablaSimbolos() {
    FILE *f = fopen("tablas.txt", "a");
    if (f == NULL) {
        printf("Error al abrir tablas.txt\n");
        return;
    }
    fprintf(f, "\nTabla de Símbolos:\n");
    for (int i = 0; i < posSimb; i++) {
        fprintf(f, "Posición: %d, Nombre: %s, Tipo: %d\n", tablaSimbolos[i].posicion, tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
    }
    fclose(f);
}

//funcion para buscar
int buscarSimbolo(char *nombre) {
    for (int i = 0; i < posSimb; i++) {
        if (strcmp(tablaSimbolos[i].nombre, nombre) == 0) {
            return i;  // El símbolo ya existe, devolver la posición
        }
    }
    return -1;  // No se encontró el símbolo
}

int buscarReservada(char *palabra) {
    FILE *file = fopen("reservadas.txt", "r");
    char buffer[100];
    int valor;
    
    if (file == NULL) {
        printf("Error al abrir el archivo reservadas.txt\n");
        return -1;  // Error
    }

    while (fscanf(file, "%[^,],%d\n", buffer, &valor) != EOF) {
        if (strcmp(palabra, buffer) == 0) {
            fclose(file);
            return valor;  // Devuelve la posición en el catálogo
        }
    }

    fclose(file);
    return -1;  // No encontrado
}

int buscarRelacional(char *operador) {
    FILE *file = fopen("relacionales.txt", "r");
    char buffer[100];
    int valor;

    if (file == NULL) {
        printf("Error al abrir el archivo relacionales.txt\n");
        return -1;  // Error
    }

    while (fscanf(file, "%[^,],%d\n", buffer, &valor) != EOF) {
        if (strcmp(operador, buffer) == 0) {
            fclose(file);
            return valor;  // Devuelve la posición en el catálogo
        }
    }

    fclose(file);
    return -1;  // No encontrado
}


Token tablaTokens[100];

void agregarToken(Token token) {
     tablaTokens[posToken] = token;
     posToken++;	
}



void imprimirTablaTokens() {
    FILE *file = fopen("tokens.txt", "w");

    if (file == NULL) {
        printf("Error al abrir el archivo tokens.txt\n");
        return;
    }

    for (int i = 0; i < posToken; i++) {
        //if (tablaTokens[i].clase == 9){
	//	fprintf(file,"(Clase: %d, valor: %s)\n",tablaTokens[i].clase, tablaTokens[i].valor);	
	
	//}
	fprintf(file, "(Clase: %d, Valor: %d)\n", tablaTokens[i].clase, tablaTokens[i].valor);
    }

    fclose(file);
}


int buscarAsignacion(char *operador) {
    FILE *file = fopen("asignacion.txt", "r");
    char buffer[100];
    int valor;

    if (file == NULL) {
        printf("Error al abrir el archivo relacionales.txt\n");
        return -1;  // Error
    }

    while (fscanf(file, "%[^,],%d\n", buffer, &valor) != EOF) {
        if (strcmp(operador, buffer) == 0) {
            fclose(file);
            return valor;  // Devuelve la posición en el catálogo
        }
    }

    fclose(file);
    return -1;  // No encontrado
}

