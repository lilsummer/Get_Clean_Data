getcleandata
============

GetCleanData

##This is a readme file for run_analysis.R

###How I processed the data
    run_analysis.R is the script for processing data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    Basically, it takes the raw data and do the following steps
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
###What assumptions I made
    According to the readme.txt in the raw dataset, there have been several assumptions made as follows
    * Data file named "Inertial signals" is not useful for the data processing.
    * X is the measurement value
    * Y is the subject label for X
    * Features.txt is the activity label. It is related with activity_labels.txt
    
###Why I did things a certain way
####Step2: extracts only the measurement on the mean and standard deviation
    In this step, I matched all the column names by "mean" and "std" in a non-case-sensitive way.

####Step5: Create a second, independent tidy data set 
    In this step, I use melt and cast in reshape library.
        ##melt the data by subject and activity
		X.new2=melt(X.new,id.vars=c('subject','activity'))
		
		##cast the data frame
		X.new3=cast(data=X.new2,fun=mean)
	Final dataset is X.new3, there are 180 rows and 88 columns in the data.
		
###How and where did I obtain original data
    The original dataset was downloaded from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
    Unzip the file before use.
