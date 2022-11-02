#' Relational API
#'
#' TBD.
#'
#' @name rel
#' @export
rel_from_df <- function(con, df) {
  UseMethod("rel_from_df")
}

#' @rdname rel
#' @export
rel_to_df <- function(rel) {
  UseMethod("rel_to_df")
}

#' @rdname rel
#' @export
rel_filter <- function(rel, exprs) {
  UseMethod("rel_filter")
}

#' @rdname rel
#' @export
rel_project <- function(rel, exprs) {
  UseMethod("rel_project")
}

#' @rdname rel
#' @export
rel_aggregate <- function(rel, groups, aggregates) {
  UseMethod("rel_aggregate")
}

#' @rdname rel
#' @export
rel_order <- function(rel, orders) {
  UseMethod("rel_order")
}

#' @rdname rel
#' @export
rel_inner_join <- function(left, right, conds) {
  UseMethod("rel_inner_join")
}

#' @rdname rel
#' @export
rel_limit <- function(rel, n) {
  UseMethod("rel_limit")
}

#' @rdname rel
#' @export
rel_distinct <- function(rel) {
  UseMethod("rel_distinct")
}

#' @rdname rel
#' @export
rel_tostring <- function(rel) {
  UseMethod("rel_tostring")
}

#' @rdname rel
#' @export
rel_explain <- function(rel) {
  UseMethod("rel_explain")
}

#' @rdname rel
#' @export
rel_alias <- function(rel) {
  UseMethod("rel_alias")
}

#' @rdname rel
#' @export
rel_set_alias <- function(rel, alias) {
  UseMethod("rel_set_alias")
}

#' @rdname rel
#' @export
rel_sql <- function(rel, sql) {
  UseMethod("rel_sql")
}

#' @rdname rel
#' @export
rel_names <- function(rel) {
  UseMethod("rel_names")
}

