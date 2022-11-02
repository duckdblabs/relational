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
expr_reference <- function(name, rel = NULL, alias = NULL) {
  new_expr(list(name = name, alias = alias), class = "relational_expr_reference")
}

#' @export
expr_constant <- function(val, alias = NULL) {
  new_expr(list(val = val, alias = alias), class = "relational_expr_constant")
}

#' @export
expr_function <- function(name, args, alias = NULL) {
  new_expr(list(name = name, args = args, alias = alias), class = "relational_expr_function")
}

#' @export
print.relational_expr <- function(expr, ...) {
  writeLines(format(expr, ...))
}

#' @export
format.relational_expr <- function(expr, ...) {
  # FIXME: Use home-grown code
  utils::capture.output(print(constructive::construct(expr)))
}
