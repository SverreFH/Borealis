source("helperMethods/getUserId.R")
source("serverComponents/observers/dirObserver.R")
source("serverComponents/observers/expInputObserver.R")
source("serverComponents/observers/dateInputObserver.R")
source("serverComponents/observers/plotBtnEnabler.R")
source("serverComponents/observers/dynamicAxisEntries.R")
source("serverComponents/observers/plotObserver.R")
source("serverComponents/observers/dynamicTabsObserver.R")
source("serverComponents/observers/pLevelObserver.R")
source("serverComponents/observers/saveObserver.R")
source("serverComponents/observers/experimentToggleObserver.R")
source("serverComponents/observers/applyObserver.R")

server <- function(input, output, session){

    #############################################
    #                Variables                  #
    #############################################

    #Creats a variable that holds the users id
    userId <- GetUserId()

    #By default disables the experiments input at the start of the program
    disable("Experiments")

    #By default disables the daterange input at the start of the program
    disable("Daterange")

    #Creates a variable called directory which holds the default starting directory
    #path for the directory selector
    directory <- reactiveValues()

    #Creates a fileList variable that holds the list of files in the 
    #selected directory
    fileList <- reactiveVal(NULL)

    #Creates a list that holds the colours for the given experiments in a plot
    colour <- reactiveValues(data = list())

    #Creates a lsit that holds the nicknames for the given experiments in a plot
    shortNames <- reactiveValues(data = list())

    AxisValues <- reactiveValues()

    #Holds the p value of each selected paramater for the given experiments
    pValues <- reactiveVal(list())

    #Creates a list for holding all selected paramaters
    selectedParams <- reactiveVal(list())

    #Creates a lsit to hold all created plots
    plots <- reactiveVal(list())

    #A lsit for holding each paramater that has an observer, nessecary to prevent the creation of
    #multiple observers for a single paramater
    paramsWithObservers <- reactiveVal(list())

    #A list for holding all created axis entry cards, is nessecary to prevent all axis cards for resetting
    #when a new paramater is added, or a old one removed
    created_elements <- reactiveVal(character())

    #A variable to hold wheter a event has been triggered by the user or the system, is used to prevent logick from
    #triggering when the event is called by the system
    system_update <- reactiveVal(FALSE)

    #A reactive mapping of paramaters and their associated dataframelists
    plotDataFrame <- reactiveVal(list())

    #NOT IN USE
    expTogglesWithObservers <- reactiveVal(list())

    #A reactive mapping between paramaters and their currently highlighted members
    HighlightedMembersForParam <- reactiveVal(list())

    #############################################
    #                  Logick                   #
    #############################################

    plotBtnEnabler(input, output, session, selectedParams)

    #Logick that observers the user inputs in the directory selector
    dirObserverServer(input, output, session, directory, fileList, userId)

    #Logick that observs the user inputs in the experiment selection input
    expInputObserverServer(input, output, session, fileList)

    #Logick that observs the user input in the date selection input
    dateInputObserverServer(input, output, session, selectedParams, fileList, paramsWithObservers)

    #Logick that creates Axis customization cards based on the selected paramaters
    dynamicAxisEntries(input, output, session, selectedParams, AxisValues, fileList, created_elements)

    #Logick that obsers the plot btn
    plotObserverServer(input, output, session, selectedParams, plots, fileList, directory, pValues, colour, shortNames, system_update, plotDataFrame, HighlightedMembersForParam)

    #Logick that observes the users selected plot tab
    dynamicTabsObserverServer(input, output, session, pValues, system_update, plots, selectedParams, plotDataFrame, expTogglesWithObservers, colour, shortNames, HighlightedMembersForParam)

    #Logick for observing the users triggering the save btn
    saveObserverServer(input, output, session, selectedParams, plots, pValues)

    #Logick for observing the users triggering the apply btn
    applyObserverServer(input, output, session, colour, shortNames, plots, pValues, selectedParams, plotDataFrame, HighlightedMembersForParam)

}