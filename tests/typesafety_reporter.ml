open OUnit2

let test_print_result =
  "print_result" >:: (fun _ -> assert_bool "always true" true);;

let () =
  let tests = "all_tests" >::: [ test_print_result; ] in
  run_test_tt_main tests;;
