##数学函数
abs()##绝对值
sqrt()#平方根
exp()#以e为底的指数函数

sqrt(c(16,25,81))

##统计函数
z<-mean(x,trim=0.05,na.rm=TRUE)#丢弃了最大和最小的5%
#后得到的算术平均数
median()#中位数
sd() var()#标准差,方差
sum() range()#求和，求值域

##概率函数
#在区间[-3.3]上绘制正态分布曲线
x<-pretty(c(-3,3),30)
y<-dnorm(x)
plot(x,y,type="l",
     xlab="Normal Deviate",
     ylab="Density",
     yaxs="i")
##设定随机数种子
set.seed()
##生成多元正态数据
install.packages("MASS")
library(MASS)
##mvrnrom(n,mean,sigma)
options(digits = 3)
set.seed(1234)
mean<-c(230.7,146.7,3.6)
sigma<-matrix(c(15360.8,6721.2,-47.1,
                6721.2,4700.9,-16.5,
                -47.1,-16.5,0.3),3,3)
mydata<-mvrnorm(500,mean,sigma)
mydata<-as.data.frame(mydata)
names(mydata)<-c("y","x1","x2")
dim(mydata)
head(mydata,20)

##字符处理函数
nchar()#计算x中的字符数量
x<-c("adad","abcnds","asdadj")
nchar(x)
substr(x,start,end)#提取或替换字符向量中的字串
substr(x[2],2,5)
substr(x[3],1,7)<-"enenee"


y<-c("abdesdada")
nchar(y)
substr(y,2,5)
substr(y,2,5)<-"erty"

#paste函数连接字符串
paste("x",1:4,sep = "") ##连接x和1，2，3，4
paste("x",1:5,sep="made")
paste("today is",date())

##其他实用函数
length()#求对象长度
seq()#生成序列
seq(1,10,2)
rep()#将x重复n次
rep(c(1:3),3)
pretty(x,n)#将x分割为连续的区间
cat()#连接对象
cat("abcd","dede","\b.\n","cdcd",append = FALSE)

##apply()将函数应用到矩阵中
mydata<-matrix(runif(30),6,5)
apply(mydata, 1, sqrt)##对每一行求平方根
apply(mydata, 2, mean)##对每一列求均值

##控制流
#for和while循环
for (i in 1:10) {
  print("hello world")
}

i<-10
while (i>0) {
  print("helloworld")
  i<-i-1
}

#if else条件执行
grade<-c("adadada")
if(is.character(grade))
  grade<-as.factor(grade)
##写else的时候要加一个大括号
{
if(!is.factor(grade)) 
  grade<-as.factor(grade) 
  else print("grade already is a factor")
}

##ifelse结构
score=sample(1:10,1,replace = FALSE)
ifelse(score>6,print("passed"),print("failed"))

##switch结构
feelings<-c("sad","fear")
for (i in feelings) {
  print(switch(i,
               happy="123",
               sad="134",
               angry="111",
               fear="333"
               
  ))
  
}

##用户自编函数
mydate<-function(type="long") {
  switch (type,
    long = format(Sys.time(),"%A %B %d %Y"),
    short=format(Sys.time(),"%m-%d-%y"),
    cat(type, "is not a reconized type\n")
    #只有当type为非long和short时才执行cat语句
  )
}

##矩阵的转置
cars<-mtcars[1:5,1:4]
t(cars)

##整合数据aggregate()
options(digits = 3)
attach(mtcars)
aggdata<-aggregate(mtcars,by=list(cyl,gear),FUN = mean,
                   na.rm=TRUE)
















