\name{compact}
\alias{.compact}
\alias{.compact.ff}
\alias{.compact.ffdf}
\alias{compact}
\alias{compact.ff}
\alias{compact.ffdf}
\title{Compact a ff vector or ffdf data frame}
\usage{
  .compact(x, use.na = TRUE, ...)

  .compact.ff(x, use.na = TRUE, ...)

  .compact.ffdf(x, use.na = TRUE, ...)
}
\arguments{
  \item{x}{\code{ff} or \code{ffdf} object}

  \item{use.na}{\code{logical} if TRUE the resulting ff
  vector can contain NA, otherwise this is not checked}

  \item{...}{other parameters, not actually passed but
  needed to muffle check.}
}
\value{
  compact cloned ff vector, or original if no compacting
  can be done
}
\description{
  Compact takes a ff vector and tries to use the smallest
  binary data type for this vector.
}

