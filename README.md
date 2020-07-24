Getting and Cleaning Data Course Project

This repository is Rxrxmusic's assignment for the Getting and Cleaning Data Course Project. It contains the codebook and code for running a dataset analysis for Human Activity. Below is the dataset:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files include:
  
  Codebook.md: describes variables, data, and transformations to tidy up the data

  run_analysis.R: code for executing data analysis. Does the following:
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity         and each subject.
    
  Final.txt: final tidy data, output of run_analysis.R.
