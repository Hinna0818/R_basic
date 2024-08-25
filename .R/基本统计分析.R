##基本统计分析


##描述性统计分析
myvars<-c("mpg","hp","wt")
mtcars2<-mtcars[myvars]
head(mtcars[myvars])
#使用summary
summary(mtcars[myvars])
sapply(mtcars[myvars], mean)

##更多方法
install.packages("Hmisc")
install.packages("pastecs")

##Hmisc的describe函数
library(Hmisc)
describe(mtcars2)

##pastecs包的stat.desc函数
library(pastecs)
stat.desc(mtcars2)

##用aggregate整合
aggregate(mtcars2,by=list(am=mtcars$am),mean)

dstats<-function(x)sapply(x,mean)
by(mtcars2,mtcars$am,dstats)

##分组计算拓展
install.packages("doBy")
library(doBy)
summaryBy(mpg+hp+wt~am,data=mtcars,FUN = mean)

install.packages("psych")
library(psych)
describeBy(mtcars2,list(am=mtcars$am))

##频数表和列联表
library(vcd)
head(Arthritis)


##一维列联表
mytable<-with(Arthritis,table(Improved))
##也可以用mytable<-table(Arthritis$Improved)

#将频数转化为比例
prop.table(mytable)
prop.table(mytable)*100  #化为百分比形式


##二维列联表
attach(Arthritis)
mytable<-table(Treatment,Improved)
detach(Arthritis)

mytable<-xtabs(~Treatment+Improved,data=Arthritis)

##生成边际频数和比例
margin.table(mytable,1)
margin.table(mytable,2)

prop.table(mytable,1)
prop.table(mytable,2)

prop.table(mytable)

##添加边际和
addmargins(mytable)
addmargins(prop.table(mytable))
addmargins(prop.table(mytable,1),2)
addmargins(prop.table(mytable,2),1)

##使用CrossTable生成二维列联表
install.packages("gmodels")
library(gmodels)
CrossTable(Arthritis$Treatment,Arthritis$Improved)

##三维列表
mytable<-xtabs(~Treatment+Sex+Improved,data=Arthritis)
ftable(mytable)

##三维边际频数
margin.table(mytable,1)
margin.table(mytable,c(1,3))##improved和treatment的频数组合
#比例
#options(digits = 2)
ftable(prop.table(mytable,c(1,2)))
ftable(addmargins(prop.table(mytable,c(1,2)),3))
ftable(addmargins(prop.table(mytable,c(1,2)),3))*100

##独立性检验
#卡方检验
library(vcd)
mytable<-xtabs(~Improved+Sex,data = Arthritis)
chisq.test(mytable)

#Fisher精确检验
options(digits = 7)
mytable<-xtabs(~Treatment+Improved,data = Arthritis)
fisher.test(mytable)

#Cochran-Mantel-Haenszel检验
mytable<-xtabs(~Improved+Sex+Treatment,
               data=Arthritis)
mantelhaen.test(mytable)

#相关性的度量
library(vcd)
mytable<-xtabs(~Treatment+Improved,data = Arthritis)
assocstats(mytable)
kappa(mytable)

##三种相关
states<-state.x77[,1:6]
cov(states)
cor(states)
cor(states,method = "spearman")

#如果不想得到一个方阵
x<-states[,c("Population","Income","Illiteracy")]
y<-states[,c("Life Exp","Murder")]
cor(x,y)

##偏相关
install.packages("ggm")
library(ggm)
colnames(states)
covv<-cov(states)
pcor(c(1,4,2,3,5),covv)

##相关性的显著性检验
cor.test(states[,3],states[,5])
##通过corr.test计算相关矩阵并进行显著性检验
library(psych)
corr.test(states,use = "complete")
corr.test(states[,1:3],use = "complete",method = "spearman")


##独立样本的t检验
library(MASS)
t.test(Prob~So,data = UScrime)
##非独立样本的t检验
library(MASS)
sapply(UScrime[c("U1","U2")],function(x)(
  c(mean=mean(x),sd=sd(x))
))
#with(UScrime,t.test(U1,U2,paired=TRUE))
attach(UScrime)
t.test(U1,U2,data=UScrime,paired=TRUE)
detach(UScrime)






















