##' Munge some 'raw' csv into a suitable R data structure
##'
##' \code{read.csv} and \code{factor} can have some annoying
##' defaults, that can easily lead to corruption of data.
##'
##' Here is a codebook for the example dataset:
##'
##' Admit:
##'   0 = Rejected
##'   1 = Admitted
##' Gender:
##'   1 = Male
##'   2 = Female
##' Dept:
##'   1 = Dept A
##'   2 = Dept B
##'   3 = Dept C
##'   4 = Dept D
##'   5 = Dept E
##'   6 = Dept F
##'
##' @param file filename or connection
##' @return data.frame, target is in example
##' @examples
##' ## when you `lapply(result, levels)`,
##' ## you should see:
##' structure(list(Admit = c("Admitted", "Rejected"),
##'                Gender = c("Male", "Female"),
##'                Dept = c("A", "B", "C", "D", "E", "F")),
##'                .Names = c("Admit", "Gender", "Dept"))
##' @export
loadAndParseIntegerCSV <- function(file){
    ## You may want to change options to read.csv
    out <- read.csv(file)

    ## 'within' evaluates within an environment,
    ## and returns the mutated environment.
    out <- within(out, {
        Dept <- factor(LETTERS[Dept])
    })
    return(out)
}



