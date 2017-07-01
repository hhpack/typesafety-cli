(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type absolute_path = string

type hhconfig_result =
  | AlreadyExists of absolute_path
  | FileCreated of absolute_path

let file_created file = FileCreated file
let already_exists file = AlreadyExists file

let string_of_result = function
  | AlreadyExists v -> Printf.sprintf "File %s is already exists." v
  | FileCreated v -> Printf.sprintf "File %s created." v

let config_file = ".hhconfig"
let config_path ?(dir = Sys.getcwd ()) () =
  Filename.concat dir config_file

let exists file = Sys.file_exists file

let touch file =
  try
    close_out (open_out file);
    Ok (file_created file)
  with Sys_error e -> Error e

let create_if ?(dir = Sys.getcwd ()) ~no_hhconfig () =
  let config_file = config_path ~dir () in
  let not_exists = not (exists config_file) in
  let not_exists_error = Error (config_file ^ " is not found") in
  if not_exists then
    if no_hhconfig then
      not_exists_error
    else
      touch config_file
  else
    Ok (already_exists config_file)
