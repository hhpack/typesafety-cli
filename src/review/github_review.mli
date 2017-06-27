(**
 * Copyright 2016-2017 Noritaka Horio <holy.shared.design@gmail.com>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 *)

type skip_result =
  | NoError
  | NotPullRequest

type review_result =
  | Skiped of skip_result
  | Reviewed of Github_t.review_result

module type S = sig
  val create: Typechecker_check_t.result -> (review_result, string) result
end

module Make(Supports_ci: Ci_detector.Supports_ci.S) (Http_client: Http_client.S): S

val create: Typechecker_check_t.result -> (review_result, string) result
