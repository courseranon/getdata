require('data.table')
require('reshape2')

message('set data folder')
wdPath <- getwd()
dataPath <- file.path(wdPath, 'data')
if (!file.exists(dataPath)) { dir.create(dataPath) }

# check Samsung data is in your working directory
dataSetPath <- file.path(wdPath,'UCI HAR Dataset')
if (!file.exists(dataSetPath)) {
  # check on dataPath
  dataSetPath <- file.path(dataPath,'UCI HAR Dataset')
  if (!file.exists(dataSetPath)) {
    # check for zip file
    zipFile <- 'getdata-projectfiles-UCI HAR Dataset.zip'
    filePath <- file.path(dataPath, zipFile)
    # download unless exists
    if (!file.exists(filePath)) {
      zipUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
      message('downloading dataset...')
      download.file(url = zipUrl, destfile = filePath, method = 'curl')
    }
    message('unzip dataset')
    unzip(zipfile = filePath, exdir = dataPath)
  }
}

# read files
message('reading training and test files and saving them...')
# Bug related to fread when line starts with spaces https://github.com/Rdatatable/data.table/issues/956
dataTrain <- data.table(read.table(file.path(dataSetPath, 'train', 'X_train.txt'), header = F))
dataTest  <- data.table(read.table(file.path(dataSetPath, 'test', 'X_test.txt'), header = F))
activityTrain <- fread(input = file.path(dataSetPath, 'train', 'y_train.txt'), header = F)
activityTest  <- fread(input = file.path(dataSetPath, 'test', 'y_test.txt'), header = F)
subjectTrain <- fread(input = file.path(dataSetPath, 'train', 'subject_train.txt'), header = F)
subjectTest  <- fread(input = file.path(dataSetPath, 'test', 'subject_test.txt'), header = F)

message('read feature names. set column names')
features <- fread(input = file.path(dataSetPath, 'features.txt'), header = F)
setnames(dataTrain, features$V2)
setnames(dataTest, features$V2)
setnames(activityTrain, 'activityId')
setnames(activityTest, 'activityId')
setnames(subjectTest, 'subjectId')
setnames(subjectTrain, 'subjectId')

message('merge training and test data (rows)')
tmpData <- rbind(dataTrain, dataTest)
tmpActivity <- rbind(activityTrain, activityTest)
tmpSubject <- rbind(subjectTrain, subjectTest)

message('merge and create a data set (columns)')
data <- cbind(tmpSubject, tmpActivity, tmpData)
if (exists('data')) {
  remove(list = c('dataTrain', 'activityTrain', 'subjectTrain'))
  remove(list = c('dataTest', 'activityTest', 'subjectTest'))
  remove(list = c('tmpData', 'tmpActivity', 'tmpSubject'))
}

message('subset mean and standard deviation')
subsetCols <- grep('activityId|subjectId|mean\\(\\)|std\\(\\)', names(data))
data <- data[, subsetCols, with = F]

message('use descriptive activity names')
activityNames <- fread(input = file.path(dataSetPath, 'activity_labels.txt'), header = F)
setnames(activityNames, c('activityId', 'activity'))
data <- merge(data, activityNames, by = 'activityId', all.x = T)

message('clean variable names (descriptive)')
#Converts aa()-X > aa...X
#setnames(data, make.names(names(data), unique = T, allow_ = F))
setnames(data, gsub(pattern = '[()]', replacement = '', names(data)))
setnames(data, gsub(pattern='[-]', replacement='.', names(data)))

message('remove column activityId used to merge')
data <- data[, !(names(data) %in% c('activityId')), with = F]

message('melt data set')
meltDT <- melt(data = data, id.vars = c('subjectId', 'activity'))

message('create independent tidy data set')
tidyData <- dcast.data.table(data = meltDT, subjectId + activity ~ variable, mean)

message('save tidy data')
tidyFile <- file.path(dataPath, 'tidydata.txt')
write.table(tidyData, file = tidyFile, row.names = F)

message('Tidy Data filepath: ', tidyFile)
View(tidyData)
