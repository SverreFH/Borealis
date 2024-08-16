#Creates a selection field where the user can select which members to highlight. Selction input is only created if a 
#relevant score type has been used in the plot. 
#
#input:                         Allows access to the interfaces entry fields
#output:                        Allows access to the interfaces output field
#plots:                         A list of plots
#selectedParams:                A list over all currently selected paramaters
#plotDataFma:                   A mapping of paramaters and their associated dataframelists
#HighlightedMembersForParam:    A mapping between paramaters and their currently highlighted members
dynamicMemberHighlightEntry <- function(input, output, plots, selectedParams, plotDataFrame, HighlightedMembersForParam){
    param <- input$dynamicTabs
    plot_list <- plots()
    params <- selectedParams()
    index <- which(params == param)
    plot <- plot_list[[index]]

    currentHighlightedMembers <- HighlightedMembersForParam()
    
    currentDataFrames <- plotDataFrame()
    members <- unique(currentDataFrames[[param]][[length(currentDataFrames[[param]])]]$member)

    if(substr(input$score, 1, 4) == "det_"){
        output$MemberHighlight <- renderUI({
        selectInput(paste0("HighlightedMembers", param),
            label = "Highlighted Members:",
            choices = c(members),
            multiple = TRUE,
            selected = c(currentHighlightedMembers[[param]]),
            width = "90%"
            )
        })
    } else {
        output$MemberHighlight <- renderUI({
        tagList(
            p("")
        )
        })
    }


    
}