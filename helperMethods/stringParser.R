### StringParser ###
#Parses a experiments long title into a shorter more readable one.
#
#originalString:        The orignal string to be shortend
stringParser <- function(originalString){
    intial_exp <- sub("^(.*\\.harp\\.){3}(.*?)\\.model\\..*$", "\\2", originalString)
    exp_parts <- regmatches(originalString, gregexpr("(?<=\\.model\\.).*?(?=\\.model\\.|\\.rds)", originalString, perl=TRUE))[[1]]

    exps <- c(intial_exp, exp_parts)

    return(exps)
}