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
这里记得插入一张运行图片

```
```R
##数学函数
abs(x) #绝对值
sqrt(x) #算术平方根

##对数和指数函数
log(x, base = y) #以y为底x的对数，base默认值为e
exp(x) #e的x次方

##运算函数
sum(c(1,2,3)) ##对函数内的向量求和
prod(c(1,2,3)) ##对函数内的向量累乘
max(x)
min(x)

mean(x)
var(x) #方差
sd(x) #标准差

```
```R
##小数位数的操作
floor(x)  #向下取整
ceiling(x) #向上取整
trunc(x)  #截尾
round(x, digits = y) #保留y位小数。y取负数就往个位十位方向保留

##运算符
%/% #表示整除部分
%% #表示余数

##比较向量相同位置大小
pmin(c(1, 2, 3, 4), c(4, 2, 3, 1))
## [1] 1 2 3 1

pmin(3, 1:5)
## [1] 1 2 3 3 3

pmax(1:5,2)
## [1] 2 2 3 4 5
```
##### 总结
数值型向量主要注意运算符的类别和顺序、基本数学函数的应用、随机生成一段序列等等。  
<br>
<br>


### 二、 逻辑向量（logical vectors）
在R语言中，逻辑用TRUE（1）和FALSE（0）来表示，可以通过比较两个向量相同位置比较，返回逻辑值<br>
比较符号：
```R
== #判断符号
!= #不等符号
```
<br>

<mark> NA、NULL、Inf的区别和用法：

NULL与长度为零的向量表现相似，是安全的，在向量中出现可认为是0  
NA代表不可用，一般用来注释缺失值，可以通过```R
is.na(x)```来判断x中的缺失值，用`is.NULL()`来判断NULL值，通过`na.omit(x)`来删除x中的缺失值  
Inf代表无穷，有正无穷和负无穷的分别  

<mark> 逻辑运算符

`&` 为且、`|`为或，通常用来连接向量，逐步比较向量相同位置的元素；而`&&`和`||`是懒惰运算符，如果第一个位置的比较后就能得出最终结果，就不用比较后面的位置了。

ifelse结构
```R
ifelse(a, b, c) ##如果a是TRUE，结果就为b，否则为c

#例子：
 z <- rnorm(5)
> ifelse(z > 0.5, z, -z)
[1] 1.190207 1.689556 1.239496 0.108966 0.117242
> z
[1]  1.190207 -1.689556  1.239496 -0.108966 -0.117242
```

### 三、列表和属性（lists and attributes）
#### 类别
我们可以使用`typeof()`函数来确定某个对象的类别。  

类别转换：`as.numeric()、as.characters()、as.factors()、as.logical()`可以转换对象的类别。

其中，TRUE和FALSE可以作为1和0进行一些简单的运算，比如：
```R
c(TRUE)+1
[1] 2
c(TRUE+FALSE+TRUE)
[1] 2
```

#### 列表（list）
<mark> 创建一个列表
```R
mylist <- list('id'=1234, 'name'='hn', 'class'= 2022)
> mylist
$id
[1] 1234

$name
[1] "hn"

$class
[1] 2022

str(mylist) ##查看列表成员的类别
List of 3
 $ id   : num 1234
 $ name : chr "hn"
 $ class: num 2022
```

<mark> 列表取值
```R
mylist[[1]] ##双括号取元素
[1] 1234

> mylist[1] ##单括号取完还是列表
$id
[1] 1234

mylist$'id'
[1] 1234

mylist$id
[1] 1234
```

<mark> 列表的嵌套
```R
list(list(1,2,3),4,5)
[[1]]
[[1]][[1]]
[1] 1

[[1]][[2]]
[1] 2

[[1]][[3]]
[1] 3


[[2]]
[1] 4

[[3]]
[1] 5
```
<mark> 列表元素的增删改
```R
##修改列表各元素名
names(mylist)
[1] "id"    "name"  "class"
names(mylist) <- c('ID','Name','Class')
mylist
$ID
[1] 1234

$Name
[1] "hn"

$Class
[1] 2022

##添加新项
mylist$Sex <- c('Male')
> mylist
$ID
[1] 1234

$Name
[1] "hn"

$Class
[1] 2022

$Sex
[1] "Male"

##修改元素
mylist$ID <- c(3227030006,123) #添加新的ID元素
> mylist
$ID
[1] 3227030006        123

$Name
[1] "hn"

$Class
[1] 2022

$Sex
[1] "Male"

mylist <- mylist[-3] #删除第三个类
> mylist
$ID
[1] 3227030006        123

$Name
[1] "hn"

$Sex
[1] "Male"
```

<mark> 列表的合并
```R
newlist <- list('age' = 20, 'height' = 170)
combined <- c(mylist, newlist)
combined
$ID
[1] 3227030006        123

$Name
[1] "hn"

$Sex
[1] "Male"

$age
[1] 20

$height
[1] 170
```

<mark> 列表的转化
```R
unlist(combined)
ID1   ID2    Name   Sex   age  height
"3227030006"   "123"    "hn"   "Male"   "20"   "170"

##unlist后转化为有key值的向量，类似于python里的字典
```
也可以使用`as.list()`来将向量转化为列表


#### 属性（attributes）
使用structure结构，构造“键值对”属性  

<mark> 列表的属性
```R
x_simple <- 1:10

x <- structure(
x_simple, 
attribute1="value1",
attribute2=c(6, 100, 324)
) ## x的两个属性
```

有一些特殊的属性，如数据框的列名  
<br>

<mark> 向量的属性
```R
x <- structure(c(13, 2, 6), names=c("spam", "sausage", "celery"))
> x
   spam sausage  celery
     13       2       6
> print(x)
   spam sausage  celery
     13       2       6
> names(x)
[1] "spam"    "sausage" "celery"
> attr(x,'names')  ##截取x的names属性
[1] "spam"    "sausage" "celery"
```

我们可以通过`structure()`在原对象的基础上来重新声明一个结果，来达到增删改的效果；或者可以使用`attr(x, "some_attribute") <- new_value`来修改x的一个属性  
  

<br>

### 四、向量索引（vector index）



