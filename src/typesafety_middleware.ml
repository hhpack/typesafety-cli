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
  match Hhvm_version.check_hhvm_version () with
    | Ok v -> Next (Hhvm_version.parse_hhvm_version v)
    | Error e -> Error (1, e)

let check_hhconfg () =
  match Hhconfig.create_hhconfg_if_not_exists (Sys.getcwd ()) with
    | Ok v -> Next v
    | Error e -> Error (2, e)

module HHClient = struct
  let to_success output =
    print_string output;
    Next ()

  let restart () =
    match Hhclient.restart () with
      | Ok output -> to_success output
      | Error err -> Error (4, err)

  let check () =
    match Hhclient.check () with
      | Ok output -> to_success output
      | Error err -> Error (4, err)

  let typecheck () =
    match restart () with
      | Next _ -> check ()
      | Done _ -> check ()
      | Error err -> Error err
end

let typecheck = HHClient.typecheck
