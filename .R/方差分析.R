##方差分析

#单因素方差分析
install.packages("multcomp")
library(multcomp)
attach(cholesterol)
table(trt)
##各组均值及标准差
aggregate(response,by=list(trt),FUN=mean)
aggregate(response,by=list(trt),FUN=sd)
##检验组间差异
fit<-aov(response~trt)
summary(fit)
##画图
install.packages("gplots")
library(gplots)
plotmeans(response~trt,xlab = "Treatment",
          ylab = "Response",main="Mean Plot\nwith 95% CI")
detach(cholesterol)

##多重比较
TukeyHSD(fit)
par(las=2)
par(mar=c(5,8,4,2))
plot(TukeyHSD(fit))

library(multcomp)
par(mar=c(5,4,6,2))
tuk<-glht(fit,linfct=mcp(trt="Tukey"))
plot(cld(tuk,levels=.05),col="lightgrey")

##评估检验的假设条件
#正态性检验
library(car)
qqPlot(lm(response~trt,data=cholesterol),
       simulate=TRUE,main="Q-Q Plot",labels=FALSE)

#方差齐性检验
bartlett.test(response~trt,data=cholesterol)

#检测离群点
library(car)
outlierTest(fit)

###单因素协方差分析
data(litter,package = "multcomp")
attach(litter)
table(dose)

aggregate(weight,by=list(dose),FUN=mean)
fit<-aov(weight~gesttime+dose)
summary(fit)

library(effects)
effect("dose",fit)

##对用户定义的对照的多重比较
library(multcomp)
contrast<-rbind("no drug vs. drug"=c(3,-1,-1,-1))
a<-glht(fit,linfct = mcp(dose=contrast))
summary(a)

##检验回归斜率的同质性
library(multcomp)
fit2<-aov(weight~gesttime*dose,data=litter)
summary(fit2)

##结果可视化
install.packages("HH")
library(HH)
ancova(weight~gesttime+dose,data=litter)

##双因素方差分析
attach(ToothGrowth)
table(supp,dose)
aggregate(len,by=list(supp,dose),FUN=mean)
aggregate(len,by=list(supp,dose),FUN=sd)

dose<-factor(dose)
fit<-aov(len~supp*dose)
summary(fit)
detach(ToothGrowth)

##展示双因素分析的交互作用
interaction.plot(dose,supp,len,type="b",
                 col=c("red","blue"),pch=c(16,18),
                 main="Interaction between Dose and Supplement Type")


library(gplots)
plotmeans(len~interaction(supp,dose,sep=""),
          connect = list(c(1,3,5),c(2,4,6)),
          col = c("red","darkgreen"),
          main="Interacion Plot with 95% CIs",
          xlab="Treatment and Dose Combination")


install.packages("HH")
library(HH)
attach(ToothGrowth)
interaction2wt(len~supp*dose)
detach(ToothGrowth)

##重复测量方差分析
attach(CO2)
conc<-factor(conc)
w1b1<-subset(CO2,Treatment=='chilled')

fit<-aov(uptake~conc*Type+Error(Plant/(conc)),w1b1)
summary(fit)

#画图
par(las=2)
par(mar=c(10,4,4,2))
with(w1b1,interaction.plot(conc,Type,uptake,type="b",
                 col=c("red","blue"),pch=c(16,18),
                 main="Interaction Plot for Plant Type and Concentration"))

boxplot(uptake~Type*conc,data=w1b1,col=c("gold","green"),
        main="Chilled Quebec and Mississippi Plants",
        ylab="Carbon dioxide uptake rate(umol/m^2 sec)")

##多元方差分析
library(MASS)
attach(UScereal)
shelf<-factor(shelf)
y<-cbind(calories,fat,sugars)
aggregate(y,by=list(shelf),FUN=mean)
cov(y)

fit<-manova(y~shelf)
summary(fit)
##F检验显著，拒绝原假设
summary.aov(fit)


##评估假设检验
#用Q-Q图检验多元正态性
center<-colMeans(y)#获取y的均值向量
n<-nrow(y)#获取y的行数
p<-ncol(y)#获取y的列数
cov<-cov(y)#获取y的协方差矩阵
d<-mahalanobis(y,center,cov)#计算y所有点离中心点的马哈拉诺比斯距离
coord<-qqplot(qchisq(ppoints(n),df=p),
              d,main="Q-Q Plot Assessing Multivariate Normality",
              ylab = "Mahalanobis D2")
abline(a=0,b=1)
identify(coord$x,coord$y,labels=row.names(UScereal))

##检验多元离群点
install.packages("mvoutlier")
library(mvoutlier)
outliers<-aq.plot(y)
outliers

##稳健多元方差分析
install.packages("rrcov")
library(rrcov)
Wilks.test(y,shelf,method="mcd")









