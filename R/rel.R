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
rel_to_df <- function(rel, ...) {
  UseMethod("rel_to_df")
}

#' Lazily filter a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param exprs a list of DuckDB expressions to filter by
#' @return the now filtered `duckdb_relation` object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel2 <- rel_filter(rel, list(expr_function("gt", list(expr_reference("cyl"), expr_constant("6")))))
rel_filter <- function(rel, exprs, ...) {
  UseMethod("rel_filter")
}

#' Lazily project a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param exprs a list of DuckDB expressions to project
#' @return the now projected `duckdb_relation` object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel2 <- rel_project(rel, list(expr_reference("cyl"), expr_reference("disp")))
rel_project <- function(rel, exprs, ...) {
  UseMethod("rel_project")
}

#' Lazily aggregate a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param groups a list of DuckDB expressions to group by
#' @param aggregates a (optionally named) list of DuckDB expressions with aggregates to compute
#' @return the now aggregated `duckdb_relation` object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' aggrs <- list(avg_hp = expr_function("avg", list(expr_reference("hp"))))
#' rel2 <- rel_aggregate(rel, list(expr_reference("cyl")), aggrs)
rel_aggregate <- function(rel, groups, aggregates, ...) {
  UseMethod("rel_aggregate")
}

#' Lazily reorder a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param orders a list of DuckDB expressions to order by
#' @return the now aggregated `duckdb_relation` object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel2 <- rel_order(rel, list(expr_reference("hp")))
rel_order <- function(rel, orders, ...) {
  UseMethod("rel_order")
}

#' Lazily INNER join two DuckDB relation objects
#' @param left the left-hand-side DuckDB relation object
#' @param right the right-hand-side DuckDB relation object
#' @param conds a list of DuckDB expressions to use for the join
#' @return a new `duckdb_relation` object resulting from the join
#' @export
#' @examples
#' left <- rel_from_df(mtcars)
#' right <- rel_from_df(mtcars)
#' cond <- list(expr_function("eq", list(expr_reference("cyl", left), expr_reference("cyl", right))))
#' rel2 <- rel_inner_join(left, right, cond)
rel_inner_join <- function(left, right, conds, ...) {
  UseMethod("rel_inner_join")
}

#' @rdname rel
#' @export
rel_limit <- function(rel, n, ...) {
  UseMethod("rel_limit")
}

#' Lazily compute a distinct result on a DuckDB relation object
#' @param rel the input DuckDB relation object
#' @return a new `duckdb_relation` object with distinct rows
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel2 <- rel_distinct(rel)
rel_distinct <- function(rel, ...) {
  UseMethod("rel_distinct")
}

#' @rdname rel
#' @export
rel_tostring <- function(rel, ...) {
  UseMethod("rel_tostring")
}

#' Print the EXPLAIN output for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_explain(rel)
rel_explain <- function(rel, ...) {
  UseMethod("rel_explain")
}

#' Get the internal alias for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_alias(rel)
rel_alias <- function(rel, ...) {
  UseMethod("rel_alias")
}

#' Set the internal alias for a DuckDB relation object
#' @param rel the DuckDB relation object
#' @param alias the new alias
#' @export
#' @examples
#' rel <- rel_from_df(mtcars)
#' rel_set_alias(rel, "my_new_alias")
rel_set_alias <- function(rel, alias, ...) {
  UseMethod("rel_set_alias")
}

#' @rdname rel
#' @export
rel_names <- function(rel, ...) {
  UseMethod("rel_names")
}

