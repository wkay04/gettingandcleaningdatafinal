---
title: "Getting and Cleaning Data Final Project Readme"
author: "William Kay"
date: "6/14/2020"
output:
  html_document:
    keep_md: yes
---


This project was created for the [Getting and Cleaning Data course](https://www.coursera.org/learn/data-cleaning/home/welcome) offered by Johns Hopkins University through Coursera. All data were sourced from the [UCI Machine Learning Repository's](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) Human Activity Recognition Using Smartphones Data Set. 


Raw data were downloaded directly from the coursera project page.For additional notes on the raw data files please see the original [data set description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

To create the tidy dataset please run the [run_analysis.R](./run_analysis.R). This file should download the data directly into your working directory, clean it, and create a file called "final_output.txt"

The run_analysis.R script does the following (pulled directly from the course website)

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the 6. average of each variable for each activity and each subject.

In order to run the script please ensure that the dplyr and reshape2 packages are installed. 

For a description of variables please see the [codebook](./codebook.rmd)




