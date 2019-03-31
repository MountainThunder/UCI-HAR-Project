## Getting and Cleaning Data
## Week 4 Project

library(plyr)
library(dplyr)
library(janitor)


## Download file & unzip
#fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileURL, destfile = "Dataset.zip")
#unzip("Dataset.zip")

## Read test and train data in
x_testFile <- "D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\test\\X_test.txt"
y_testFile <-"D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\test\\y_test.txt"
#x_testData <- read.table(x_testFile)
#y_testData <- read.table(y_testFile)

x_trainFile <- "D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\train\\X_train.txt"
y_trainFile <- "D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\train\\y_train.txt"
#x_trainData <- read.table(x_trainFile)
#y_trainData <- read.table(y_trainFile)

## Read in features file and assign as variable names to x_test and x_train.
featureFile <-"D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\features.txt"
featureData <- read.table(featureFile, header=FALSE)
VariableNames <- as.vector(featureData$V2)
colnames(x_testData) <- VariableNames
colnames(x_trainData) <- VariableNames

##Add label to activity column in y_train and test
colnames(y_trainData) <- c("activity")
colnames(y_testData) <- c("activity")

#add y data column in the x_train and x_test data
train <- bind_cols(y_trainData, x_trainData)
test <- bind_cols(y_testData, x_testData)

#read in subject test table 
subjectTestFile <-"D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\test\\subject_test.txt"
subjectTestData <- read.table(subjectTestFile, header=FALSE)

#read in subject train table 
subjectTrainFile <-"D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\train\\subject_train.txt"
subjectTrainData <- read.table(subjectTrainFile, header=FALSE)

# Add column name for subject
colnames(subjectTestData) <- c("subject")
colnames(subjectTrainData) <- c("subject")

# Bind subject column in the train and test data
train <- bind_cols(subjectTrainData, train)
test <- bind_cols(subjectTestData, test)

## Step 1: Merges the training and the test sets to create one data set.
mergedData <- bind_rows(test, train)
                    
## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
meanAndSTDData <- select(mergedData, subject, activity, matches(".*([Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]).*"))

## Step 3: Uses descriptive activity names to name the activities in the data set
activityFile <-"D:\\Jessica\\Coursera Data Science\\Getting and Cleaning Data\\Week 4\\UCI HAR Dataset\\activity_labels.txt"
activityNames <- read.table(activityFile)
activityVariableNames <- as.vector(activityNames$V2)
meanAndSTDData$activity <- mapvalues(meanAndSTDData$activity, from=1:6, to=activityVariableNames)

## Step 4: Appropriately labels the data set with descriptive variable names.

names(meanAndSTDData) <- gsub("Z", " on the z axis", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("X", " on the x axis", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("Y", " on the y axis", names(meanAndSTDData))
names(meanAndSTDData) <- tolower(names(meanAndSTDData))
names(meanAndSTDData) <- gsub("acc", " acceleration ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("tbody", "time of body ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("fbody", " frequency of body ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("tgravity", "time of gravity ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("fgravity", "frequency of gravity ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("std", " standard deviation ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("mag", " magnitude ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("sma", " signal magnitude area ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("iqr", " interquartile range ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("arcoeff", " autorregresion coefficients ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("-", " ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("\\(\\)", "", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("\\(", " of ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("\\)", " ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("jerk", " jerk ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub(",", " and ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("gyro", " gyro ", names(meanAndSTDData))
names(meanAndSTDData) <- gsub("freq", " frequency", names(meanAndSTDData))

#cleanData <- clean_names(meanAndSTDData, case="lower_camel")

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averageData <- meanAndSTDData %>%
    group_by(subject, activity) %>%
    dplyr::summarise_all(list(average = mean))

names(averageData) <- gsub("_", " ", names(averageData))
write.table(averageData, "averageData.txt", row.name=FALSE)
