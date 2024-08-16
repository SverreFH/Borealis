source("helperMethods/stringParser.R")

### CreateUniqueExpList ###
#Takes a list of all experiments in the form of a vector
#then shortens the names and creates a list of unique experiments
#
#allExperiments:    A list of all possible experiments
CreateUniqueExpList <- function(allExperiments){
    uniqueExpList <- character(0)
    files <- allExperiments()
    if (!is.null(files)) {
        for (file in files) {
            processed_str <- paste(stringParser(file), collapse = " ")
            if (!(processed_str %in% uniqueExpList)) {
                uniqueExpList <- c(uniqueExpList, processed_str)
            }
        }
    }
    return(uniqueExpList)
}