setwd("C:/Users/Arijit Kumar/Desktop/Coursera/Getting_n_Cleaning_Data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

library(dplyr)

# Importing the files
activity_labels <-read.table("./activity_labels.txt")
activity_labels # Gives the activity

features <-read.table("./features.txt")
head(features) # Gives the stat being measured

subject_test <-read.table("./test/subject_test.txt")
head(subject_test) # has 30% of the 30 subj
names(subject_test) <- "StudentID"
  
X_test <-read.table("./test/X_test.txt")
names(X_test) <- feature_name

y_test <- read.table("./test/y_test.txt")
head(y_test)
names(y_test) <- "Activity"

subject_train <-read.table("./train/subject_train.txt")
head(subject_train) # has 70% of the 30 subj
names(subject_train) <- "StudentID"

X_train <-read.table("./train/X_train.txt")
names(X_train) <- feature_name

y_train <- read.table("./train/y_train.txt")
head(y_train)
names(y_train) <- "Activity"

# Merging the Test files
test_final <- cbind(subject_test,y_test,X_test)

# Merging the Train files
train_final <- cbind(subject_train,y_train,X_train)

# Q1. Merging the Test and Train Datasets to create a single table
Merge_data <- rbind(train_final,test_final)

# Q2. Extract only Mean and STD columns
dat<-Merge_data[,grepl("mean()|std()",colnames(Merge_data))]
Merge_data2 <- tbl_df(dat)
Merge_data_3 <- select(Merge_data2,contains("mean()"),contains("std()"))
subj_acti <- Merge_data[,1:2]

# Final merged dataset having only StudentID, Activity, Mean and STD vars
Merge_data_final <- cbind(subj_acti,Merge_data_3)

Q3. # Renaming The Activity col
Merge_data_final$Activity <- as.factor(activity_labels$V2[Merge_data_final$Activity])

Merge_data_final2 <- tbl_df(Merge_data_final)
Merge_data_final2$StudentID <- as.factor(Merge_data_final2$StudentID)

# Q5. Independant Tidy Dataset with the average of each variable for each activity and each subject
tidy_table <- Merge_data_final2 %>% group_by(StudentID,Activity) %>% summarise_each(funs(mean))

# Write the table to txt format
write.table(tidy_table,"./tidy_table.txt",row.name=FALSE)

# Recheckig to confirm the tidy dataset
test <- read.table("./tidy_table.txt")







