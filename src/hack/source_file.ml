(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type 'a read_result =
  | Cache of 'a
  | File of 'a

let read_from_cache ~cache file =
  try Some (Cache.find cache file)
    with Not_found -> None

let read_from_file file =
  let ch = open_in file in
  let length = in_channel_length ch in
  let file = really_input_string ch length in
  close_in ch;
  file

let rec lines_into inputs outputs i =
  let line_number = i + 1 in
  match inputs with
    | [] -> outputs
    | hd :: tl -> lines_into tl (Lines.add ~key:line_number ~data:hd outputs) line_number

let lines_from_string s =
  let outputs = Lines.empty in
  let inputs = Str.split_delim (Str.regexp "\n") s in
  lines_into inputs outputs 0

let read_from_file_and_cache ~cache file =
  let content = read_from_file file in
  let lines = lines_from_string content in
  Cache.add cache ~key:file ~data:lines;
  lines

let read_all ?(cache=Cache.create 1024) file =
  match read_from_cache file ~cache with
    | Some v -> Cache v
    | None -> File (read_from_file_and_cache file ~cache)

let read_range ?(cache=Cache.create 1024) ?(width = 1) ~line file =
  let range_lines ?(width = 1) m =
    Lines.range_lines ~width ~line m in
  match read_all ~cache file with
    | File m -> range_lines ~width m
    | Cache m -> range_lines ~width m
