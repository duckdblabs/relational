#' Relational API
#'
#' TBD.
#'
#' @name rel
#' @export
new_relational <- function(..., class = NULL) {
  structure(..., class = c(class, "relational"))
}

#' @export
rel_from_df <- function(df) {
  # FIXME: make generic
  stopifnot(is.data.frame(df))
  new_relational(list(df), class = c("relational_df"))
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

#' Print the EXPLAIN output for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_explain(rel)
rel_explain <- function(rel) {
  UseMethod("rel_explain")
}

#' Get the internal alias for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_alias(rel)
rel_alias <- function(rel) {
  UseMethod("rel_alias")
}

#' Set the internal alias for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param alias the new alias
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_set_alias(rel, "my_new_alias")
rel_set_alias <- function(rel, alias) {
  UseMethod("rel_set_alias")
}

#' @rdname rel
#' @export
rel_names <- function(rel) {
  UseMethod("rel_names")
}

