

## Download the file and put the file in the data folder

  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

  unzip(zipfile="./data/Dataset.zip",exdir="./data")

  path_rf <- file.path("./data" , "UCI HAR Dataset")
  files<-list.files(path_rf, recursive=TRUE)
  files

## Read the data from the files into the variables
## Read the activity files

  dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

## Read the subject files
  
  dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
  dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

## Read fearures files

  dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
  dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

## Concatenate the data tables by rows

  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataActivity<- rbind(dataActivityTrain, dataActivityTest)
  dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)
  
## Set names to variables

  names(dataSubject)<-c("subject")
  names(dataActivity)<- c("activity")
  dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
  names(dataFeatures)<- dataFeaturesNames$V2

## Merge columns to get the data frame data for all data

  dataCombine <- cbind(dataSubject, dataActivity)
  data <- cbind(dataFeatures, dataCombine)

## Subset Name of Features by measurements on the mean and standard deviation

  subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

## Subset the data frame data by seleted names of Features

  selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
  data<-subset(data,select=selectedNames)

## Read activity labels

  activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

## Create a tidy data

  library(plyr);
  data2<-aggregate(. ~subject + activity, data, mean)
  data2<-data2[order(data2$subject,data2$activity),]
  write.table(data2, file = "tidy_dataset.txt",row.name=FALSE)






