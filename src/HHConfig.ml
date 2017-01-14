(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type absolute_path = string

type hhconfig_result =
  | AlreadyExists of absolute_path
  | FileCreated of absolute_path

let config_file = ".hhconfig"
let config_path ?(dir = Sys.getcwd ()) () = (File.dirname dir) ^ "/" ^ config_file

let exists file = Sys.file_exists file

let touch file =
  let created = (FileCreated file) in
  try
    close_out (open_out file);
    Ok created
  with Sys_error e -> Error e

let create_if ?(dir = Sys.getcwd ()) v default =
  if v then
    touch (config_path ~dir ())
  else
    default

(* unused? *)
let create_if_not_exists dir =
  let file = config_path ~dir () in
  let already_exists = AlreadyExists file in
  let file_not_exists = not (exists file) in
  let file_already_exists = Ok already_exists in
  create_if file_not_exists file_already_exists
