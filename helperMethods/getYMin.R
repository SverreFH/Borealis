### GetYMin ###
#Gets the lower limit of the y-axis from the given paramater's axis card, if no 
#value is set the system automatically sets the value to NULL
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#param:         The paramater to get the lower y limit for
GetYMin <- function(input, param){
    yMin <- input[[paste0("YLower_", param)]]
    if (is.null(yMin) || yMin == "") {
        yMin <- NULL
    } else {
        yMin <- as.double(yMin)
    }
    return(yMin)
}