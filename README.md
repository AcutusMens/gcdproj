README
======
##### COURSERA GETTING AND CLEANING PROJECT 2 REQUIREMENTS:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

All requirements are satisfied with run_analysis.R script.

##### Requirement 1:

Multiple .txt pieces of this data set can be put together into one data table as follows:

column heading - add manually|column heading - add manually|features
-----------------------------|-----------------------------|--------
subject_train|y_train|X_train   
subject_test|y_test|X_test


data.table library is used for reading files in because of its speed. You will also see many calls to rm() in order to clean up these large chunks as we build one big dataset.

##### Requirement 4:

This is fulfilled by reading in features.txt and using the resulting vector as column headers for X_train / X_test.
We add "subject" and "activity" as column headers for subject_train / subject_test and y_train / y_test pieces respectively as you can see in the diagram above. I did not change any names from features.txt because these are about as descriptive as can be.

##### Requirement 2:

I used grep() function to extract an index of positions where any column heading contains "mean()"
or "std()". Please note that "meanFreq" measurements are not included.
Then I used dplyr library's select() function and selected only columns based on the index from above. This gave me a dataset with a "subject" column, "activity" column, and 66 other variable columns (down from 561 before).
Number of observations (rows) is the same as before (over 10,000).

##### Requirement 3:

Read in activity_labels.txt, there are 6 unique values, it is easy for a loop to call
gsub() function to substitute numbers for descriptive labels in the "activity" column.
I also used tolower() to drop case of descriptive labels.

##### Requirement 5:

I used dplyr library group_by_() function to create 180 unique combinations of subject and activity. Then I used summarise_each() to calculate the mean of each column (3 through 68) for each combination.
