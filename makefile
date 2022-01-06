test: all clean
	./a.out < input.c > output.c

all: flex bison myscanner.tab.h
	gcc myscanner.tab.c lex.yy.c -w

flex: myscanner.l
	flex -i myscanner.l

bison: myscanner.y
	bison -v -d myscanner.y

clean:
	rm lex.yy.c myscanner.tab.c myscanner.tab.h myscanner.output