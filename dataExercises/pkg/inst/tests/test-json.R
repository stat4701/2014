context("Reading a string that happens to be json into a data.frame")

## Setup
verboseFile <- system.file("slate-json-verbose.json", package="dataExercises")
named <- readJSONFile(verboseFile)
conciseFile <- system.file("slate-json-concise.json", package="dataExercises")
#unnamed <- readJSONFile(conciseFile)


test_that("type is data frame, correct dims, correct names.", {
verboseFile <- system.file("slate-json-verbose.json", package="dataExercises")
named <- readJSONFile(verboseFile)
#expect_equal(class(readJSONFile(conciseFile)), "data.frame")
expect_equal(class(named), "data.frame")
expect_equal(dim(named), c(25, 112))
})

test_that("names are correct", {
verboseFile <- system.file("slate-json-verbose.json", package="dataExercises")
named <- readJSONFile(verboseFile)
correctNames <- c("Country", "CID",
"Gold2014", "Silver2014", "Bronze2014", "Total2014", "Rank2014",
"Gold2010", "Silver2010", "Bronze2010", "Total2010", "Rank2010",
"Gold2006", "Silver2006", "Bronze2006", "Total2006", "Rank2006",
"Gold2002", "Silver2002", "Bronze2002", "Total2002", "Rank2002",
"Gold1998", "Silver1998", "Bronze1998", "Total1998", "Rank1998",
"Gold1994", "Silver1994", "Bronze1994", "Total1994", "Rank1994",
"Gold1992", "Silver1992", "Bronze1992", "Total1992", "Rank1992",
"Gold1988", "Silver1988", "Bronze1988", "Total1988", "Rank1988",
"Gold1984", "Silver1984", "Bronze1984", "Total1984", "Rank1984",
"Gold1980", "Silver1980", "Bronze1980", "Total1980", "Rank1980",
"Gold1976", "Silver1976", "Bronze1976", "Total1976", "Rank1976",
"Gold1972", "Silver1972", "Bronze1972", "Total1972", "Rank1972",
"Gold1968", "Silver1968", "Bronze1968", "Total1968", "Rank1968",
"Gold1964", "Silver1964", "Bronze1964", "Total1964", "Rank1964",
"Gold1960", "Silver1960", "Bronze1960", "Total1960", "Rank1960",
"Gold1956", "Silver1956", "Bronze1956", "Total1956", "Rank1956",
"Gold1952", "Silver1952", "Bronze1952", "Total1952", "Rank1952",
"Gold1948", "Silver1948", "Bronze1948", "Total1948", "Rank1948",
"Gold1936", "Silver1936", "Bronze1936", "Total1936", "Rank1936",
"Gold1932", "Silver1932", "Bronze1932", "Total1932", "Rank1932",
"Gold1928", "Silver1928", "Bronze1928", "Total1928", "Rank1928",
"Gold1924", "Silver1924", "Bronze1924", "Total1924", "Rank1924")
expect_equal(correctNames, names(named))

})
