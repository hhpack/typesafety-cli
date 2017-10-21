open Misc

let root_dir = Sys.getcwd ()

let read_template ?(root=root_dir) ~file () =
  let tmpl = File.read_all file in
  let symbol = Str.regexp "{{root}}" in
  Str.global_replace symbol root tmpl

let json_from ?(root=root_dir) ~file ~f () =
  f (read_template ~root ~file ())
