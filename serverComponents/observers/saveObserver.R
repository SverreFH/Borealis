
#Observes user iputs with the save button
#
#input:             The systems input variable, allows accessing of input fields in the user interface
#output:            The systems output variable, allows accessing the systems outputs in the user interface
#selecedParams:     A list of all currently selected paramaters
#plots:             A list of plots
#pValues:           A lsit of paramaters and their associated p values
saveObserverServer <- function(input, output, session, selectedParams, plots, pValues){
    # Define reactive placeholder for file name
    pname <- reactive({
        currentParams <- selectedParams()
        param <- input$dynamicTabs
        index <- which(currentParams == param)
        current_pValues <- pValues()
        lev <- current_pValues[[param]]
        score <- input$score
        period <- input$Daterange
        experiments <- unlist(strsplit(input$Experiments, " "))
        models <- paste(experiments, collapse = ".model.")
        
        plot_dir <- "plots"
        plot_fmt <- "png"
        
        paste0(plot_dir, "/", param, "_", lev, "_", score, "_", period, "_", models, ".", plot_fmt)
    })

    # Use the placeholder in shinyFileSave
    shinyFileSave(input, "save", roots = c(home = paste0(getwd())), session = session, filetypes = c("png"), defaultPath = pname())

    observeEvent(input$save, {
        print("Save called")
        plot_dir    = "plots"
        plot_fmt    <- "png"
        plot_width  <- 50
        plot_height <- 34
        plot_dpi    <- 300

        currentParams <- selectedParams()
        param <- input$dynamicTabs
        index <- which(currentParams == param)
        currentPlots <- plots()
        plot <- currentPlots[[index]]
        
        # Extract the filename entered by the user
        save_path <- parseSavePath(c(home = paste0(getwd())), input$save)
        if (nrow(save_path) > 0) {
            user_filename <- save_path$datapath
            ggsave(user_filename, device = plot_fmt, units = "cm", width = plot_width, height = plot_height, dpi = plot_dpi, plot = plot)
            showNotification("Plot created!", type = "message")
        }
    })
}