\name{.upgradevmode}
\alias{.upgradevmode}
\title{Upgrade vmode of ff column while stacking}
\usage{
  .upgradevmode(x, y, use.na = TRUE)
}
\arguments{
  \item{x}{ff}

  \item{y}{ff or vector}

  \item{use.na}{require a vmode that supports NAs?
  default=TRUE}
}
\description{
  Similar to aux function \code{coerce_to_highest_vmode} in
  ffbase, except this does range/unique values checking
  rather than simple type checking.
}

