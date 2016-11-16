open Core.Std
open OUnit2
open Typesafety_reporter

let test_print_result =
  "print_result" >:: (
    fun _ ->
      let f = Filename.realpath "../tests/fixtures/output.json" in
      Typesafety_reporter.print_result_file f;
      assert_bool "always true" true
  );;

let () =
  let tests = "all_tests" >::: [ test_print_result; ] in
  run_test_tt_main tests;;
