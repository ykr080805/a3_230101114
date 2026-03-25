# Makefile for nanoC lexer - CS348 Assignment 3

all: a3_230101114

# compile the generated C file into the lexer executable
a3_230101114: lex.yy.c
	gcc lex.yy.c -o a3_230101114 -lfl

# generate C source from flex spec
lex.yy.c: a3_230101114.l
	flex a3_230101114.l

# run the lexer on the test file
run: a3_230101114
	./a3_230101114 a3_230101114_test.nc

# remove all generated files
clean:
	rm -f lex.yy.c a3_230101114 a3_230101114_token.txt a3_230101114_st.txt
