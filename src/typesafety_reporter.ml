open Core.Std

let print_error_message message =
  let open Typechecker_check_t in
  print_endline message.source_path;
  print_endline (String.concat ["  "; message.source_descr])

let print_error err =
  let open Typechecker_check_t in
  List.iter err.error_messages print_error_message

let print_json json =
  let open Typechecker_check_t in
  let result = Typechecker_check_j.result_of_string json in
  List.iter result.errors print_error

let print_result_file file =
  let json = In_channel.read_all file in
  print_json json
