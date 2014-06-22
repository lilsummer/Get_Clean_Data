
###this is the script to process data in the course project


###Merge training and test data set
	rm(list=ls())

	### get test data set
		setwd("../UCI HAR Dataset/test")
		X.test=read.table('X_test.txt')
		Y.test=read.table('Y_test.txt')
		sub.test=read.table('subject_test.txt')

	###get training data set
		setwd("..")
		setwd("../UCI HAR Dataset/train")
		X.train=read.table('X_train.txt')
		Y.train=read.table('Y_train.txt')
		sub.train=read.table('subject_train.txt')
		
	##merge two data set
		X=rbind(X.test,X.train)
		Y=rbind(Y.test,Y.train)

		
###Extracts only the measurements on the mean and standard deviation for each measurement.
	### get features list
		setwd("..")
		feature.List=read.table('features.txt')
	
	###fine the 'mean' and 'std' in the feature.List, and return a list of numbers of column for extracting data
		feature.List$V2=as.character(feature.List$V2)
		a="mean"
		b="std"
		number.List.mean=c()
		number.List.sd=c()
			for (i in 1:length(feature.List$V2)) {
				if (grepl(a,feature.List$V2[i], ignore.case=TRUE)==TRUE) {
					number.List.mean=c(number.List.mean,i)
					}
				if (grepl(b,feature.List$V2[i],ignore.case=TRUE)==TRUE) {
					number.List.sd=c(number.List.sd,i)
					}
			}
		number.List=c(number.List.mean,number.List.sd)
		number.List=sort(number.List)
		X.new=c()
	###extract mean and sd column according to number.List
	 		for (i in number.List) {
	 			X.new=cbind(X.new, X[,i]) 
	 		}
	    

###Uses descriptive activity names to name the activities in the data set
		##get the activity description list
		act.Descrptn=read.table('activity_labels.txt')
		
		##add a new column in the clean data set (X.new), and label the activities
		activity=character(length=nrow(Y))
		for (i in 1: nrow(Y)) {
			act=Y[i,1]
			row.number=which(act.Descrptn==act)
			new.act=act.Descrptn$V2[row.number]
			activity[i]=as.character(new.act)
		}
		
		X.new=cbind(activity,X.new)
		
		
###	Appropriately labels the data set with descriptive variable names
		###Label the column by feature.List(the name of the measurement)
		for (i in 1:length(number.List)) {
			measure=number.List[i]
			colname=feature.List$V2[measure]
			colnames(X.new)[i+1]=as.character(colname)
		}
		
		###Label the row by the subject number and add a new variable called subject to the clean dataset(X.new)
		subject=c(sub.test[,1],sub.train[,1])		
		X.new=cbind(subject, X.new)

		
### 	Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
		##change data set into a data frame
		X.new=as.data.frame(X.new)
		
		##install reshape library
		install.pacakges('reshape')
		library(reshape)
		
		##melt the data by subject and activity
		X.new2=melt(X.new,id.vars=c('subject','activity'))
		
		##cast the data frame
		X.new3=cast(data=X.new2,fun=mean)
		

		##write the tidy data set
		write.table(X.new3,'tidyData.txt',sep="\t")
			