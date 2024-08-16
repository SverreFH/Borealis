source("serverComponents/observerComponents/applyComponents/getPLevel.R")
source("serverComponents/observerComponents/applyComponents/getMemberHighlights.R")
source("helperMethods/rePlotter.R")

#Observs user inputs to the interactive apply button
#
#input:                         The systems input variable, allows accessing of input fields in the user interface
#output:                        The systems output variable, allows accessing the systems outputs in the user interface
#colours:                       A list of colours
#shortNames                     A list of nicknames
#plots:                         A list of plots
#pValues:                       A mapping of paramaters and their associated p values
#selecteParams:                 A list of all currently selected paramaters
#plotDataFrame.                 A mapping of paramaters and their associated dataframelists
#HighlightedMembersForParam:    A mapping of paramaters and their currently highlighted members
applyObserverServer <- function(input, output, session, colours, shortNames, plots, pValues, selectedParams, plotDataFrame, HighlightedMembersForParam){
    observeEvent( input$applyBtn, {
        

        pLevel <- as.integer(getPLevel(input))
        print(pLevel)
        MemberHighlights <- getMemberHighlights(input)
        print(MemberHighlights)

        score <- input$score
        param <- input$dynamicTabs
        experiments <- unlist(strsplit(input$Experiments, " "))
        currentDataFrames <- plotDataFrame()

        currentHighlightedMembers <- HighlightedMembersForParam()
        currentHighlightedMembers[[param]] <- input[[paste0("HighlightedMembers", param)]]
        HighlightedMembersForParam(currentHighlightedMembers)

        print("Right before plotter")

        rePlotter(score, colours, experiments, shortNames, param, plots, pValues, pLevel, selectedParams, input, currentDataFrames[[param]])

        print("Right after plotter")

        plot_list <- plots()
        params <- selectedParams()
        index <- which(params == param)

        output[[paste0("plot", index)]] <- renderPlot({
            plot_list[[index]] 
        })
    })
}