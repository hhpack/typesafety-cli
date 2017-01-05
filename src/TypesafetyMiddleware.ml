open Process

type middleware_error = int * string

type ('b, 'c) middleware_result =
  | Next of 'b
  | Done of 'c
  | Error of middleware_error

type ('a, 'b, 'c) middleware = unit -> ('b, 'c) middleware_result

let rec middleware_exec middlewares =
  match middlewares with
    | [] -> Ok ()
    | middleware :: remain_middlewares ->
      match middleware () with
        | Next _ -> middleware_exec remain_middlewares
        | Done _ -> middleware_exec remain_middlewares
        | Error err -> Error err

let check_hhvm_installed () =
  match HHVMVersion.check_hhvm_version () with
    | Ok v -> Next (HHVMVersion.parse_hhvm_version v)
    | Error e -> Error (1, e)

let check_hhconfg () =
  match HHConfig.create_hhconfg_if_not_exists (Sys.getcwd ()) with
    | Ok v -> Next v
    | Error e -> Error (2, e)
