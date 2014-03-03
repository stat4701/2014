\name{ensureDate}
\alias{ensureDate}
\alias{ensureDate,Date-method}
\alias{ensureDate,character-method}
\alias{ensureDate,data.frame-method}
\alias{ensureDate,factor-method}
\alias{ensureDate,list-method}
\alias{ensureDate,numeric-method}
\title{Ensure that x is a Date}
\arguments{
  \item{x}{Date, fac, chr, num, data.frame, or list that
  might be or contain something that should be a Date}

  \item{origin}{for Dates that may have lost their
  attributes, and coerced to integer, the origin for
  reasserting their Date-ness. default=1970-01-01}

  \item{dates}{for data.frame method, columns of \code{x}
  that should themselves be ensureDates}
}
\value{
  x encoded as a Date \emph{unless all of x is numbers less
  than 1000,} for datamart numeric survey coding.
}
\description{
  Ensure that x is a Date
}

