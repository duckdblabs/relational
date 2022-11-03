# singleton DuckDB instance since we need only one really
# we need a finalizer to disconnect on exit otherwise we get a warning
default_duckdb_connection <- new.env(parent=emptyenv())
get_default_duckdb_connection <- function() {
  if(!exists("con", default_duckdb_connection)) {
    default_duckdb_connection$con <- DBI::dbConnect(duckdb::duckdb())
    reg.finalizer(default_duckdb_connection, function(e) {
      DBI::dbDisconnect(e$con, shutdown=TRUE)
    }, onexit=TRUE)
  }
  default_duckdb_connection$con
}

#' DuckDB relational backend
#'
#' TBD.
#'
#' @param df A data frame.
#' @return A relational object.
#'
#' @export
duckdb_rel_from_df <- function(df) {
  # FIXME: make generic
  stopifnot(is.data.frame(df))

  rel <- attr(df, "rel")
  if (!is.null(rel) && inherits(rel, "duckdb_relation")) {
    return(rel)
  }

  duckdb:::rel_from_df(get_default_duckdb_connection(), df)
}

#' @export
rel_to_df.duckdb_relation <- function(rel, ...) {
  out <- duckdb:::rel_to_altrep(rel)
  attr(out, "rel") <- rel
  out
}

#' @export
rel_filter.duckdb_relation <- function(rel, exprs, ...) {
}

#' @export
rel_project.duckdb_relation <- function(rel, exprs, ...) {
}

#' @export
rel_aggregate.duckdb_relation <- function(rel, groups, aggregates, ...) {
}

#' @export
rel_order.duckdb_relation <- function(rel, orders, ...) {
}

#' @export
rel_inner_join.duckdb_relation <- function(left, right, conds, ...) {
}

#' @export
rel_limit.duckdb_relation <- function(rel, n, ...) {
  duckdb:::rapi_rel_limit(rel, n)
}

#' @export
rel_distinct.duckdb_relation <- function(rel, ...) {
}

#' @export
rel_tostring.duckdb_relation <- function(rel, ...) {
}

#' @export
rel_explain.duckdb_relation <- function(rel, ...) {
}

#' @export
rel_alias.duckdb_relation <- function(rel, ...) {
}

#' @export
rel_set_alias.duckdb_relation <- function(rel, alias, ...) {
}

#' @export
rel_names.duckdb_relation <- function(rel, ...) {
}
