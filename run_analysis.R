##create one R script called run_analysis.R that merges the test and training sets, sets the activity names and labels the variables, extracts only the means and standard deviations and then produces an independent tidy dataset of the the average of each variable for each activity and each subject.

#read in test set 
tdata = read.table("C:\\Rdata\\UCI HAR Dataset\\test\\X_test.txt",header=F)
#establish number of rows and columns in training set
##561 columns, 2947 rows##

#read 'features' data
features = read.table("C:/Rdata/UCI HAR Dataset/features.txt")
head(features)
#add headers to tdata with second column of 'features' dataset
colnames(tdata) = features$V2
head(tdata, n=1)

#read 'labels' data
labels = read.table("C:\\Rdata\\UCI HAR Dataset\\test\\y_test.txt")
#give 'labels' data a header
colnames(labels) = 'activity.number'
head(labels)

#read 'label names' data
labelnames = read.table("C:\\Rdata\\UCI HAR Dataset\\activity_labels.txt")
labelnames
#rename columns so label names can be merged with labels
colnames(labelnames) = c("activity.number","activity.name")

#merge labels and label names to create 'newlabels'
newlabels = merge(labels,labelnames, by = 'activity.number')
head(newlabels)
tail(newlabels)

#create new dataset by column binding 'newlabels' tdata
tdata2 = cbind(tdata,newlabels)
head(tdata2)

#read subject dataset
subject = read.table("C:\\Rdata\\UCI HAR Dataset\\test\\subject_test.txt")
head(subject)
#give header to subject dataset
colnames(subject) = "subject"
head(subject)
#create new dataset by column binding 'subject' with 'tdata2'
tdata3 = cbind(tdata2,subject)
head(tdata3)

##REPEAT PROCESS FOR TRAINING SET

#read in training set 
trdata = read.table("C:/Rdata/UCI HAR Dataset/train/X_train.txt",header=F)
#establish number of rows and columns in training set
##561 columns, 7352 rows##

#read 'features' data
features = read.table("C:/Rdata/UCI HAR Dataset/features.txt")
head(features)
#add headers to trdata with second column of 'features' dataset
colnames(trdata) = features$V2
head(trdata, n=1)

#read 'labels' data
labels = read.table("C:\\Rdata\\UCI HAR Dataset\\train\\y_train.txt")
#give 'labels' data a header
colnames(labels) = 'activity.number'
head(labels)

#read 'label names' data
labelnames = read.table("C:\\Rdata\\UCI HAR Dataset\\activity_labels.txt")
labelnames
#rename columns so label names can be merged with labels
colnames(labelnames) = c("activity.number","activity.name")

#merge labels and label names to create 'newlabels'
newlabels = merge(labels,labelnames, by = 'activity.number')
head(newlabels)
tail(newlabels)

#create new dataset by column binding 'newlabels' trdata
trdata2 = cbind(trdata,newlabels)
head(trdata2)

#read subject dataset
subject = read.table("C:\\Rdata\\UCI HAR Dataset\\train\\subject_train.txt")
head(subject)
#give header to subject dataset
colnames(subject) = "subject"
head(subject)
#create new dataset by column binding 'subject' with 'trdata2'
trdata3 = cbind(trdata2,subject)
head(trdata3)

## 'Merge' new training and test sets to create one data set by using rbind
newdata= rbind(trdata3,tdata3)
head(newdata)
tail(newdata)

## Extract only the measurements on the mean and standard deviation for each measurement. 
newdata2 = (newdata[,grep("mean|std", colnames(newdata))])
head(newdata2)
newdata3 = newdata[,c("activity.name","subject")]
head(newdata3)
tail(newdata3)
data = cbind(newdata3, newdata2)
head(data)

##from 'data', create a second, independent tidy data set with the average of each variable for each activity and each subject.
data[,1] = as.character(data[,1])
data[,2] = as.character(data[,2])

tidydata = aggregate(. ~  activity.name + subject, data = data,FUN=mean )
colnames(tidydata)[3:length(colnames(tidydata))] = paste0('Average.of.', colnames(tidydata)[3:length(colnames(tidydata))])
tidydata = tidydata[order(tidydata$activity.name,tidydata$subject),]
head(tidydata)
