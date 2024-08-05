## 本段介绍R语言的基本数据结构（仅补充一些有意思的函数或操作）  

### 一、 数值型向量(numeric vectors)
```R
c(1, 2, 3) ##形成一个向量

##分割向量
rep(c(a, b, c), c(x, y, z)) ##a重复x次。b重复y次，c重复z次；还可以添加length.out和times参数控制

seq(from = a, to = b, by = c) ##形成一个从a到b，步长为c的一段向量
seq(1,10) 与 1:10等价

##生成随机向量
rnorm(a)  ##生成a个满足N(0, 1)的数
runif(a)  ##生成a个满足U(0, 1)的数
sample(a:b, c, replace = TRUE)  ##从a到b中进行可重复抽样，抽取c个数

##随机数种子
set.seed(1234) ##通常用于生成随机数或者向量，再次运行种子可以重现之前的结果


