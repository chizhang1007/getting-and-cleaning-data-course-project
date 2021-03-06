library(plyr)
library(data.table)
# read data
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
# process data
Xdata <- rbind(Xtrain, Xtest)
ydata <- rbind(ytrain, ytest)
subjectdata <- rbind(subjecttrain, subjecttest)
Xdatameanstd <- Xdata[, grep("-(mean|std)\\(\\)",features[, 2])]
names(Xdatameanstd) <- features[grep("-(mean|std)\\(\\)", features[, 2]), 2]
ydata[, 1] <- activitylabels[ydata[, 1], 2]
names(subjectdata) <- c("subject")
names(ydata) <- c("activity")
alldata <- cbind(Xdatameanstd, ydata, subjectdata)
names(alldata) <- make.names(names(alldata))
names(alldata) <- gsub('Acc', "Acceleration", names(alldata))
names(alldata) <- gsub('GyroJerk', "AngularAccerlation", names(alldata))
names(alldata) <- gsub('Gyro', "AngularSpeed", names(alldata))
names(alldata) <- gsub('Mag', "Magnitude", names(alldata))
names(alldata) <- gsub('^t', "TimeDomain", names(alldata))
names(alldata) <- gsub('^f', "FrequencyDomain", names(alldata))
names(alldata) <- gsub('\\.mean', ".Mean", names(alldata))
names(alldata) <- gsub('\\.std', ".StandardDeviation", names(alldata))
names(alldata) <- gsub('Freq\\.', "Frequency.", names(alldata))
names(alldata) <- gsub('Freq$', "Frequency", names(alldata))
finaldataset <- aggregate(. ~subject + activity, alldata, mean)
finaldataset <- finaldataset[order(finaldataset$subject, finaldataset$activity), ]
write.table(finaldataset, file = "tidydata.txt", row.names = FALSE)