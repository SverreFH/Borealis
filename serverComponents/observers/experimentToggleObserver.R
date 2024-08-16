source("helperMethods/rePlotter.R")

experimentToggleObserverServer <- function(input, output, session, plotDataFrame, colour, shortNames, plots, pValues, selectedParams, directory){
    #observe({
    #    req(input$dynamicTabs)
    #    score <- input$score
    #    param <- input$dynamicTabs
    #    experiments <- unlist(strsplit(input$Experiments, " "))
    #    lev <- input$Plevel
    #    currentDataFrames <- plotDataFrame()
    #    activeExperiments <- unique(currentDataFrames[[param]][[1]]$fcst_model)
    #    # Get all toggle input IDs
    #    toggle_ids <- paste0("toggle", activeExperiments)
    #    
    #    # Observe changes in any toggle checkbox
    #    observeEvent({
    #        sapply(toggle_ids, function(id) input[[id]])
    #    }, {
    #        # Print out the state of all toggle checkboxes
    #        toggles_status <- sapply(toggle_ids, function(id) {
    #            paste(id, ":", ifelse(input[[id]], "Checked", "Unchecked"))
    #        })
    #        
    #        cat("Current toggles status:\n", paste(toggles_status, collapse = "\n"), "\n")
    #        rePlotter(score, colour, experiments, shortNames, param, plots, pValues, lev, selectedParams, input, plotDataFrame)
    #    })
    #})


    observeEvent(input$toggledExperiments, {
        score <- input$score
        param <- input$dynamicTabs
        experiments <- unlist(strsplit(input$Experiments, " "))
        lev <- input$Plevel
        currentDataFrames <- plotDataFrame()
        activeExperiments <- unique(currentDataFrames[[param]][[1]]$fcst_model)
        currentPlots <- plots()
        dataframe <- currentDataFrames[[param]]
        dataframe[[1]] <- subset(dataframe[[1]], fcst_model!= input$toggledExperiments[[1]])

        print(subset(dataframe[[1]], fcst_model!= input$toggledExperiments[[1]]))

        experiments <- Filter(function(x) x != input$toggledExperiments[[1]], experiments)

        currentDataFrames[[param]] <- dataframe

        #rePlotter(score, colour, experiments, shortNames, param, plots, pValues, lev, selectedParams, input, currentDataFrames[[param]])
        Plotter(input$Daterange, score, colour, experiments, shortNames, param, plots, directory, pValues, 850, selectedParams, input, plotDataFrame)

        print("Toggle observer triggering")
        print(currentPlots[[1]])
                print(input$toggledExperiments)

    })
}