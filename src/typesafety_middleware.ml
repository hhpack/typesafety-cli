open Process

type middleware_error = int * string

type ('b, 'c) middleware_result =
  | Next of 'b
  | Done of 'c
  | Error of middleware_error

type ('a, 'b, 'c) middleware = unit -> ('b, 'c) middleware_result

module HHVM_version = struct
  type hhvm_version = {
    version: string;
    compiler: string;
    repo_schema: string;
  }

  let check_hhvm_version () =
    try
      Ok (String.concat "\n" (Process.read_stdout "hhvm" [|"--version"|]))
    with _ -> Error "hhvm not installed"

  let parse_hhvm_version output =
    let regexp = Str.regexp "HipHop VM \\(.+\\)\nCompiler: \\(.+\\)\nRepo schema: \\(.+\\)" in
    let group n s = Str.matched_group n s in
    let version s = group 1 s in
    let compiler s = group 2 s in
    let repo_schema s = group 3 s in
    if Str.string_match regexp output 0 then
      Some {
        version=(version output);
        compiler=(compiler output);
        repo_schema=(repo_schema output);
      }
    else
      None

  let check_hhvm_installed () =
    match check_hhvm_version () with
      | Ok v -> Next (parse_hhvm_version v)
      | Error e -> Error (1, e)
end

let check_hhvm_installed = HHVM_version.check_hhvm_installed

module HHConfg = struct
  let config_file = ".hhconfig"
  let config_path dir = (File.dirname dir) ^ "/" ^ config_file

  let hhconfg_exists dir =
    Sys.file_exists (config_path dir)

  let touch_hhconfig dir =
    let absolute_path = config_path dir in
    try
      close_out (open_out absolute_path);
      Ok absolute_path
    with Sys_error e -> Error e

  let create_hhconfg_if_not_exists dir =
    let absolute_path = config_path dir in
    if hhconfg_exists dir then
      Ok absolute_path
    else
      touch_hhconfig dir

  let check_hhconfg () =
    match create_hhconfg_if_not_exists (Sys.getcwd ()) with
      | Ok v -> Next v
      | Error e -> Error (2, e)
end

let check_hhconfg = HHConfg.check_hhconfg

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
