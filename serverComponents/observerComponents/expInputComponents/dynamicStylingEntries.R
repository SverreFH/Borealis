#Creates dynamic styling cards for each experiments in the selected experiments
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
dynamicStylingEntries <- function(input, output, session){
    req(input$Experiments)
    experiments <- unlist(strsplit(input$Experiments, " "))
    output$dynamicEntries <- renderUI({
        do.call(tagList, lapply(experiments, function(element) {
            div(class = "Entry",
                verbatimTextOutput(paste0("OrigExp_", element), placeholder = TRUE),
                textInput(paste0("ShortName_", element), label = NULL, placeholder = "Enter nickname here", width = "100%"),
                colourInput(paste0("color_", element), label = NULL, value = NULL),
            )
        }))
    })

    lapply(experiments, function(element) {
        output[[paste0("OrigExp_", element)]] <- renderText({
            paste(element)
        })
    })
}