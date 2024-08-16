source("uiComponents/interactiveComponents/PLevel.R")
source("uiComponents/interactiveComponents/ExperimentToggle.R")
source("uiComponents/interactiveComponents/Member.R")

bodyUI <- function(){
    div(class = "bodyView",
        div(class = "plotTabs",
        tabsetPanel(id = "dynamicTabs")
        ),
        div(class = "InteractiveArea", 
            div(class = "Interactive",
                div(class = "SaveBtnContainer",
                        shinySaveButton("save", "Save Plot", "Save Plot As", filetype = list(png = "png")),
                ),
                PLevelUI(),
                #ExperimentToggleUI(),
                MemberUI(),
                actionButton("applyBtn", "Apply")
            ),
            div(class = "InteractivePlaceholder",
                "Interactive options are displayed here when a plot is selected"
            )
        )
    )
    
}