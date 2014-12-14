---
title: "Human Activity Recognition Using Smartphones Data Set"
author: "Hayden"
date: "Sunday, December 14, 2014"
output: pdf_document
---

The goal is to prepare tidy data that can be used for later analysis. Files in the repository include:

* run_analysis.R: the script for performing the analysis, getting and clearning the data.

* getdata-projectfiles-UCI HAR Dataset.zip: dataset downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* codebook.md: a code book that describes the variables, the data, and any transformations or work that performed to clean up the data

* data.txt: the data file for submission - tidy data set with the average of each variable for each activity and each subject.

Transformations and work that performed to clean up the data are as follows:

1. Read the whole datasets, into variables X_train, y_train,subject_train,X_test,y_test, subject_test

2. Merge the training and the test sets to create one data set, by combining train and test vertically, and binding X,y and subject horizontally to create variable data_merge

3. From feature.txt, get to know which features are about the measurements on the mean and standard deviation for each measurement. 

4. Extract the requested measurements from data_merge to create a tidy version 

5. Use descriptive activity names (which are extracted from activity_labels.txt) to name the activities in the data set, i.e., WALKING as 1, WALKING_UPSTAIRS as 2, etc.

6. Appropriately label the data set with descriptive variable names (which are extracted from feature.txt)

7. From the data set in step 6, create a second, independent tidy data set with the average of each variable for each activity and each subject using melt and dcast function, generate variable data_melt

8. Save data for submission

 
 