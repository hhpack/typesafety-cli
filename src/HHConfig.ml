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

let file_created file = FileCreated file
let already_exists file = AlreadyExists file

let string_of_result = function
  | AlreadyExists v -> v
  | FileCreated v -> v

let config_file = ".hhconfig"
let config_path ?(dir = Sys.getcwd ()) () = (File.dirname dir) ^ "/" ^ config_file

let exists file = Sys.file_exists file

let touch file =
  let created = (file_created file) in
  try
    close_out (open_out file);
    Ok created
  with Sys_error e -> Error e

let create_if ?(dir = Sys.getcwd ()) v default =
  if v then
    touch (config_path ~dir ())
  else
    default

let create_if_auto_generate ?(dir = Sys.getcwd ()) no_hhconfig =
  let config_file = config_path ~dir () in
  let not_exists = not (exists config_file) in
  let not_exists_error = Error (config_file ^ " is not found") in
  let no_hhconfig_create = not no_hhconfig in
  if not_exists then
    create_if ~dir no_hhconfig_create not_exists_error
  else
    Ok (already_exists config_file)
