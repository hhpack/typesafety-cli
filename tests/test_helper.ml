open Hhvm

let print_diff f v =
  let expect, actual = v in
  Format.fprintf f "\n  actual: %s\n  expected: %s" actual expect

let diff_of_int f v =
  let expect, actual = v in
  Format.fprintf f "\n  actual: %s\n  expected: %s" (string_of_int actual) (string_of_int expect)

let diff_of_hhconfig_result f v =
  let open Hh_config in
  let expect, actual = v in
  Format.fprintf f "\n  actual: %s\n  expected: %s" (string_of_result actual) (string_of_result expect)
