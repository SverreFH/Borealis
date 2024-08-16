### GetYMax ###
#Gets the upper limit of the y-axis from the given paramater's axis card, if no 
#value is set the system automatically sets the value to NULL
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#param:         The paramater to get the upper y limit for 
GetYMax <- function(input, param){
    yMax <- input[[paste0("YUpper_", param)]]
    if (is.null(yMax) || yMax == "") {
        yMax <- NULL
    } else {
        yMax <- as.integer(yMax)
    }
    return(yMax)
}