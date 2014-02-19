\name{loadAndParseIntegerCSV}
\alias{loadAndParseIntegerCSV}
\title{Munge some 'raw' csv into a suitable R data structure}
\usage{
loadAndParseIntegerCSV(file)
}
\arguments{
  \item{file}{filename or connection}
}
\value{
data.frame, target is in example
}
\description{
\code{read.csv} and \code{factor} can have some annoying
defaults, that can easily lead to corruption of data.
}
\details{
Here is a codebook for the example dataset:

Admit: 0 = Rejected 1 = Admitted Gender: 1 = Male 2 =
Female Dept: 1 = Dept A 2 = Dept B 3 = Dept C 4 = Dept D 5
= Dept E 6 = Dept F
}
\examples{
## when you `lapply(result, levels)`,
## you should see:
structure(list(Admit = c("Admitted", "Rejected"),
               Gender = c("Male", "Female"),
               Dept = c("A", "B", "C", "D", "E", "F")),
               .Names = c("Admit", "Gender", "Dept"))
}

