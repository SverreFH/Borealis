source("helperMethods/dateParser.R")

### CreateDateListForExp ###
# Creates a list of all possible dates for a given experiment
#
# Exp:              The experiment to create a list of dates for
# allExperiments:   A list of all possible experiments
CreateDateListForExp <- function(Exp, allExperiments){
    ExpDateList <- character(0)
    files <- allExperiments()
    patterns <- strsplit(Exp, " ")[[1]]
    for (file in files) {
            if(all(sapply(patterns, function(pat) grepl(pat, file)))){
                dateString <- dateParser(file)
                if(!(dateString %in% ExpDateList)){
                    ExpDateList <- c(ExpDateList, dateString)
                }
            }
        }
    return(ExpDateList)
}