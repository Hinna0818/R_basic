##安装RTools包
install.packages("installr")
install.packages("stringr")    ###依赖包
library(stringr)
library(installr)
install.Rtools()

##安装coin包
##install.packages(file.choose(),repos=NULL,type="source")
install.packages("coin")


##t检验与单因素置换检验
library(coin)
score<-c(40,57,45,55,58,57,64,55,63,53)
treatment<-factor(c(rep("A",5),rep("B",5)))  ##对AB各重复5次
mydata<-data.frame(treatment,score)
t.test(score~treatment,data=mydata,var.equal=TRUE)

oneway_test(score~treatment,data=mydata,distribution="exact")

##k样本检验
library(multcomp)
set.seed(1234)
oneway_test(response~trt,data=cholesterol,
            distribution=approximate(B=9999)) ##进行9999次的蒙特卡洛实验

##卡方检验的置换检验版本 探究变量独立性
library(coin)
library(vcd)
Arthritis<-transform(Arthritis,
                      Improved=as.factor(as.numeric(Improved)))
set.seed(1234)
chisq_test(Treatment~Improved,data=Arthritis,
           distribution=approximate(B=9999))

##数值变量的独立性检验
states<-as.data.frame(state.x77)
set.seed(1234)
spearman_test(Illiteracy~Murder,data=states,
              distribution=approximate(B=9999))

##用lmPerm包做线性模型的置换检验

##简单回归与多项式回归
install.packages("lmPerm")
library(lmPerm)
set.seed(1234)
fit<-lmp(weight~height,data=women,perm = "prob")
summary(fit)

fit<-lmp(weight~height+I(height^2),data=women,perm = "prob")
summary(fit)

##多元回归预测
set.seed(1234)
states<-as.data.frame(state.x77)
fit<-lmp(Murder~Population+Illiteracy+Income+Frost,
         data=states,perm = "prob")
summary(fit)


##置换检验中的单因素方差分析
library(lmPerm)
library(multcomp)
set.seed(1234)
fit<-aovp(response~trt,data=cholesterol,perm="prob")
summary(fit)


##置换检验中的单因素协方差分析
library(lmPerm)
set.seed(1234)
fit<-aovp(weight~gesttime+dose,data=litter,perm = "prob")
summary(fit)
anova(fit)

#置换检验中的双因素方差分析
library(lmPerm)
set.seed(1234)
fit<-aovp(len~dose*supp,data=ToothGrowth,perm = "Prob")
anova(fit)












