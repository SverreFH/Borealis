source("./plot_verif_paper2.R")
source("helperMethods/createDataFrame.R")
source("helperMethods/getPlotName.R")
source("helperMethods/getXLabel.R")
source("helperMethods/getYLabel.R")
source("helperMethods/getYMax.R")
source("helperMethods/getYMin.R")

### Plotter ###
#A method for structuring all the nessecay data before passing it to the plot_verif_paper method for actual plotting
#
#dateRange:             The daterange to plot for
#score:                 The score type to plot for
#colour:                A list of colours
#shortNames:            A list of shortNames
#param:                 The paramater to plot for
#plots:                 A list of all current plots
#directory:             A reactive value holding the directory path to the experiment files
#pValues:               A list of curren paramaters and their p values
#lev:                   The level to plot for
#selectedParams:        A list of all currently selected paramaters
#input:                 The systems input variable, allows accessing of input fields in the user interface
#plotDataFrame:         A list of paramaters and their corresponding dataframelists
Plotter <- function(dateRange, score, colour, experiments, shortNames, param, plots, directory, pValues, lev, selectedParams, input, plotDataFrame){

    PlotName <- GetPlotName(input, param)

    xLabel <- GetXlabel(input, param)

    yLabel <- GetYLabel(input, param)

    yMin <- GetYMin(input, param)

    yMax <- GetYMax(input, param)

    createDataFrame(param, dateRange, experiments, plotDataFrame, directory)

    currentDataFrames <- plotDataFrame()

    #experiment_list <- setNames(shortNames, experiments) 
    if(!(param %in% c("Q", "RH", "S", "T", "Td", "Z" ))){
        lev = NULL
    } 

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
            lev = lev,
            pValues = pValues,
            selected_params = selectedParams,
            shortNames = shortNames,
            input = input,
            plotDataFrame = currentDataFrames[[param]],
            rePlot = FALSE
        )
        
}