#Enables the styling tab when experiments are selected
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
styleTabEnabler <- function(input, output, session){
    req(input$Experiments)
    shinyjs::hide(selector = ".PlaceholderStyling")
    shinyjs::show(selector = ".StylingPanel")
}