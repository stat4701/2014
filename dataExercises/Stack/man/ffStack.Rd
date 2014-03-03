\name{ffStack}
\alias{ffStack}
\alias{ffStack,ffdf,data.frame-method}
\alias{ffStack,ffdf,ffdf-method}
\alias{ffStack,ffdf,list-method}
\title{Merge a data.frame into an ffdf data.frame-alike}
\arguments{
  \item{ffdf}{an \code{\link[ff]{ffdf}}}

  \item{df}{a \code{\link[base]{data.frame}}}

  \item{verbose}{print extra information about columns as
  they stack}

  \item{...}{further arguments}
}
\value{
  An ffdf.
}
\description{
  For fast operations on large data frames, we want to turn
  them into ffdf. This is a special case of
  \code{\link{Stack}} where the first arugment is already
  an ffdf, and we are Stacking another data.frame into it,
  expanding factor levels as needed, and possibly enlarging
  vmodes of existing ff columns.
}

