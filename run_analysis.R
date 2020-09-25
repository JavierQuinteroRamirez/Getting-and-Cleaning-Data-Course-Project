library(dplyr)

zipFileName <- "GetClean_Project.zip"

#1 => Download and unzip de origin dataset

  #if zip file doesn't exists, download it.
if (!file.exists(zipFileName)){
  zipFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(zipFileURL, zipFileName, method="curl")
}  

  #if directory doesn't exists, unzip it.
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipFileName) 
}


#2 => Reading all needed data
activitiesLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")


#3 => Merges the training and the test sets to create one data set.
xBinded <- rbind(xTrain, xTest)
yBinded <- rbind(yTrain, yTest)
subject <- rbind(subjectTest, subjectTrain)
dataMerged <- cbind(subject, xBinded, yBinded)

#4 => Extracts only the measurements on the mean and standard deviation for each measurement. 
dataMeanStd <- dataMerged %>% select(subject, id, contains("mean"), contains("std"))

#5 => Uses descriptive activity names to name the activities in the data set
dataMeanStd$id <- activitiesLabels[dataMeanStd$id, 2]

#6=> Appropriately labels the data set with descriptive variable names. 
names(dataMeanStd)[2] = "activity"
names(dataMeanStd)<-gsub("Acc", "Accelerometer", names(dataMeanStd))
names(dataMeanStd)<-gsub("Gyro", "Gyroscope", names(dataMeanStd))
names(dataMeanStd)<-gsub("BodyBody", "Body", names(dataMeanStd))
names(dataMeanStd)<-gsub("Mag", "Magnitude", names(dataMeanStd))
names(dataMeanStd)<-gsub("^t", "Time", names(dataMeanStd))
names(dataMeanStd)<-gsub("^f", "Frequency", names(dataMeanStd))
names(dataMeanStd)<-gsub("tBody", "TimeBody", names(dataMeanStd))
names(dataMeanStd)<-gsub("-mean()", "Mean", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("-std()", "STD", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("-freq()", "Frequency", names(dataMeanStd), ignore.case = TRUE)
names(dataMeanStd)<-gsub("angle", "Angle", names(dataMeanStd))
names(dataMeanStd)<-gsub("gravity", "Gravity", names(dataMeanStd))

#7 => From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
Data <- dataMeanStd %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Data, "Data.txt", row.name=FALSE)
                      
str(Data)
                      
                      