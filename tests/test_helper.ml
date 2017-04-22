let print_diff f v =
  let expect, actual = v in
  Format.fprintf f "\n  actual: %s\n  expected: %s" actual expect

let assert_equal ?ctxt ?msg expect actual =
  OUnit2.assert_equal ?ctxt ?msg ~pp_diff:print_diff expect actual

let assert_bool s v =
  OUnit2.assert_bool s v

let (>::) = OUnit2.(>::)
let (>:::) = OUnit2.(>:::)
