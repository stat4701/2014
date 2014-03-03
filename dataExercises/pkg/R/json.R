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
    out <- do.call("rbind", out)
    return(as.data.frame(out))
}
