#include <stdlib.h> /* for atoi */
#include <stdio.h>
#include <string.h>

int level;

typedef struct _simbolo {
	struct _simbolo * sig;
	char nombre [20];
	int valor;
	int scope;
} simbolo;

 simbolo * crear();
 void insertar(simbolo **, simbolo *);
 void eliminar(simbolo **);
 void eliminarBloque(simbolo **);
 simbolo *buscar(simbolo *, char[]);
 simbolo *buscarEnBloque(simbolo *, char[], int);
 void entrarBloque();
 void salirBloque();
 void imprimir(simbolo * );