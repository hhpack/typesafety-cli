(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type line = int * string
type line_range = int * int

module Line_number: sig
  type t = int
  val compare: 'a -> 'a -> int
  val prev: ?n:int -> from:int -> min:int -> int
  val next: ?n:int -> from:int -> max:int -> int
end

module Line_range: sig
  type t = line_range
  val create: first:'a -> last:'b -> 'a * 'b
  val map: int * int -> f:(int -> 'a) -> 'a list
end

type key = Line_number.t
and 'a t = 'a MoreLabels.Map.Make(Line_number).t

val empty: 'a t

val is_empty: 'a t -> bool
val add: key:key -> data:'a -> 'a t -> 'a t
val find: key -> 'a t -> 'a
val find_of_line: 'a t -> line:key -> 'a option
val range: ?width:int -> 'a t -> line:int -> int * int
val range_map: ?width:int -> 'a t -> line:int -> f:(int -> 'b) -> 'b list
val range_lines: ?width:int -> string t -> line:int -> (key * string) list
