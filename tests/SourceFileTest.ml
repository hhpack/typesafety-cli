open OUnit2

let read_all =
  "read from file/cache" >:: (fun _ ->
    let cache = Cache.create 1024 in
    let readed_file1 = SourceFile.read_all "../tests/fixtures/example1.ml" cache in
    let readed_file2 = SourceFile.read_all "../tests/fixtures/example1.ml" cache in
    let is_from_file = match readed_file1 with
      | SourceFile.Cache _ -> false
      | SourceFile.File _ -> true in
    let is_from_cache = match readed_file2 with
      | SourceFile.Cache _ -> true
      | SourceFile.File _ -> false in

    assert_bool "should be read from file" is_from_file;
    assert_bool "should be read from cache" is_from_cache)

let tests =
  "all_tests" >::: [ read_all; ]
