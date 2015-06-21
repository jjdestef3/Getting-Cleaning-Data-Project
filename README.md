# Getting-Cleaning-Data-Project
This reposotory contains the final project for Getting and Cleaning Data, a Coursera course.

---

## Contents
    1. The README.md file you are looking at now.
    2. The CodeBook.md file which contains a detailed description of the project objectives
    3. The run_analysis.R file which is an R function that performs the project objectives.
    
---

## Project Objectives Overview

The project dataset contain data collected from the accelerometers from the Samsung Galaxy S smartphone. After obtaining the project data set from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

write an R script called run_analysis.R which perform the following objectives:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the 
       average of each variable for each activity and each subject.
       
## Running the analysis

First, read the CodeBook.md file for a description of the projects objective, the variables used, 
and any required transformations that were performed on the test data. Second, read the 
documentation that is included in the run_analysis.R file. This will describe what options are 
available when performing the analysis. 

To perform the cleaning and analysis with program defaults execute the run_analysis.R script from
with the R environment (I use RStudio).