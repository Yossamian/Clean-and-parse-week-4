#Clean and parse final project

#Packages
library(sqldf)
library(dplyr)

#Download, unzip file to correct directory
fileloc<-"./R/Data/samsung.zip"
if(!file.exists(fileloc)){
        Url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(Url, destfile=fileloc, method="curl")
        unzip(fileloc, exdir="./R/Data")
}


#Load test set info
xtestloc<-"./R/Data/UCI HAR Dataset/test/X_test.txt"
ytestloc<-"./R/Data/UCI HAR Dataset/test/y_test.txt"
if (!exists("x_test")){
        x_test<-read.table(xtestloc)
}
if (!exists("ytest")){
        y_test<-read.table(ytestloc)   
}

#Load train set info
xtrainloc<-"./R/Data/UCI HAR Dataset/train/X_train.txt"
ytrainloc<-"./R/Data/UCI HAR Dataset/train/y_train.txt"
if (!exists("x_train")) {
        x_train<-read.table(xtrainloc) 
}
if (!exists("y_train")){
        y_train<-read.table(ytrainloc)    
}

#Load feature vector (561 features)
featloc<-"./R/Data/UCI HAR Dataset/features.txt"
feat<-read.table(featloc, sep=" ")
#Select important features (mean and std)
key_features<-sqldf("SELECT * FROM feat WHERE feat.V2 LIKE '%mean()%' OR feat.V2 LIKE '%std()%'")
features<-feat[,2]

#Load subject info
subj_trainloc<-"./R/Data/UCI HAR Dataset/train/subject_train.txt"
subj_testloc<-"./R/Data/UCI HAR Dataset/test/subject_test.txt"
subj_train<-read.table(subj_trainloc)
subj_test<-read.table(subj_testloc)

#Create full datasets (test + train)
full_labels<-rbind(y_train, y_test)
full_features<-rbind(x_train, x_test)
full_subjects<-rbind(subj_train, subj_test)
names(full_labels)<-"number_label"
names(full_features)<-feat[,2]
names(full_subjects)<-"subject_id"
#Select only relevant features from feature dataset (mean and std)
full_features<-full_features[,key_features$V2]

#Create df for label activity names
activityloc<-"./R/Data/UCI HAR Dataset/activity_labels.txt"
activity<-read.table(activityloc, sep=" ")

#Adjust label df
full_labels_detailed<-sqldf("SELECT * FROM full_labels JOIN activity ON full_labels.number_label=activity.V1")
full_labels_detailed<-select(full_labels_detailed, V2)
names(full_labels_detailed)<-"activity_label"

#Combine to create full dataset (labels, subjects, features)
#full_df answers questions #1-4 of the project
full_df<-cbind(full_labels_detailed, full_subjects, full_features)

#Split full_df by subject, activity 
split_df<- group_by(full_df, subject_id, activity_label)
#Summarize all reamining columns with mean
avg<-summarise_all(split_df, mean)
#Output result as dataset
#(30 subjects)x(6 activities)=180 rows
avg_full_df<-as.data.frame(a)

#Write final file outpt
outputloc="./R/R_scripts/Cleaning and Parsing Data/Week4Proj/Clean-and-parse-week-4/tidy.csv"
write.csv(avg_full_df, file=outputloc)

                  