# can construct expressions

    Code
      expr_reference("column")
    Output
      list(name = "column") |>
        structure(class = c("relational_expr_reference", "relational_expr"))
    Code
      expr_constant(42)
    Output
      list(val = 42) |>
        structure(class = c("relational_expr_constant", "relational_expr"))
    Code
      expr_function("+", list(expr_reference("column"), expr_constant(42)))
    Output
      list(
        name = "+",
        args = list(
          list(name = "column") |>
            structure(class = c("relational_expr_reference", "relational_expr")),
          list(val = 42) |>
            structure(class = c("relational_expr_constant", "relational_expr"))
        )
      ) |>
        structure(class = c("relational_expr_function", "relational_expr"))
    Code
      expr_alias(expr_constant(42), "fortytwo")
    Output
      list(val = 42, alias = "fortytwo") |>
        structure(class = "relational_expr")

