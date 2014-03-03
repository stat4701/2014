##' Munge some 'raw' csv into a suitable R data structure
##'
##' \code{read.csv} and \code{factor} can have some annoying
##' defaults, that can easily lead to corruption of data.
##'
##' I've prepared examples from a toy dataset in the base
##' distribution of R that are drawn from my experience
##' of munging -- reading, recoding, verifying -- actual data
##' \dQuote{in the wild}.
##'
##' Writing a function and a test is also meant to
##' demonstrate good practices of replicable research
##' and test-driven development.
##'
##' Here is a codebook for the example dataset:
##'
##' Admit: 0 = Rejected, 1 = Admitted
##' Gender: 1 = Male, 2 = Female
##' Dept: 1 = Dept A, 2 = Dept B, 3 = Dept C,
##' 4 = Dept D, 5 = Dept E, 6 = Dept F
##'
##' @param file filename or connection
##' @return data.frame, target is in example
##' @examples
##' ##' ## when you `lapply(result, levels)`,
##' ## you should see:
##' structure(list(Admit = c("Admitted", "Rejected"),
##'                Gender = c("Male", "Female"),
##'                Dept = c("A", "B", "C", "D", "E", "F")),
##'                .Names = c("Admit", "Gender", "Dept"))
##' @export
loadAndParseMixedCSV <- function(file){
    out <- read.csv(file)
    out <- within(out, {
        Dept <- factor(Dept, labels=LETTERS[1:6])
        Gender <- factor(Gender, levels=c("Male", "Female"))
        Admit <- factor(Admit, labels=c("Admitted", "Rejected")) # alpha  is ok
    })
    return(out)
}

