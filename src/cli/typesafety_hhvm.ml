open Hhvm
open Process

module Hhvm = Hhvm_runtime.Make(Process_exec)
module Hh_client = Hh_client.Make(Process_exec)
