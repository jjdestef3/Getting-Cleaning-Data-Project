# Function to run data analysis for ....
# This function takes an optional reloadData parameter. If true the
# any current data files and directories are removed. If false, then a 
# check is done to see if the datafile is present. If not the it is re-downloaded
# and extracted.
run_analysis <- function(reloadData=FALSE) {
    
    # Data files and directory
    dataFile <- "dataset.zip"
    dataDir <- "UCI HAR Dataset"
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    ########################################################################################
    # First section sets up data file and directory
    ########################################################################################
    
    # Deletes data file if there
    cleanUp <- function() {
        if(file.exists(dataFile)) {
            file.remove(dataFile)
        }
    }
    
    # Check to see if the data file is there first. If not download it.
    # Once the data file is there then delete the data directory (if
    # it exists) and unzip the data file.
    getData <- function() {
        # If its there don't run again
        if(!file.exists(dataFile)) { 
            download.file(url, dataFile, method = "curl")
        }
        
        # Extract data
        if(file.exists(dataDir)) {
            unlink(dataDir, recursive=TRUE)
        }
        unzip(dataFile, exdir = ".")
    }
    
    # Clean up any current data file and directory
    if (reloadData) {
        cleanUp()
    }
    
    # Set up data
    getData()
    
    
    ############################################################
    #1. Combine training and test data to make a single data set
    ############################################################
    # Start with X
    xTest <- read.table(paste("./",dataDir,"/test/X_test.txt", sep = ""))
    xTrain <- read.table(paste("./",dataDir,"/train/X_train.txt", sep = ""))
    xCombined <- rbind(xTest, xTrain)
    
    # Then Y
    yTest <- read.table(paste("./",dataDir,"/test/y_test.txt", sep = ""))
    yTrain <- read.table(paste("./",dataDir,"/train/y_train.txt", sep = ""))
    yCombine <- rbind(yTest, yTrain)
    
    # Then subject
    sTest <- read.table(paste("./",dataDir,"/test/subject_test.txt", sep = ""))
    sTrain <- read.table(paste("./",dataDir,"/train/subject_train.txt", sep = ""))
    sCombine <- rbind(sTest, sTrain)
    
    ###########################################################
    #2. Extracts only the measurements on the mean and standard 
    #   deviation for each measurement
    ###########################################################
    
    # Make feature names to colum headers for combined data set 
    featureNames <- read.table(paste("./",dataDir,"/features.txt", sep=""))[,2]
    names(xCombined) <- featureNames
    
    # Now get the colums that have mean or std in them
    meanStdCols <- grep("(mean|std)\\(\\)", names(xCombined))
    
    # Now make a table of only those colums
    meanStdDataTbl <- xCombined[, meanStdCols]
    
    ###########################################################
    #3.
    ###########################################################
    
    ###########################################################
    #4.
    ###########################################################
    
    ###########################################################
    #5.
    ###########################################################
    
}