open OUnit2

let () =
  run_test_tt_main ("all_tests" >::: [
    HHConfigTest.tests;
    HHVMVersionTest.tests;
    TypesafetyReporterTest.tests;
    SourceFileTest.tests
  ])
