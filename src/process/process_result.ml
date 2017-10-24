(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

type t = int * string

let create ~status output =
  (status, output)

let status result =
  let (status, _) = result in
  status

let output result =
  let (_, output) = result in
  output

let is_ok result =
  let (status, _) = result in
  status = 0

let is_error result =
  is_ok result = false

let to_string result =
  let (status, output) = result in
  (string_of_int status) ^ ":" ^ output

let return_ok result =
  Lwt.return_ok (output result)

let return_error result ~msg =
  Lwt.return_error (msg ^ "\n" ^ (output result))
