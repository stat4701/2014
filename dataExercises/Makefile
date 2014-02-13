test:
	R CMD INSTALL pkg
	R --slave -e 'library(testthat); system.time(test_package("dataExercises", filter="${file}"))'

watch:
	R CMD INSTALL pkg
	R --slave -e 'library(testthat); auto_test("pkg/R/", "pkg/inst/tests/")'
