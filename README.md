# Data Cleaning

The repository contains the data cleaning project files related to operations performed on the project data set. The operations performed on the downloaded dataset are merging, renaming, subsetting, and creating tidy data set.

The repository includes following files:
* README.md
* CodeBook.md: Details about the variables and steps used for cleaning the measurements name
* run_analysis.R: R script to perform operations on data set as required. It initially downloads the dataset, operates on the downloaded dataset, and creates the tidy data set.

Each record in the data set includes:
* Activity label
* Volunteer ID
* Set of measurements

Tidy data set can be created by executing the script `run_analysis.R`.

__Note__
* Script requires the dplyr package to be installed on the system