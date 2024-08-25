## R语言函数与R包的认识与构建

### 一、 函数 (function)
前言：本模块主要学习R语言中基础函数的写法和R包的相关知识

在R中，函数的定义方式为：
```R
function_name <- function(args){
body
}
```
函数包括形参（传进去的参数）、函数实体（函数运行的主要表达式和函数的返回值（有些函数可以没有返回值，表示一个操作，类似于C语言中的`void()`函数

函数可以被赋值为一个对象，通过引用这个对象并传入参数，可以实现对象的函数化:
```R
##举个例子
add <- function(x, y){
return(x+y)
}

> add(1,2)  
[1] 3
```
<br>

练习1：写一个函数`standardise()`,将一个向量中的元素进行标准化
```R
standardise <- function(vector){
vector <- (vector-mean(vector))/sd(vector)
return(vector)
}

> standardise(c(1,3,2,5,3,4,2))
[1] -1.3805850  0.1061988 -0.6371931  1.5929827  0.1061988  0.8495908 -0.6371931
```

练习2：写一个函数`concat()`连接两个字符串，并且用`""`连接
```R
concat <- function(x,y){
result <- paste(x,y,sep = "")
return(result)
}

> concat('Hi','nna')
[1] "Hinna"

##也可以使用管道运算符|>来传参
'Hi' |> concat('nna')
[1] "Hinna"
```

练习3：Write a function `normalise()` that takes a numeric vector x and returns its version
shifted and scaled to the [0, 1] interval. （归一化）
```R
normalise <- function(vector){
vector <- (vector-min(vector))/(max(vector)-min(vector))
return(vector)
}

> normalise(c(23,14,22,15,3,1,6))
[1] 1.00000000 0.59090909 0.95454545 0.63636364 0.09090909 0.00000000 0.22727273
```

练习4：写一个函数`fill_na()`，输入一个向量和一个填充函数，使得向量中的缺失值被非缺失值的某函数填充，这里以`mean()`为例：
```R
fill_na <- function(x, fill_fun){
missing_position <- is.na(x)
replacing_value <- fill_fun(x[!missing_position])
x[missing_position] <- replacing_value
return(x)
}

fill_na(c(10,23,NA,18,5,NA),mean)
[1] 10 23 14 18  5 14
```
<br>

<mark> 一些常见内置函数


`what`是一个函数，`args`是一个对象，可以是列表或向量，它将列表或向量中的元素作为参数传递给指定函数。它允许在运行时动态地调用函数，并且可以用于简化代码和提高可读性。

`do.call()`函数用法:
```R
do.call(what, args, quote = FALSE, envir = parent.frame())
```
<br> 

`Map()`函数是R语言中的一个函数，用于并行地对多个列表或向量的元素应用指定的函数。它类似于 `lapply()`，但可以同时处理多个输入列表。`Map()` 返回一个列表，其中每个元素是对输入列表的相应元素应用函数后的结果。
```R
Map(f,...) #f为函数，...为对象
```

<br>

<mark> 从R包中获取函数

R包管理平台：
1. `CRAN`，全称为 `The Comprehensive R Archive Network`（综合R档案网络），是R编程语言的主要软件包存储库。它是一个分布式的网络系统，旨在存储和分发R语言及其扩展包。我们通常用的`install.packages()`就是从`CRAN`中下载包。
   
2. `Bioconductor` 是一个专门用于生物信息学和计算生物学的开源软件项目。它与 `CRAN` 类似，也提供了一个平台来分发 R 包，但其重点在于支持基因组数据分析和其他生命科学相关的数据分析。`Bioconductor` 提供了一套高质量的 R 包，主要用于处理和分析生物数据，如基因表达数据、基因组数据、蛋白质组数据等。
   
注意：`Bioconductor` 的包不能直接通过 `install.packages() `从 `CRAN `安装，而是需要使用 `Bioconductor `提供的专用安装工具：
```R
# 下载特有安装的平台包
install.packages("BiocManager")

# 使用 BiocManager 安装 Bioconductor 包
BiocManager::install("DESeq2")
```
<br>

`::`运算符：用于从特定包中引用函数或对象。这种语法确保了引用的函数或对象是来自指定的包，而不会因命名冲突而调用其他包中的同名函数或对象。并且，如果我没有加载这个包，同样也可以访问这个包里的函数。
```R
# 使用 ggplot2 包中的 ggplot 函数
ggplot2::ggplot(data = mtcars, aes(x = mpg, y = wt)) + geom_point()
```

`::`可以避免不同包的相同函数名的混调，非常方便

<br>


R包的存储路径函数为`.libPaths()`:
```R
.libPaths()
[1] "C:/R/R-4.3.1/library" #我的R包存储路径
```
如果我想重新设置一个R包访问路径，而不覆盖原来的路径，可以用：
```R
libPaths(c(additional_lib_path, .libPaths()))
```

<br>

### 二、控制流 (flow)
条件控制:  
在R中,使用`if`和`else`构造条件语句,多条件可以用`else if`实现
```R
if(condition){
    expression
}

else(condition){
    expression
}
```
短路连接符  
`&&`和`||`通常用来连接多个逻辑值,在`if`中运用;同时,它也被称为短路连接符或者是`lazy`的操作,因为如果第一次比较就能知道最后结果,剩下就不用比较了;而`&`和`|`通常用在向量的比较

while  
`while()`通常用于单个可修改的条件判断,只要为真就运行:
```R
while(conditon){
    expression
}
```

for循环
for循环的基本语法与python相似:
```R
for name in vector{
    expression
}
```

比如,我要输出abcd四个字母,可以用:
```R
for(i in c('a','b','c','d')){
cat(sprintf("%s\n",i))}
```

再比如:
```R
##打印一个下三角乘法表
for (i in 1:9) {
  for (j in 1:i) {
      cat(sprintf("%d x %d = %d " ,i,j,i*j))
    }
      cat("\n")
  }
```

while和for循环的应用场景: for 循环通常用于已知迭代次数的场景，而 while 循环更适合条件驱动的循环

但是,通常我们在写`for`循环里面的条件时,一般不用`name in 1:length(name)`,因为如果name是一个空向量的时候会报错,我们可以用`name in 1:seq_along(name)`

next和break的区别
在R中,`next`相当于C语言中的`continue`,意思是跳过当前循环,进入下一个循环,不执行后面的语句;而`break`就是跳出所有循环,运行循环后的结果,举个例子:
```R
##使用next跳出当前循环
for (i in 1:5) {
+   if(i==3){
+     next
+   }
+   print(i)
+ }
[1] 1
[1] 2
[1] 4
[1] 5

##使用break跳出所有循环
for (i in 1:5) {
+   if(i==3){
+     break
+   }
+   print(i)
+ }
[1] 1
[1] 2
```
<br>


### 三、设计函数
简洁性  
   能用几行代码的事情绝不写多，代码要讲究简洁性，不能写的冗杂，看不懂。比如，要写多个条件的判断语句时，如果用太多的和跟或符号，会使得语句过于冗杂，我们可以使用`stopifnot()`函数来构建多条件的判断语句：
   
```R
stopifnot(expr1, expr2...)
```
其中，expr是一个条件，只有全部满足括号内的条件表达式才执行下面的语句，否则报错，这相当于是筛选了输入的参数。

<br>

<mark> 从外部导入R脚本

我们可以使用`source()`函数来导入外部的一个R脚本，从而调用这个脚本的函数：
```R
source("path to file.R")
```
一般为了方便，可以设置工作目录为该脚本的文件目录下，这样可以直接使用文件名传入`source`函数：
```R
setwd("path to file.R")
source("xxx.R")
```

<br>

### 四、撰写R包
在撰写R包之前，建议先安装两个方便处理R包的R包（听起来很怪是吧），`devtools` 和 `roxygen2` （便于编写文档语言）这两个包要安装好。

同时，`pkg`包是R语言中的一个包管理工具，用于简化R包的安装、更新和管理。它可以从CRAN、Bioconductor、GitHub上下载包，具体用法如下：
```R
##加载pkg包
library(pkg)

##下载多个R包
pkg::pkg_install(c("package1","package2"))

##更新R包与移除R包
pkg::pkg_update()
pkg::pkg_remove()
```
<br>

### 1. R包的基本结构  
   （1） DESCRIPTION   
   一个包含本项目的名字、版本、作者信息、与其他包的依赖性等的文本文件

   （2） NAMESPACE   
   一个包含本项目中出现的对象名称和其他包中的对象名称  

   （3）R  
   一个包含本项目主要函数的代码和一些示例数据的R文件  

   （4）man  
   man文件夹是用于存放帮助文档（手册页，manual pages）的目录。每个R包的man目录下都会包含一系列以.Rd为扩展名的文件，这些文件是R包函数、数据集、以及其他导出对象的帮助文档。

### 2. 文档记录
在自己撰写的R包当中，除了主要的脚本函数与输出示例数据，也要对该项目下的函数、对象、输入、输出等步骤进行解释，这就需要编写一个R文档来实现。其中，这些要写在man文件夹的子目录下，以.Rd文件实现（使用类似于LateX的语法来撰写）。这个文件最后会以`help()`函数来调用。

<br>

### 五、撰写代码的注意事项
1. 使用git来管理代码与脚本文件，并学会使用GitHub。
2. 找好R语言的编辑器，比如R Studio和VS等，方便debug
3. 学会使用R内置的函数`Rprof()`进行代码运行的记录，可以知道一段代码运行的时间
   
<br>

### 六、一些特殊的符号
`<-`符号用于进行赋值操作，把右值赋给左边的对象；而`$`符号表示对一个对象的引用，通常用于列表和数据框中：
```R
 mylist <- list(name = 'hn',age = 20,class = 2022)
> mylist$name
[1] "hn"

> mylist[['name']] #这里[[]]内要加引号
[1] "hn"
```
如果引用的名称中含有特殊字符或空格，此时只能使用`[[]]`来引用了。一般来说`[[]]`会比`$`要更快，并且后者不适用于原子向量和矩阵。

我们通常使用的是`if`语句，这里说明一下`if()`函数的用法：
```R
##格式
'if'(test, what_if_true, what_if_wrong)

##示例
'if'(runif(1)<0.5,"yes","no")
[1] "yes"

##类似于
ifelse(runif(1)<0.5,"yes","no")
[1] "yes"
```

几个百分号符号的用法：  
`%%`返回两个数相除的余数（取模），`%/%`返回两个数相除的数的整数部分（截尾）、`% in %`返回成员关系

<br>

省略号`...`的用法：  
在 R 语言中，`...`（省略号） 是一个非常有用的功能，它用于在函数定义中表示一个可变数量的参数。`...` 允许你向函数传递任意数量的参数，而无需在函数定义中明确列出这些参数。这样使得代码更具有灵活性和简洁性，比如：
```R
sum_up <- function(...){
return(sum(...))
}

> sum_up(1:100) #无需在定义函数的时候设置过多的参数
[1] 5050
```

### 总结与练习
1. Will `stopifnot(1)` stop? What about `stopifnot(NA)`, `stopifnot(TRUE, FALSE)`,
and `stopifnot(c(TRUE, TRUE, NA))`    答：只要`stopifnot()`的括号内是真，就可以运行。NA是缺失值，既不是真也不是假，通常会返回错误并停止运行。所以第一个可以运行。

<br>

2. Does`attributes<-(x, NULL)` modify x?  
答：`attributes(x) <- NULL`会将x的所有属性移除，但对x本身的数据无影响。

<br>

3. What is the difference between `names(x)[1] <- new_name` and `names(x[1]) <- new_name`?  
答：`names(x)[1] <- new_name` 修改的是对象 x 的第一个元素的名字。
`names(x[1]) <- new_name` 是试图修改 x 的第一个元素的名字，但这在大多数情况下是没有意义的，因为它仅会修改一个子集的名字，而不是原对象的名字。比如：
```R
x <- structure(1:3,names=c('a','b','c'))
> names(x)[1] <- 'h' #成功对第一个元素修改
> x
h b c
1 2 3

> names(x[1]) <- 'a'
> x
h b c
1 2 3
```






