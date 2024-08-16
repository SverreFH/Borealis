source("serverComponents/observerComponents/dynamicTabComponents/interactiveEnabler.R")
source("serverComponents/observerComponents/dynamicTabComponents/dynamicPLevelEntry.R")
source("serverComponents/observerComponents/dynamicTabComponents/dynamicExperimentToggleEntries.R")
source("serverComponents/observerComponents/dynamicTabComponents/dynamicMemberHighlightEntry.R")

#Observes user dynamicTabs inputs.
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#pValues:           A list of experiments and their p values
#system_update:     A boolean telling the method if it is being triggered by a user or the system
dynamicTabsObserverServer <- function(input, output, session, pValues, system_update, plots, selectedParams, plotDataFrame, expTogglesWithObservers, colour, shortNames, HighlightedMembersForParam){
    observeEvent(input$dynamicTabs, {
        interactiveEnabler(input, output, session)

        DynamicPlevelEntry(input, output, session, pValues, system_update)

        #dynamicExperimentToggleEntries(input, output, session, plots, selectedParams, plotDataFrame, expTogglesWithObservers, colour, shortNames, pValues)

        dynamicMemberHighlightEntry(input, output, plots, selectedParams, plotDataFrame, HighlightedMembersForParam)
    })
}