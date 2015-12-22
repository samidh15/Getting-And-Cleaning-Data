#/usr/bin/RScript

# Assumes that the code resides in the same level as "UCI HAR Dataset"


# 1. Combine the train and test set. I believe inadvertently, step 3 has also been accomplished here.
# The names of the columns have been added in this step, instead of waiting until step 3. I did not notice
# until I went to step 3. At least that is what I think.

# Read data files

df_train <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
df_test <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)

# Read the features and convert them into a vector so as to read them into colnames function of the above data frames

cnames <- as.character((read.table("UCI HAR Dataset/features.txt", sep = "", header = FALSE))[[2]])

#Following three steps can be combined into one and may be readability will not be affected

colnames(df_train) <- cnames
colnames(df_test) <- cnames
combined_df <- rbind(df_train, df_test)

#2. Extract mean and std columns


#One can combine the two following steps into one, but I kept them separate for readability purposes

df_mean_std <- subset(combined_df, select = c(grep("mean", ignore.case = TRUE, cnames)))
df_mean_std <- cbind(df_mean_std, subset(combined_df, select = c(grep("std", cnames, ignore.case = TRUE))))


#3. Descriptive activity names to name the activities in the data set

# This part has already been taken care of, in step 1 when the colnames have been added to the combined as well as individual data sets

# 4. Stupidest way to describe the labels. If this stupid way is still here, it means I did not find enough time to make lapply, replace and assign to work correctly
# and deadline was near. Bad excuse, but true.

df_mean_std <- cbind(df_mean_std, rbind(read.table("UCI HAR Dataset/train/y_train.txt"), read.table("UCI HAR Dataset/test/y_test.txt")))
names(df_mean_std)[names(df_mean_std) == "V1"] <- "activity_labels"
df_mean_std[df_mean_std[[87]] == 1,]$activity_labels <- "WALKING"
df_mean_std[df_mean_std[[87]] == 2,]$activity_labels <- "WALKING_UPSTAIRS"
df_mean_std[df_mean_std[[87]] == 3,]$activity_labels <- "WALKING_DOWNSTAIRS"
df_mean_std[df_mean_std[[87]] == 4,]$activity_labels <- "SITTING"
df_mean_std[df_mean_std[[87]] == 5,]$activity_labels <- "STANDING"
df_mean_std[df_mean_std[[87]] == 6,]$activity_labels <- "LAYING"


#5. Averaging by activity and subject

# Add subject info as the last column

df_mean_std <- cbind(df_mean_std, rbind(read.table("UCI HAR Dataset/train/subject_train.txt"), read.table("UCI HAR Dataset/test/subject_test.txt")))
names(df_mean_std)[names(df_mean_std) == "V1"] <- "subject_labels"

# Mean of each feature grouped by activity level and subject

aggdata <-aggregate(df_mean_std, by=list(df_mean_std$activity_labels,df_mean_std$subject_labels), FUN = mean, na.rm = TRUE) 

write.table(df_mean_std, file = "resultant_tidy_set.csv", sep = "," )


