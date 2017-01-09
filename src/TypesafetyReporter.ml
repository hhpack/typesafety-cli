(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open TypecheckerCheck_t
open SourceFile

let line_number_length = 5

let padding_char n c = String.make n c
let spaces n = padding_char n ' '
let columns n = padding_char n '^'
let hint_placeholder start_column end_column = columns ((end_column + 1) - start_column)
let split_ln s = Str.split (Str.regexp "\n") s

let hint_message start_column end_column =
  let space_string = spaces (start_column + line_number_length) in
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
  let line_code = Lines.find line lines in
  let string_of_line = (string_of_int line) in
  let lpad_length = line_number_length - String.length string_of_line in
  (spaces lpad_length) ^ string_of_line ^ ":" ^ line_code

let lines_of_source file cache =
  match SourceFile.read_all file cache with
    | File lines -> lines
    | Cache lines -> lines
    
let formatter msg_seq =
  if msg_seq == 0 then Color.error else Color.info


let header_message err_seq msg_seq message =
  let color_formatter = formatter msg_seq in
  color_formatter "Error: %d - %s\n\n" err_seq message.source_path

let description_message msg_seq message lines_of_source =
  let color_formatter = formatter msg_seq in
  let hint_description = hint_message message.source_start message.source_end in
  let messages = [
    color_formatter "%s\n\n" (indent_with message.source_descr);
    color_formatter "%s\n" (indent_with (source_code lines_of_source message.source_line));
    color_formatter "%s\n\n" (indent_with hint_description)
  ] in
  String.concat "" messages

let print_error_message cache err_seq =
  fun msg_seq message ->
    let lines_of_source = lines_of_source message.source_path cache in
    let head_message = header_message err_seq msg_seq message in
    let desc_message = description_message msg_seq message lines_of_source in
    let default_messages = [ desc_message ] in
    let messages = if msg_seq == 0 then head_message :: default_messages else default_messages in
    List.iter print_string messages

let print_error cache =
  fun err_seq err -> List.iteri (print_error_message cache (err_seq + 1)) err.error_messages

let print_json json =
  let cache = Cache.create 1024 in
  let result = TypecheckerCheck_j.result_of_string json in
  List.iteri (print_error cache) result.errors

let print_result_file file =
  let json = File.read_all file in
  print_json json
