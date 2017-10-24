(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

type 'a read_result =
  | Cache of 'a
  | File of 'a

val read_all: ?cache: string Source_lines.t Source_cache.t
  -> string
  -> string Source_lines.t read_result

val read_range:
  ?cache:string Source_lines.t Source_cache.t ->
  ?width:int ->
  line:int ->
  Source_cache.key ->
  (Source_lines.key * string) list
