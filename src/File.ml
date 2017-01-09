(**
 * Copyright 2016 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

let read_all file =
  let ch = open_in file in
  let length = in_channel_length ch in
  let file = really_input_string ch length in
  close_in ch;
  file

let dirname path =
  let omit_last_char path = String.sub path 0 ((String.length path) - 1) in
  let last_char path = String.sub path ((String.length path) - 1) 1 in
  if (last_char path) = "/" then omit_last_char path else path
