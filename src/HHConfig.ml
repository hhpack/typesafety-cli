let config_file = ".hhconfig"
let config_path dir = (File.dirname dir) ^ "/" ^ config_file

let exists dir =
  Sys.file_exists (config_path dir)

let touch dir =
  let absolute_path = config_path dir in
  try
    close_out (open_out absolute_path);
    Ok absolute_path
  with Sys_error e -> Error e

let create_if_not_exists dir =
  let absolute_path = config_path dir in
  if exists dir then
    Ok absolute_path
  else
    touch dir
