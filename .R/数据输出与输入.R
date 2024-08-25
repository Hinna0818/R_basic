##数据输入
##使用文本编辑器输入数据
mydata<-data.frame(age=numeric(0),gender=character(0),weight=numeric(0))
mydata<-edit(mydata)
fix(mydata)##相当于mydata<-edit(mydata)的简单版

##使用read.table函数读取csv文件的数据
grades<-read.table("studentgrades.csv",header=TRUE,row.names="StudentID",sep=",")



library(readxl)

workbook<-"C:\大一\人力\其它\22级名单模版.xls"
library(xlsx)
mydataframe<-read.xlsx(workbook,1)


mydata1<-data.frame(name=character(0),age=numeric(0),salary=numeric(0))
fix(mydata1)


##读取数据(先选取数据)

retval<-subset(grades,Science==87)
write.csv(retval,"hn.csv",row.names = FALSE)
newdata<-read.csv("hn.csv")







