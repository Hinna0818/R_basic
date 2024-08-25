## 数据工程与数据整理
在本节中，我会使用`baseR`、`dplyr`、`data.table`三种方法进行处理

### 一、数据选取
使用已知的内置数据集`iris`进行操作  
任务1. 对花瓣长度大于2的xx花展现花瓣的长度和宽度：  

<br>

`baseR`语法：`data[row_condition,select = colnames, drop = FALSE]`  
通过条件来选取行，并附上需要展现的列。

```R
#baseR
 data <- iris[iris$Petal.Length > 2, c("Petal.Length", "Petal.Width", "Species")]

> head(data,10)
   Petal.Length Petal.Width    Species
51          4.7         1.4 versicolor
52          4.5         1.5 versicolor
53          4.9         1.5 versicolor
54          4.0         1.3 versicolor
55          4.6         1.5 versicolor
56          4.5         1.3 versicolor
57          4.7         1.6 versicolor
58          3.3         1.0 versicolor
59          4.6         1.3 versicolor
60          3.9         1.4 versicolor

##baseR特点：速度快，API稳定。但默认设置很麻烦
```

`data.table`的用法跟`baseR`类似  
```R
##data.table
library(data.table)
iris_data.table <- as.data.table(iris)
> cols <- c("Petal.Length", "Petal.Width", "Species")
> rows <- iris_data.table$Petal.Length > 2

iris_data.table <- iris_data.table[rows, ..cols]
> head(iris_data.table)
   Petal.Length Petal.Width    Species
          <num>       <num>     <fctr>
1:          4.7         1.4 versicolor
2:          4.5         1.5 versicolor
3:          4.9         1.5 versicolor
4:          4.0         1.3 versicolor
5:          4.6         1.5 versicolor
6:          4.5         1.3 versicolor
```

<br>

`dplyr`提供了管道运算符`%>%`将各个步骤串联起来，其中`dplyr::select`选取列，`dplyr::filter`筛选行  
```R
##dplyr
iris_dplyr <- iris %>%
+ select(Petal.Length, Petal.Width, Species) %>%
+ filter(Petal.Length > 2)
> head(iris_dplyr)
  Petal.Length Petal.Width    Species
1          4.7         1.4 versicolor
2          4.5         1.5 versicolor
3          4.9         1.5 versicolor
4          4.0         1.3 versicolor
5          4.6         1.5 versicolor
6          4.5         1.3 versicolor
```

<br>

### 二、处理缺失值
一般处理缺失值可以使用`na.omit`，他会自动返回没有缺失值的行。同时，也可以使用`complete.cases()`，它可以对行的缺失值进行忽略：
```R
a <- data.frame(a = c(1,2,3,NA,NA), b = c(2,NA,3,4,1))
> a
   a  b
1  1  2
2  2 NA
3  3  3
4 NA  4
5 NA  1

#使用baseR
> a[complete.cases(a),]
  a b
1 1 2
3 3 3
> na.omit(a)
  a b
1 1 2
3 3 3

#使用dplyr
b <- a %>%
+ filter(., complete.cases(.))
> b
  a b
1 1 2
2 3 3
```

<br>

### 三、dplyr
#### 行
1. `fliter`  
`fliter`允许我们根据列的值保留行，第一个参数为数据帧，第二个参数为筛选的条件。
```R
flights |> 
  filter(dep_delay > 120)
#> # A tibble: 9,723 × 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
#> 1  2013     1     1      848           1835       853     1001           1950
#> 2  2013     1     1      957            733       144     1056            853
#> 3  2013     1     1     1114            900       134     1447           1222
#> 4  2013     1     1     1540           1338       122     2020           1825
#> 5  2013     1     1     1815           1325       290     2120           1542
#> 6  2013     1     1     1842           1422       260     1958           1535
#> # ℹ 9,717 more rows
#> # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>, …
```

condition可以由`>>=<<===!=&,|`随机组成。如果想对同一个列名进行操作，可以使用：`flights |> fliter(month %in% c(1, 2)) `

当运行 dplyr 时，dplyr 会执行筛选操作，创建一个新的数据帧，然后打印它。它不会修改现有数据集，因为 dplyr 函数永远不会修改它们的输入。要保存结果，您需要使用赋值运算符 ：`filter()flights<-`

2. `arrange` 
   
根据列的值更改行的顺序。它需要一个数据帧和一组列名（或更复杂的表达式）来排序。如果提供多个列名，则每个附加列将用于打破前面列的值中的平局。例如，下面的代码按出发时间排序，该时间分布在四列中。首先得到最早的年份，然后在一年内得到最早的月份，依此类推。
```R
flights |> arrange(year, month, day, dep_time)
# A tibble: 336,776 × 19
    year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
   <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
 1  2013     1     1      517            515         2      830            819
 2  2013     1     1      533            529         4      850            830
 3  2013     1     1      542            540         2      923            850
 4  2013     1     1      544            545        -1     1004           1022
 5  2013     1     1      554            600        -6      812            837
 6  2013     1     1      554            558        -4      740            728
 7  2013     1     1      555            600        -5      913            854
 8  2013     1     1      557            600        -3      709            723
 9  2013     1     1      557            600        -3      838            846
10  2013     1     1      558            600        -2      753            745
```
这样，行就从年到月到日进行逐步排序，优先级逐级递减。如果想对某一列进行从小到大或者从大到小排序，可以：
```R
flights |> arrange(desc(dep_time))
# A tibble: 336,776 × 19
    year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
   <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
 1  2013    10    30     2400           2359         1      327            337
 2  2013    11    27     2400           2359         1      515            445
 3  2013    12     5     2400           2359         1      427            440
 4  2013    12     9     2400           2359         1      432            440
 5  2013    12     9     2400           2250        70       59           2356
 6  2013    12    13     2400           2359         1      432            440
 7  2013    12    19     2400           2359         1      434            440
 8  2013    12    29     2400           1700       420      302           2025
 9  2013     2     7     2400           2359         1      432            436
10  2013     2     7     2400           2359         1      443            444
```

3. `distinct`  

`distinct`查找 `dataset` 中的所有唯一行，因此从技术意义上讲，它主要对行进行操作。但是，大多数时候，需要一些变量的不同组合，因此还可以选择提供列名称：
```R
flights |> 
  distinct(origin, dest, .keep_all = TRUE)
#> # A tibble: 224 × 19
#>    year month   day dep_time sched_dep_time dep_delay arr_time sched_arr_time
#>   <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
#> 1  2013     1     1      517            515         2      830            819
#> 2  2013     1     1      533            529         4      850            830
#> 3  2013     1     1      542            540         2      923            850
#> 4  2013     1     1      544            545        -1     1004           1022
#> 5  2013     1     1      554            600        -6      812            837
#> 6  2013     1     1      554            558        -4      740            728
#> # ℹ 218 more rows
#> # ℹ 11 more variables: arr_delay <dbl>, carrier <chr>, flight <int>, …
```

<br>

#### 列
1. `mutate`

`mutate`的工作是添加从现有列计算的新列。通常该函数会将新列默认添加到最右侧，大多情况下会看不到，所以可以通过设置参数`.before = 1`来将新列设置到最左侧：
```R
flights |>
+ mutate(gain = dep_delay - arr_delay,
+ .before = 1
+ )
# A tibble: 336,776 × 20
    gain  year month   day dep_time sched_dep_time dep_delay arr_time
   <dbl> <int> <int> <int>    <int>          <int>     <dbl>    <int>
 1    -9  2013     1     1      517            515         2      830
 2   -16  2013     1     1      533            529         4      850
 3   -31  2013     1     1      542            540         2      923
 4    17  2013     1     1      544            545        -1     1004
 5    19  2013     1     1      554            600        -6      812
 6   -16  2013     1     1      554            558        -4      740
 7   -24  2013     1     1      555            600        -5      913
 8    11  2013     1     1      557            600        -3      709
 9     5  2013     1     1      557            600        -3      838
10   -10  2013     1     1      558            600        -2      753
```
跟前面一样，操作只打印一个操作后的数据框，并不会真的保存。所以，记得赋值。

2. `select`
  
使用`select`可以快速放大数据，选择感兴趣的列进行讨论：
```R
flights |> select(day, month, year) #选择想要的列

flights |> select(day:year) #选择day和year中间的所有列

flights |> select(!(day:year)) #除day和year中间的列都选择
```

3. `rename`

`rename`可以重命名变量，并保留剩下的变量：
```R
#语法
df |> rename(new_name = old_name)

#示例
flights |> rename(Day = day)
# A tibble: 336,776 × 19
    year month   Day dep_time sched_dep_time dep_delay arr_time sched_arr_time
   <int> <int> <int>    <int>          <int>     <dbl>    <int>          <int>
 1  2013     1     1      517            515         2      830            819
 2  2013     1     1      533            529         4      850            830
 3  2013     1     1      542            540         2      923            850
 4  2013     1     1      544            545        -1     1004           1022
 5  2013     1     1      554            600        -6      812            837
 6  2013     1     1      554            558        -4      740            728
 7  2013     1     1      555            600        -5      913            854
 8  2013     1     1      557            600        -3      709            723
 9  2013     1     1      557            600        -3      838            846
10  2013     1     1      558            600        -2      753            745
```

4. `relocate`

用于移动变量。我们可能希望将相关变量一起收集或将重要变量移到最前面。默认情况下，将变量移到前面。也可以设置参数`.before = colname `或`.after = colname`来手动设置调整的位置：
```R
bble: 336,776 × 19
   arr_time  year month   day dep_time sched_dep_time dep_delay sched_arr_time
      <int> <int> <int> <int>    <int>          <int>     <dbl>          <int>
 1      830  2013     1     1      517            515         2            819
 2      850  2013     1     1      533            529         4            830
 3      923  2013     1     1      542            540         2            850
 4     1004  2013     1     1      544            545        -1           1022
 5      812  2013     1     1      554            600        -6            837
 6      740  2013     1     1      554            558        -4            728
 7      913  2013     1     1      555            600        -5            854
 8      709  2013     1     1      557            600        -3            723
 9      838  2013     1     1      557            600        -3            846
10      753  2013     1     1      558            600        -2            745

#手动设置
flights |> relocate(dep_time, .before = day)
```

#### 组
1. `group_by`

用于将数据集划分对研究有意义的组：
```R
#base
df |> group_by(group)

#example
flights |> group_by(month)
```
`group_by`不会更改数据，但如果仔细查看输出，会注意到输出指示它“分组”月份。这意味着后续操作现在将“按月”工作。将此分组功能（称为类）添加到数据框中，这将更改应用于数据的后续动词的行为。

2. `summarize`

`dplyr` 中的 `summarize` 是一个强大的函数，用于根据分组数据计算各种汇总统计量。它与 `group_by` 函数配合使用，可以轻松实现复杂的数据汇总操作。通过灵活运用 `summarize`，可以实现对数据的各种统计分析和摘要计算。
```R
#example
#根据month分组，求每个month的到达时间的均值
flights |>
+ group_by(month) |>
+ summarize(avr_arr_time = mean(arr_time, na.rm = TRUE))
# A tibble: 12 × 2
   month avr_arr_time
   <int>        <dbl>
 1     1        1523.
 2     2        1522.
 3     3        1510.
 4     4        1501.
 5     5        1503.
 6     6        1468.
 7     7        1456.
 8     8        1495.
 9     9        1504.
10    10        1520.
11    11        1523.
12    12        1505.
```
注意，这里设置了`na.rm = TRUE`，避免了缺失值带来的影响，即计算均值的时候忽略缺失值。

3. `slice`

`slice `是一个非常有用的函数，可以轻松选择或删除数据框中的特定行。它与其他 `dplyr` 函数（如 `group_by`）结合使用时，可以执行更复杂的数据操作。通过灵活使用 `slice `及其变体 `slice_head`, `slice_tail`, `slice_max`, 和 `slice_min`，可以更好地控制数据框的行选择过程。
```R
#base
slice(data, ...)

#用法
slice_head(n = m) #选择前面m行
slice_tail(n = m) #选择后面m行

slice_max(order_by = colname, n = m) #按照colname选择值最大的m行
slice_min(order_by = colname, n = m) #按照colname选择值最小的m行

slice(-c(a, b, c)) #删除第a、b、c行
```

