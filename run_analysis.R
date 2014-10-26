


FEAT<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt')

TRAIN<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt')
TRAINsubject<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt')
TRAINlabels<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt')

TRAIN_DATA<-cbind(TRAIN,TRAINsubject,TRAINlabels)

TEST<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt')
TESTsubject<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt')
TESTlabels<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt')

TEST_DATA<-cbind(TEST,TESTsubject,TESTlabels)

DATA=rbind(TRAIN_DATA,TEST_DATA)

colnames(DATA)<-FEAT[,2]
colnames(DATA)[562]<-'Subject'
colnames(DATA)[563]<-'Label'



effective<-grep('.*-mean.*|.*-std.*', FEAT[,2])
DATA=DATA[,c(effective,562,563)]




ACTlabel<-read.table('getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt')
for(i in 1:6){

	DATA[DATA$Label==i,]$Label=ACTlabel[i,2]
	}
n=ncol(DATA)
colnames(DATA)[n]<-'Activity'

install.packages('reshape2')
library('reshape2')
DATAMelt<-melt(DATA,id=c('Activity','Subject'),measure.vars=colnames(DATA)[1:(n-2)])
DATA2<-dcast(DATAMelt,Subject+Activity~variable, mean)
write.table(DATA2, "TIDY.txt", sep="\t")

