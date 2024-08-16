source("ui.R")
source("server.R")
#source("global.R")

#The main file for the Borealis application. This is the file that is executed on program start
shinyApp(ui = ui, server = server)