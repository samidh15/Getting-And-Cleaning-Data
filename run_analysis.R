#/usr/bin/RScript

# Assumes that the code resides in the same level as "UCI HAR Dataset"


# 1. Combine the train and test set

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


