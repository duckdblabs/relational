test_that("promises work as expected", {

    producer <- function(x) {
        42L
    }
    is_promise <- function(x) .Call(relational:::is_promise, x)

    expect_true(is_promise(.Call(relational:::promise, producer)))
    expect_true(.Call(relational:::promise, producer) |> is_promise())

    p <- .Call(relational:::promise, producer)
    expect_false(is_promise(p))

})
