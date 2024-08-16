source("helperMethods/rePlotter.R")

#Observes user Plevel inputs
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#plots:             A list of plots
#selectedParams:    A list of selected paramaters
#pValues:           A list of experiments and their associated p values
#directory:         A reactive variable holding the directory path to experiment files
#colours:           A list of colours for experiments
#shortNames:        A list of shortNames for experiments
#system_update:     A boolean telling the method if its being triggered by a user or the system
pLevelObserverServer <- function(input, output, session, plots, selectedParams, pValues, directory, colours, shortNames, system_update, plotDataFrame){
    observeEvent(input$Plevel, {
        if(!system_update()){
            req(input$Daterange)
            score <- input$score
            param <- input$dynamicTabs
            experiments <- unlist(strsplit(input$Experiments, " "))
            lev <- input$Plevel

            currentPValues <- pValues()
            currentDataFrames <- plotDataFrame()
            print(currentPValues)
            print("Before p value check in PInteractive")
            if(currentPValues[[param]] != lev){
                rePlotter(score, colours, experiments, shortNames, param, plots, pValues, lev, selectedParams, input, currentDataFrames[[param]])

                plot_list <- plots()

                params <- selectedParams()
                index <- which(params == param)

                output[[paste0("plot", index)]] <- renderPlot({
                    plot_list[[index]] 
                })
            } else {
                print("Pleves equal")
            }
        } else {
            system_update(FALSE)
        }
        
    })
}