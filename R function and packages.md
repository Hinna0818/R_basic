## R语言函数与R包的认识与构建

### 一、 函数 (function)
前言：本文档主要以函数的撰写练习为主，所有的函数直接在PowerShell终端运行。

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

