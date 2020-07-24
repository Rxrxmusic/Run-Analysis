library(dplyr)

filename <- 'run_analysis.zip'

if (!file.exists(filename)){
  fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  download.file(fileURL, filename, method = 'curl')
}

if (!file.exists('UCI HAR Dataset')){
  unzip(filename)
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

X <- rbind(xTrain, xTest)
Y <- rbind(yTrain, yTest)
Subject <- rbind(subjectTrain, subjectTest)
Merged <- cbind(Subject, Y, X)

Tidy <- Merged %>% select(subject, code, contains('mean'), contains('std'))

Tidy$code <- activities[Tidy$code, 2]

names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "STD", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

Final <- Tidy %>%
  group_by(subject, activity) %>%
  summarize_all(list(mean))
write.table(Final, 'Final.txt', row.names=FALSE)