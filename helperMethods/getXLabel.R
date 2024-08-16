### GetXlabel ###
#Gets the x label for the given param from the param's axis card,
#if no x label is set the system automatically set the x label to "auto"
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#param:         The paramater to get the x-label for
GetXlabel <- function(input, param){
    xLabel <- input[[paste0("XAxis_", param)]]
    if (is.null(xLabel) || xLabel == "") {
        xLabel <- "auto"
    }
    return(xLabel)
}