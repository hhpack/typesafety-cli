(* Auto-generated from "TypecheckerCheck.atd" *)


type error_detail = TypecheckerCheck_t.error_detail = {
  source_descr (*atd descr *): string;
  source_path (*atd path *): string;
  source_line (*atd line *): int;
  source_start (*atd start *): int;
  source_end (*atd end *): int;
  source_code (*atd code *): int
}

type error = TypecheckerCheck_t.error = {
  error_messages (*atd messages *): error_detail list
}

type result = TypecheckerCheck_t.result = {
  passed: bool;
  errors: error list;
  version: string
}

val write_error_detail :
  Bi_outbuf.t -> error_detail -> unit
  (** Output a JSON value of type {!error_detail}. *)

val string_of_error_detail :
  ?len:int -> error_detail -> string
  (** Serialize a value of type {!error_detail}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_error_detail :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> error_detail
  (** Input JSON data of type {!error_detail}. *)

val error_detail_of_string :
  string -> error_detail
  (** Deserialize JSON data of type {!error_detail}. *)

val write_error :
  Bi_outbuf.t -> error -> unit
  (** Output a JSON value of type {!error}. *)

val string_of_error :
  ?len:int -> error -> string
  (** Serialize a value of type {!error}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_error :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> error
  (** Input JSON data of type {!error}. *)

val error_of_string :
  string -> error
  (** Deserialize JSON data of type {!error}. *)

val write_result :
  Bi_outbuf.t -> result -> unit
  (** Output a JSON value of type {!result}. *)

val string_of_result :
  ?len:int -> result -> string
  (** Serialize a value of type {!result}
      into a JSON string.
      @param len specifies the initial length
                 of the buffer used internally.
                 Default: 1024. *)

val read_result :
  Yojson.Safe.lexer_state -> Lexing.lexbuf -> result
  (** Input JSON data of type {!result}. *)

val result_of_string :
  string -> result
  (** Deserialize JSON data of type {!result}. *)
