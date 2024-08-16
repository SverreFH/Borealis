### GetYLabel ###
#Gets the y label for the given param from the param's axis card,
#if no y label is set the system automatically set the y label to "auto"
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#param:         The paramater to get the y-label for
GetYLabel <- function(input, param){
    yLabel <- input[[paste0("YAxis_", param)]]
    if (is.null(yLabel) || yLabel == "") {
        yLabel <- "auto"
    }
    return(yLabel)
}