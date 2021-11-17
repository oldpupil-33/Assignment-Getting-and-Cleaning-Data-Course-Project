---
title: "CodeBook"
author: "Jun Yue"
date: "2021/11/16"
output: pdf_document
---
1.Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

```{r setup, include=FALSE}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile = "./orginaldata.zip")
unzip("orginaldata.zip")
```

2.Assign each data to variables;

```{r}
features <- read.table("./UCI HAR Dataset/features.txt")
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./UCI HAR Dataset/test/y_test.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
```

3.Merges the training and the test sets to create one data set.Total_dt contais all the data you need:
   test subjects being observed
   recorded features test data
   test data of activities’code labels
   train data of volunteer subjects being observed
   recorded features train data
   train data of activities’code labels
   activities: performed when the corresponding measurements     were taken and its codes (labels)
   each measurement
   -ids:the code of the subject.
   -activity:the name of the activity performed by the subject              when measurements were taken:
             1)walking
             2)walking upstairs
             3)walking downstairs
             4)sitting
             5)standing
   -column 3:88,total 85 measurements
   -
```{r}
colnames(x_train) <- features$V2
colnames(x_test) <- features$V2
x_dt <- rbind(x_train,x_test)
colnames(y_test) <- "activity"
colnames(y_train) <- "activity"
y_dt <- rbind(y_train,y_test)
colnames(subject_test) <- "ids"
colnames(subject_train) <- "ids"
subject <- rbind(subject_train,subject_test)
Total_dt <- cbind(subject,y_dt,x_dt)
```
4.Extracts only the measurements on the mean and standard deviation for each measuremen
```{r}
Tidy_dt <- Total_dt %>% select(ids,activity,contains("mean"),contains("std"))

```
5.Uses descriptive activity names to name the activities in the data set
```{r}
Tidy_dt$activity <- activities[Tidy_dt$activity,2]
```
6.Appropriately labels the data set with descriptive variable names
```{r}
names(Tidy_dt) <- gsub("Acc","Accelerometer",names(Tidy_dt))
Tidy_dt[1:2,1:5]
names(Tidy_dt) <- gsub("Gyro","Gyroscope",names(Tidy_dt))
names(Tidy_dt) <- gsub("BodyBody","Body",names(Tidy_dt))
names(Tidy_dt) <- gsub("Mag","Magnitude",names(Tidy_dt))
names(Tidy_dt) <- gsub("^t","Time",names(Tidy_dt))
names(Tidy_dt) <- gsub("^f","Frequency",names(Tidy_dt))
names(Tidy_dt) <- gsub("tBody","TimeBody",names(Tidy_dt))
names(Tidy_dt) <- gsub("-mean()","Mean",names(Tidy_dt))
names(Tidy_dt) <- gsub("-std()","STD",names(Tidy_dt))
names(Tidy_dt) <- gsub("-freq()","frequency",names(Tidy_dt))
names(Tidy_dt) <- gsub("angle","Angle",names(Tidy_dt))
names(Tidy_dt) <- gsub("gravity","Gravity",names(Tidy_dt))
```
7.From the previous Tidy_dt, creates a second, independent tidy data set with the average of each variable for each activity and each subject
```{r}
NewTidy_dt <- Tidy_dt %>% group_by(ids,activity) %>% 
    summarise_all(funs(mean))
write.table(NewTidy_dt,"NewTidy_dt.txt",row.names = F)
```

