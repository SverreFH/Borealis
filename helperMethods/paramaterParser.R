### ParamaterParser ###
# Gets the paramater from a original file name
# 
# exp:      The filename to get the paramater from
paramaterParser <- function(exp){
    pattern <- "\\.harp\\.([^\\.]*)\\.harp"

    matches <- regmatches(exp, gregexpr(pattern, exp))

    if (length(matches[[1]]) > 0) {
        return(sub("\\.harp\\.([^\\.]*)\\.harp.*", "\\1", matches[[1]][1]))
    } else {
        return(NA)
    }
}