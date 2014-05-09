context("The very basics")

test_that("Data types are as expected", {
    expect_equal(levels(letters), NULL)
    expect_equal(as.vector(unclass(factor(letters))), 1:26)
    expect_equal(levels(factor(rev(letters))), letters)
})
