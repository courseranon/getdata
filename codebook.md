# Codebook

## Experiment Study

The source data set was collected from an experiment realized by UCI. ["Human Activity Recognition Using Smartphones"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). In the link is their study design.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist.

## Files

The files needed to create the tidy data
 + 'features_info.txt': Shows information about the variables used on the feature vector.
 + 'features.txt': List of all features.
 + 'activity_labels.txt': Links the class labels with their activity name.
 + 'train/X_train.txt': Training set.
 + 'train/y_train.txt': Training labels.
 + 'test/X_test.txt': Test set.
 + 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

 + 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Variables

> Note: Features are normalized and bounded within [-1,1]. Therefore 
> variables [are unitless](https://class.coursera.org/getdata-010/forum/thread?thread_id=49#comment-453)

 + `subjectId ` ID of the subject who volunteered
 + `activity  ` Activity name [LAYING, SITTING, STANDING, etc...]
 + `measurements` (66 columns) are the desired measures extracted (*mean()* and *std()*) from the raw set and organized in columns, each measure has its own column.

Measurements names:
```
tBodyAcc.mean.X, tBodyAcc.mean.Y, tBodyAcc.mean.Z, tBodyAcc.std.X, 
tBodyAcc.std.Y, tBodyAcc.std.Z, tGravityAcc.mean.X, tGravityAcc.mean.Y, 
tGravityAcc.mean.Z, tGravityAcc.std.X, tGravityAcc.std.Y, tGravityAcc.std.Z, 
tBodyAccJerk.mean.X, tBodyAccJerk.mean.Y, tBodyAccJerk.mean.Z, 
tBodyAccJerk.std.X, tBodyAccJerk.std.Y, tBodyAccJerk.std.Z, tBodyGyro.mean.X, 
tBodyGyro.mean.Y, tBodyGyro.mean.Z, tBodyGyro.std.X, tBodyGyro.std.Y, 
tBodyGyro.std.Z, tBodyGyroJerk.mean.X, tBodyGyroJerk.mean.Y, 
tBodyGyroJerk.mean.Z, tBodyGyroJerk.std.X, tBodyGyroJerk.std.Y, 
tBodyGyroJerk.std.Z, tBodyAccMag.mean, tBodyAccMag.std, 
tGravityAccMag.mean, tGravityAccMag.std, tBodyAccJerkMag.mean, 
tBodyAccJerkMag.std, tBodyGyroMag.mean, tBodyGyroMag.std, 
tBodyGyroJerkMag.mean, tBodyGyroJerkMag.std, fBodyAcc.mean.X, 
fBodyAcc.mean.Y, fBodyAcc.mean.Z, fBodyAcc.std.X, fBodyAcc.std.Y, 
fBodyAcc.std.Z, fBodyAccJerk.mean.X, fBodyAccJerk.mean.Y, 
fBodyAccJerk.mean.Z, fBodyAccJerk.std.X, fBodyAccJerk.std.Y, 
fBodyAccJerk.std.Z, fBodyGyro.mean.X, fBodyGyro.mean.Y, fBodyGyro.mean.Z, 
fBodyGyro.std.X, fBodyGyro.std.Y, fBodyGyro.std.Z, fBodyAccMag.mean, 
fBodyAccMag.std, fBodyBodyAccJerkMag.mean, fBodyBodyAccJerkMag.std, 
fBodyBodyGyroMag.mean, fBodyBodyGyroMag.std, fBodyBodyGyroJerkMag.mean, 
fBodyBodyGyroJerkMag.std,
```

## Transformations

 1. Combined tranining and test data sets and merged combined files
 2. Extracted measurements for mean and standard deviation (No mean frequency)
 3. Merged `activity_labels` file to data set and used to describe activity
 4. Cleaned column names (hyphens, parenthesis are ilegal in column names)
 5. Created a tidy data set (with average of each variable for each activity and each subject)

The tidy data has 180 rows (30 volunteers x 6 activities) and 68 columns (subjectId, activity and 66 measurements).
