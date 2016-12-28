open Process

type middleware_error = int * string

type ('b, 'c) middleware_result =
  | Next of 'b
  | Done of 'c
  | Error of middleware_error

type ('a, 'b, 'c) a_middleware = unit -> ('b, 'c) middleware_result

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
    let version s = Str.matched_group 1 s in
    let compiler s = Str.matched_group 2 s in
    let repo_schema s = Str.matched_group 3 s in
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

(* WIP Create .hhconfg if it does not exist *)
let check_hhconfg =
  true
