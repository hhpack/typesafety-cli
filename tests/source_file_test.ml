open OUnit2
open Test_helper

let example1 = "../tests/fixtures/example1.ml"

let read_all_test tcxt =
  let cache = Source_cache.create 1024 in
  let readed_file1 = Source_file.read_all example1 ~cache in
  let readed_file2 = Source_file.read_all example1 ~cache in
  let is_from_file = match readed_file1 with
    | Source_file.Cache _ -> false
    | Source_file.File _ -> true in
  let is_from_cache = match readed_file2 with
    | Source_file.Cache _ -> true
    | Source_file.File _ -> false in

  assert_bool "should be read from file" is_from_file;
  assert_bool "should be read from cache" is_from_cache

let read_range_test tcxt =
  let string_of_line line =
    let line_number, source_code = line in
    (string_of_int line_number) ^ ":" ^ source_code in
  let readed_file f = Source_file.read_range ~line:2 f in
  let joined_line_range f = List.fold_right (fun a b -> (string_of_line a) ^ b) (readed_file f) "" in
  assert_equal
    ~pp_diff:print_diff
    "1:let () =2:  print_endline \"example1.ml\"3:"
    (joined_line_range example1)

let tests =
  "all_tests" >::: [
    "read from file/cache" >:: read_all_test;
    "read from file/cache" >:: read_range_test;
  ]
