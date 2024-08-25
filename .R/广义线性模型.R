##广义线性模型
#Logistic回归
install.packages("AER")
library(AER)
data(Affairs,package = "AER")

##先将affairs转化为二值型因子ynaffair
Affairs$ynaffair[Affairs$affairs>0]<-1
Affairs$ynaffair[Affairs$affairs==0]<-0
Affairs$ynaffair<-factor(Affairs$ynaffair,
                         levels=c(0,1),
                         labels=c("NO","Yes"))## 转化为因子类型

###使用Logistic模型拟合
fit.full<-glm(ynaffair~gender+age+yearsmarried+children+
                religiousness+education+occupation+rating,
              data=Affairs,family = binomial())
summary(fit.full)


##去除p值较高的几个变量重新拟合
fit.reduced<-glm(ynaffair~age+yearsmarried+
                religiousness+rating,
              data=Affairs,family = binomial())
summary(fit.reduced)


##用anova函数检验两种拟合效果是否相同
anova(fit.full,fit.reduced,test = "Chisq") ##使用卡方检验
## 结果：p值大于0.05，显著性低，无法拒绝原假设，故两种拟合效果相似

##探究预测变量对结果概率的影响
##创建虚拟测试集
test.data<-data.frame(rating=c(1,2,3,4,5),age=mean(Affairs$age),
                      yearsmarried=mean(Affairs$yearsmarried),
                      religiousness=mean(Affairs$religiousness))

test.data$prob<-predict(fit.reduced,newdata=test.data,type = "response")


####泊松回归
install.packages("robust")
library(robust)
data(breslow.dat,package = "robust")

##可视化
opar<-par(no.readonly = TRUE) ##创建画图参数
par(mfrow=c(1,2)) ##创建一个1x2的图表
attach(breslow.dat)
hist(sumY,breaks=20,xlab="Seizure Count",
     main="Distribution of Seizure")
boxplot(sumY~Trt,xlab="Treatment",
        main="group comparsion")
par(opar)##关闭(恢复默认参数)参数设置


##泊松回归
fit<-glm(sumY~Age+Trt+Base,data = breslow.dat,family = poisson())
summary(fit)





