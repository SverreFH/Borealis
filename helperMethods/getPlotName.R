## GetPlotName ###
#Gets the plotname from the given param's axis card if one is set. If plot names is not set
#then plotname is set euqal to "auto"
#
#input:         The systems input variable, allows accessing of input fields in the user interface
#param:         The paramater to get the plotName for
GetPlotName <- function(input, param){
    PlotName <- input[[paste0("PlotName_", param)]]
    if (is.null(PlotName) || PlotName == "") {
        PlotName <- "auto"
    }
    return(PlotName)
}