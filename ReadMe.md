---
title: "ReadMe"
author: "Jun Yue"
date: "2021/11/16"
output: html_document
---
  This repository is a submission for Getting and Data course project. The run_analisis.R running on Human Activity recognition dataset
  
  ## Dataset
```{r setup, include=FALSE}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

  ## Files:
    1)CodeBook.md a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data .
    2) run_analysis.R that does the following. 

      2.1:Merges the training and the test sets to create one data set.

      2.2:Extracts only the measurements on the mean and standard deviation for each measurement. 

      2.3:Uses descriptive activity names to name the activities in the data set

      2.4:Appropriately labels the data set with descriptive variable names. 

      2.5:From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

   3)NewTidy_dt.txt is the exported data with the average of each variable for each activity and each subject.

