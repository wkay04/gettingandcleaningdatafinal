
library(dplyr)
library(reshape2)
download.file(
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
        "datasets.zip"
)
unzip("datasets.zip")
path <- paste(getwd(), "/UCI HAR Dataset/", sep = "")
merge_and_clean <- function(testortrain) {
        var_names <- read.table(paste(path, "features.txt", sep = ""))
        activity_labels <-
                read.table(paste(path, "activity_labels.txt", sep = ""))
        var_names <- var_names[, 2]
        values <-
                read.table(paste(path, testortrain, "/X_", testortrain, ".txt", sep = ""),
                           col.names = var_names)
        subject <-
                read.table(paste(
                        path,
                        testortrain,
                        "/subject_",
                        testortrain,
                        ".txt",
                        sep = ""
                ))
        
        names(subject)[1] <- "subject_ID"
        activity <-
                read.table(paste(path, testortrain, "/Y_", testortrain, ".txt", sep = ""))
        names(activity)[1] <- "activity_ID"
        activity$rownum <- rownames(activity)
        values$rownum <- rownames(values)
        subject$rownum <- rownames(subject)
        full <- full_join(activity, values, by = "rownum")
        full <- full_join(full, values, by = "rownum")
        full <- full_join(full, subject, by = "rownum")
        subset <-
                select(full,
                       grep(
                               "mean|std|subject_ID|rownum",
                               names(full),
                               ignore.case = TRUE
                       ))
        names(activity_labels)[1] <- "value"
        names(activity_labels)[2] <- "label"
        names(activity)[1] <- "value"
        activity <- activity %>%
                left_join(activity_labels, by = "value")
        subset <- left_join(subset, activity, by = "rownum")
        subset <- select(subset, !(rownum))
        
        return(subset)
}
test <- merge_and_clean("test")
train <- merge_and_clean("train")
merged <- rbind(test, train)
merged <- subset(merged, select = -value)
merged <- melt(merged, id.vars = c("subject_ID", "label"))

merged <- group_by(merged, subject_ID)
merged <- group_by(merged, label, .add = TRUE)
merged <- group_by(merged, variable, .add = TRUE)

final <- summarise_all(merged, mean)
names(final)[2] <- "activity"
names(final)[4] <- "mean"
write.table(final, file = "final_output.txt", row.names = FALSE)
