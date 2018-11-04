# Parser for ml-like functional language

## Overview
This is a parser for a toy ml-like functional language, see `examples/` for sample programs.

## Syntax
* Only integer and boolean literals supported
* A program is a series of let statements, separated by `in`
* Binary expressions supported (>, <, ==, >=, <=)
* Arithmetic operations supported (+, -, /, *)
* If expressions supported (if-then-else only)
* Fun expressions (one parameter, multiple via curry `examples/curry.fl`)
* Function applications (one parameter, multiple via curry `examples/curry.fl`)
* Fst/Snd expressions
* Inl/Inr expressions
* Match expressions (see `examples/match.fl`)

## Compile and run
```bash
# Make sure you have ocamllex, ocamlyacc installed
make
./main <input-file>
```