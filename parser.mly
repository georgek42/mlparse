%{

open Ast

%}

%token <string> IDENT
%token <int> NUM
%token <bool> BOOL

%token EQ GR LT GRE LTE
%token ADD SUB MULT DIV

%token ASSI
%token LET IN FUN ARROW IF THEN ELSE FST SND INL INR

%token MATCH WITH BAR

%token LPAREN RPAREN
%token COMMA

%token EOF

%start program
%type <Ast.program> program

%%

program:
| statements EOF { $1 }
;

statements:
| statement { [$1] }
| statement IN statements { $1 :: $3 }
;

statement:
| LET IDENT ASSI expression { Let ($2, $4) }
;

expression:
| NUM { Int $1 }
| BOOL { Bool $1 }
| IDENT { Var $1 }
| expression EQ expression { Eq ($1, $3) }
| expression GR expression { Gr ($1, $3) }
| expression LT expression { Lt ($1, $3) }
| expression GRE expression { Gre ($1, $3) }
| expression LTE expression { Lte ($1, $3) }
| expression ADD expression { Add ($1, $3) }
| expression SUB expression { Sub ($1, $3) }
| expression DIV expression { Div ($1, $3) }
| expression MULT expression { Mult ($1, $3) }
| IF expression THEN expression ELSE expression { If ($2, $4, $6) }
| FUN IDENT ARROW expression { Fun ($2, $4) }
| FUN params ARROW expression { FunX ($2, $4) }
| expression LPAREN expression RPAREN { App ($1, $3) }
| LPAREN expression COMMA expression RPAREN { Tuple ($2, $4) }
| FST expression { Fst $2 }
| SND expression { Snd $2 }
| INL expression { Inl $2 }
| INR expression { Inr $2 }
| MATCH expression WITH BAR INL IDENT ARROW expression BAR INR IDENT ARROW expression {
  Match ($2, $6, $8, $11, $13)
}
;

params:
| { [] }
| IDENT params { $1 :: $2 }

%%
