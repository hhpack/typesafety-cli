(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
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

let dirname path = Filename.dirname path
