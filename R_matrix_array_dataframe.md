## 进阶数据结构（数组与矩阵、数据框）

### 一、 矩阵与数组（matrix and array）
二维数组由行列两个维度的向量组成，一般使用`array()`构建，而特殊的二维数组叫做矩阵，使用`matrix()`构建。

<mark>构建矩阵的方法：
```R
#法一：
a <- matrix(1:6,byrow = TRUE, nrow = 3)
> a
     [,1] [,2]
[1,]    1    2
[2,]    3    4
[3,]    5    6

#法二：
 array(1:6,dim = c(2,3)) #dim为数组的维度
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```
在这里，我设定了矩阵的行数为3行，且`byrow = TRUE`为按行填充（优先填充于行，一行填满了再开启下一行）。在这里，`dim`为数组的维度，二维为矩阵，以此类推。

同时，可以使用`dimnames`参数给矩阵的行和列赋予名字：
```R
 a <- matrix(1:6,byrow = TRUE, nrow = 3, dimnames = list(c("a","b","c"),c("d","e")))
> a

  d e
a 1 2
b 3 4
c 5 6
```

<mark>矩阵的行与列操作

在R中，矩阵默认是按列填充的，一般也是对列进行操作，比如`as.matrix(1:2)`返回的是一个列向量，而`t(1:2)`返回的是一个行向量；  
具体而言，对于矩阵的行列操作，`rbind()`表示对矩阵的行进行合并，即合并后的行数增加，列数不变；`cbind()`表示对矩阵的列进行合并，即合并后的列数增加，行数不变：
```R
#行合并
rbind(1:3,4:6,7:9)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
[3,]    7    8    9

#列合并
 cbind(1:3,4:6,7:9)
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9
```

`simplify2array` 是 R 语言中的一个函数，用于将列表或向量简化为数组或矩阵。这个函数会尝试将列表中的元素组合成一个数组，如果这些元素具有相同的长度且类型一致，那么就可以成功地简化：
```R
a = list(c(1,2,3),c(4,5,6),c(7,8,9))
> simplify2array(a)  ##返回一个矩阵
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9

##也可以用do.call函数：
do.call(cbind,list(a = 1, b = c(2,3), c = c(4,5,6)))
     a b c
[1,] 1 2 4
[2,] 1 3 5
[3,] 1 2 6
Warning message:
In (function (..., deparse.level = 1)  :
  number of rows of result is not a multiple of vector length (arg 2)
```

还可以：
```R
a <- list(runif(15),rnorm(10))
sapply2 <- function(...){
+ do.call(cbind,lapply(...))
+ }
> sapply2(a,mean)
          [,1]         [,2]
[1,] 0.4939233 -0.001564338
```

<br>

矩阵的元素可以不是数值型，也可以是字符型和逻辑值：
```R
matrix(strrep(LETTERS[1:6],1:6),nrow = 2)
     [,1] [,2]   [,3]
[1,] "A"  "CCC"  "EEEEE"
[2,] "BB" "DDDD" "FFFFFF"
```
<br>

<mark>矩阵/二维数组的属性

矩阵或二维数组的属性一般是行和列的数目与名称，比如：
```R
 A <- matrix(1:6,nrow = 3, dimnames = list(LETTERS[1:3],LETTERS[4:5]))

> A
  D E
A 1 4
B 2 5
C 3 6

> dim(A)  #同attr(A,"dim")
[1] 3 2

> dimnames(A)  #同attr(A,"dimnames")
[[1]]
[1] "A" "B" "C"

[[2]]
[1] "D" "E"

#更改填充方式，与A的转置不同
'dim<-' (A,c(2,3))
     [,1] [,2] [,3]
[1,]    1    3    5
[2,]    2    4    6
```

<br>

<mark>数组索引

与python相似，R中的索引采用`[]`的形式，举个例子：
```R
A <- matrix(1:12,byrow = TRUE, nrow = 3)
> A
     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4
[2,]    5    6    7    8
[3,]    9   10   11   12

##这里索引的顺序是以列为准的
> A[6]
[1] 10

##也可以采用[row,col]的形式
> A[3,2]
[1] 10

##修改列名
B <- 'dimnames<-'(A,list(LETTERS[1:3],LETTERS[4:7]))
> B
  D  E  F  G
A 1  2  3  4
B 5  6  7  8
C 9 10 11 12
```

矩阵和二维数组的索引的方法如下所示：
```R
 A[1]
[1] 1  #以列的顺序为准的第一个元素

> A[1,]
[1] 1 2 3 4  #第一行的全部元素

> A[,1]
[1] 1 5 9  #第一列的全部元素
```
<br>


其中，如果不想失去数组或矩阵原始的维度，可以加入`drop = FALSE`参数，此参数默认为`TRUE`：
```R
A[1,,drop = FALSE]

     [,1] [,2] [,3] [,4]
[1,]    1    2    3    4  #结果为第一行，且保留一行四列的属性
```

<br>

<mark>矩阵截取的规则

在R中，我们可以截取矩阵的任意行与列，返回一个新的矩阵：
```R
A <- matrix(1:12,nrow = 3, dimnames = list(LETTERS[1:3],LETTERS[4:7]))
> A
  D E F  G
A 1 4 7 10
B 2 5 8 11
C 3 6 9 12

##截取第一、二行和第一至三列
> A[1:2,c(1:3)]
  D E F
A 1 4 7
B 2 5 8

##不选择第一行，且选取D、F列
A[-1,c("D","F")]
  D F
B 2 8
C 3 9
```
<br>

<mark>基于逻辑值的索引

R中支持矩阵中索引为逻辑值，从而对原矩阵进行截取：
```R
##选取第一行与第三行和二到四列的元素
 A[c(TRUE,FALSE,TRUE),2:4]
  E F  G
A 4 7 10
C 6 9 12

##求每行和每列元素的平均值
colMeans(A)
 D  E  F  G
 2  5  8 11

rowMeans(A)
  A   B   C
5.5 6.5 7.5

##索引值可以为筛选条件
A[2,colMeans(A)>2]  #选择第二行与均值大于2的列
 E  F  G
 5  8 11

##逻辑值索引
 A>8
      D     E     F    G   ##返回布尔值
A FALSE FALSE FALSE TRUE
B FALSE FALSE FALSE TRUE
C FALSE FALSE  TRUE TRUE

> A[A>8]   #返回A中大于8的元素
[1]  9 10 11 12
 ```

同时，也可以使用一个两列的矩阵或数组对某矩阵进行索引:
```R
I <- cbind(c(1,2,3),c(2,4,1))
> I
     [,1] [,2]  #可以对（1，2），（2，4），（3，1）的位置元素进行引用
[1,]    1    2
[2,]    2    4
[3,]    3    1

> A[I]
[1]  4 11  3  
```

<br>

<mark>矩阵的常用操作

1. 矩阵的转置(transpose)  
   矩阵的转置一般使用`t()`函数进行操作:
```R
 A <- matrix(1:6,nrow = 3)
> A
     [,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
> t(A)
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
```

2. 矩阵元素的处理  
   可以使用`round`,`sqrt`,`log`等数学函数对矩阵的所有元素进行整体处理：
```R
 round(sin(A),2)
     [,1]  [,2]
[1,] 0.84 -0.76
[2,] 0.91 -0.96
[3,] 0.14 -0.28
```

3. 对行或列进行操作  
   `apply(matrix,n,f)`是对矩阵的行或列（n=1或2维度）进行f函数的操作：
```R
 apply(A,1,mean) #返回A每一行的均值，同rowMeans(A)
[1] 2.5 3.5 4.5

 apply(A,2,mean) #返回A每一列的均值，同colMeans(A)
[1] 2 5
```

4. 矩阵的运算
   对于两个行数与列数相同的矩阵，可以使用对两个矩阵中的相同位置元素进行运算：
```R
A <- rbind(1:3,4:6)
> A
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6
> B <- matrix(c(2,4,9,12,6,24),byrow = TRUE, nrow = 2)
> B
     [,1] [,2] [,3]
[1,]    2    4    9
[2,]   12    6   24
> A+B
     [,1] [,2] [,3]
[1,]    3    6   12
[2,]   16   11   30
> A*B
     [,1] [,2] [,3]
[1,]    2    8   27
[2,]   48   30  144
```

练习：对一个矩阵的每一列的元素进行归一化处理
```R
 standardise <- function(A,...){
+ result <- apply(A,2,function(x){
+ (x-mean(x))/sd(x)})
+ return(result)
+ }

> standardise(A)
           [,1]       [,2]       [,3]
[1,] -0.7071068 -0.7071068 -0.7071068
[2,]  0.7071068  0.7071068  0.7071068
```

5. 矩阵的乘法（线性代数回顾）  
   一般，使用`*`对两个同行同列的矩阵的相同位置的元素进行相乘处理，而`%*%`对两个矩阵进行矩阵乘法运算，前提是前一个矩阵的列数要和后一个矩阵的行数相同：
```R
A <- rbind(c(1,2,3),c(4,5,6))
> A
     [,1] [,2] [,3]
[1,]    1    2    3
[2,]    4    5    6

> B <- matrix(2:7,nrow = 3)
> B
     [,1] [,2]
[1,]    2    5
[2,]    3    6
[3,]    4    7

> A %*% B
     [,1] [,2]
[1,]   20   38
[2,]   47   92
```

特殊地、可以使用`crossprod(A,B)`函数来计算`t(A) %*% B`,使用`tcrossprod(A,B)`函数来计算`A %*% t(B)`。


<br>

<mark>矩阵的范数与矩阵的距离

范数（Norm）是数学中用于测量向量或矩阵的“长度”或“大小”的一种函数。范数在各种数学领域中都有应用，尤其是在线性代数、解析学和优化理论中。在矩阵中的应用如下：![alt text](ae05efbf3c9ad4a06d6539a7f372a03.png)
<br>


`dist`函数在R语言中用于计算矩阵或数据框中行与行之间的距离。它生成一个距离矩阵，表示每对行之间的距离。这个函数特别适用于聚类分析或其他需要计算多维数据点之间距离的统计方法。在矩阵中，每行可以看作一个观测点，每列作为不同的指标或者变量作为该观测点的属性。
```R
#计算向量或矩阵中的xx距离
dist(x, method = "euclidean", diag = FALSE, upper = FALSE, p = 2)

#method参数可以设置为多种类型的距离计算方法，默认为欧几里得距离
```

<br>

欧几里得距离在矩阵中的计算方法：
![alt text](5326cad91aaa589c5ecdf4dcaa521d6.png)

示例：
```R
A <- matrix(c(4,2,6,1,5,8,3,9,3,2,10,7),nrow = 4)
> A
     [,1] [,2] [,3]
[1,]    4    5    3
[2,]    2    8    2
[3,]    6    3   10
[4,]    1    9    7

> as.matrix(dist(A))  ##计算矩阵A的欧几里得距离
         1         2         3        4
1 0.000000  3.741657  7.549834 6.403124
2 3.741657  0.000000 10.246951 5.196152
3 7.549834 10.246951  0.000000 8.366600
4 6.403124  5.196152  8.366600 0.000000
```
<br>


字符串的编辑距离：  
`adist` 函数是 R 中用于计算两个字符串之间的编辑距离`（edit distance）`的函数。编辑距离，也被称为` Levenshtein `距离，是指将一个字符串转换成另一个字符串所需的最小操作次数。操作可以包括插入、删除或替换字符：
```R
# x一般为一个向量，最后返回的结果为矩阵
adist(x, y = NULL, costs = NULL, counts = FALSE, ...) 
```

比如：
```R
a <- c("hina","hn","nanhe","boy")
> names(a) <- a
> a
   hina      hn   nanhe     boy
 "hina"    "hn" "nanhe"   "boy"

> adist(a)  #计算a向量的字符编辑距离矩阵（对称）
      hina hn nanhe boy
hina     0  2     4   4
hn       2  0     4   3
nanhe    4  4     0   5
boy      4  3     5   0
```

进而，我们可以根据距离矩阵进行一个简单的聚类分析：
```R
#使用平均值进行聚类分析
h <- hclust(as.dist(a), method = "average")
plot(h)

#设定聚类的cluster数量
cutree(h,n)    #n为实际需要的cluster数量
```
聚类的结果如下：
![alt text](image-1.png)

<br>

计算矩阵的特征值：
可以使用`eigen()`函数计算矩阵的特征值和特征向量，比如：
```R
 a <- rbind(c(2,3,1),c(4,2,5),c(1,5,6))
> eigen(a)
eigen() decomposition
$values
[1] 10.359631 -2.691128  2.331497

$vectors
           [,1]       [,2]       [,3]
[1,] -0.3017316  0.4262455 -0.7586164
[2,] -0.5915655 -0.8044409 -0.2799374
[3,] -0.7476686  0.4137506  0.5883334
```

其他的矩阵应用：
1. QR decomposition（QR分解）
2. SVD decomposition（SVD分解）
3. 与矩阵相关的R包（适用于稀疏矩阵）


<br>

### 二、 数据框（data.frame）
数据框（Data Frame）是R语言中最常用的数据结构之一，尤其适用于处理表格数据。它类似于电子表格或SQL数据库中的表格，由行和列组成。每列可以包含不同类型的数据（如数字、字符、因子等），但同一列中的所有数据必须是相同类型的。

数据框具有如下特点：
1. 数据框的行代表一个观测值，列表示一个属性或一个变量。其中，每一列都具有相同的长度，且不同列之间的数据类型可以不同，这是与矩阵区别的地方。
2. 数据框的每一个列本质上是一个向量，可以看作是由几个等长的向量拼接而成的。


<br>

构建一个数据框：
```R
a <- data.frame(ID = c(1,2,3),color = c("red","green","blue"),sex = c("f","f","m"))
> a
  ID color sex
1  1   red   f
2  2 green   f
3  3  blue   m

#转化为数据框类型
as.dataframe(x,...)
```
<br>

<mark> 行列合并

与矩阵类似的是，数据框可以使用`rbind`和`cbind`函数进行行和列的合并。其中，`rbind`是按行合并，要求列数相同；`cbind`是按列合并，要求行数相同：
```R
##增加多一列'name'（增加一个观测的变量）
 cbind(a,name = c("a","b","c"))
  ID color sex name
1  1   red   f    a
2  2 green   f    b
3  3  blue   m    c

##增加多一行（增加一个观测对象）
 rbind(a,c(4,"yellow","f"))
  ID  color sex
1  1    red   f
2  2  green   f
3  3   blue   m
4  4 yellow   f
```

<br>

<mark>导入csv文件  

在R中，可以使用`read.csv()`函数来导入csv格式的文件：
```R
read.csv(file, header = TRUE, sep = ",", stringAsFactors = TRUE， ...)
```
file为csv文件的地址，`header = TRUE`是默认的，默认纳入列名。`stringAsFactors = TRUE`将字符类型的数据转化为因子类型的数据。

<br>

<mark>数据框的截取

数据框其实是由多个列表构成的，列表的元素构成了数据框的一个列。
```R
a <- data.frame(ID = c(1,2,3),color = c("red","green","blue"),sex = c("f","f","m"))

length(a)  #数据框的列数
[1] 3
> names(a) #数据框的列名,相当于colnames(a)
[1] "ID"    "color" "sex"
```

与列表类似，数据框也可以使用`[]`来进行数据的分割截取：
```R
a[["ID"]]     ##返回ID这一列的所有元素
[1] 1 2 3

a["ID"]       ##返回ID单独一列的数据框
  ID
1  1
2  2
3  3

a$ID         ##同a[["ID"]]，返回这一列的所有元素
[1] 1 2 3
```
<br>

<mark>数据框的重新赋值

同列表，数据框也可以使用`<-`对原列元素进行重新赋值：
```R
##先增多一列
a <- cbind(a,class = c(2020,2021,2022))
  ID color sex class
1  1   red   f  2020
2  2 green   f  2021
3  3  blue   m  2022

##使ID整体加1
a[["ID"]] <- a[["ID"]]+1
> a
  ID color sex class
1  3   red   f  2020
2  4 green   f  2021
3  5  blue   m  2022

##去除sex这一列
a[["sex"]] <- NULL  
> a
  ID color class
1  3   red  2020
2  4 green  2021
3  5  blue  2022

##新增一列
a[["e"]] <- 10*a[["ID"]]^2
> a
  ID color class   e
1  3   red  2020  90
2  4 green  2021 160
3  5  blue  2022 250
```

数据框的列还可以这么玩：
```R
y <- head(a,1) #先截取原数据框的第一行
 y
  ID color class  e
1  3   red  2020 90

##去除两列
y[-match(c("ID","e"),names(y))] #match("ID",names(y))返回ID在y的位置
  color class
1   red  2020

##修改列名
names(y)[names(y)=="ID"] <- "id"
> y
  id color class  e
1  3   red  2020 90
```

数据框跟矩阵的索引切片十分类似，都是通过`[]`进行操作：
```R
a[1:2,]
  ID color class   e
1  3   red  2020  90
2  4 green  2021 160

> a[1,]
  ID color class  e
1  3   red  2020 90

> a[,1]
[1] 3 4 5
```

<br>

<mark>数据框行的操作

数据框的本质就是类矩阵操作的列表，具体而言数据框的每一列都是由列表组成的，且行数相同，操作与矩阵类似，都可以用`[[]]`和`[]`访问变量。一般的，使用`$`和`[[]]`也可以直接对数据框的变量进行访问，但前者不适用于矩阵，通常使用后者的灵活性会更高，适用于多种数据结构。

`order()`函数经常用于将数据框中按某一列进行从小到大的顺序进行行的重排，返回的是索引顺序的向量，通常使用`x[order(x),]`返回具体的行：
```R
#按e列中的元素从小到大排列（设置decreasing = TRUE可以降序排列）
a[order(a[["e"]]),]
  ID color class  e
2  4 green  2021 23
1  3   red  2020 40
3  5  blue  2022 90

#对两个列的顺序进行行重排，以第一个参数为准
a <- rbind(a,c(7,"yellow",2018,48))
> a
  ID  color class  e
1  1    red  2020 40
2  2  green  2021 23
3  3   blue  2022 90
4  7 yellow  2018 48

a[order(a[["e"]],a[["class"]]),]  ##先按e排，再按class排
  ID  color class  e
2  2  green  2021 23
1  1    red  2020 40
4  7 yellow  2018 48
3  3   blue  2022 90

##设置一个升序一个降序(在升序的前提下)
a[order(a[["e"]],-a[["class"]]),]
  ID  color class  e
2  2  green  2021 23
1  1    red  2020 40
4  7 yellow  2018 48
3  3   blue  2022 90
```
<br>

重复行与列的处理  
在R中，可以使用`duplicated()`函数检查数据框中是否存在重复的行或列，并返回逻辑值：
```R
##检查a中是否有重复的行
 duplicated(a)
[1] FALSE FALSE FALSE

##检查a中是否有重复的列
a
  ID  color class  e number
1  1    red  2020 40     10
3  3   blue  2022 90     20
4  7 yellow  2018 48     18

for(i in colnames(a)){
+ result <- duplicated(a[[i]])
+ print(result)
+ }
[1] FALSE FALSE FALSE
[1] FALSE FALSE FALSE
[1] FALSE FALSE FALSE
[1] FALSE FALSE FALSE
[1] FALSE FALSE FALSE

##替换重复的行
a <- a[!duplicated(a[[colnames]]),]
```

<br>

<mark> 合并数据框

通常，`merge()`函数提供了合并两个数据框的方法，并且可以通过设置参数来实现保留哪一个数据框为主：
```R
merge(x, y, all.x = FALSE, all.y = FALSE) #以某一共同行进行合并
```
两个参数若设置为`TRUE`，那么就保留该数据框的所有行：
```R
#示例
x <- data.frame(u = c(10,23,14,15),v = c(23,15,27,24))
> x
   u  v
1 10 23
2 23 15
3 14 27
4 15 24
> y <- data.frame(u = c(21,23,14,5),w = c(1,2,3,24))
> y
   u  w
1 21  1
2 23  2
3 14  3
4  5 24
> merge(x,y)
   u  v w
1 14 27 3
2 23 15 2
>
> merge(x,y,all.x = TRUE)
   u  v  w
1 10 23 NA
2 14 27  3
3 15 24 NA
4 23 15  2
>
> merge(x,y,all.y = TRUE)
   u  v  w
1  5 NA 24
2 14 27  3
3 21 NA  1
4 23 15  2
>
> merge(x,y,all.x = TRUE,all.y = TRUE)
   u  v  w
1  5 NA 24
2 10 23 NA
3 14 27  3
4 15 24 NA
5 21 NA  1
6 23 15  2
```

补充：  
`aggregate()`函数的用法：`aggregate` 是R语言中用于对数据进行分组并计算统计量的函数。它常用于数据框或矩阵，对分组后的数据应用一些函数（如均值、总和、计数等），并返回结果。
```R
#基本语法
#表示按照group分组，计算value的某函数值
result <- aggregate(value ~ group, data = mydata, FUN = fun)
 

#常规用法
df <- data.frame(
+ value = c(10,15,20,25,30,35),
+ group = c("A","B","A","C","B","C"))

 df
  value group
1    10     A
2    15     B
3    20     A
4    25     C
5    30     B
6    35     C

#根据group分组求value的均值
> result <- aggregate(df, value ~ group, FUN = mean) 
> print(result)
  group value
1     A  15.0
2     B  22.5
3     C  30.0

aggregate(iris[2],iris[5],function(x) c(Min = min(x), Max = max(x)))

     Species Sepal.Width.Min Sepal.Width.Max
1     setosa             2.3             4.4
2 versicolor             2.0             3.4
3  virginica             2.2             3.8

##若有多个group分组，就改为group1+group2+...+groupn；若数据为多列，可以使用cbind合并数据
```

<br>

<mark> 处理缺失值

`is.na()`用于检测向量或数据框中的缺失值，结果返回一个逻辑值，若为`TRUE`，则该位置具有缺失值。`na.omit()`直接删除数据中缺失值的行（数据框）或者值（向量），并返回去除后的结果：
```R
##is.na
x <- rbind(x, c(NA,31))
> x
   u  v
1 10 23
2 23 15
3 14 27
4 15 24
5 NA 31

> is.na(x)
         u     v
[1,] FALSE FALSE
[2,] FALSE FALSE
[3,] FALSE FALSE
[4,] FALSE FALSE
[5,]  TRUE FALSE

##na.omit
na.omit(x)
   u  v
1 10 23
2 23 15
3 14 27
4 15 24
```
<br>

补充：table到数据框的转化方式，可使用`as.data.frame.table()`进行转化：
```R
#基本语法
as.data.frame.table(x, responseName = "Freq", stringsAsFactors = TRUE, ...)

#示例
res <- table(sex = c("f","m","f","f","m"), grades = c("A","A","A","B","B"))
> res
   grades
sex A B
  f 2 1
  m 1 1
> res_frame <- as.data.frame.table(res)
> print(res_frame)

  sex grades Freq  #Freq为出现的频数
1   f      A    2
2   m      A    1
3   f      B    1
4   m      B    1
```
<br>

对数据进行分组转换

有时，需要根据数据集的子集情况来转换变量。例如，当我们决定用对应分组内的平均值替换缺失值，或者想要计算相对排名或Z分数时，就会遇到这种情况。通常，分组转换的具体操作分为：拆分、应用和绑定：
```R
##示例数据框
 x <- data.frame(
+ a = c(10,1,NA,NA,NA,4),
+ b = c(-1,10,40,30,1,20),
+ c = runif(6),
+ d = c("v","u","u","u","v","u")
+ )
> x
   a  b            c d
1 10 -1 0.7613621671 v
2  1 10 0.9576514973 u
3 NA 40 0.8632814593 u
4 NA 30 0.7171690566 u
5 NA  1 0.2582756914 v
6  4 20 0.0005376455 u

##编写处理数值的函数
fill_na <- function(x){ 
+ x[is.na(x)] <- mean(x[!is.na(x)])
+ return(x)
}

standardise <- function(x){
+ return((x-mean(x))/sd(x))
+ }

##按照d列进行分组
x_groups <- lapply(
+ split(x,x["d"]),
+ function(df){
+ df[["a"]] <- fill_na(df[["a"]])
+ df[["b"]] <- rank(df[["b"]])
+ df[["c"]] <- standardise(df[["c"]])
+ return(df)
+ })
> x_groups
$u
    a b          c d
2 1.0 1  0.7439292 u
3 2.5 4  0.5265718 u
4 2.5 3  0.1900389 u
6 4.0 2 -1.4605399 u

$v
   a b          c d
1 10 1  0.7071068 v
5 10 2 -0.7071068 v

##合并为一个数据框（rbind.data.frame()）
do.call(rbind.data.frame, x_groups)
       a b          c d
u.2  1.0 1  0.7439292 u
u.3  2.5 4  0.5265718 u
u.4  2.5 3  0.1900389 u
u.6  4.0 2 -1.4605399 u
v.1 10.0 1  0.7071068 v
v.5 10.0 2 -0.7071068 v
```

<br>

<mark>基于元编程的技术  

R中提供了一些便利接口的常用数据框操作函数，如`with()`、`subset()`等函数，也有像`dplyr`这类管道运算数据处理的包。
```R
##subset函数用法
subset(x, subset, select) #x为数据框，subset为条件（选择行），select选择展示的列，默认为全部列展示

##例子
subset(iris,Sepal.Length<4.5, select = c("Species","Sepal.Length"))
   Species Sepal.Length
9   setosa          4.4
14  setosa          4.3
39  setosa          4.4
43  setosa          4.4
```
<br>

`transform()`函数用于在数据框中进行列的转换或创建新列。它可以方便地对数据进行处理和转换，同时保留原数据框的结构，所以最后结果返回的是一个新的数据框，而原数据框仍可以访问。
```R
 mtcars1 <- mtcars[sample(seq_len(nrow(mtcars)),4),c("hp","mpg")]
> mtcars1
                hp  mpg
Merc 230        95 22.8
Toyota Corolla  65 33.9
Ferrari Dino   175 19.7
Duster 360     245 14.3

> mtcars2 <- transform(mtcars1, HP = log(hp), MPG = mpg*2)
> mtcars2
                hp  mpg       HP  MPG
Merc 230        95 22.8 4.553877 45.6
Toyota Corolla  65 33.9 4.174387 67.8
Ferrari Dino   175 19.7 5.164786 39.4
Duster 360     245 14.3 5.501258 28.6
```

<br>

attach 函数在 R 语言中用于将数据框的列直接附加到 R 的搜索路径上，使得可以在不使用数据框名称的情况下直接引用数据框中的列。这在处理复杂数据时可以简化代码，但也有一定的风险，特别是在大型脚本中，可能会导致命名冲突和其他潜在的问题。所以，可以使用`within()`函数来进行处理。
`within` 函数在 R 语言中用于在数据框的局部环境中对数据进行修改。这使得我们可以在数据框的局部环境中执行计算和操作，而不需要担心修改原始数据框或命名冲突的问题。within 函数提供了一个局部的环境，类似于 with 函数，但它允许我们修改数据框中的数据：
```R
#基本语法
within(data, {...})

##示例
mtcars3 <- within(mtcars1,{
+ log_hp <- log(hp)  #用括号括起来的部分可以直接使用变量名，不需要引用
+ fcon <- 235/mpg
+ hp <- NULL
+ fcon <- NULL})
> mtcars3
                mpg   log_hp
Merc 230       22.8 4.553877
Toyota Corolla 33.9 4.174387
Ferrari Dino   19.7 5.164786
Duster 360     14.3 5.501258  
```

<br>

练习与总结：
1. 数据框的属性  
   在 R 中，数据框具有以下属性：
```R
names：数据框中列的名称。  
row.names：数据框中行的名称或索引。  
class：对象的类别，对于数据框来说，通常是 "data.frame"。  
dim：数据框的维度，一个长度为 2 的向量，表示行数和列数。  
dimnames：一个包含两个元素的列表，第一个元素是行名称，第二个元素是列名称。  
levels：如果数据框中包含因子变量，还包括这些因子的水平。  
```

2. 如何创建一个矩阵列的数据框？
```R
# 创建一个矩阵
matrix_col <- matrix(1:9, nrow=3, ncol=3)

# 创建一个数据框，其中一列是矩阵,使用I封装成列表
df <- data.frame(id = 1:3, matrix_col = I(list(matrix_col)))

print(df)
```
3. 一些常见的易错点：
![alt text](e51ab76e28c541a0f149e60c69796d8-1.png)

![alt text](7068db2a995c289b6ad7e7aa14f683d.png)

![alt text](f63d861e92a31221318f518b758b0ef.png)


   


