README
======
### COURSERA GETTING AND CLEANING PROJECT 2 REQUIREMENTS:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

All requirements are satisfied with run_analysis.R script.

## Requirement 1:

Multiple .txt pieces of this data set can be put together into one data table as follows:

1. X_train
2. y_train
3. subject_train
4. X_test
5. y_test
6. subject_test
7. features
A. - not an actual file but indicates where a column heading must be created manually


A|A|7
3|2|1   
6|5|4


data.table library is used for reading files in because of its speed. Nevertheless you will see many calls to rm() in order to clean up these large chunks as we build one big dataset.

## Requirement 4:

This is fulfilled by reading in features.txt and using the resulting vector as column names.
We add "subject" and "activity" as column names for the appropriate columns.

## Requirement 2:

I used grep() function to extract an index of positions where any column heading contains "mean()"
or "std()". Please note that "meanFreq" measurements are not included.
Then use dplyr library's select() function and select only columns based on the index from above.

## Requirement 3:

Read in activity_labels.txt, there aren't many unique values, it is easy for a loop to call
gsub() function to substitute numbers for descriptive labels in the "activity" column.

## Requirement 5:

I used dplyr library group_by_() and summarise_each() to create a 180 unique combinations of subject and activity and then calculate the mean of each variable for each combination.
