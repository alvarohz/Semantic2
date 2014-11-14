calc: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c -o comp
	
y.tab.c: comp.y
	bison -d comp.y -o y.tab.c
	
lex.yy.c: comp.l
	lex comp.l
	
clean:
	rm comp
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h
