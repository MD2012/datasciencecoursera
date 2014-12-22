datasciencecoursera
===================

Getting and Cleaning Data - Course Project

run_analysis.R documentation:

# Functions
## run_analysis: Main function to execute, runs / delegates following sub-functions
### 1a Merge training and test files for subject, x and y data, using sub-functions:
#### get_subj_merged()
#### get_x_merged()
#### get_y_merged()
### 2 For x_merged extract the mean & std columns only, using sub-functions:
#### get_meanstd_feature_ids()
#### get_meanstd_feature_labels()
#### meanstd_df()
### 1b Merge extracted x_merged, y and subject data alltogether
### 4 Descript. Var Names (for the x_merged part)
### 3 Activity Names, Replace ids with real names
### Export step 4 dataset, using sub-function
#### export_data()
## ra2: Prepared subfunction for step 5 (calculatio of means for all subject,activity combinations) 


