open Hhvm

module Hhvm = Runtime.Make(Process.Process_exec)
module Hh_client = Hh_client.Make(Process.Process_exec)
