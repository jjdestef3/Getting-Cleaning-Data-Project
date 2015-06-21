# CodeBook for Getting and Cleaning Data, a Coursera course
---

## Objective of Assignment
The objective is to clean and perform limited analysis on a data set which contains data collected from 
accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This project, titled "Human Activity Recognition Using Smartphones Data Set", contains the data set being
used. Briefly, the experiments was carried out with a group of 30 volunteers who each performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone. Using the 
phones embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity reading
were captured at a constant rate of 50Hz. A video is also avaialble at the site.

---

## Source of Data
The data used for this project can be found here: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The zip file contains the relevant data files as well as a description of the data.

---

## Variables Used
Each of the variables for WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
was used for each test subject. For each variable, 6 readings were used; 3 axial angular velocity
readings and 3 axial linear acceleration readings.

---

## Description of Transformation and Cleaning
The following process was used in the documented order. This process was implemented in an R
script called run_analysis.R. For a detailed coding description refer to the documentation in the 
run_analysis.R script. This script performs the following:

1. Merges the training and the test sets to create one data set.
  * Data sets for training and testing were combined based on the provided files.
  * X_test.txt and X_train.txt was combined using rbind
  * Y_test.txt and Y_train.txt was combined using rbind
  * subject_test.txt and subject_train.txt was combined using rbind

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  * The grep function was used to extract a list of column names that contained mean() and std() from the x combined dataset
  * The list was used to create a final X combined data set with only the mean and std columns

3. Uses descriptive activity names to name the activities in the data set
  * Labels from the activity_labels.txt file where used as labels in the Y combined data set
  * The labels in activity_labels.txt where first forced to lower case before applying
  
4. Appropriately labels the data set with descriptive variable names
  * The column names in the combined and filtered X data set where further modified replacing -std with Std and -mean with Mean.
  * The column name for the subject combined data set was set to "subject"
  * The column Name for the combined Y data set was set to "activity"
  * The resultant X (filtered for only std/mean), Y, and subject data sets where combined together using cbind
  * The combined data set was written out to the file system.
 
5. From the data set in step 4, creates a second, independent tidy data set with the average of
each variable for each activity and each subject.
  * Using the plyr R library the data set produced from step 4 was used to create another data set
  * The new data set contains the mean for each variable for each activity and each subject
  * This data set was then written to the file system
