(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type t = Buffer.t

let create ?(size=1024) () =
  Buffer.create size

let ntimes ~c ~n =
  String.make n c

let spaces ~n =
  String.make n ' '

let write t ~s =
  Buffer.add_string t s; t

let write_ntimes t ~c ~n =
  write t ~s:(ntimes ~n ~c)

let write_space t ~n =
  write t ~s:(spaces ~n)

let write_indent ?(n=1) t =
  write t ~s:(ntimes ~c:'\t' ~n)

let write_crlf t ~n =
  write t ~s:(ntimes ~c:'\n' ~n)

let write_with_c t ~c ~n ~s =
  Buffer.add_string t (ntimes ~c ~n);
  Buffer.add_string t s;
  t

let write_with_indent ?(indent=1) ?(ln=0) ~s t =
  let write_line buf s = write_with_c buf ~c:'\t' ~n:indent ~s:(s ^ "\n") in
  let write_ln buf ~n = if n <= 0 then buf else write_crlf buf ~n in

  let write_one_line buf ~s =
    write_ntimes buf ~c:'\t' ~n:indent |>
    write ~s |>
    write_ln ~n:ln in

  let write_multiple_line buf ~lines =
    ListLabels.fold_left ~f:write_line ~init:buf lines |>
    write_ln ~n:(ln - 1) (* Consider the case of multiple lines *) in

  let lines = String.split_on_char '\n' s in
  match lines with
    | [] -> t
    | hd::[] -> write_one_line t ~s:hd
    | hd::tail -> write_multiple_line t ~lines:(hd::tail)

let write_wrap_s t ~wrap ~s =
  write t ~s:wrap |> write ~s |> write ~s:wrap

let writeln ?s ?(n=1) t =
  match s with
    | Some s -> write t ~s |> write_crlf ~n
    | None -> write_crlf t ~n

let contents t =
  Buffer.contents t
