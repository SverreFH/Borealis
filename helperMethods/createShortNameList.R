### CreateShortNameList ###
#Creats a list of nicknames for the given experiments. The nicknames are
#sorced from the experiments styling cards. If no nickname is set the system
#automatically sets the nickname equal to the name.
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#shortNames:        A list containing all shortNames
#experiments:       A list of experiments to create shortNames for
CreateShortNameList <- function(input, shortNames, experiments){
    shortNames$data <- sapply(experiments, function(experiment) {
        name <- input[[paste0("ShortName_", experiment)]]
        if (is.null(name) || name == "") {
            experiment
        } else {
            name
        }
    })
}