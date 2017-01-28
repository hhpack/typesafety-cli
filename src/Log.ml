module ColorFormatter = struct
  open Color
  let debug fmt = color_format White fmt
  let info fmt = color_format Cyan fmt
  let warn fmt = color_format Yellow fmt
  let success fmt = color_format Green fmt
  let error fmt = color_format Red fmt
end

let verbose = ref false
let verbose_on () = verbose := true
let verbose_off () = verbose := false
let set_verbose verbose = if verbose then verbose_on () else verbose_off ()

let output s = output_string stdout s
let output_error s = output_string stderr s
let quit s = ()

let debug fmt =
  let output = if !verbose then output else quit in
  Printf.ksprintf output (ColorFormatter.debug fmt)

let info fmt = Printf.ksprintf output (ColorFormatter.info fmt)
let warn fmt = Printf.ksprintf output (ColorFormatter.warn fmt)
let error fmt = Printf.ksprintf output_error (ColorFormatter.error fmt)
let success fmt = Printf.ksprintf output_error (ColorFormatter.success fmt)
let fail fmt = error fmt
