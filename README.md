Getting and Cleaning Data - Course Project
===================
# run_analysis.R Documentation
## HowTo Run
Simply execute run_analysis() to perform all steps 1-4, step 5 has only been prepared not finished and hence not included.
## Code Book / run_analysis Execution Plan
### run_analysis
Main function to execute, runs / delegates following sub-functions
* Step 1a: Merge training and test files for subject, x and y data, using sub-functions:
  * get_subj_merged()
  * get_x_merged()
  * get_y_merged()
* Step 2: For x_merged extract the mean & std columns only, using sub-functions:
  * get_meanstd_feature_ids()
  * get_meanstd_feature_labels()
  * meanstd_df()
* Step 1b: Merge extracted x_merged, y and subject data alltogether
* Step 4 Descript. Var Names (for the x_merged part)
* Step 3: Activity Names, Replace ids with real names
* Export step 4 dataset, using sub-function
  * export_data()
 
### ra2: Prepared subfunction for step 5 (calculatio of means for all subject,activity combinations) 


