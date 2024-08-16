source("uiComponents/sidebarComponents/selectionSidebar.R")
source("uiComponents/sidebarComponents/stylingSidebar.R")
source("uiComponents/sidebarComponents/axisSidebar.R")


sidebarUI <- function(){

    #A sidebar component consisting of tabs where in each tab holds a different sidebar
    #(Styling sidebar and selection sidebar)
    div(class = "Sidebar",
        tabsetPanel(
        tabPanel("Selection",
            selectionSidebarUI()
        ),
        tabPanel("Styling",
            stylingSidebarUI()
        ),
        tabPanel("Axis",
            axisSidebarUI()
        )
        )
    )
}

