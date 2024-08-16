
# Creates a list of dataframes based on the given paramater, period, experiments and directory.
# Works by creating a filename that points to the whanted experiment/date files. When a list of
# data frames are createt for the given paramater it is added to the list over dataframes per paramater.
# paramater:            The paramater to read files for and the paramater to update the dataframe list for
# period:               The period to read files for
# experiments:          The experiment to read files for
# plotDataFrame:        A mapping over paramaters and their corresponding dataframelists
# directory:            The directory to search for files
createDataFrame <- function(paramater, period, experiments, plotDataFrame, directory){
    #Constructs the filenames from the users seleceted experiments
    tag      <- ".harp."
    filename <- paste(
        directory$datapath,
        "/harpPointVerif",
        tag, paramater, tag, period, tag, 
        paste(experiments, collapse = ".model."), 
        ".rds", sep = ""
    )

    #Reads the experiment data
    currentDataFrames <- plotDataFrame()
    currentDataFrames[[paramater]] <- readRDS(filename)
    plotDataFrame(currentDataFrames)
}