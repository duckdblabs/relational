% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rel.R
\name{rel_order}
\alias{rel_order}
\title{Lazily reorder a relation object}
\usage{
rel_order(rel, orders, ...)
}
\arguments{
\item{rel}{The relation object.}

\item{orders}{a list of DuckDB expressions to order by}

\item{...}{Reserved for future extensions, must be empty.}
}
\value{
the now aggregated relation object
}
\description{
TBD.
}
\examples{
rel <- rel_from_df(mtcars)
rel2 <- rel_order(rel, list(expr_reference("hp")))
}
