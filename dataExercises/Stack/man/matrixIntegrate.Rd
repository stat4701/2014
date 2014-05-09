\name{matrixIntegrate}
\alias{matrixIntegrate}
\title{Integrate matrices based on their dim names}
\usage{
  matrixIntegrate(x, y, x.names = dimnames(x),
    y.names = dimnames(y), joinFunction = pasteExp)
}
\arguments{
  \item{x}{matrix}

  \item{y}{matrix}

  \item{x.names}{a list of length 2}

  \item{y.names}{a list of length 2}

  \item{joinFunction}{function used to join things}
}
\value{
  union of x and y, with \emph{write something about
  expected return ordering}.
}
\description{
  Integrate matrices based on their dim names
}

