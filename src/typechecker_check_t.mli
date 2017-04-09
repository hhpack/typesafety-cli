(* Auto-generated from "typechecker_check.atd" *)


type error_detail = {
  source_descr (*atd descr *): string;
  source_path (*atd path *): string;
  source_line (*atd line *): int;
  source_start (*atd start *): int;
  source_end (*atd end *): int;
  source_code (*atd code *): int
}

type error = { error_messages (*atd messages *): error_detail list }

type result = { passed: bool; errors: error list; version: string }
