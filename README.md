# Getting and Cleaning Data
## Course Project

### Data

> "Human Activity Recognition Using Smartphones Dataset"
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script looks up for **UCI HAR Dataset** on the working directory, if not found downloads the file to /data and unzip it.

### Requirements

 + R
 + R Packages: `reshape2` `data.table`
 + Internet connection (in case doesn't find folder)

### Steps

 1. Open R (R Studio or a terminal)
 2. Set working directory to "UCI HAR Dataset" parent folder if you already have it unzipped (Or use your normal working directory).
 3. Source `run_analysis.R`

### How it works

run_analysis.R
 + Sets /data folder
 + Downloads zip if folder or zip not found
 + Extracts files to /data
 + Reads training and test files and saves them
 + Reads feature names and set column names
 + Combine training and test files (rows)
 + Merges and creates an unified data set
 + Subsets mean and standard deviation columns
 + Sets descriptive activity names
 + Cleans variable names
 + Removes column activityId used to merge
 + Melts data set
 + Creates an independent tidy data set (avg of each variable)
 + Saves tidy data

Codebook contains:
 + Information about the experiment study
 + List of files used to create the tidy data
 + Description of variables
 + Information about transformations and summary choices
