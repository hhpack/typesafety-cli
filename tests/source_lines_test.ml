open OUnit2
open Test_helper
open Hack

let make items =
  List.fold_left (
    fun a b ->
      let l, s = b in
      Source_lines.add ~key:l ~data:s a
  ) Source_lines.empty items

let string_of_line pair =
  let l, s = pair in
  (string_of_int l) ^ ":" ^ s

let joined_line a b =
  a ^ (string_of_line b)

let lines_map_at_line1 _tctx =
  let m = make [(1, "A"); (2, "B"); (3, "C")] in
  let line_range m = Source_lines.range_lines m ~line:1 in
  let res = List.fold_left joined_line "" (line_range m) in

  assert_equal ~pp_diff:print_diff ~msg:"lines map at line 1" "1:A2:B" res

let lines_map_at_line2 _tctx =
  let m = make [(1, "A"); (2, "B"); (3, "C")] in
  let line_range m = Source_lines.range_lines m ~line:2 in
  let res = List.fold_left joined_line "" (line_range m) in

  assert_equal ~pp_diff:print_diff ~msg:"lines map at line 2" "1:A2:B3:C" res

let lines_map_at_line3 _tctx =
  let m = make [(1, "A"); (2, "B"); (3, "C")] in
  let line_range m = Source_lines.range_lines m ~line:3 in
  let res = List.fold_left joined_line "" (line_range m) in

  assert_equal ~pp_diff:print_diff ~msg:"lines map at line 3" "2:B3:C" res

let tests = "all_tests" >::: [
  "lines_map at line 1" >:: lines_map_at_line1;
  "lines map at line 2" >:: lines_map_at_line2;
  "lines map at line 3" >:: lines_map_at_line3
]
