(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type line = (int * string)
type line_range = (int * int)

module Line_number = struct
  type t = int
  let compare = compare
  let prev ?(n = 1) ~from ~min =
    let prev = from - n in
    if prev > min then prev else min
  let next ?(n = 1) ~from ~max =
    let next = from + n in
    if next > max then max else next
end

module Line_range = struct
  type t = line_range
  let create ~first ~last = (first, last)
  let map t ~f =
    let first, last = t in
    let rec inner_map ~first ~last ~out =
      let process ~first =
        inner_map ~first:(first + 1) ~last ~out:((f first)::out) in
      if first <= last then
        process ~first
      else
        List.rev out in
    inner_map ~first ~last ~out:[]
end

module Lines = MoreLabels.Map.Make(Line_number)

include Lines

let find_of_line m ~line =
  try
    Some (Lines.find line m)
  with Not_found -> None

let range ?(width = 1) m ~line =
  let sl = Line_number.prev ~n:width ~from:line ~min:1 in
  let el = Line_number.next ~n:width ~from:line ~max:(cardinal m) in
  (sl, el)

let range_map ?(width = 1) m ~line ~f =
  let line_range = range m ~width ~line in
  Line_range.map line_range f

let range_lines ?(width = 1) m ~line =
  let to_line line = match find_of_line m ~line with
    | Some v -> (line, v)
    | None -> (line, "") in
  range_map ~width ~line ~f:to_line m
