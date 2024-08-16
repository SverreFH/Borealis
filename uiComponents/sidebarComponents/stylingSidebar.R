stylingSidebarUI <- function() {

    #A special sidebar for handeling styling of the plots
    div(class = "stylingSidebar",

        #A container to hold the dynamically created styling cards for each experiment
        div(class = "StylingPanel",
            uiOutput("dynamicEntries")  # Dynamic UI output
        ),

        #A placeholder telling the user what must first be selected before styling cards are enabled
        div(class = "PlaceholderStyling", "Please select directory and experiments")
    )
}