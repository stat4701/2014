context("Working with microdata and R data structures")

test_that("Data is encoded in the correct structures",{
    codebookLevels <-
        structure(list(Admit = c("Admitted", "Rejected"),
                       Gender = c("Male", "Female"),
                       Dept = c("A", "B", "C", "D", "E", "F")),
                  .Names = c("Admit", "Gender", "Dept"))
    file <- system.file('UCBAdmissions-microdata.csv', package='dataExercises')
    systemUnderTest <- loadAndParseIntegerCSV(file)
    expect_equal(lapply(systemUnderTest, levels), codebookLevels)

    file <- system.file('UCBAdmissions-microdata-text.csv', package='dataExercises')
    sut <- loadAndParseMixedCSV(file)
    expect_equal(lapply(sut, levels), codebookLevels)
})

test_that("Make a data.frame suitable for plotting 'Percentage of Women Admitted by Dept'", {
    file <- system.file('UCBAdmissions-microdata.csv', package='dataExercises')
    sut <- loadAndParseIntegerCSV(file)
    sut <- makePlottableTable(sut)
    tab <-
        structure(list(
           Gender = structure(c(1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L),
           .Label = c("Male", "Female"), class = "factor"),
           Dept = structure(c(1L, 1L, 2L, 2L, 3L, 3L, 4L, 4L, 5L, 5L, 6L, 6L),
           .Label = c("A", "B", "C", "D", "E", "F"), class = "factor"),
           Proportion = c(0.88, 0.12, 0.96, 0.04, 0.35, 0.65, 0.53, 0.47, 0.33, 0.67, 0.52, 0.48)),
           .Names = c("Gender", "Dept", "Proportion"
           ), row.names = c(NA, -12L), class = "data.frame")
    expect_identical(sut, tab)
})
