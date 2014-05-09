\name{.preparedf}
\alias{.preparedf}
\title{Prepare a data.frame for as.ffdf to not break}
\usage{
  .preparedf(df)
}
\arguments{
  \item{df}{a data.frame or a list}
}
\value{
  \code{df} ready for \code{\link[ff]{as.ffdf}}
}
\description{
  Presently only converts char to factor. Any other
  cleaning of things?
}

