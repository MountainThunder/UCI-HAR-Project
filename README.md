# UCI-HAR-Project
Getting and Cleaning Data Week 4 Project

###Jessica Friedman
###Getting and Cleaning Data - Coursera Course
###Week 4 Project

##Analysis

First, the files from the UCI HAR Dataset were downloaded and read.table was used to read the data into R. The features.txt file was used to assign variable names to both the x-test and x-train datasets. Labelling each variable ensured that variables in both the train and text sets would be lined up correctly when merged together.

Next, the data in y-train and y-test were added as columns in the x-train and x-test data tables, respectively, and labelled as "activity". The subject identifiers from subject_train and subject_test were added as a column and labelled as "subject".

The train and test sets were then merged together using bind_rows. Then, select, in conjuction with a regex expression, was used to retain only columns regarding mean or std data.

The activity number was replaced with descriptive names from the activity_labels.txt file.

Variable names were then amended to expand abbreviations as described in the features_info.txt file and standardize names to lower case and to use spaces in place of underscores and dashes.

Observations were grouped by subject and activity and then averaged to find the average of each variable for each activity and each subject.



