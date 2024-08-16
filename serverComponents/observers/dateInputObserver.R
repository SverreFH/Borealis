source("helperMethods/createParamListForExp.R")
source("serverComponents/observerComponents/dateInputComponents/axisSidebarEnabler.R")
source("serverComponents/observerComponents/dateInputComponents/paramFieldEnabler.R")
source("serverComponents/observerComponents/dateInputComponents/dynamicParamaterEntries.R")

#Observs userinputs in the date selection field
#
#input:                 The systems input variable, allows accessing of input fields in the user interface
#output:                The systems output variable, allows accessing the systems outputs in the user interface
#selectedParams:        A list of all currently selectedParams
#fileList:              A list containing all filenames
#paramsWithObservers:   A list of all paramaters that currently have observers
dateInputObserverServer <- function(input, output, session, selectedParams, fileList, paramsWithObservers){
    observeEvent(input$Daterange, {
        shinyjs::show(selector = ".InteractivePlaceholder")
        shinyjs::hide(selector = ".Interactive")

        #A method for enabeling the axis sidebar
        axsiSidebarEnabler(input, output, session, selectedParams)

        #A method for enabeling the param button container
        paramFieldEnabler(input, output, session)

        params <- CreateParamListForExp(input$Experiments, input$Daterange, fileList)

        #A method for dynamically creating a button for each possible paramater
        dynamicParamaterEntries(input, output, session, params, selectedParams, paramsWithObservers)

    }) 

}