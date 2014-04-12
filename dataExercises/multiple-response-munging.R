indicators <- letters
makeResponse<- function(){
    factor(sample(1:26, 1000, replace=TRUE),
           levels=1:26, labels=indicators)
}
inputData <- data.frame(V1 = makeResponse(),
                        
                        V2 = makeResponse())
oldFunction <- function(inputData){
    out <- as.data.frame(matrix(0, nrow(inputData),
                                length(unique(indicators))))
    names(out) <- paste0("V1",letters)
    for (i in 1:nrow(out)){
        for (j in 1:length(unique(indicators))) {
            colname=paste('V1',inputData[i,j],sep='')
            out[i,colname] <- TRUE
        }
    }
    return(out)
}

newFunction <- function(inputData){
    Ind1 <- model.matrix(~V1 -1 ,data=inputData)
    Ind2 <- model.matrix(~V2 -1 ,data=inputData)
    as.data.frame(Ind1 | Ind2)
}

system.time(oldResult <- oldFunction(inputData))
system.time(newResult <- newFunction(inputData))
dim(oldResult)
dim(newResult)
oldResult <- oldResult[,-27] # ??
all(oldResult == newResult)
max(rowSums(newResult)) == 2

inputData <- as.data.frame(lapply(1:16, makeResponse))
