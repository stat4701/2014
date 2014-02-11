\name{makePlottableTable}
\alias{makePlottableTable}
\title{Make a plottable data.frame from microdata}
\usage{
makePlottableTable(data)
}
\arguments{
  \item{data}{person-level data.frame with factor
  demographic indicators}
}
\value{
data.frame suitable for plottingf
}
\description{
Continuing with toy example using the sample data, a
micro-level version of \code{data(UCBAdmissions)},
construct a data.frame with the following columns: Gender:
factor with levels Male, Female Dept: factor A-F
Proportion: Proportion of admitted students, rounded to two
decimal places.
}
\details{
The test expectation and example show the target.
}
\examples{
## Result target is this:
 structure(list(
Gender = structure(c(1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L, 1L, 2L),
.Label = c("Male", "Female"), class = "factor"),
Dept = structure(c(1L, 1L, 2L, 2L, 3L, 3L, 4L, 4L, 5L, 5L, 6L, 6L),
.Label = c("A", "B", "C", "D", "E", "F"), class = "factor"),
Proportion = c(0.88, 0.12, 0.96, 0.04, 0.35, 0.65, 0.53, 0.47, 0.33, 0.67, 0.52, 0.48)),
.Names = c("Gender", "Dept", "Proportion"
), row.names = c(NA, -12L), class = "data.frame")
}

