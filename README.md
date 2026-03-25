# a3_230101114 - nanoC Lexer

Lexer for the nanoC language using flex. Built for CS348 Assignment 3.

## Files
- `a3_230101114.l` - flex source file
- `a3_230101114_test.nc` - test input
- `Makefile` - for building
- `a3_230101114_token.txt` - output tokens (generated after running)
- `a3_230101114_st.txt` - symbol table (generated after running)

## How to run

```
make
make run
```

Or manually:
```
flex a3_230101114.l
gcc lex.yy.c -o a3_230101114 -lfl
./a3_230101114 a3_230101114_test.nc
```

## What it does

- Reads a nanoC source file and breaks it into tokens
- Each token is printed as `<TYPE, value, line_no>` into the token file
- Identifiers go into a symbol table written to the st file
- Handles keywords, identifiers, integer/float/char constants, strings, all punctuators
- Skips over single line and multi line comments
- Reports unrecognized characters as errors with line numbers
