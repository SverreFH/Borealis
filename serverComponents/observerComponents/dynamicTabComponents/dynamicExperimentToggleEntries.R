dynamicExperimentToggleEntries <- function(input, output, session, plots, selectedParams, plotDataFrame, expTogglesWithObservers, colour, shortNames, pValues){
    #experiments <- unlist(strsplit(input$Experiments, " "))
        param <- input$dynamicTabs
        plot_list <- plots()
        params <- selectedParams()
        index <- which(params == param)
        plot <- plot_list[[index]]
        plotExps <- unique(plot$data$fcst_model)
    #
        currentDataFrames <- plotDataFrame()
        activeExperiments <- unique(currentDataFrames[[param]][[1]]$fcst_model)
    #
    #    print(activeExperiments)
    #
    #    output$ExperimentToggles <- renderUI({
    #        do.call(tagList, lapply(activeExperiments, function(exp) {
    #            div( class = "expToggleEntry",
    #                if(exp %in% plotExps){
    #                    checkboxInput(paste0("toggle", exp), exp, value = TRUE)
    #                } else {
    #                    checkboxInput(paste0("toggle", exp), exp, value = FALSE)
    #                }
    #            )
    #        }))
    #    })

    output$ExperimentToggles <- renderUI({
        selectInput("toggledExperiments",
            label = "Choose experiments to toggle:",
            choices = c(activeExperiments),
            selected = c(plotExps),
            multiple = TRUE
        )
    })

}