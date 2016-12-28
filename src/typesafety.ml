open Cmdliner

let program_terminate = function
  | `Error _ -> exit 1
  | _ -> exit 0

let () =
  program_terminate (Term.eval (Typesafety_check.check_t, Typesafety_check.info))
