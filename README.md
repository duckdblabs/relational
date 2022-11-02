
<!-- README.md is generated from README.Rmd. Please edit that file -->

# relational

<!-- badges: start -->
<!-- badges: end -->

The goal of relational is to represent expressions and provide a set of
generics for transformations of tables (relations).

## Installation

You can install the development version of relational like so:

``` r
devtools::install_github("duckdblabs/relational")
```

## Example

### Expressions

``` r
library(relational)

expr_function(
  "+", 
  list(
    expr_reference("column"),
    expr_constant(42, alias = "fortytwo")
  )
)
#> list(
#>   name = "+",
#>   args = list(
#>     list(name = "column", alias = NULL) |>
#>       structure(class = c("relational_expr_reference", "relational_expr")),
#>     list(val = 42, alias = "fortytwo") |>
#>       structure(class = c("relational_expr_constant", "relational_expr"))
#>   ),
#>   alias = NULL
#> ) |>
#>   structure(class = c("relational_expr_function", "relational_expr"))
```
