#' @export
wrap <- function(x) {
	.Call(chunkrep_wrap, x)
}

#' @export
wrap_df <- function(df) {
  stopifnot(is.data.frame(df))
  out <- lapply(df, wrap)
  class(out) <- "data.frame"
  message(1)
  .Call(set_row_names, out, wrap(.set_row_names(nrow(df))))
  message(2)
  out
}
