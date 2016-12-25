type error = int * string

type ('a, 'b) middleware_result =
  | Next 'a
  | Done 'a
  | Error of 'b

type ('i, 'a, 'b) middleware = 'i -> ('a, 'b) middleware_result

(* WIP Check whether HHVM is installed *)
let check_hhvm_installed =
  true

(* WIP Create .hhconfg if it does not exist *)
let check_hhconfg =
  true
