#' Relational expressions
#'
#' TBD.
#'
#' @name expr
#' @export
new_expr <- function(x, class = NULL) {
  structure(x, class = unique(c(class, "relational_expr")))
}

#' @export
expr_reference <- function(name, rel = NULL) {
  new_expr(list(name = name), class = "relational_expr_reference")
}

#' @export
expr_constant <- function(val) {
  new_expr(list(val = val), class = "relational_expr_constant")
}

#' @export
expr_function <- function(name, args) {
  new_expr(list(name = name, args = args), class = "relational_expr_function")
}

#' @export
expr_alias <- function(expr, alias) {
  expr <- unclass(expr)
  expr[["alias"]] <- alias
  new_expr(expr)
}

#' @export
print.relational_expr <- function(expr, ...) {
  writeLines(format(expr, ...))
}

#' @export
format.relational_expr <- function(expr, ...) {
  # FIXME: Use home-grown code
  capture.output(print(constructive::construct(expr)))
}
