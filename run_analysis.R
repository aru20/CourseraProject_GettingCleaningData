##############################################################################
# Getting and Cleaning Data Course Project
# File:run_analysis.R
#  
# OVERVIEW
#   Using data collected from the accelerometers from the Samsung Galaxy S 
#   smartphone, work with the data and make a clean data set, outputting the
#   resulting tidy data to a file named "tidy_data.txt".
#   See README.md for details.
#

library(dplyr)
library(reshape2)
##############################################################################
# STEP1 - Geting the data
##############################################################################
# download zip file containing data if it hasn't already been downloaded

zipFileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipFileurl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}

##############################################################################
# STEP 2 - Reading the data 
##############################################################################

# Reading training data from "train" folder
# reading "subject_train.txt","X_train.txt","y_train.txt"

trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

# Reading test data from "test" folder
# Reading "subject_test.txt","X_test.txt","X_test.txt"

testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))

# Reading features from "features.txt"
#Renaming the features table column name to "index", "featureNames"

features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE,col.names = c("index", "featureNames"))

# Reading activity labels from "activity_labels.txt"
# Renaming the activities table column name to "activityId", "activityLabel"
activities <- read.table(file.path(dataPath, "activity_labels.txt"),col.names = c("activityId", "activityLabel"))


##############################################################################
# Step 3 - Merging the training and the test data sets to create one data set
##############################################################################

# concatinating individual data tables to make single data table

 allTraining <- cbind(trainingActivity,trainingSubjects,trainingValues)
 allTest <- cbind(testActivity,testSubjects,testValues)
 humanActivity <- rbind(allTraining,allTest)
 #colnames(humanActivity)

 # assign column names
 colnames(humanActivity) <- c("subject","activity",features[, 2])
##############################################################################
# Step 4 - Extracting only the measurements on the mean and standard deviation
#          for each measurement
##############################################################################

# determine columns of data set to keep based on column name...
# Reading column names
  columnnames <- colnames(humanActivity)
  columnnames
# Create vector for defining ID, mean, and sd
  columnsToKeep <- (grepl("activity", columnnames) |
                    grepl("subject", columnnames) |
                    grepl("mean..", columnnames) |
                    grepl("std...", columnnames)
 )
 #columnsToKeep
 # Making necessary subset
  humanActivity <- humanActivity[ , columnsToKeep == TRUE]
  
##############################################################################
# Step 5 - Use descriptive activity names to name the activities in the data
#          set
##############################################################################
  
# replace activity values with named factor levels
  humanActivity$activity <- factor(humanActivity$activity, 
                                   levels = activities[, 1], labels = activities[, 2])
  

##############################################################################
# Step 6 - Appropriately label the data set with descriptive variable names
##############################################################################
# get column names
  humanActivityCols <- colnames(humanActivity)
  
# remove special characters
  humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)
  
# expand abbreviations and clean up names
  humanActivityCols <- gsub("^f", "frequency", humanActivityCols)
  humanActivityCols <- gsub("^t", "time", humanActivityCols)
  humanActivityCols <- gsub("Acc", "Acc", humanActivityCols)
  humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
  humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
  humanActivityCols <- gsub("Freq", "Freq", humanActivityCols)
  humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
  humanActivityCols <- gsub("std", "Std", humanActivityCols)
# correct typo
  humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)
  
# use new labels as column names
  colnames(humanActivity) <- humanActivityCols
  ##############################################################################
  # Step 5 - Create a second, independent tidy set with the average of each
  #          variable for each activity and each subject
  ##############################################################################
  
  # group by subject and activity and summaries using mean
  humanActivityMeans <- humanActivity %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
  
  # output to file "tidy_data.txt"
  write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
              quote = FALSE)
