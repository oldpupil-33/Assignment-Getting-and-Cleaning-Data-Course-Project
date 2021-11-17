#Download the dataset
library(dplyr)
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile = "./orginaldata.zip")
unzip("orginaldata.zip")
##Assigning all data frames
features <- read.table("./UCI HAR Dataset/features.txt")
subject_test<- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<- read.table("./UCI HAR Dataset/test/y_test.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
head(features,3)
dim(x_train)
dim(y_train)
dim(y_test)
head(y_train)
head(subject_test)
dim(features)
#Run analysis
## create merged data set for analisis
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
dim(Total_dt)
colnames(Total_dt)[1:3]
##Extracts the measurements on the SD and mean
Tidy_dt <- Total_dt %>% select(ids,activity,contains("mean"),contains("std"))
dim(Tidy_dt)
head(activities,12)
View(activities)
###Uses descriptive names for Tidy_dt
Tidy_dt$activity <- activities[Tidy_dt$activity,2]
Tidy_dt[1:3,85:88]
dim(Tidy_dt)

###Appropriately labels the data set with descriptive names
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

###create a new dity data set
NewTidy_dt <- Tidy_dt %>% group_by(ids,activity) %>% 
    summarise_all(funs(mean))
write.table(NewTidy_dt,"NewTidy_dt.txt",row.names = F)

str(NewTidy_dt)




