open Typechecker_check_t
open Source_file

let padding_char n c = String.make n c
let spaces n = padding_char n ' '
let columns n = padding_char n '^'
let hint_placeholder start_column end_column = columns ((end_column + 1) - start_column)
let split_ln s = Str.split (Str.regexp "\n") s

let hint_message start_column end_column =
  let space_string = spaces (start_column - 1) in
  let hint_text = hint_placeholder start_column end_column in
  space_string ^ hint_text

(* Indent a specified number *)
let indent ?(n = 1) () = spaces (n * 2)

(* Returns a string with an indent *)
let indent_with ?(n = 1) s =
  let indent s = (indent ~n ()) ^ s in
  let indent_lines = List.map indent (split_ln s) in
  String.concat "\n" indent_lines

let source_code lines line =
  Lines.find line lines

let lines_of_source file cache =
  match Source_file.read_all file cache with
    | File lines -> lines
    | Cache lines -> lines

let print_error_message cache =
  fun message ->
    let lines_of_source = lines_of_source message.source_path cache in
    let hint_description = hint_message message.source_start message.source_end in
    let messages = [
      (Color.red "%s" message.source_path);
      "";
      (indent_with message.source_descr);
      "";
      (indent_with (source_code lines_of_source message.source_line));
      (indent_with hint_description);
      ""
    ] in
    List.iter print_endline messages

let print_error cache =
  fun err -> List.iter (print_error_message cache) err.error_messages

let print_json json =
  let cache = Cache.create 1024 in
  let result = Typechecker_check_j.result_of_string json in
  List.iter (print_error cache) result.errors

let print_result_file file =
  let json = File.read_all file in
  print_json json
