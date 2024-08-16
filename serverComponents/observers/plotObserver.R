source("helperMethods/plotter.R")
source("helperMethods/getPlotName.R")
source("helperMethods/getXLabel.R")
source("helperMethods/getYLabel.R")
source("helperMethods/getYMax.R")
source("helperMethods/getYMin.R")

#Observes plot user iputs
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#selectedParams:    A list of currently selected paramaters
#plots:             A lsit of plots
#fileList:          A list of filenames
#directory:         A reactive variable holding the path to the experiment locations
#pValues:           A list holding paramaters and their associated p levels
#colour:            A list of colours
#shortNames:        A list of nicknames
#system_update:     A boolean value telling the method wether its been triggered by a user or the system
plotObserverServer <- function(input, output, session, selectedParams, plots, fileList, directory, pValues, colour, shortNames, system_update, plotDataFrame, HighlightedMembersForParam){
    observeEvent(input$plot, {
        plots(list())
        HighlightedMembersForParam(list())

        shinyjs::disable(selector = ".mainPage")
    
        output$progress_ui <- renderUI({
            div(id = "progress", style = "width: 100%;")
        })
    
        progress <- shiny::Progress$new(session, min = 0, max = length(selectedParams()))
        on.exit({
            progress$close()
            shinyjs::enable(selector = ".mainPage")
            output$progress_ui <- renderUI({ NULL })
        })
        progress$set(message = 'Creating plots', value = 0)

        score <- input$score
        experiments <- unlist(strsplit(input$Experiments, " "))

        paramlist <- as.character(unlist(selectedParams()))

        for (param in as.character(unlist(paramlist))) {

            progress$inc(0, detail = paste("Processing", param))

            Plotter(input$Daterange, score, colour, experiments, shortNames, param, plots, directory, pValues, 850, selectedParams, input, plotDataFrame)

            progress$inc(1, detail = paste("Processing", param, "completed"))
        }

        plot_list <- plots()

        allParams <- CreateParamListForExp(input$Experiments, input$Daterange, fileList)

        lapply(seq_along(allParams), function(i){
            system_update(TRUE)
            removeTab(inputId="dynamicTabs", target = allParams[[i]])
        })
        
        shinyjs::delay(300, {
            params <- selectedParams()
            lapply(seq_along(params), function(i) {
                system_update(TRUE)
                tabName <- params[[i]]
                insertTab(inputId = "dynamicTabs",
                tabPanel(
                    id = paste0("tab", i),
                    title = tabName,
                    plotOutput(outputId = paste0("plot", i), width = "100%", height = "100%")
                ),
                select = FALSE)

            output[[paste0("plot", i)]] <- renderPlot({
            plot_list[[i]] 
            })
        })
    
        updateTabsetPanel(inputId = "dynamicTabs", selected = params[[1]])
        system_update(FALSE)
    })

            print("Plotter completes")
    })
}