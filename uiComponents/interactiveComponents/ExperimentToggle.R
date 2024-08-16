ExperimentToggleUI <- function(){
    div(class = "ExperimentToggleContainer",
        div(class = "ToggleHeader",
            "Toggle experiment:"
        ),
        uiOutput("ExperimentToggles")
    )
}