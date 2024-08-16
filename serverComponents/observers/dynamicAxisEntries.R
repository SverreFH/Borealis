#Observes daterange user inputs
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#selectedParams:    A list of all currently selected paramaters
#AxisValues:        A lsit of all current AxisValues
#fileList:          a lsit of file names
#created_elements:  A list containing all created axis cards
dynamicAxisEntries <- function(input, output, session, selectedParams, AxisValues, fileList, created_elements){
    observe({
        req(input$Daterange)
        
        current_selected <- selectedParams()
        existing_elements <- created_elements()
        
        # Elements to be added
        new_elements <- setdiff(current_selected, existing_elements)
        
        # Elements to be removed
        removed_elements <- setdiff(existing_elements, current_selected)
        
        # Add new elements
        if (length(new_elements) > 0) {
            created_elements(c(existing_elements, new_elements))
            
            insertUI(
                selector = "#dynamicAxisEntries",
                where = "beforeEnd",
                ui = do.call(tagList, lapply(new_elements, function(element) {
                    div(class = paste0("AxisEntry", element),
                        verbatimTextOutput(paste0("Param_", element), placeholder = TRUE),
                        textInput(paste0("PlotName_", element), label = NULL, placeholder = "Enter plot name (optional)", width = "100%"),
                        div(class = "AxisNames",
                            textInput(paste0("XAxis_", element), label = NULL, placeholder = "Enter x-axis name (optional)", width = "90%"),
                            textInput(paste0("YAxis_", element), label = NULL, placeholder = "Enter y-axis name (optional)", width = "90%")
                        ),
                        div(class = "Ylimits",
                            textInput(paste0("YLower_", element), label = NULL, placeholder = "Enter lower y limit (optional)", width = "90%"),
                            textInput(paste0("YUpper_", element), label = NULL, placeholder = "Enter upper y limit (optional)", width = "90%")
                        )
                    )
                }))
            )
            
            lapply(new_elements, function(element) {
                output[[paste0("Param_", element)]] <- renderText({
                    paste(element)
                })
            })
        }
        
        # Remove elements that are no longer selected
        if (length(removed_elements) > 0) {
            created_elements(setdiff(existing_elements, removed_elements))
            
            lapply(removed_elements, function(element) {
                removeUI(selector = paste0(".AxisEntry", element))
        })
    }
    })
    
}