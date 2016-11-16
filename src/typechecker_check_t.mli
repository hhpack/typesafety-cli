(* Auto-generated from "typechecker_check.atd" *)


type error_detail = {
  desc: string;
  path: string;
  line: int;
  start: int;
  end: int;
  code: int
}

type error = { message: error_detail list }

type result = { passed: bool; errors: error list; version: string }
