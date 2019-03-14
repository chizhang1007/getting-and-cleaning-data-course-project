# *Getting and Cleaning Data* course project

This is the repository for the course project of Getting and Cleaning Data from Coursera.

The `run_analysis.R` script will perform the following functions:

1. Read data from the downloaded file "UCI HAR Dataset"
2. Load the information and labels for activity and feature
3. Load the data for both training and test datasets
4. Combine the training and test data, as well as combine the activity and subject data for both training and test
5. Select only columns that contain information on mean and standard deviation
6. Merge the activity and subject data with the training and test data
7. Creates a tidy dataset that only includes the mean and standard deviation values for each mesurement, subject and activity
8. Write the final result into the `tidy.txt` file
