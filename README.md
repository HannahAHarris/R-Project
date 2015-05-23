# R-Project
R Project for Getting and Cleaning Data Course on Coursera.

The overall objective for this project is to:
  "create one R script called run_analysis.R that merges the test and training sets, sets the activity names and labels the    variables, extracts only the means and standard deviations and then produces an independent tidy dataset of the the average   of each variable for each activity and each subject."
  
NOTE: This task was completed successfully, however the steps were not executed in the exact order above. See the explaination below for details. 

First, you must download the Sumsung data 
(available at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it to your working directory.

The R script "run_analysis.R" does the following:

1.Creates a complete test dataset with appropriate column names by doing the following:
  a. reads the test dataset and adds headers to the dataset using the test features data
  b. reads the test labels dataset and creates a header for this dataset  
  c. adds the test labels dataset to the test dataset using cbind
  d. reads the test label names dataset and merges this dataset with the labels dataset on the header "activity.number"
  e. adds the new label dataset to the test dataset using cbind
  f. reads the test subjects dataset, gives the data a header and adds this to the test dataset using cbind

2.Creates a complete training dataset with appropriate column names by repeating the above for the training data

3."merges" the two complete datasets (test and training) using rbind

4.creates a new dataset with only the means and standard deviations for each measurement using the grep function

5.creates a tidy dataset called "tidydata" from the dataset in #4 by using the aggregate function to produce a table with the average of each variable for each activity and each subject. The headers for each measurement variable are re-named with 'Average.of' to illustrate the nature of the data.

NOTE: See the codebook for details on each of the variables contained in the "tidydata".
