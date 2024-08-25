##主成分分析和因子分析
#加载包
library(psych)

#主成分分析
#判断主成分的个数
fa.parallel(USJudgeRatings[,-1],fa="pc",
            n.iter = 100,show.legend = FALSE,main = "碎石检验绘图")
#使用了碎石检验pc来判断主成分的个数

#提取主成分
pc<-principal(USJudgeRatings[,-1],nfactors = 1)


##当主成分个数为多个时
fa.parallel(Harman23.cor$cov, n.obs = 302, fa="pc", n.iter = 100,
            show.legend = FALSE, main="碎石检验绘图")


pc1<-principal(Harman23.cor$cov, nfactors = 2, rotate = "none")

##主成分旋转
rc<-principal(Harman23.cor$cov, nfactors = 2, rotate = "varimax")

#获取主成分得分
pc<-principal(USJudgeRatings[,-1],nfactors = 1, scores = TRUE)
head(pc$scores)
cov(pc$scores,USJudgeRatings$CONT)



###因子分析
options(digits = 2) ##将所有数据设为小数点后两位
covariance<-ability.cov$cov
correlations<-cov2cor(covariance) ##转化为相关系数矩阵

##判断所需因子个数
library(psych)
fa.parallel(correlations,n.obs = 112,fa="both", n.iter = 100,
            main = "两种方法下的检验绘图")

##提取公共因子
fa(correlations, nfactors = 2, rotate = "none", fm="pa")

#因子正交旋转
fa.varimax<-fa(correlations, nfactors = 2, rotate = "varimax", fm="pa")

#因子斜交旋转
fa.Promax<-fa(correlations, nfactors = 2, rotate = "Promax", fm="pa")

##求解因子结构矩阵
fsm<-function(oblique)
{
  if(class(oblique)[2]=="fa" & is.null(oblique$Phi))
  {
    warning("Object doesn't look like oblique EFA")
  }
  else
  {
    P<-unclass(oblique$loading)
    F<-P %*% oblique$Phi
    colnames(F)<-c("PA1","PA2")
    return(F)
  }
}

fsm(fa.Promax)

factor.plot(fa.Promax,labels=rownames(fa.Promax$loadings))

fa.diagram(fa.Promax,simple = FALSE)
fa.diagram(fa.Promax,simple = TRUE)

fa.Promax$weights












