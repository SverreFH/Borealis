#Enables the date field selection input when a experiment has been selected
#in the experiment selection input. Additionally creates the list of selectable dates
#based on the selected experiments
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#fileList:          Holds a list of file names
dateFieldEnabler <- function(input, output, session, fileList){
    req(input$Experiments)
    dates <- CreateDateListForExp(input$Experiments ,fileList)
    updateSelectInput(session, "Daterange",
    choices = c("Please select daterange" = "", setNames(dates, dates)))
    enable("Daterange")
}

