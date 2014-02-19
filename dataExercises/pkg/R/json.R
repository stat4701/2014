##' Read a json file using RJSONIO
##'
##'
##' @param string interpreted as a string or a file path
##' @return a data.frame, hopefully
##' @importFrom RJSONIO fromJSON
##' @export
readJSONFile <- function(file) {
    out <- RJSONIO::fromJSON(file)
    ## result is a list of lists
    print(str(out, max=1))
    print(str(out[[1]]))
    return(as.data.frame(out))
}
