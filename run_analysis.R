

// Download the file and put the file in the data folder

  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

  unzip(zipfile="./data/Dataset.zip",exdir="./data")

  path_rf <- file.path("./data" , "UCI HAR Dataset")
  files<-list.files(path_rf, recursive=TRUE)
  files

// Read the data from the files into the variables
// Read the activity files

  dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
