(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

type color = Magenta | Red | Green | Yellow | Cyan | White

let start_with ~start ~fmt =
  start ^^ fmt ^^ "\027[0m"

let color_format ~color ~fmt =
  let color_with ~color =
    match color with
      | Magenta -> start_with ~start:"\027[35m"
      | Red -> start_with ~start:"\027[31m"
      | Green -> start_with ~start:"\027[32m"
      | Yellow -> start_with ~start:"\027[33m"
      | Cyan -> start_with ~start:"\027[36m"
      | White -> start_with ~start:"\027[37m" in
  color_with ~color ~fmt
