source("helperMethods/createUniqueExpList.R")

#Observs the dir user input
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#directory:         A reactive value holding the directroy path to the experiment files
#userId:            The id of the user currently using the system
dirObserverServer <- function(input, output, session, directory, fileList, userId){
    #Defines the functionality that allows the user to select a
    #directory of experiment files. Defaults the user to the scratch
    #home directory. Will allow the user to select a folder containing 
    #rds files. 
    shinyDirChoose(
        input,
        'dir',
        roots = c(home = paste0('/ec/res4/scratch/', userId, '/harp/VERTABLE')),
        filetypes = c('rds')
    )

    observeEvent(input$dir, {
        disable("Experiments")
        disable("Daterange")
        shinyjs::show(selector = ".PlaceholderStyling")
        shinyjs::hide(selector = ".StylingPanel")
        shinyjs::show(selector = ".PlaceholderParams")
        shinyjs::hide(selector = ".button-ui-container")
        shinyjs::disable("plot")
        shinyjs::show(selector = ".InteractivePlaceholder")
        shinyjs::hide(selector = ".Interactive")

        directory$datapath <- parseDirPath(c(home = paste0('/ec/res4/scratch/', userId, '/harp/VERTABLE')), input$dir)
        files <- list.files(path = directory$datapath, full.names = TRUE)
        fileList(files)

        dir_path <- parseDirPath(c(home = '~'), input$dir)
        output$dir <- renderText({
            if (is.null(dir_path)) {
                "No directory selected"
            } else {
                dir_path
            }
        })

        if (length(dir_path) != 0) {
            exps <- CreateUniqueExpList(fileList)
            updateSelectInput(session, "Experiments",
                choices = c("Please select experiments" = "", setNames(exps, exps)))
            enable("Experiments")
        } 
    
    })


}