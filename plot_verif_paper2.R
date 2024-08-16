library(harp)
library(here)
library(dplyr)
library(forcats)

source("helperMethods/createColorList.R")
source("helperMethods/createMemberColorList.R")
source("helperMethods/createShortNameList.R")

# Creates a plot. The method first read the required files and creates the nessecary dataframes.
# Further creates a colorList and a shortNames list to be used in the plot. Further checks the verif_type
# to determin wich type of plot should be created.
#
# paramater:          The paramater to create a plot for
# period:             The daterange to create the plot for
# score:              The score to plot
# colour:             A lsit of colours to use in the plot
# lev:                The p level to plot for
# data_dir:           The path to the directory where the data is found
# plot_title:         The title to give the plot
# x_label:            The x_label to give the plot
# y_label:            The y_label to give the plot
# y_min:              The lower y axis value to give the plot
# y_max:              The upper y axis value to give the plot
# plots:              A list of plots
# experiments:        A list of experiments to create the pot for
# pValues:            A list of paramaters and their asoicated p level
# selected_params:    A list of all selected paramaters
# shortNames:         A list of the experiment nicknames to be used in the plot
# input:              The systems input variable, allows accessing of input fields in the user interface
plot_verif_paper <- function(
  parameter, 
  score, 
  colour, 
  lev, 
  plot_title,
  x_label,
  y_label,
  y_min,
  y_max,
  plots,
  experiments,
  pValues,
  selected_params,
  shortNames,
  input,
  plotDataFrame,
  rePlot
) {


  #create a non reacitve p values list
  currentPValues <- pValues()

  #Update the local p values list
  currentPValues[[parameter]] <- lev

  #update the reactibe p value list to equal the local p value list
  pValues(currentPValues)
  
  #Reads the experiment data
  currentDataFrames <- plotDataFrame
  ver_data <- currentDataFrames

  #Create a list of all active experiments
  activeExperiments <- unique(ver_data[[1]]$fcst_model)
  members <- unique(ver_data[[length(ver_data)]]$member)



  verif_type <- ""
  if(substr(score, 1, 4) == "ens_"){
    verif_type <- "ens"
    CreateColorList(input, colour, experiments)

  } else {
    verif_type <- "det"

    createMemberColorList(input, colour, members, parameter, rePlot)
                    print("Method start")
    print(colour)
  }

  #Create the shortName list for the plot
  CreateShortNameList(input, shortNames, experiments)

  #Create the color list for the plot

  print(colour$data)

  #Sets the shortnames of the experiments
  mname_map <- setNames(shortNames$data, activeExperiments) 

  #Updates the ver data dataframe with the newly assigned nicknames
  for (i in seq_along(mname_map)) {
    
    verif_attrs <- attributes(ver_data)
    ver_data    <- map_at(
      ver_data,
      which(map_int(ver_data, nrow) > 0),
      mutate,
      fcst_model = case_when(
        fcst_model == names(mname_map)[i] ~ mname_map[[i]], 
        TRUE                         ~ fcst_model
      )
    )
    
    attributes(ver_data) <- verif_attrs

  }

  #Debugging statement used to print the fiels of the dataframes 
  print("Column names in each data frame:")
  lapply(seq_along(ver_data), function(i) {
    cat(sprintf("Data frame %d:\n", i))
    print(names(ver_data[[i]]))
    cat("\n")
  })

  #Filters out non relevant experimetns when no p level is selected
  if (is.null(lev)) {
    ver_data <- filter_list(ver_data, leadtime > 0 )
  }
  
  #Filters out non relevant experiments when a p level is selected
  if (!is.null(lev)) {
    ver_data <- filter_list(ver_data, p == lev)
  }
  
  #Checks the verif type, and creates a variable holding the verif type
  
  my_colours <- data.frame()

  if(verif_type == "det"){
    mname_map <- members
    print("Mname maps follows")
    print(mname_map)
    my_colours <- data.frame(
      member  = unlist(mname_map),
      colour = colour$data
    )
  } else {
        print(mname_map)

    my_colours <- data.frame(
      mname  = unlist(mname_map),
      colour = colour$data
    )
  }

      print(ver_data[[length(ver_data)]])

  #### TEMPORARY CODE FOR ENSURING THAT MEMBER 0 IS PLOTTET ON TOP!!!!!!

    print(my_colours)
  if(rePlot){
    for(member in input[[paste0("HighlightedMembers", parameter)]]){
    memberToMove <- member
    my_colours$member <- factor(my_colours$member, 
                            levels = c(setdiff(unique(my_colours$member), memberToMove), memberToMove))

    my_colours <- my_colours %>% arrange(member)
  }
  }
  


  print(my_colours)
  
  #Gets the score type
  score <- substr(score, 5, nchar(score))

  #Remainder of code calls the bakcend plot method based on the users inputs in axis styling and the verif type
  if(verif_type == "ens"){
    if(is.null(y_min) || is.null(y_max)){
        plot <- plot_point_verif(
        ver_data,
        {{score}},
        verif_type = verif_type,
        plot_num_cases = FALSE,
        colour_table   = my_colours,
        plot_title = plot_title,
        y_label = y_label,
        x_label = x_label,
        base_size = 20
      )

      currentPlots <- plots()
      if(length(currentPlots) == length(selected_params())){
          index <- which(selected_params() == parameter)
          currentPlots[[index]] <- list(plot)
      } else {
          currentPlots <- append(currentPlots, list(plot))
      }
      plots(currentPlots)
    } else {
      plot <- plot_point_verif(
        ver_data,
        {{score}},
        plot_num_cases = FALSE,
        colour_table   = my_colours,
        plot_title = plot_title,
        y_label = y_label,
        x_label = x_label,
        base_size = 20
      ) + ylim(y_min, y_max)

      currentPlots <- plots()
      if(length(currentPlots) == length(selected_params())){
          index <- which(selected_params() == parameter)
          currentPlots[[index]] <- list(plot)
      } else {
          currentPlots <- append(currentPlots, list(plot))
      }
      plots(currentPlots)
    }

  } else {
      if(is.null(y_min) || is.null(y_max)){
        plot <- plot_point_verif(
        ver_data,
        {{score}},
        verif_type = verif_type,
        plot_num_cases = FALSE,
        colour_by = member,
        colour_table   = my_colours,
        plot_title = plot_title,
        y_label = y_label,
        x_label = x_label,
        base_size = 20,
        facet_by = vars(fcst_model)
      )

      currentPlots <- plots()
      print("\n")
            print("\n")
      print("\n")
      print("\n")
      print("\n")
      print("\n")
      print("\n")

      plot$layers <- rev(plot$layers)
      print(plot$layers[[2]])
      if(length(currentPlots) == length(selected_params())){
          index <- which(selected_params() == parameter)
          currentPlots[[index]] <- list(plot)
      } else {
          currentPlots <- append(currentPlots, list(plot))
      }
      plots(currentPlots)
    } else {
      plot <- plot_point_verif(
        ver_data,
        {{score}},
        plot_num_cases = FALSE,
        colour_by = member,
        colour_table   = my_colours,
        plot_title = plot_title,
        y_label = y_label,
        x_label = x_label,
        base_size = 20,
        facet_by = vars(fcst_model)
      ) + ylim(y_min, y_max)

      currentPlots <- plots()
      print("\n")
            print("\n")
      print("\n")
      print("\n")
      print("\n")
      print("\n")
      print("\n")

      plot$layers <- rev(plot$layers)
      print(plot$layers)
      if(length(currentPlots) == length(selected_params())){
          index <- which(selected_params() == parameter)
          currentPlots[[index]] <- list(plot)
      } else {
          currentPlots <- append(currentPlots, list(plot))
      }
      plots(currentPlots)
    }
  }

  print("Plotting completes")

}
