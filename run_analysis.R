## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

merge_datasets <- function(){

    ## 1. Merges the training and the test sets to create one data set.
    
    #read in the train data sets into data frames
    x_trainData <- read.table('UCI HAR Dataset/train/X_train.txt')
    y_trainLabel <- read.table('UCI HAR Dataset/train/y_train.txt')    
    trainSubject <- read.table('UCI HAR Dataset/train/subject_train.txt')
    
    #read in the test data sets into data frames
    x_testData <-read.table('UCI HAR Dataset/test/X_test.txt')
    y_testLabel<-read.table('UCI HAR Dataset/test/y_test.txt')    
    testSubject <- read.table('UCI HAR Dataset/test/subject_test.txt')
    
    #combine the trainData and testData
    combinedData <- rbind(x_trainData,x_testData)
    
    #combine the trainLabel and testLabel
    combinedLabel <- rbind(y_trainLabel, y_testLabel)
    
    #combine the trainSubject and testSubject
    combinedSubject <- rbind(trainSubject, testSubject)
 
    
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    
    features <- read.table('UCI HAR Dataset//features.txt')
    goodFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
    combinedData <- combinedData[,goodFeatures]
    names(combinedData)<- features[goodFeatures,2]
    names(combinedData) <-gsub("\\(|\\)", "", names(combinedData))
    names(combinedData) <- tolower(names(combinedData))

    ## 3. Uses descriptive activity names to name the activities in the data set
        activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt')
        activityLabels[,2] =gsub('_','',tolower(as.character(activityLabels[,2])))
        combinedLabel[,1] = activityLabels[combinedLabel[,1],2]
        names(combinedLabel) <-'activity'
    
    ## 4. Appropriately labels the data set with descriptive variable names. 
    names(combinedSubject) <- 'subject'
    mergedSet <- (cbind(combinedSubject, combinedLabel, combinedData))
    
    write.table(mergedSet, 'tidy_data_set.txt')
    
    ## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
    ## of each variable for each activity and each subject.
        
    uniqueS = unique(combinedSubject)[,1]
    numS = length(uniqueS)
    numA = length(activityLabels[,1])
    numCols = dim(mergedSet)[2]
    resultSet = mergedSet[1:(numS*numA),]
    row = 1
    for (s in 1:numS){
        for (a in 1:numA){
            resultSet[row,1] = uniqueS[s]
            resultSet[row,2] = activityLabels[a,2]
            tmp <- mergedSet[mergedSet$subject==s & mergedSet$activity==activityLabels[a,2],]
            resultSet[row,3:numCols] <- colMeans(tmp[,3:numCols])
            row = row+1
        }
    }
    write.table(resultSet, 'tidy_data_average.txt')

}

merge_datasets()