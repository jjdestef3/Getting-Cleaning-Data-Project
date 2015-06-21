################################################################################################################
# Function to run data analysis for Coursera Getting and Cleaning Data Course Final Project.
# This function takes 3 optional parameters; reloadData, cleanedDataSetFileName, cleanedAvgDataSetFileName.
#
# relaodData: The purpose is to re-download the data file. The default is false. The unziped data directory will 
#             always be deleted and the data file unzipped for each run. If true, and the data file exisits
#             in the directory, it will be deleted and re-downloaded. Note: If the data file does not exist 
#             it will be downloaded first, regardless of the value for reloadData.
#
# cleanedDataSetFileName: The name of the combined, cleaned data set to write (Step 4 below). The default is
#             "cleaned_data.txt".
#
# cleanedAvgDataSetFileName: The name of the the data set that contains the averages (Step 5 below). The 
#             default is "cleaned_avg_data.txt".
# 
# The steps that is function performs after the test data set has been downloaded and unzipped are as follows:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#    for each activity and each subject.
#
# Required librarys: plyr
#
################################################################################################################
run_analysis <- function(reloadData=FALSE, cleanedDataSetFileName="cleaned_data.txt",
                         cleanedAvgDataSetFileName="cleaned_avg_data.txt") {
    
    # Data files and directory
    dataFile <- "dataset.zip"
    dataDir <- "UCI HAR Dataset"
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    ########################################################################################
    # First section sets up data file and directory
    ########################################################################################
    
    # Return file names
    getFilePath <- function(fileName) {
        paste("./",dataDir,fileName, sep = "")
    }
    
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
    xTest <- read.table(getFilePath("/test/X_test.txt"))
    xTrain <- read.table(getFilePath("/train/X_train.txt"))
    xCombined <- rbind(xTest, xTrain)
    
    # Then Y
    yTest <- read.table(getFilePath("/test/y_test.txt"))
    yTrain <- read.table(getFilePath("/train/y_train.txt"))
    yCombined <- rbind(yTest, yTrain)
    
    # Then subject
    sTest <- read.table(getFilePath("/test/subject_test.txt"))
    sTrain <- read.table(getFilePath("/train/subject_train.txt"))
    sCombined <- rbind(sTest, sTrain)
    
    ###########################################################
    #2. Extracts only the measurements on the mean and standard 
    #   deviation for each measurement
    ###########################################################
    
    # Make feature names to colum headers for combined data set 
    featureNames <- read.table(getFilePath("/features.txt"))[,2]
    names(xCombined) <- featureNames
    
    # Now get the colums that have mean or std in them
    meanStdCols <- grep("(mean|std)\\(\\)", names(xCombined))
    
    # Now make a table of only those colums
    meanStdDataTbl <- xCombined[, meanStdCols]
    
    ###########################################################
    #3. Use descriptive activity names to name the activities
    #   in the data set
    ###########################################################
    
    # Read the nice names
    acts <- read.table(getFilePath("/activity_labels.txt"))
    
    # make description lower case
    acts[, 2] <- tolower(as.character(acts[, 2]))
    
    # Set the labels based on the y data value:
    # Get the data values
    yData <- yCombined[,1]
    
    # Now map the description in acts based on the value of yData
    # and put that in the first column of yCombine
    yCombined[,1] <- acts[yData, 2]
    
    # Give the column a header
    names(yCombined) <- "activity"
    
    ###########################################################
    #4. Appropriately label the data set with descriptive 
    #   variable names and create a final combined data set
    ###########################################################
    
    # Change -mean() to Mean
    names(meanStdDataTbl) <- gsub("-mean\\(\\)", "Mean", names(meanStdDataTbl))
    
    # Change -std() to Std
    names(meanStdDataTbl) <- gsub("-std\\(\\)", "Std", names(meanStdDataTbl))
    
    # Give subject a column heading
    names(sCombined) <- "subject"
    
    # Combine into single data set and write out
    allCombined <- cbind(meanStdDataTbl, yCombined, sCombined)
    write.table(allCombined, getFilePath(paste("/",cleanedDataSetFileName, sep = "")))
    
    ###########################################################
    #5. From the data set in step 4, creates a second, 
    #   independent tidy data set with the average of each 
    #   variable for each activity and each subject and write
    #   it out
    ###########################################################
    library(plyr)
    allCombinedAvgs <- ddply(allCombined, .(subject, activity), numcolwise(mean))
    write.table(allCombinedAvgs, getFilePath(paste("/",cleanedAvgDataSetFileName, sep = "")), row.name=FALSE)
}