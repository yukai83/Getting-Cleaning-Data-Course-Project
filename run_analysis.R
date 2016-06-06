# 1. Combine training & test datasets into one big dataset

## 1.a: Download from website the zip file
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./downloaded_data.zip")
listZip <- unzip("./downloaded_data.zip")

## 1.b: Transfer downloaded data into R
train.sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train.x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./UCI HAR Dataset/train/y_train.txt")

test.sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test.x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./UCI HAR Dataset/test/y_test.txt")


## 1.c: Combine both datasets
training_Data <- cbind(train.sub, train.y, train.x)
testing_Data <- cbind(test.sub, test.y, test.x)
Combined_Data <- rbind(training_Data, testing_Data)


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

## 2.a: Transfer the feature name into R and extract measurements
feature_Name <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)[,2]
feature_Index <- grep(("mean\\(\\)|std\\(\\)"), feature_Name)
Complete_Data <- Combined_Data[, c(1, 2, feature_Index+2)]
colnames(Complete_Data) <- c("subject", "activity", feature_Name[feature_Index])


# 3. Rename activities in the dataset to be more meaningful

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
Complete_Data$activity <- factor(Complete_Data$activity, levels = activity_labels[,1], labels = activity_labels[,2])

names(Complete_Data) <- gsub("\\()", "", names(Complete_Data))

names(Complete_Data) <- gsub("-mean", "Mean", names(Complete_Data))
names(Complete_Data) <- gsub("-std", "Std", names(Complete_Data))

names(Complete_Data) <- gsub("^t", "time", names(Complete_Data))
names(Complete_Data) <- gsub("^f", "frequence", names(Complete_Data))


# 4. Create 2nd independent tidy data set with average of each variable for each activity & subject
library(dplyr)
grouped_Data <- Complete_Data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

write.table(grouped_Data, "./Tidy_Data.txt", row.names = FALSE)