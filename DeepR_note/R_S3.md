## 面向对象编程（OOP）
前言：在本模块的学习中，我们将学习R语言中面向对象编程的方法 (S3)。

<br>

回顾：`attributes()`、`typeof()`、`class()`的区别：  
`attribute` 是一个对象的元数据，可以包含多种信息，比如类属性、维度、名称等。
`typeof` 描述对象的底层数据类型，即对象在内存中的存储方式。如整数、逻辑值等
`class` 描述对象的行为类别，决定对象如何与泛型函数交互，通常通过属性来设置。
```R
x <- matrix(c(1,2,3,4))
x
     [,1]
[1,]    1
[2,]    2
[3,]    3
[4,]    4

> class(x)
[1] "matrix" "array"

> typeof(x)
[1] "double"

> attributes(x)
$dim
[1] 4 1
```

<br>

### 一、S3的定义
`S3泛型（S3 Generics）`是R语言中的一种面向对象编程机制，它允许你定义一个函数的通用接口（即泛型），然后为不同类型的对象提供特定的实现（即方法）。S3泛型是基于R的早期版本（S语言的第3版）开发的，因此得名S3。

`泛型（Generics）`是面向对象编程中的一个概念，指的是具有相同名称但操作不同类型数据的一组函数。泛型函数在不同的编程语言中可能有不同的实现和特性。在R语言中，S3泛型是一种特殊的函数，它们可以根据输入对象的类（class）属性来分派（dispatch）到相应的方法（method）。

特点：  

**通用接口**：泛型函数定义了一个操作的通用形式，但它不实现具体的功能，而是根据传入对象的类属性来分派到相应的方法。  

**方法调度**：当调用泛型函数时，R会根据第一个参数的类属性（有时是其他参数）来选择并调用相应的方法。  

**灵活性**：S3系统允许用户为自定义类编写方法，使得这些类可以与内置的泛型函数无缝协作。

<br>

### 二、S3对象的创建
S3 类是一种不需要显式定义的类，类的定义主要依赖于为对象分配一个类属性。S3 类实际上只是一个具有特定名称的属性，这意味着同一个对象可以属于多个类。示例如下：
```R
obj <- list(name = 'henan', age = 20, class = 2022)
class(obj) <- 'student'

 obj
$name
[1] "henan"

$age
[1] 20

$class
[1] 2022

attr(,"class")
[1] "student"
```
在这里，我构建了一个名为`obj`的`student`类对象，其中包含三种成员。

<br>


### 三、方法调度
S3方法是基于函数名称和类的组合来实现的，R会自动选择最适合的函数来处理特定类的对象。这被称为“泛型函数”机制。通常，我们可以使用`generic.class`的定义方式来定义特定类的函数，`generic`是一个通用的方法，比如`summary`,`plot`,`print`等，`class`就是一个S3对象，比如：
```R
print.student <- function(x){
+ cat(sprintf("my name is %s",x$name),"\n")
+ cat(sprintf("my age is %d",x$age),"\n")
+ cat(sprintf("my class is %d",x$class),"\n")
+ }

> print(obj) #改变了obj这个对象的print输出（重新根据需求定义）

my name is henan
my age is 20
my class is 2022

##如果我想按照原来默认的输出
print.default(obj)
$name
[1] "henan"

$age
[1] 20

$class
[1] 2022

attr(,"class")
[1] "student"
```

使用`unclass()`函数，将原来的class类对象还原成最初的类型，如：
```R
unclass(obj)
$name
[1] "henan"

$age
[1] 20

$class
[1] 2022

> typeof(obj)
[1] "list"    ##还原成了列表
```

