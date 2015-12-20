## xtable 简介
xtable 是一个 R 包，用于将 R 的对象（普通文本格式的表格）转化为 xtable 表格对象，然后导出为 LaTeX 或者 HTML 表格。

### 安装与加载
和普通的 R 包没有区别，安装加载 xtable 的命令分别为
<pre class="lang:r decode:true " >
install.packages("xtable") # 仅第一次需要安装
require(xtable)
</pre>

## 使用说明
安装之后就可以使用了，核心函数是 `xtable` 与 `print.xtable`，前者将我们 R 中的对象转为 xtable 对象，主要形式为：
<pre class="lang:r decode:true " >
new_object <- xtable(r_object) # 为了导出 r_object，创建 new_object
print.xtable(new_object, type="latex", file="filename.tex") # 导出到文件
</pre>

**NOTE**: 实际上，`print.xtable` 可以写为 `print`，后文均写为 `print`。

### `xtable` 函数主要参数解释

+ `x`: 需要转换的对象，比如回归模型，或者 ANOVA 的结果等等；
+ `caption`: 转换之后的表格的标题一个长度为 1 或者 2 的向量（`caption=c("Long Title","Short Title")`），前者用于表格上方显示，后者是这个 Caption 的简短形式，主要用于超链接中，比如 `List of Tables`，默认为`NULL`，；
+ `align`: 用于设置表格的列格式的字符向量，长度需要和表格列数一致，可以使用的选项有 `"l","r","c","r","p\{3cm\}"`，并且 `|`，可以加在这些选项中；
+ `digits`: 数字的显示位数，接受长度为 1 的数字或者长度为列数的向量，或者符合表格的行列要求的矩阵。
+ `display`: 数字的显示，可选项为 `"d"(整数), "f", "e"（科学计数）, "E", "g", "G", "fg" (实数), or "s" (字符串)`


### `print.xtable` 函数主要参数解释

`print.xtable` 有很多参数，可以定制自己的输出效果，下面对主要常用的参数进行解释，更多详细的内容参看 [xtable 主页](http://cran.r-project.org/web/packages/xtable/index.html)。

+ `x`: 需要输出的 xtable 对象；
+ `type`: 输出 LaTeX 表格还是 HTML，对应的选项为 `type="latex"`（默认）以及 `type="html"`；
+ `file`: 如果需要将表格输出到文件，则需要声明文件名，比如 `file="filename.tex"`；
+ `append`: 在上一个选项不为空的时候，`append=TRUE` 的时候表示将内容添加到声明的文件中，而不是覆盖原有文件，默认为 `FALSE`；
+ `floating`: 如果输出的表格中不需要最外层的 `table`(*)的环境，可以设置为 `floating=FALSE`，默认为 `TRUE`；
+ `floating.environment`: 当 `type=latex` 时，可选项为 `"table"` 和`"table*"`；
+ `table.placement`: 表格浮动设置，可选项为 `{"h","t","b","p","!","H"}`，默认为 `"ht"`；
+ `caption.placement`: 表格标题的放置，可选项为 `"top"` 和 `"bottom"`（默认），建议改为 `"top"`；
+ `booktabs`: 是否使用三线表，默认为 `FALSE`，如果选择 `TRUE`，注意需要在 LaTeX 源文件中添加 `booktabs` 宏包；

## xtable 示例
### 直接打印到屏幕
<pre class="lang:r decode:true " >
data(tli)
fm1 <- aov(tlimth ~ sex + ethnicty + grade + disadvg, data = tli)
fm1.table <- xtable(fm1, caption="ANOVA with Dataset tli")
print(fm1.table,caption.placement="top",booktabs=TRUE)
print(fm1.table,caption.placement="top",booktabs=TRUE)
</pre>

输出结果为：
<pre class="lang:tex decode:true " >
 % latex table generated in R 3.1.3 by xtable 1.7-4 package
 % Tue Mar 31 19:13:05 2015
\begin{table}[ht]
\centering
\caption{ANOVA with Dataset tli} 
\begin{tabular}{lrrrrr}
  \toprule
 & Df & Sum Sq & Mean Sq & F value & Pr($>$F) \\ 
  \midrule
sex & 1 & 75.37 & 75.37 & 0.38 & 0.5417 \\ 
  ethnicty & 3 & 2572.15 & 857.38 & 4.27 & 0.0072 \\ 
  grade & 1 & 36.31 & 36.31 & 0.18 & 0.6717 \\ 
  disadvg & 1 & 59.30 & 59.30 & 0.30 & 0.5882 \\ 
  Residuals & 93 & 18682.87 & 200.89 &  &  \\ 
   \bottomrule
\end{tabular}
\end{table}
</pre>

### 输出到 LaTeX 文件中
<pre class="lang:r decode:true " >
fm2 <- lm(tlimth ~ sex*ethnicty, data = tli)
fm2.table <- xtable(fm2,caption="linear model regression")
print(fm2.table,file="fm2.tex",append=TRUE,caption.placement="top",booktabs=TRUE)
</pre>

我们设定输出到 `fm2.tex` 文件中，并且表格标题置顶，使用 `booktabs` 宏包，使用添加结果的方式导出。在我们的文件夹内有一个文件叫 `fm2.tex`，然后我们可以在 LaTeX 文件中将我们的表格导入
<pre class="lang:tex decode:true " >
\documentclass{article} 

\usepackage{mathpazo,booktabs} % 要添加 booktabs 宏包

\begin{document}

\input{fm2.tex}

\end{document}
</pre>
编译效果为：
<center>![xtable](http://ddswhu.com/wp-content/uploads/2015/03/xtable.jpg)</center>

## 想了解更多？
更详细的情况，请查看 xtable 的文档说明或者 google 其使用方法！
