selectionSidebarUI <- function() {
    div(class = "SidebarGeneral",

        #UI elements for letting a user select a directory from which the experiments will be 
        #selected. 
        div(
            div( class = "dirDiv", 
                tags$strong("Experiment Directory:"),
                shinyDirButton("dir", "Select Directory", "Upload", class = "DirBtn")
            ),
            verbatimTextOutput("dir", placeholder = TRUE),
        ),

        #UI element that allows a user to select which experiments to plot for
        #from a drop down list auto populated based on the experiments in the previously
        #selected experiments folder
        selectInput("Experiments", "Experiments:",
                    c("Please select experiments" = ""),
                    width="100%"),

        #UI element that allows a user to select which date to plot for
        #from a drop down list auto populated based on the experiments in the previosly
        #selected experiments folder and the previosly selected experiment.
        selectInput("Daterange", "Daterange:",
                    c("Please select daterange" = ""),
                    width="100%"),

        #Temporary textinput that will allow the user to select a value
        selectizeInput("score", "Score type:",
                     choices = list(
                       "Ens Summary Scores" = c("CRPS" = "ens_crps", 
                       "CRPS Potential" = "ens_crps_potential",
                       "CRPS Reliability" = "ens_crps_reliability",
                       "Hexbin" = "ens_hexbin",
                       "Mean Bias" = "ens_mean_bias",
                       "Normalized Rank Histogram" = "ens_normalized_rank_histogram",
                       "Number Of Cases" = "ens_num_cases",
                       "Rank Histogram" = "ens_rank_histogram",
                       "RMSE" = "ens_rmse",
                       "Spread" = "ens_spread",
                       "Spread Skill" = "ens_spread_skill",
                       "Spread Skill Ratio" = "ens_spread_skill_ratio",
                       "STDE" = "ens_stde"),

                       "Det Summary Scores" = c("Bias" = "det_bias",
                       "Hexbin" = "det_hexbin",
                       "MAE" = "det_mae",
                       "Number Of Cases" = "det_num_cases",
                       "RMSE" = "det_rmse",
                       "STDE" = "det_stde")
                     ),
                     width = "100%"),

        
        #UI element that shows all the possible paramaters for the selected experiment and date
        #allowing the user to toggle the paramaters they wish to plot for 
        div(
            tags$strong("Select Paramaters:")
        ),

        #Placeholder element to tell a user what must first be done in order to get the actual
        #param buttons to show.
        div(class = "PlaceholderParams", "Please select directory, experiments and daterange"),

        #A container for holding all of the dynamically created paramater buttons
        div(class = "button-ui-container",
            uiOutput("paramBtnUi")
        ), 

        #The plot button itself. Pressing this button creates the plot based on the user inputs.
        div(class = "plot-btn-container",
            actionButton("plot", "Plot")
        )
    )
}