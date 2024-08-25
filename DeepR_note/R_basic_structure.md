## 本段介绍R语言的基本数据结构

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

mylist[1] <- list(c(123,321)) #mylist[1]也是一个子列表，相当于把一个列表赋值给这个子列表
> mylist
$id
[1] 123 321

$name
[1] "hn"

$class
[1] 2022

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

### 四、向量索引(vector index)
<mark> 取向量部分值

`head(a, b)`查看向量a中前b个元素, `tail(a, b)`返回向量a中后b个元素

```R
 x <- c(runif(10))
> x
 [1] 0.09132974 0.48655300 0.17757615 0.53243523 0.46595986 0.55937284
 [7] 0.82129799 0.89281962 0.15456344 0.98210655

head(x,5)
[1] 0.09132974 0.48655300 0.17757615 0.53243523 0.46595986

tail(x, 5)
[1] 0.5593728 0.8212980 0.8928196 0.1545634 0.9821066
```
<mark> 向量索引与切片

在R语言中,向量第一个元素是1位置,区分于python和C语言等其他语言;通常,如果定义一个向量`x`,那么首元素为`x[1]`,末元素为`x[length(x)]`

R语言和python一样,都支持分片操作:
```R
x[1:3]
[1] 0.09132974 0.48655300 0.17757615

x[c(1,2,3,5)] ##不要写成x[1,2,3,5]!!
[1] 0.09132974 0.48655300 0.17757615 0.46595986
```

在列表中,索引要注意`[]`和`[[]]`的区别:
```R
y <- list(1, 11:12, 21:23)
> y
[[1]]
[1] 1

[[2]]
[1] 11 12

[[3]]
[1] 21 22 23

###括号层数的区别:
y[2]
[[1]]
[1] 11 12  ##[]后的结果仍为一个列表,只是提取了原列表中第二层(子列表)

y[[2]]
[1] 11 12  ##[[]]后的结果是第二层的元素,此时是元素而不是列表
```
如果我想提取`y`的第二层中的第二个元素,可以采用如下操作:
```R
 y[[c(2,2)]] ##注意要用[[c()]]的形式,不能写成y[2][2]!
[1] 12
```
<br>

<mark> 负索引
```R
y[-1]  #除了y中第一个元素
[[1]]
[1] 11 12

[[2]]
[1] 21 22 23

y[-c(1,2)] #负索引也支持分片
[[1]]
[1] 21 22 23
```
注意,正索引和负索引不能同时出现,比如`x[-1:3]`是不对的,要写成`x[(-1):3]`才可以

<br>

<mark> 逻辑索引  

当且仅当TRUE时返回对应的元素,FALSE时元素被忽略
```R
x <- runif(4)
> x
[1] 0.3879617 0.6755077 0.5309930 0.9694041

> x[c(TRUE,FALSE,FALSE,TRUE)]
[1] 0.3879617 0.9694041  #只保留第1和4位元素

which(c(NA,TRUE,FALSE,FALSE))
[1] 2  #which返回TRUE的位置
```

<br>

<mark> 字符索引

在R中,也可以用字符作为索引:
```R
x <- structure(1:10, names=letters[1:10])
> x
 a  b  c  d  e  f  g  h  i  j
 1  2  3  4  5  6  7  8  9 10

x[c('a','c','h')]
a c h
1 3 8
```
<br>

<mark> 有关索引的函数

`%in%`常用来判断左边向量的成员是否存在于右边向量，比如：
```R
x <- c('red', 'green', 'white', 'black')
x %in% c('red','blue','white')
[1]  TRUE FALSE  TRUE FALSE
```

如果想要获取同时存在两个向量中元素的对应索引，可以使用`match()`函数：
```R
match(x, c('red','blue','white'))
[1]  1 NA  3 NA  ##x中red和white分别是右边向量的1和3号元素
```

使用`split()`函数来将向量划分为子类别，比如：
```R
name <- c('a', 'b', 'c', 'd')
color <- c('blue','blue','white','pink')
split(name,color)

$blue
[1] "a" "b"

$pink
[1] "d"

$white
[1] "c"
```

<br>

<mark> 对向量中的元素排序

如果`x`是一个向量，`order(x)`返回一个向量从小到大的值的索引排序，而`x[order(x)]` 返回从小到大排序结果

比如：
```R

x <- c(12,143,1244,34,26,467,232)
order(x)
[1] 1 5 4 2 7 6 3

x[order(x)]  ##与sort()的结果一致
[1]   12   26   34  143  232  467 1244

sort(x)
[1]   12   26   34  143  232  467 1244

##设置decreasing = TRUE， 可以从大到小排序
order(x,decreasing = TRUE)
[1] 3 6 7 2 4 5 1

x[order(x,decreasing = TRUE)]
[1] 1244  467  232  143   34   26   12
```

<br>

<mark> 识别重复值

`duplicated()`函数可以用来识别向量中重复出现的元素，并且以逻辑值返回：
```R
 x <- c(1,2,3,1,2,4,5,10,5,4,9,2)

duplicated(x)
[1] FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE

x[duplicated(x)]
[1] 1 2 5 4 2 #返回重复出现的元素，2重复出现了三次

##还可以用这个方法返回重复元素的次数
unique(x)
[1]  1  2  3  4  5 10  9

match(x, unique(x))
[1] 1 2 3 1 2 4 5 6 5 4 7 2

table(match(x,unique(x))) #返回x中重复出现的元素次数
1 2 3 4 5 6 7
2 3 1 2 2 1 1
```

##### 总结
1. `x[]`返回`x`中的所有元素，而`x[c()]`返回integer(0)
2. 向量的索引类型不能混用
3. `na.omit()`返回一个带有类属性的对象，而`as.vector(na.omit())`返回一个向量
4. 向量索引不可以超过最大长度，比如`x[length(x)+1]`是非法的


<br>

### 五、字符向量 (character vetors)
在R中，使用`'`或者`"`来引用字符串。`nchar()`返回一个字符串的长度；`cat()`用来输出和连接字符串。
```R
cat("hello world\n") #cat输出的字符串无引号，与print不同
hello world

cat('abc','aca','ada\n',seq="")
abc aca ada #cat函数没有自动换行，需要自行添加换行符

```

<br>

<mark> 字符连接函数

`paste()`函数用来连接多个字符串，通过设置`sep`和`collapse`参数来调整输出：
```R
##sep参数针对于一个对象，而collapse参数针对两个及以上的对象
a <- c('a','b','c','d')
> paste(a, collapse="")
[1] "abcd"

> paste(a,c(1,2,3,4),seq="")
[1] "a 1 " "b 2 " "c 3 " "d 4 "

> paste(a,c(1,2,3,4),seq="",collapse="")
[1] "a 1 b 2 c 3 d 4 "
```
<br>

`format()`函数用来格式化 R 对象，使其在输出时符合特定的格式要求;`sprintf()`函数类似于C语言中的`printf()`，可以设置字符串或数值的输出格式
```R
sprintf('%s','abad')
[1] "abad"
```

提取字符串字串可以用`substring()`函数处理：
```R
substring('my name is hn',1,7)
[1] "my name"
```

### 小结
这个文档记录了R语言基础的数据结构，包括数值型、字符串、逻辑类别对应的向量，以及基础的运算规则和数学函数。同时，还了解了列表的属性以及操作方法。向量的索引以及切片操作是重点。
