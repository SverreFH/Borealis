source("./plot_verif_paper2.R")
source("helperMethods/getPlotName.R")
source("helperMethods/getXLabel.R")
source("helperMethods/getYLabel.R")
source("helperMethods/getYMax.R")
source("helperMethods/getYMin.R")

### rePlotter ###
#A method for structuring all the nessecay data before passing it to the plot_verif_paper method for actual plotting
#
#score:                 The score type to plot for
#colour:                A list of colours
#experiments:           A list of experiments to plot for
#shortNames:            A list of shortNames
#param:                 The paramater to plot for
#plots:                 A list of all current plots
#pValues:               A list of curren paramaters and their p values
#pLevel:                   The level to plot for
#selectedParams:        A list of all currently selected paramaters
#input:                 The systems input variable, allows accessing of input fields in the user interface
#currentDataFrame:      A dataframelsit
rePlotter <- function(score, colour, experiments, shortNames, param, plots, pValues, pLevel, selectedParams, input, currentDataFrame){
    PlotName <- GetPlotName(input, param)

    xLabel <- GetXlabel(input, param)

    yLabel <- GetYLabel(input, param)

    yMin <- GetYMin(input, param)

    yMax <- GetYMax(input, param)


    #experiment_list <- setNames(shortNames, experiments) 
    if(!(param %in% c("Q", "RH", "S", "T", "Td", "Z" ))){
        lev = NULL
    } 

    print("Right before big plotter")

    plot_verif_paper(
            parameter = param,
            score = score,
            colour = colour,
            plot_title = PlotName,
            x_label = xLabel,
            y_label = yLabel,
            y_min = yMin,
            y_max = yMax,
            plots = plots,
            experiments = experiments,
            lev = pLevel,
            pValues = pValues,
            selected_params = selectedParams,
            shortNames = shortNames,
            input = input,
            plotDataFrame = currentDataFrame,
            rePlot = TRUE
        )
    print("Right after big plotter")

}
