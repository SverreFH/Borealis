source("helperMethods/createDateListForExp.R")
source("serverComponents/observerComponents/expInputComponents/dateFieldEnabler.R")
source("serverComponents/observerComponents/expInputComponents/styleTabEnabler.R")
source("serverComponents/observerComponents/expInputComponents/dynamicStylingEntries.R")

#Observes Experiment user iputs
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#fileList:          A list of file names
expInputObserverServer <- function(input, output, session, fileList){
    observeEvent(input$Experiments, {

        shinyjs::show(selector = ".PlaceholderParams")
        shinyjs::hide(selector = ".button-ui-container")
        shinyjs::disable("plot")
        shinyjs::show(selector = ".InteractivePlaceholder")
        shinyjs::hide(selector = ".Interactive")

        #A method for handeling the enabeling of the date input
        dateFieldEnabler(input, output, session, fileList)

        #A method for handeling the enabeling of the styling sidebar tab
        styleTabEnabler(input, output, session)

        #A method for dynamically creating styling entires for each experiment in the styling tab
        dynamicStylingEntries(input, output, session)
    })
}