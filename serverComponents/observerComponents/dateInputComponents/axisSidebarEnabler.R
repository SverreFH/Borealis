#Enables the axis sidebar if the selectedParams list contains a minimum of one paramater.
#Disables the axis sidebar if there are no paramaters in the selecetedParams list
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#selectedParams:    A list of all currently selected paramaters
axsiSidebarEnabler <- function(input, output, session, selectedParams){
    req(input$Daterange)
    if(length(selectedParams()) == 0){
        shinyjs::show(selector = ".PlaceholderAxis")
    } else {
        shinyjs::hide(selector = ".PlaceholderAxis")
    }
}