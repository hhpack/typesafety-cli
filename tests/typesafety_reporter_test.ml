open OUnit2
open Typesafety_reporter

(* let current_dir = Sys.getcwd () *)

let test_print_result =
  "print_result" >:: (
    fun _ ->
      let json = Template.read_template "../tests/fixtures/output.json" in
      Typesafety_reporter.print_json json;
      assert_bool "always true" true
  )

let tests = "all_tests" >::: [ test_print_result; ]
