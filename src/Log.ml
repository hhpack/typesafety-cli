module ColorFormatter = struct
  open Color
  let end_format = end_format ()
  let debug fmt = (start_format White) ^^ fmt ^^ end_format
  let info fmt = (start_format Cyan) ^^ fmt ^^ end_format
  let warn fmt = (start_format Yellow) ^^ fmt ^^ end_format
  let success fmt = (start_format Green) ^^ fmt ^^ end_format
  let error fmt = (start_format Red) ^^ fmt ^^ end_format
end

let verbose = ref false
let verbose_on () = verbose := true
let verbose_off () = verbose := false
let set_verbose verbose = if verbose then verbose_on () else verbose_off ()

let output s = output_string stdout s
let output_error s = output_string stderr s

let debug fmt = Printf.ksprintf output (ColorFormatter.debug fmt)
let info fmt = Printf.ksprintf output (ColorFormatter.info fmt)
let warn fmt = Printf.ksprintf output (ColorFormatter.warn fmt)
let error fmt = Printf.ksprintf output_error (ColorFormatter.error fmt)
let success fmt = Printf.ksprintf output_error (ColorFormatter.success fmt)
let fail fmt = error fmt
