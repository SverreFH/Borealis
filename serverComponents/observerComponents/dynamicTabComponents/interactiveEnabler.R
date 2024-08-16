#Enables the interactive section of the screen when a tab is selected
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface         
interactiveEnabler <- function(input, output, session){
    req(input$dynamicTabs)
    shinyjs::hide(selector = ".InteractivePlaceholder")
    shinyjs::show(selector = ".Interactive")
}