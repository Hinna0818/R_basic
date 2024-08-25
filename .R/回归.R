###回归
#简单线性回归
fit<-lm(weight~height,data = women)
summary(fit)
women$weight
#计算预测值和残差值
fitted(fit)
residuals(fit)
##绘制曲线和散点图
plot(women$height,women$weight,
     xlab="Height (in inches)",
     ylab="Weight(in pounds)")
abline(fit)

##多项式回归
fit2<-lm(weight~height+I(height^2),data = women)
summary(fit2)
##绘制曲线和散点图
plot(women$height,women$weight,
     xlab="Height (in inches)",
     ylab="Weight(in pounds)")
lines(women$height,fitted(fit2))#fitted()表示预测值
     
##优化使用scatterplot函数绘制二元关系图
install.packages("car")
library(car)
scatterplot(weight~height,data=women,
            spread=FALSE,smoother.args=list(lty=2),pch=19,
            main="Women age 30-39",
            xlab="Height (in inches)",
            ylab="Weight(in pounds)")
            
##多元线性回归
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
cor(states)
scatterplotMatrix(states,spread=FALSE,smoother.args=list(lty=2),
                  main="Scatter Plot Matrix")
#回归
fit<-lm(Murder~Population+Illiteracy+Income+Frost,
        data=states)
summary(fit)

##有显著交互项的回归
fit<-lm(mpg~hp+wt+hp:wt,data=mtcars)
summary(fit)
install.packages("effects")
library(effects)
plot(effect("hp:wt",fit,,list(wt=c(2.2,3.2,4.2))),multiline=TRUE)

##回归诊断
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
fit<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
confint(fit)

##标准方法
fit<-lm(weight~height,data = women)
par(mfrow=c(2,2))
plot(fit)

##对women进行二次拟合
fit2<-lm(weight~height+I(height^2),data=women)
par(mfrow=c(2,2))
plot(fit2)

##删除两个观测点
newfit<-lm(weight~height+I(height^2),data=women[-c(13,15),])
par(mfrow=c(2,2))
plot(newfit)

##检验states回归问题
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
fit<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
par(mfrow=c(2,2))
plot(fit)


##用car包优化检验
#正态性假设
install.packages("car")
library(car)
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
fit<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
qqPlot(fit,labels=row.names(states),id.method="identify",
       simulate=TRUE,main="Q-Q Plot")


##误差的独立性
durbinWatsonTest(fit)

##线性
library(car)
crPlots(fit)

##同方差性
library(car)
ncvTest(fit)
spreadLevelPlot(fit)

##线性模型的综合验证
install.packages("gvlma")
library(gvlma)
gvmodel<-gvlma(fit)
summary(gvmodel)

##异常观测值
#离群点
library(car)
outlierTest(fit)

##高杠杆值点
  hat.plot<-function(fit){
  p<-length(coefficients(fit))
  n<-length(fitted(fit))
  plot(hatvalues(fit),main="Index Plot of Hat Values")
  abline(h=c(2,3)*p/n,col="red",lty=2)
  identify(1:n,hatvalues(fit),names(hatvalues(fit)))
}
  hat.plot(fit)

##强影响点
#变量添加图
library(car)
avPlots(fit,ask=FALSE,id.method="identify")  

##整合
library(car)
influencePlot(fit,id.method="identify",
              main="Influence Plot",
              sub="Circle size is proportional to cook's distance")

##选择最佳回归模型
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
fit1<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
fit2<-lm(Murder~Population+Illiteracy,data=states)
anova(fit2,fit1)


AIC(fit1,fit2)

##逐步回归
library(MASS)
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
fit<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
stepAIC(fit,direction = "backward")
     
##全子集回归
library(leaps)
states<-as.data.frame(state.x77[,c("Murder","Population",
                                   "Illiteracy","Income","Frost")])
     
leaps<-regsubsets(Murder~Population + Illiteracy + Income + Frost,
                  data=states,nbest=4)     
plot(leaps,scale="adjr2")     
     
     
library(car)
subsets(leaps,statistic = "cp",
        main="Cp Plot for all subsets regression")
abline(1,1,lty=2,col="red")
      
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
















