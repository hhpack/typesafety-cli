open OUnit2

let test_github_json ctx =
  let open Github_t in
  let to_json = Github_j.review_result_of_string in
  let result_json = Template.json_from ~file:"../tests/fixtures/review.json" ~f:to_json () in
  assert_equal 37975422 result_json.id

let tests = "all_tests" >::: [
  ("github_json" >:: test_github_json);
]
