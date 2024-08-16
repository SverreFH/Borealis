#Dynamically creates a button for each possible paramater for the given experiment and date
#when a observers is created for a paramater it i added to the list of paramsWithObservers, ensuring that
#a paramater will never have more that one active observer at a time.
#
#input:                 The systems input variable, allows accessing of input fields in the user interface
#output:                The systems output variable, allows accessing the systems outputs in the user interface
#params:                A list of all possible params
#selectedParams:        A list of all the currently selected paramaters
#paramsWithObservers:   A list of all paramaters with observers
dynamicParamaterEntries <- function(input, output, session, params, selectedParams, paramsWithObservers){
    req(input$Daterange)
    selectedParams(list())

    output$paramBtnUi <- renderUI({
        do.call(tagList, lapply(params, function(element){
            actionButton(inputId = paste0("button_", element),
            label = element,
            class = "ToggleBtn untoggledBtn")
        }))
    })

    paramsWithoutObservers <- setdiff(params, paramsWithObservers())
    paramsWithObservers(union(paramsWithObservers(), paramsWithoutObservers))

    lapply(paramsWithoutObservers, function(element) {
        observeEvent(input[[paste0("button_", element)]], {
            currentParams <- selectedParams()

            if(element %in% currentParams){
                currentParams <- setdiff(currentParams, element)
                removeClass(selector = paste0("#button_", element), class = "toggledBtn")
                addClass(selector = paste0("#button_", element), class = "untoggledBtn")
                shinyjs::hide(selector = paste0(".AxisEntry", element))
            } else {
                currentParams <- append(currentParams, element)
                removeClass(selector = paste0("#button_", element), class = "untoggledBtn")
                addClass(selector = paste0("#button_", element), class = "toggledBtn")
                shinyjs::show(selector = paste0(".AxisEntry", element))
            }
            selectedParams(currentParams)
            print(selectedParams)
        })
    })
}