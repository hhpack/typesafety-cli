open Core.Std

let print_result file =
  let json = In_channel.read_all file in
  print_endline json;;
