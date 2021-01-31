# CourseraProject_GettingCleaningData
This is Coursera  Getting and Cleaning Data Course Project
# Project Description

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smart phone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities.70% of the volunteers was selected for generating the training data and 30% the test data. 


# This repository contains the following files:

* README.md, this file, which provides an overview of the data set and how it was created.
* tidy_data.txt, which contains the data set.
* code_book.md, the code book, which describes the contents of the data set (data, variables   and transformations used to generate the data).
* run_analysis.R, the R script that was used to create the data set (see the Creating the    data set section below)

# Collection of the raw data

The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# R script run_analysis.R
The R script run_analysis.R can be used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

1. Download and unzip source data if it doesn't exist.
2. Read data.
3. Merge the training and the test sets to create one data set.
4. Extract only the measurements on the mean and standard deviation for each measurement.
5. Use descriptive activity names to name the activities in the data set.
6. Appropriately label the data set with descriptive variable names.
7. Create a second, independent tidy set with the average of each variable for each activity and each subject.
8. Write the data set to the tidy_data.txt file.
