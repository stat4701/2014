\name{Stack}
\alias{Stack}
\title{Stack
Combine data frames with column names that do not completely intersect}
\usage{
  Stack(df1, df2, return.data.frame = TRUE,
    dates = c("wave", "date"), origin = "1970-01-01",
    mixed.chr.factor = c("factor", "character"),
    verbose = FALSE)
}
\arguments{
  \item{df1}{a \code{data.frame} or a list}

  \item{df2}{a \code{data.frame} or a list}

  \item{return.data.frame}{defaults to TRUE and uses
  \code{\link[plyr]{quickdf}}; regular data.frame checks
  are not done.}

  \item{dates}{character names of columns that are or
  should be class \code{\link[base]{Date}}. These columns
  will be coerced to Date, handling the odd case where they
  are quoted chr days-since-origin.}

  \item{origin}{Origin for dates that are chr like
  \code{"15218"}, which ought to be 2011-09-01. This is not
  uncommon for dates coming from SPSS.}

  \item{mixed.chr.factor}{when an element is mixed
  factor/character in \code{df1} and \code{df2}, what
  should the result type be? Default="factor".}

  \item{verbose}{print extra information along the way
  about each column.}
}
\value{
  a list of data vectors suitable for coercion to a
  \code{data.frame}. Because \code{\link{as.data.frame}} is
  extremely costly and memory-intensive, and Stacking often
  involves many such column-wise combinations, avoid this
  by returning a list.
}
\description{
  Stack Combine data frames with column names that do not
  completely intersect
}
\examples{
testdf1 <- data.frame(both.int=1:4,
                      expand.factor=c("blue", "yellow"),
                      mixed.fac.int=factor(letters[1:4]),
                      date=as.Date("1983-11-22"),
                      df1only=rep(1:2, each=2),
                      mixed.fac.chr=I(c("a","b","NA",NA)))
testdf2 <- data.frame(both.int=5:24,
                      expand.factor=factor(rep(c(1:4, NA), 4)),
                      mixed.fac.int=1:4,
                      date=as.Date("1981-09-24"),
                      df2only=factor(c("c", "d")),
                      mixed.fac.chr=c("a","b",NA,"c"))

levels(testdf2$mixed.fac.chr) <- letters #overleveled
## put levels in a different order than sort(levels) would do, but
## don't make it an ordered factor. Result needs to be ordered
## to preserve this.
levels(testdf2$expand.factor) <- c("green", "blue", "red", "yellow")
Stack(testdf1, testdf2)
Stack(testdf2, testdf1)
}

