open Printf

type color = Magenta | Red | Cyan | White

let color_to_string = function
  | Magenta -> "\027[35m"
  | Red -> "\027[31m"
  | Cyan -> "\027[36m"
  | White -> "\027[37m"

let color_start color =
  Scanf.format_from_string (color_to_string color) ""

let color_end =
  Scanf.format_from_string "\027[0m" ""

let color_format color fmt = (color_start color) ^^ fmt ^^ color_end

let magenta fmt = sprintf (color_format Magenta fmt)
let red fmt = sprintf (color_format Red fmt)
let cyan fmt = sprintf (color_format Cyan fmt)
let white fmt = sprintf (color_format White fmt)
