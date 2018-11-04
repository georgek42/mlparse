{

open Parser

let line_num = ref 1

exception Syntax_error of string

let syntax_error msg = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !line_num)))

}

let blank = [' ' '\r' '\t']
let digit = ['0'-'9']
let number = digit*
let alpha = ['a'-'z' 'A'-'Z']
let ident = alpha (alpha | digit | '_')*

rule micro = parse
    | '='         { ASSI }
    | '>'         { GR }
    | '<'         { LT }
    | ">="        { GRE }
    | "<="        { LTE }
    | '+'         { ADD }
    | '-'         { SUB }
    | '*'         { MULT }
    | '/'         { DIV }
    | "=="        { EQ }
    | "let"       { LET }
    | "in"        { IN }
    | "fun"       { FUN }
    | "->"        { ARROW }
    | "if"        { IF }
    | "then"      { THEN }
    | "else"      { ELSE }
    | "fst"       { FST }
    | "snd"       { SND }
    | "inr"       { INR }
    | "inl"       { INL }
    | "match"     { MATCH }
    | "with"      { WITH }
    | '|'         { BAR }
    | "true"      { BOOL(true) }
    | "false"     { BOOL(false) }
    | '('         { LPAREN }
    | ')'         { RPAREN }
    | ','         { COMMA }
    | ident as i  { IDENT(i) }
    | number as n { NUM(int_of_string n) }
    | '\n'     { incr line_num; micro lexbuf }
    | blank    { micro lexbuf }
    | _        { syntax_error "couldn't identify the token" }
    | eof      { EOF }

