# R learning notes by henan
## learning resource：deepr、R数据科学实战、R语言实战
### supplementary source: dplyr  
（https://github.com/tidyverse/dplyr.git）

## 目录
1. R语言基础数据结构（向量、列表）
2. R语言进阶数据结构（矩阵、数据框）
3. R包与函数
4. 图形绘制
5. S3类面向对象
6. tidyverse基础（补充）
7. R深度（deepest）

这是我的R语言学习笔记和总结，借鉴了包括像deepr、R数据科学实战、R语言分析等书籍。以下是我阅读deepr这本书的总结感想，我把它分成了七个模块，所有的笔记和代码我会上传到GitHub上的R_basic文件夹里，方便后续补充完善。


## 本书概要
这本书一共分为三个模块：R basic、Rdeeper、和R deepest，难度逐层递增。  
在本书的第一部分，作者重点介绍了R语言的基础知识，包括R环境与交互模式、数值型向量与逻辑向量的操作、列表及其属性、和一些常见的数学函数与运算。这一部分较为基础。  

<br>

本书的第二部分是R语言的进阶知识。首先介绍了向量的索引，通过索引可以进行对数据的引用和修改。其次，作者还介绍了字符串的具体操作。同时，作者深入探讨了函数设计与R包的简单撰写与管理，包括数据流、函数组织与特殊函数。最后，在第二章末尾，本书介绍了R语言中重要的面对对象的S3类方法。

<br>

本书的最后部分是R的高级方法，介绍了环境模型、闭包、惰性运算与元编程的概念，同时学习了R中的绘图方法与操作。

## 心得体会
阅读完本书后，我对R语言的理解更加深刻了。以前我总把这门编程语言当成工具，使用别人编写好的函数和R包进行自己的分析。但其实，R是一门非常完备的编程语言，具有自己的逻辑与思路。同时，R语言的绘图环境管理的非常好，许多R包调用后能出很多精美的图像，像`ggplot`系列让图片绘制更加轻松美观，这是许多编程语言所做不到的。R中也有很多方便进行数据处理的函数与R包，`tidyverse`系列可以使用管道运算符进行数据框的清洗操作。最后，作为一名生物信息学的学生，R语言是必须要掌握的。在专业方面，有`seurat`和`Bioconductor`两个系列的环境能够进行单细胞分析。目前这类型的分析的pipeline已经比较成熟。  

