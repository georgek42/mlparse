all: main

parser.ml: parser.mly
	ocamlyacc $<

lexer.ml: lexer.mll
	ocamllex $<

main: ast.mli parser.ml lexer.ml parser.ml
	ocamlc ast.mli
	ocamlc parser.mli
	ocamlc -o $@ str.cma parser.ml lexer.ml  main.ml

clean:
	rm -f *.cmo
	rm -f *.cmi
	rm -f *.ml
	rm -f main