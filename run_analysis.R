setwd("!!!SET YOUR WORKING DIRECTORY HERE!!!")

## Downloading archive file provided in the assignment
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Archive <- "UCI_HAR_Dataset.zip"
download.file(URL, destfile)

## Reading overall information
### Reading activity labels table and naming the columns of resulting data frame
activity_labels <- read.table(unz(Archive, "UCI HAR Dataset/activity_labels.txt"))
names(activity_labels) <- c("Activity.ID", "Activity.Name")
### Reading feature labels table and naming the columns of resulting data frame
features <- read.table(unz(Archive, "UCI HAR Dataset/features.txt"), sep = " ")
names(features) <- c("Feature.ID", "Feature.Name")

## Creating training dataset
### Reading subjects' activities (training set)
y_train_numeric <- read.table(unz(Archive, "UCI HAR Dataset/train/y_train.txt"))
### Creating the 'y_train' factor variable representing activity type
y_train <- factor(y_train_numeric$V1, levels = c(1:6), labels = activity_labels$Activity.Name)
### Reading subjects' IDs (training set) 
subject_train <- read.table(unz(Archive, "UCI HAR Dataset/train/subject_train.txt"))
### Binding subject IDs and their activities into the 'subj_act_train' data frame, naming its columns (training set)
subj_act_train <- cbind(y_train, subject_train)
names(subj_act_train) <- c("Activity.ID", "Subject.ID")
### Reading observations (training set)
x_train <- read.table(unz(Archive, "UCI HAR Dataset/train/X_train.txt"))
### Naming variables according to the 'features' variable
names(x_train) <- features$Feature.Name
### Finally, creating the training dataset with subject ID, activity ID and corresponding observation
training_dataset <- cbind(subj_act_train, x_train)

## Creating test dataset
### Reading subjects' activities (test set)
y_test_numeric <- read.table(unz(Archive, "UCI HAR Dataset/test/y_test.txt"))
### Creating the 'y_test' factor variable representing activity type
y_test <- factor(y_test_numeric$V1, levels = c(1:6), labels = activity_labels$Activity.Name)
### Reading subjects' IDs (test set) 
subject_test <- read.table(unz(Archive, "UCI HAR Dataset/test/subject_test.txt"))
### Binding subject IDs and their activities into the 'subj_act_test' data frame, naming its columns (training set)
subj_act_test <- cbind(y_test, subject_test)
names(subj_act_test) <- c("Activity.ID", "Subject.ID")
### Reading observations (test set)
x_test <- read.table(unz(Archive, "UCI HAR Dataset/test/X_test.txt"))
### Naming variables according to the 'features' variable
names(x_test) <- features$Feature.Name
### Finally, creating the training dataset with subject ID, activity ID and corresponding observation
test_dataset <- cbind(subj_act_test, x_test)

## Binding datasets together
dataset <- rbind(training_dataset,test_dataset)
nrow(dataset)

## Analyzing feature names in order to find indices of variables containing measurements on the mean and standard deviation
### Regular expression "*mean\\()|*std\\()" allows to find strings containing substrings "mean()" or "std()" following any number of symbols
mean_std_variable_indices <- grep("*mean\\()|*std\\()", features[,2], value = F)
### Adding the number of additional features (activity and subject IDs) which have been included in the dataset
mean_std_variable_indices <- mean_std_variable_indices + 2

## Extracting corresponding data from the dataset (i.e. variable subsetting)
new_dataset <- dataset[,c(1,2,mean_std_variable_indices)]

## Creating an independent tidy data set with the average of each variable for each activity and each subject.
### To run this code the "reshape2" package is required!
install.packages("reshape2")
library("reshape2")
melt <- melt(new_dataset,(id.vars=c("Activity.ID","Subject.ID")))
tidy <- dcast(melt, Activity.ID + Subject.ID ~ variable, mean)
write.table(tidy, file = "tidy.txt", sep = ",")


