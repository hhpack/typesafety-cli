open OUnit2

let () =
  run_test_tt_main ("all_tests" >::: [
    TypesafetyMiddlewareTest.tests;
    TypesafetyReporterTest.tests;
    SourceFileTest.tests
  ])
