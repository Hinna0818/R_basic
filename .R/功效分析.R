##功效分析

#载入pwr包
install.packages("pwr")
library(pwr)

##t检验
pwr.t.test(d=.8,sig.level = .05,power = .9,type = "two.sample",
           alternative = "two.sided")

##更改条件：假设需要40人
pwr.t.test(n=20,d=.5,sig.level = .01,type = "two.sample",
           alternative = "two.sided")
##更改条件：假设两组人数量不同
pwr.t2n.test(n1=10,n2=20,d=.5,power=.14,
             alternative = "two.sided")

##方差分析
pwr.anova.test(k=5,f=0.25,sig.level = .05,power = .8)

#相关性
pwr.r.test(r=.25,sig.level = .05,power = .9,alternative = "greater")

#线性模型
pwr.f2.test(u=3,f2=.0769,sig.level = .05,power = .9)












