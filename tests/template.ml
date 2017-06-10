let root_dir = Sys.getcwd ()

let project_root_dir =
  let tests_dir = Str.regexp "/tests" in
  Str.replace_first tests_dir "" root_dir

let read_template ?(root=root_dir) ~file () =
  let tmpl = File.read_all file in
  let symbol = Str.regexp "{{root}}" in
  Str.global_replace symbol root tmpl

let json_from ?(root=root_dir) ~file ~f () =
  f (read_template ~root ~file ())
