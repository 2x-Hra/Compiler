# Compiler-Project

## About
This project will compile C code , and it's pure `lex` and `bison`.


## installing

### Ubuntu
```
    sudo apt-get update
    sudo apt-get install flex
    sudo apt-get install bison
```
### Windows
[Download](sourceforge.net)
## running
```
    flex myscanner.l
    gcc lex.yy.c
    cat input.txt | a.exe
```
