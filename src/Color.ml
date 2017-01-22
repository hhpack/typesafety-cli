(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

open Printf

type color = Magenta | Red | Green | Yellow | Cyan | White

let color_to_format = function
  | Magenta -> "\027[35m" ^^ ""
  | Red -> "\027[31m" ^^ ""
  | Green -> "\027[32m" ^^ ""
  | Yellow -> "\027[33m" ^^ ""
  | Cyan -> "\027[36m" ^^ ""
  | White -> "\027[37m" ^^ ""

let start_format color = color_to_format color
let end_format () = "\027[0m" ^^ ""
let color_format color fmt = (start_format color) ^^ fmt ^^ (end_format ())
