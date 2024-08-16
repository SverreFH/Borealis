source("helperMethods/paramaterParser.R")

### CreateParamListForExp ###
# Creates a list of all possible paramaters for the given experiment at the given date
#
# Exp:              The given experiment to create a paramater list for
# Date:             The given date to create a paramater list for
# allExperiments:   A list of all possible experiments
CreateParamListForExp <- function(Exp, Date, allExperiments){
    ExpParamList <- character(0)
    files <- allExperiments()
    patterns <- strsplit(Exp, " ")[[1]]
    patterns <- c(patterns, Date)
    for(file in files) {
        if(all(sapply(patterns, function(pat) grepl(pat, file)))){
            paramaterString <- paramaterParser(file)
            if(!(paramaterString %in% ExpParamList)){
                ExpParamList <- c(ExpParamList, paramaterString)
            }
        }
    }
    return(ExpParamList)
}