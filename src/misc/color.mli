(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

type color = Magenta | Red | Green | Yellow | Cyan | White

val start_with:
  start:('a, 'b, 'c, 'd, 'e, 'f) format6 ->
  fmt:('f, 'b, 'c, 'e, 'g, 'h) format6 ->
  ('a, 'b, 'c, 'd, 'g, 'h) format6

val color_format:
  color:color ->
  fmt:('a, unit, string, string, string, unit) format6 ->
  ('a, unit, string, string, string, unit) format6
