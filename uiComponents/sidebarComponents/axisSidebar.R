axisSidebarUI <- function(){

    div(class = "axisSidebar",
        #Placeholder element to tell a user what must first be done in order to get the actual
        #axis sidebar to show.
        div(class = "PlaceholderAxis", "Please select directory, experiments, daterange and at least one paramater"),

        div(class = "axisPanel",
            uiOutput("dynamicAxisEntries")  # Dynamic UI output    
        )
    )

}