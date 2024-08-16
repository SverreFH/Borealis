#############################################
#                   GUI                     #
#############################################
library(harpVis)
library(harpPoint)
library(dplyr)
library(purrr)
library(grDevices)
library(shiny)
library(shinyFiles)
library(shinyjs)
library(colourpicker)

source("uiComponents/header.R")
source("uiComponents/sidebar.R")
source("uiComponents/body.R")

### page ###
#Creates the UI page with all defined elements
ui <- fluidPage(
    useShinyjs(),

    # Adds the css styling files and external javascript files
    tags$head(
        tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    ),

    # PAGE HEADER
    # The header of the page including the logo and the title of the page
    headerUI(),

    div(class = "mainPage",
        sidebarUI(),
        bodyUI()
    )
)