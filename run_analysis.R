## Script to perform analysis on the collected data as a part of Data Cleaning course project.
## Script performs the following tasks:
## - Collect the project data
## - Merge the training and test data sets into one data set
## - Extracts the measurements on the mean and standard deviation for each measurement
## - Update the activity variable/column to store the descriptive activity names instead of activity id
## - Update the data set labels with descriptive variable name
## - Generate the tidy data set

## Script is created on Linux machine
## Description:    CentOS Linux release 7.2.1511 (Core)
## 

## load the dplyr library
library(dplyr)

## Collect the project data
## If "data" folder is not there in the current woring directory, then create it. 
if(!file.exists("Samsung data")){
	## Data directory doesn't exist, creating the directory
	dir.create("Samsung data")
}

## Download the project data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="./Samsung data/dataset.zip")

## Extract the downloaded Zip
unzip("./Samsung data/dataset.zip", exdir="./Samsung data/")

## Project Data collected

## Read the different data/text files

## Read the features list
features <- read.table("./Samsung data/UCI HAR Dataset/features.txt")

## Read the activity labels list
activities <- read.table("./Samsung data/UCI HAR Dataset/activity_labels.txt")

## Read Training Data Sets
## Read Training Subjects list
subjecttrain <- read.table("./Samsung data/UCI HAR Dataset/train/subject_train.txt")

## Read Training Activities list
actvitytrain <- read.table("./Samsung data/UCI HAR Dataset/train/y_train.txt")

## Read Training variables list
variablestrain <- read.table("./Samsung data/UCI HAR Dataset/train/X_train.txt")

## Read Test Data Sets
## Read Test Subjects list
subjecttest <- read.table("./Samsung data/UCI HAR Dataset/test/subject_test.txt")

## Read Test Activities list
actvitytest <- read.table("./Samsung data/UCI HAR Dataset/test/y_test.txt")

## Read Test variables list
variablestest <- read.table("./Samsung data/UCI HAR Dataset/test/X_test.txt")


## Merge training and test data sets into single data set

## Merge different training data sets into single training data set
testdata <- cbind(subjecttrain,  actvitytrain, variablestrain)

## Merge different test data sets into single test data set
trainingdata <- cbind(subjecttest,  actvitytest, variablestest)

## Merge training and test data sets into single data set
dataset <- rbind(testdata, 	trainingdata)

## Extracts the measurements on the mean and standard deviation for each measurement

## Identify the column index of the mean and standard deviation for each variables/measurements
variablesIndex <- features[grep("\\b-std()|-mean()\\b", features$V2),]

## Cleaning variables name (removing '(' , ')' , '-' with ''
variablesIndex$V3 <- gsub("[\\(\\)-]", "", variablesIndex$V2)
#variablesIndex$V3 <- gsub("[-]", ".", variablesIndex$V3)

 
## Extract the required column
## Added 2 to variablesIndex as 2 columns have been added before the measurements/variables column
trimmeddataset <- dataset[,c(1,2,variablesIndex$V1 + 2)]

##Assign Column names to trimmeddataset
colnames(trimmeddataset) <- c("volunteer", "activity", tolower(as.vector(variablesIndex$V3)))

## Update the activity variable/column to store the descriptive activity names instead of activity id
trimmeddataset$activity <- activities[trimmeddataset$activity,]$V2


## Tidy data set creation
## Calculate average/mean of each variables/measurements after grouping by activity and volunteer
tidydata <- trimmeddataset %>% group_by(activity, volunteer) %>% summarise_each(funs(mean))

#Save the data frame into file
write.table(tidydata, file="./Samsung data/tidydata.txt", row.names=FALSE)
