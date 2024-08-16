#Enables the param btn container when a valid date has been entered in the date field
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
paramFieldEnabler <- function(input, output, session){
    req(input$Daterange)
    shinyjs::hide(selector = ".PlaceholderParams")
    shinyjs::show(selector = ".button-ui-container")
}