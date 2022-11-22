test_that("attribute copy works as expected", {
    df <- data.frame(a=1:10)
    attr(df, "asdf") <- 42

    df2 <- data.frame(b=1:20)
    attr(df2, "fdsa") <- 42

    old_names <- names(df2)
    old_rownames <- row.names(df2)

    .Call(relational:::copy_df_attribs, df, df2)

    # attrs from df2 disappear
    expect_null(attr(df2, "fdsa"))
    # attrs from df appear
    expect_equal(attr(df2, "asdf"), 42)

    # names and row.names are untouched
    expect_equal(names(df2), old_names)
    expect_equal(row.names(df2), old_rownames)
})
