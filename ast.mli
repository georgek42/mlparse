type expr =
    | Int of int
    | Bool of bool
    | Var of string
    | Eq of expr * expr
    | Gr of expr * expr
    | Lt of expr * expr
    | Gre of expr * expr
    | Lte of expr * expr
    | Add of expr * expr
    | Sub of expr * expr
    | Div of expr * expr
    | Mult of expr * expr
    | If of expr * expr * expr
    | FunX of string list * expr
    | Fun of string * expr
    | App of expr * expr
    | Tuple of expr * expr
    | Fst of expr
    | Snd of expr
    | Inl of expr
    | Inr of expr
    | Match of expr * string * expr * string * expr 

type stmt =
    | Let of string * expr

type program = stmt list