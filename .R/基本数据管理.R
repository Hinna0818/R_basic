##创建新变量
mydata<-data.frame(x1=c(2,3,5,6),
                   x2=c(3,5,2,1))
##使用两种方法创建新变量
#法一
attach(mydata)
mydata$sumx<-x1+x2
mydata$meanx<-(x1+x2)/2
detach(mydata)

#法二 使用transform函数
mydata1<-transform(mydata,
                   sumx=x1+x2,
                   meanx=(x1+x2)/2)


##变量的重命名
install.packages("plyr")
library(plyr)
##rename(文件名，c())
rename(mydata,c(x1="y1",x2="y2"))

names(mydata)[1]<-"y1"
names(mydata)[1:2]<-c("z1","z2")

##缺失值
#is.na()来判断缺失值
y<-c(1,2,3,4,5,NA)
is.na(y)

##日期
date()#返回现在的日期
format()#输出指定格式的日期值
as.Date()#以数值形式转化日期变量

today<-Sys.Date()
format(today,format="%B %d %Y")
format(today,format="%A")

##用difftime函数计算时间间隔
today<-Sys.Date()
dob<-as.Date("2004-08-18")
difftime(today,dob,units = "weeks")
##求出我出生那天是星期几
birthday<-as.Date("2004-08-18")
format(birthday,format="%A")

##判断和转换数据类型
a<-c(1,3,4)
is.numeric(a)
is.vector(a)
is.character(a)

a<-as.character(a)
is.numeric(a)
is.vector(a)
is.character(a)

##补充一个leader数据框
manager<-c(1,2,3,4,5)
date<-c("10/24/08","10/28/08","10/1/08","10/12/08","5/1/09")
country<-c("US","US","UK","UK","UK")
gender<-c("M","F","F","M","F")
age<-c(32,45,25,39,99)
q1<-c(5,3,3,3,2)
q2<-c(4,5,5,3,2)
q3<-c(5,2,5,4,1)
q4<-c(5,5,5,NA,2)
q5<-c(5,5,2,NA,1)
leadership<-data.frame(manager,date,country,gender,age,
          q1,q2,q3,q4,q5,stringsAsFactors = FALSE)

##数据的排序
order()#升序
newdata<-leadership[order(leadership$age),]

##用attach函数
attach(leadership)
newdata<-leadership[order(gender,-age),]##相同性别按年龄排序
detach(leadership)

##数据集的合并
##添加列 merge(data1,data2,by="") cbind()
ls1<-data.frame(age,q1,stringsAsFactors = FALSE)
ls2<-data.frame(q1,q2,stringsAsFactors = FALSE)
ls3<-cbind(ls1,ls2)

##添加行 rbind() 必须有相同的元素
##选入(保留)变量
myvars<-leadership[,c(6:10)]
myvars<-c("q1","q2","q3")
leadership[myvars]
##paste函数选取
myvars<-paste("q",1:5,sep="")
newdata<-leadership[myvars]

##剔除(丢弃)向量
myvars<-names(leadership) %in% c("q3","q4")
newdata<-leadership[!myvars]
##剔除leadership里面的第8,9个元素
newdata<-leadership[c(-8,-9)]

leadership$q3<-leadership$q4<-NULL

##进入观测
leadership[1:3,]##选择第一行到第三行
attach(leadership)
newdata<-leadership[gender=='F' & age<= 40,]
newdata<-leadership[gender=='M' & age<=40,]
detach(leadership)

#用subset函数选择和观测变量
mydata<-subset(leadership,gender=='M' | age>=40,
               select=gender:q3)

##简单随机抽样
mysample<-leadership[sample(1:nrow(leadership),3,
                            replace = FALSE),]

##使用SQL语句操作数据框
install.packages("sqldf")
library(sqldf)















