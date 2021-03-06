open OUnit2
open Test_helper
open Env

let test_current_env _tctx =
  let module S = Ci_service_env.Travis.Make(struct
    let get key = match key with
      | "TRAVIS" -> Some "true"
      | _ -> Some "false"
  end) in
  assert_bool "current env is false" (S.is_current ())

let test_not_current_env _tctx =
  let module S = Ci_service_env.Travis.Make(struct
    let get key = match key with
      | "TRAVIS" -> Some "false"
      | _ -> Some "false"
  end) in
  assert_bool "current env is true" (not (S.is_current ()))

let test_slug _tctx =
  let open Github in
  let module S = Ci_service_env.Travis.Make(struct
    let get key = match key with
      | "TRAVIS_PULL_REQUEST_SLUG" -> Some "holyshared/typesafey"
      | _ -> None
  end) in
  let actual slug =
    match slug with
      | Ok v -> Slug.to_string v
      | Error _ -> "invalid slug" in
  assert_equal ~pp_diff:print_diff "holyshared/typesafey" (actual (S.slug ()))

let tests =
  "all_tests" >::: [
    ("test_current_env" >:: test_current_env);
    ("test_not_current_env" >:: test_not_current_env);
    ("test_slug" >:: test_slug)
  ]
