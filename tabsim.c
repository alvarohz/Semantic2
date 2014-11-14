 #include "tabsim.h"
 
 simbolo * crear() {
	return NULL;
 };
 void insertar(simbolo **pT, simbolo *s) {
	s->sig = (*pT);
	(*pT) = s;
 };
 
 void eliminar(simbolo **pT) {
	simbolo *s = (*pT);		
	(*pT) = s->sig;	
	free(s);	
 };
 
 void eliminarBloque(simbolo **pT) {
	simbolo *s = (*pT);
	int l = s->scope;
	while (s->scope == l) {		
		(*pT) = s->sig;
		s = s->sig;
		if (s==NULL)
			break;
	}	
 };
 
 simbolo *buscar(simbolo *t, char nombre[20]){
	while ( (t != NULL) && (strcmp(nombre, t->nombre)) )
		t = t->sig;
	return (t);
 };
 
 simbolo *buscarEnBloque(simbolo *t, char nombre[20], int scope){
	
	while (t != NULL){
		if (strcmp(nombre, t->nombre)==0){
			if (t->scope==scope)
				return t;
			else
				return NULL;
		}
		else{t=t->sig;}			
		}
	return (t);
 };
 
 void entrarBloque(){
	level++;
 }
 
 void salirBloque(){
	level--;
 }
 
 void imprimir(simbolo * t) {
	while (t != NULL) {
printf("%s: valor-> %d: nivel->%d\n", t->nombre, t->valor,t->scope);		
		t = t->sig;
	}
};
