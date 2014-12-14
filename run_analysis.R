setwd('D:/coursera/Getting and Cleaning Data/project')

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "getdata-projectfiles-UCI HAR Dataset.zip"
if(!file.exists(filename)){
        download.file(fileURL, destfile = filename, method="curl")
}

unzip(filename)

#reading the whole datasets
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                      header=F, stringsAsFactors = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                      header=F, stringsAsFactors = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                      header=F, stringsAsFactors = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                      header=F, stringsAsFactors = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                     header=F, stringsAsFactors = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                            header=F, stringsAsFactors = FALSE)

# Merges the training and the test sets to create one data set.
data_merge <- cbind(rbind(X_train, X_test), rbind(y_train, y_test),
                    rbind(subject_train, subject_test))

rm(X_train,y_train,subject_train,X_test,y_test,subject_test)

# Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

# from feature.txt get to know which features are on the mean and std 
feature <- read.table("./UCI HAR Dataset/features.txt", 
                      header=F, stringsAsFactors = FALSE)

meanstd <- sapply(feature$V2, function(x) grepl("-mean()|-std()",x))  

data_merge <- data_merge[,  meanstd]


# Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                      header=F, stringsAsFactors = FALSE)
activity_labels <- unlist(activity_labels[,2])

data_merge[,length(data_merge)-1] = as.factor(activity_labels[ data_merge[,length(data_merge)-1] ])


# Appropriately labels the data set with descriptive variable names. 
feature_list <- unlist(feature[meanstd,2])
names(data_merge) <- feature_list
names(data_merge)[80:81] <- c("activity", "subject_id")
data_merge$subject_id <- as.factor(data_merge$subject_id)

# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject
library(reshape)
library(reshape2)
data_melt <- melt(data_merge, id = c("activity", "subject_id"), 
                  measure.vars = feature_list)
data_avg <- dcast(data_melt,  activity*subject_id ~ variable, mean )

# save data

write.table( data_avg, "data.txt",row.name=FALSE, ) 

# read data if necessary
data <- read.table("data.txt", header = TRUE)
