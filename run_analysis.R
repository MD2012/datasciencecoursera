# Assignment:
# 0. You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, 
#    independent tidy data set with the average of each variable 
#    for each activity and each subject.
run_analysis <- function() {
   
  ########################
  # 1a Merge training and test files for subject, x and y data
  subj_merged <- get_subj_merged();
  x_merged <- get_x_merged();
  y_merged <- get_y_merged();
  
  
  ########################
  # 2 For x_merged extract the mean & std columns only
  mean_std_feature_ids <- get_meanstd_feature_ids();
  mean_std_feature_labels <- get_meanstd_feature_labels();
  x_merged_extracted <- meanstd_df( x_merged , mean_std_feature_ids )
    
  
  ########################
  # 1b Merge extracted x_merged, y and subject data alltogether
  sum_cols <- ncol(subj_merged) + ncol(x_merged_extracted) + ncol(y_merged);
  sum_rows <- nrow(subj_merged);
  fully_merged <- data.frame();
  fully_merged <- cbind(subj_merged, y_merged, x_merged_extracted);
  
  
  ########################
  # 4 Descript. Var Names (for the x_merged part)
  mean_std_feature_labels <- c('Subject','Activity',mean_std_feature_labels)
  names(fully_merged) <- mean_std_feature_labels
  
  
  ########################
  # 3 Activity Names, Replace ids with real names
  acts = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
  fully_merged[,2] = acts[fully_merged[,2]]
  
  
  ########################
  # Export step 4 dataset
  resp <- export_data(fully_merged);
  
}

ra2 <- function() {
  td1 <- ra1();
  library(plyr);
  DF.mean <- ddply(td1, c("Subject","Activity"), summarize, B = sum(B))
}

get_subj_merged <- function() {
  test_path <- 'UCI HAR Dataset/test';
  train_path <- 'UCI HAR Dataset/train';
  
  subj_test_file <- paste(test_path, 'subject_test.txt', sep='/');
  subj_train_file <- paste(train_path, 'subject_train.txt', sep='/');
  
  subj_train <- read.table( subj_train_file );
  subj_test <- read.table( subj_test_file );
  
  subj_merged <- merge(subj_train, subj_test, all=TRUE);
}
get_x_merged <- function() {
  test_path <- 'UCI HAR Dataset/test';
  train_path <- 'UCI HAR Dataset/train';
  
  x_test_file <- paste(test_path, 'X_test.txt', sep='/');
  x_train_file <- paste(train_path, 'X_train.txt', sep='/');
  
  x_train <- read.table( x_train_file );
  x_test <- read.table( x_test_file );
     
  x_merged <- merge(x_train, x_test, all=TRUE);
}
get_y_merged <- function() {
  test_path <- 'UCI HAR Dataset/test';
  train_path <- 'UCI HAR Dataset/train';
  
  y_train_file <- paste(train_path, 'y_train.txt', sep='/');
  y_test_file <- paste(test_path, 'y_test.txt', sep='/');
  
  y_train <- read.table( y_train_file );
  y_test <- read.table( y_test_file );
  
  y_merged <- rbind(y_train,y_test);
}

meanstd_df <- function(odf, ids) {
  ndf <- data.frame(matrix(ncol = length(ids), nrow = nrow(odf)))
  for(i in 1:length(ids)) {
    ndf[,i] <- odf[,ids[i]]
  }
  ndf
}

get_activities <- function() {
  a <- read.table( paste('UCI HAR Dataset','activity_labels.txt',sep='/') );
  names(a) <- c('act_id','Activity');
  a
}
get_meanstd_feature_labels <- function() {
  features <- read.table( paste('UCI HAR Dataset','features.txt',sep='/') );
  v<-character()
  for(i in 1:nrow(features)) {
    row <- features[i,]
    id <- row$V1
    llabel <- row$V2
    if(grepl('-mean\\(',llabel) || grepl('-std\\(',llabel)) {
      #if(i<10) print(as.character(llabel))
      v<-c(v,as.character(llabel))
    }
  }
  v  
}

get_meanstd_feature_ids <- function() {
  features <- read.table( paste('UCI HAR Dataset','features.txt',sep='/') );
  v<-vector()
  for(i in 1:nrow(features)) {
    row <- features[i,]
    id <- row$V1
    label <- row$V2
    if(grepl('-mean\\(',label) || grepl('-std\\(',label)) {
      v<-c(v,id)
    }
  }
  v  
}

export_data <- function(dat) {
  # Please upload the tidy data set created in step 5 of the instructions. 
  # Please upload your data set as a txt file created with write.table() 
  # using row.name=FALSE (do not cut and paste a dataset directly 
  # into the text box, as this may cause errors saving your submission).
  write.table(dat, file='tidy_step4_dataset.txt', row.name=FALSE);
}
