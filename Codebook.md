---
title: "Codebook"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

###Jessica Friedman
###Getting and Cleaning Data - Coursera Course
###Week 4 Project


##Dataset origin:

==================================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

==================================================================


For more information about this dataset contact: activityrecognition@smartlab.ws


The README included in the original dataset describes how the original measurements were obtained. 

##Variables:


1. subject

* Range 1-30, each number represents a subject who participated in the study. Subject data was obtained from the subject_test.txt and subject_train.txt files and joined with the x-test and t-train data using bind_cols

2. activity

* This variable describes the activity the subject was doing when measurements were taken.
Values include: 

    WALKING

    WALKING_UPSTAIRS

    WALKING_DOWNSTAIRS

    SITTING

    STANDING

    LAYING

* These values were obtained by mapping the values in activity_labels.txt with original data marked with 1-6 to identify activity in both train and test data.


3-88: Average of Mean and STD Measurements

* Variable that matched regex descriptor ".\*([Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]).\*" were retained in this tidy data set.
* The features.txt file lists variable names. My transformation uses these variable names, but expands abbreviations as described in the features_info.txt file and standardized names to lower case and to use spaces in place of underscores and dashes.
* Observations were grouped by subject and activity and mean() was used to find the average of each variable for each activity and each subject.




