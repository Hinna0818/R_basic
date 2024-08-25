##聚类分析
install.packages(c("cluster","NbClust","flexclust","fMultivar","rattle"))

##计算类之间的欧几里得距离
library(flexclust)
data("nutrient",package = "flexclust")
head(nutrient,4)

d <- dist(nutrient)
d1 <- as.matrix(d)[1:4,1:4] ##获得欧几里得距离矩阵

##营养数据的平均联动聚类
data("nutrient",package = "flexclust")
row.names(nutrient) <- tolower(row.names(nutrient)) #改行名为小写
nutrient.scaled <- scale(nutrient)#标准化
d <- dist(nutrient.scaled)#计算距离
fit.average <- hclust(d,method = "average")
plot(fit.average,hang=-1,cex=.8,main="Average Linkage clustering")










