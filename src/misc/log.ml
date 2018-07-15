(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
*)

module ColorFormatter = struct
  open Color
  let debug fmt = color_format ~color:White ~fmt:fmt
  let info fmt = color_format ~color:Cyan ~fmt:fmt
  let warn fmt = color_format ~color:Yellow ~fmt:fmt
  let success fmt = color_format ~color:Green ~fmt:fmt
  let error fmt = color_format ~color:Red ~fmt:fmt
end

let verbose = ref false
let verbose_on () = verbose := true
let verbose_off () = verbose := false
let set_verbose verbose = if verbose then verbose_on () else verbose_off ()

let output s = output_string stdout s
let quit _ = ()

let debug fmt =
  let output = if !verbose then output else quit in
  Printf.ksprintf output (ColorFormatter.debug fmt)

let info fmt = Printf.ksprintf output (ColorFormatter.info fmt)
let warn fmt = Printf.ksprintf output (ColorFormatter.warn fmt)
let error fmt = Printf.ksprintf output (ColorFormatter.error fmt)
let success fmt = Printf.ksprintf output (ColorFormatter.success fmt)
let fail fmt = error fmt
