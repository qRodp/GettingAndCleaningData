#load packages
packages <- c("data.table", "reshape2", "plyr")
sapply(packages, require, character.only=TRUE, quietly=TRUE)

#set path
path <- getwd()
path

#Get the data. Download the file. Put it in the Data folder.
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "Dataset.zip"
if (!file.exists(path)) {dir.create(path)}
download.file(url, file.path(path, f))

#Unzip the file
executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
parameters <- "x"
cmd <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", file.path(path, f), "\""))
system(cmd)

#The archive put the files in a folder named UCI HAR Dataset. Set this folder as the input path. List the files here
pathIn <- file.path(path, "UCI HAR Dataset")
list.files(pathIn, recursive=TRUE)


# Step 1
# Merge the training and test sets to create one data set
#########################################################

#read the files
x_train <- read.table(file.path(pathIn, "train", "X_train.txt"))
y_train <- read.table(file.path(pathIn, "train", "Y_train.txt"))
subject_train <- read.table(file.path(pathIn, "train", "subject_train.txt"))

x_test <- read.table(file.path(pathIn, "test" , "X_test.txt" ))
y_test <- read.table(file.path(pathIn, "test" , "Y_test.txt" ))
subject_test <- read.table(file.path(pathIn, "test" , "subject_test.txt"))

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)


# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
#######################################################################################

features <- read.table(file.path(pathIn, "features.txt"))

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]


# Step 3
# Use descriptive activity names to name the activities in the data set
#######################################################################

activities <- read.table(file.path(pathIn, "activity_labels.txt"))

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"


# Step 4
# Appropriately label the data set with descriptive variable names
##################################################################

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################

# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "tidy.txt", row.name=FALSE)

