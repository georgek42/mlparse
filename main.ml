open Printf
open String

open Ast
let sprintf = Printf.sprintf
let rec expr_to_string (expr: Ast.expr): string =
    match expr with
    | Int(n) -> sprintf "Num (%d)" n
    | Bool(b) -> sprintf "Bool (%B)" b
    | Var(id) -> sprintf "Var (\"%s\")" id
    | Eq (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Eq (%s, %s)" e1s e2s
    | Gr (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Gr (%s, %s)" e1s e2s
    | Lt (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Lt (%s, %s)" e1s e2s
    | Gre (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Gre (%s, %s)" e1s e2s
    | Lte (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Lte (%s, %s)" e1s e2s
    | Add (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Add (%s, %s)" e1s e2s
    | Sub (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Sub (%s, %s)" e1s e2s
    | Div (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Div (%s, %s)" e1s e2s
    | Mult (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Mult (%s, %s)" e1s e2s
    | If (e1, e2, e3) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        let e3s = expr_to_string e3 in
        sprintf "If (%s, %s, %s)" e1s e2s e3s
    | Fun (param, e) ->
        let es = expr_to_string e in
        sprintf "Fun (\"%s\", %s)" param es
    | FunX (params, e) ->
        let es = expr_to_string e in
        sprintf "FunX (%s, %s)" (String.concat "," params) es
    | App (e1, e2) ->
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "App (%s, %s)" e1s e2s
    | Tuple (e1, e2) -> 
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Tuple (%s, %s)" e1s e2s
    | Fst (e) ->
        let es = expr_to_string e in
        sprintf "Fst (%s)" es
    | Snd (e) ->
        let es = expr_to_string e in
        sprintf "Snd (%s)" es
    | Inl (e) ->
        let es = expr_to_string e in
        sprintf "Inl (%s)" es
    | Inr (e) ->
        let es = expr_to_string e in
        sprintf "Inr (%s)" es
    | Match (e, s1, e1, s2, e2) ->
        let es = expr_to_string e in
        let e1s = expr_to_string e1 in
        let e2s = expr_to_string e2 in
        sprintf "Match (%s, \"%s\", %s, \"%s\", %s)" es s1 e1s s2 e2s
    
let stmt_to_string (s: Ast.stmt): string =
    match s with
    | Let (id, expr) -> sprintf "Let (\"%s\", %s)" id (expr_to_string expr)
let rec stmts_to_string (stmts: stmt list) (acc: string): string =
    match stmts with
    | [] -> acc
    | stmt::rest -> (stmts_to_string rest (String.concat ", " [(stmt_to_string stmt); acc]))
let ast_to_string (p: Ast.program): string = sprintf "Stmts (%s)" (stmts_to_string p "")

let parse f = 
        let lexbuf = Lexing.from_channel (open_in f) in
        try
            print_string (ast_to_string (Parser.program Lexer.micro lexbuf))
        with
        | Lexer.Syntax_error s ->
            print_string s;
            print_string "\n";
            exit 1

let help () = print_string "./main <file>\n"

let () = if Array.length Sys.argv = 1 then help ()
         else 
             let file = Array.get Sys.argv 1 in
             parse file

