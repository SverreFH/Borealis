#A general observer for displaying and hiding ui elements
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#selectedParams:    A list of all currently selected paramaters
plotBtnEnabler <- function(input, output, session, selectedParams){
    observe({
        req(input$Daterange)
        if (length(selectedParams()) == 0) {
            shinyjs::disable("plot")
            shinyjs::hide(selector = ".axisPanel")
            shinyjs::show(selector = ".PlaceholderAxis")
        } else {
            shinyjs::enable("plot")
            shinyjs::show(selector = ".axisPanel")
            shinyjs::hide(selector = ".PlaceholderAxis")
        }
    })     
}