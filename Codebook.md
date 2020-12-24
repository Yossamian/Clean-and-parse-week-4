Codebook
Directed to README.md for information on contents of each dataframe

#Libraries used  
-dplyr for dataframe transforms  
-sqldf for dataframe transforms  

#Dataframes loaded from relevant dataset .txt files  
-x_test<- df from X_test.txt  
-y_test<- df from y_test.txt  
-x_train<- df from X_train.txt  
-y_train<-df from y_train.txt  
-feat<- df from features.txt  
-subj_train<- df from subject_train.txt  
-subj_test<-df from subject_test.txt  
-activity<- df from activity_labels.txt  

#Results dataframes from manipulations  
-full_labels, full_features, full_subjects <- all created by combining train and test datasets (train on top)  
-full_labels_detailed<-use sqldf and dplyr.select to give this dataset the detailed activity names from activity df  
-key_features<-df to isolate mean and std from feat using sqldf  
-full_df<- TIDY DATASET: combination of subjects, labels (activity), and relevant features  

#Question 5  
-split_df<- Used dplyr group_by to split by subject, activity  
-avg<- Used dplyr summarise_all to summarize all columns with mean  
avg_full_df<- Created simple 180x68 dataframe (tidy) to see avg measurement by subject, activity  

Used write.csv to create final csv file of avg_full_df  

