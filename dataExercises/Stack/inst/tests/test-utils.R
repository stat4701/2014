context("utils")

v1 <- c("r", "s", "t", "l", "n", "e")
v2 <- letters[1:5]
v3 <- "z"

test_that("vectorIntegrate() behaves", {
    expect_identical(sort(unique(c(v1, v2))), sort(vectorIntegrate(v1, v2)))
    expect_identical(sort(unique(c(v1, v3))), sort(vectorIntegrate(v1, v3)))
})
