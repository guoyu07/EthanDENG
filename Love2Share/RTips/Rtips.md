本文内容来源于 Rstatistics.net 的 60 R Tips，这些都是作者们长期使用 R 积累下来的一些技巧或者建议。我觉得这个内容挺好的，并且在书上看不到这些内容，所以做了搬运和翻译，重点是加了例子，否则如果只看文字可能搞不懂状况。


1、在将 factor 类型的变量转为数值变量的时候切记不要使用 `as.numeric()`，正确的方式是 `as.numeric(as.character(myFactorVar))`。
<pre class="lang:r decode:true " >
cha2fac <- as.factor(c("4","8","10","15"))
as.numeric(cha2fac)
as.numeric(as.character(cha2fac))
</pre>


2、使用选项 `options(show.error.messages = F)` 可以关闭错误信息提示。
<pre class="lang:r decode:true " >
class(x) # error msg: Error: object 'x' not found
options(show.error.messages = F)
class(x)
</pre>

3、使用 `file.path()` 创建（使用）文件路径，这可以保证在不同系统下都适用。
<pre class="lang:r decode:true " >
setwd(file.path("F:", "git", "roxygen2"))
</pre>


4、在对字符串排序的时候，如果需要对数字也能排序，可以使用 `gtools` 包中的 `mixedsort()`，效果与 `sort()` 不一样。
<pre class="lang:r decode:true " >
Treatment <- c("Control", "Asprin 10mg/day", "Asprin 50mg/day", "Asprin 100mg/day", "Acetomycin 100mg/day", "Acetomycin 1000mg/day")
sort(Treatment)
require(gtools)
mixedsort(Treatment)
</pre>

5、在绘图的时候使用 `ylim = range(myNumericData) + 10` 可以调整 Y 轴绘图范围，可以使用倍数或者区间值。
<pre class="lang:r decode:true " >
x <- seq(1:10)
set.seed(1101)
y <- 10*rnorm(10)
plot(x, y)
plot(x, y, ylim = 1.25*range(y))
</pre>


6、使用 `plot()` 绘图时，可以使用 `las` 参数调整坐标轴标签（数字）的显示方向，`las` 取值 `{0，1，2，3}`，对应的对齐方式为 {平行于轴（默认），水平（这个不错），垂直于轴，垂直}。
<pre class="lang:r decode:true " >
plot(x, y, las = 1)
plot(x, y, las = 2)
</pre>


7、关于高阶回归分析的使用情境的汇总参看：[http://rstatistics.net/special-forms-of-regression/](http://rstatistics.net/special-forms-of-regression/)

8、`Use memory.limit(size=2500)` 限制 R 占用内存。

9、`alarm()` 函数可以添加到我们函数、过程的末尾，用以提示工作完成进度。（注意：RStudio 中无效）
<pre class="lang:r decode:true " >
for (i in 1:5) {
Sys.sleep(1)
alarm()
}
</pre>

10、`eval(parse(text=paste("a <- 10")))` 会创建向量 `a` 并赋值为 10。这个命令可以将字符串作为 R 命令执行。
<pre class="lang:r decode:true " >
eval(parse(text=paste("a <- 10")))
a
</pre>

11、`sessionInfo()` 可以获取 R 的版本、环境信息，以及加载的包的信息。
<pre class="lang:r decode:true " >
sessionInfo()
</pre>
 
12、计算从 word1 到 word2 所需要的变化可以使用 `adist(word1, word2)`.
<pre class="lang:r decode:true " >
adist("hello world","hello wordx")
</pre>

13、使用选项 `options(max.print=1000000)` 可以增加控制台的信息显示的行数。
<pre class="lang:r decode:true " >
options(max.print=1000000)
</pre>

14、如何检测时间序列中的奇异值？

[https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-
detection-in-a-time-series](https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-
detection-in-a-time-series)

15、如果有多个 R 会话，每个 R 的唯一 id 可以用 `Sys.getpid()` 获取。
<pre class="lang:r decode:true " >
Sys.getpid()
</pre>

16、可以使用 `unname()` 去除 R 对象的名称属性。
<pre class="lang:r decode:true " >
y <- quantile(mtcars$mpg)
unname(y)
</pre>

17、检验两个对象（`x` 和 `y`）是否一致使用 `identical(x, y)`，使用 `all.equal` 会比较各种属性是否一致。
<pre class="lang:r decode:true " >
x <- c(1, 2)
y <- as.vector(x)
identical(x, y)
all.equal(x, y)
y2 <- c(y, 3)
all.equal(x, y2)
</pre>

18、使用 R 获取 Twitter 推文（用于文本分析）。
[http://rstatistics.net/extracting-tweets-with-r/](http://rstatistics.net/extracting-tweets-with-r/)

19、关于时间序列分析简短的介绍：
[http://rstatistics.net/time-series-analysis/](http://rstatistics.net/time-series-analysis/)

20、当某个步骤运行的时间太长（超过预先设定的时间），可以使用 `R.utils` 包中的 `withTimeout()` 打断，然后跳到下一个步骤继续运行。

21、可以使用 `dist()` 计算矩阵行与行之间的距离（默认是欧氏距离）。
<pre class="lang:r decode:true " >
x <- matrix(seq(1:20), ncol = 4, byrow = FALSE)
dist(x, method = "euclidean", upper = TRUE)
</pre>

22、计算向量的（多重）差分可以使用 `diff()`
<pre class="lang:r decode:true " >
x <- c(seq(1:5), seq(from = 1, to = 9, by = 2))
diff(x, 2) 
</pre>

23、选项 `options(scipen=999)` 可以关闭数字科学记数法显示。
<pre class="lang:r decode:true " >
1e-5
options(scipen=999)
1e-5
</pre>

24、`earth` 包中的 `bagEarth()` 可以用来做 Bagged MARS (多元适应性回归平滑)

25、可以使用 `setClass('myClass')` 定义一个类型 `myClass`，`setAs()` 可以做进一步的自定义。

26、创建大量的变量可以使用 `assign ("varName", 10)`，原因在于，我们可以向 `varName` 传递变量名（比如用循环），方便编程。
<pre class="lang:r decode:true " >
assign("x", 10)
</pre>

27、dim(matrix) 返回的是矩阵的行数与列数。
<pre class="lang:r decode:true " >
my.Matrix <- matrix(1:20, ncol = 4)
dim(my.Matrix)
</pre>

28、两个编写函数的技巧：1. 使用 `...` 传递已有函数的参数。2. 使用 `invisible` 隐藏输出。
视频参看：[https://www.youtube.com/watch?v=ahRHTXNjixU](https://www.youtube.com/watch?v=ahRHTXNjixU)

29、使用 `data.matrix()` 可以将一个数据框转为数值矩阵，并且因子类型也会得到正确的转化。

30、`invisible(..)` 可以不显示输出，在定义函数的时候经常使用到。

31、`cat("\014")` 能清空 R 会话中的内容（类似于 `CTRL + L` 清屏，还是蛮有用的）。
<pre class="lang:r decode:true " >
cat("\014")
</pre>

32、`dir("folder.path")` 会显示文件夹内的内容，类似于 cmd。
<pre class="lang:r decode:true " >
dir()
dir("subfolder.path")
</pre>

33、在一个因子变量中如果存在缺失值，建议将缺失值做成一个因子等级 `UNKNOWN`，可以使用 `levels(Var) <-c(levels(Var), "UNKNOWN")` 来实现。
<pre class="lang:r decode:true " >
my.Factor <- as.factor(c("First", "Second", "Third", NA))
levels(my.Factor) <-c(levels(my.Factor), "UNKNOWN")
my.Factor
</pre>

34、初始化所有加载的包可以使用 `lapply(x, require, character.only = T)`，其中 `x` 为包的名称。
<pre class="lang:r decode:true " >
lapply(c("dplyr", "tidyr"), require, character.only = T)
</pre>

35、`rev()` 函数可以将一个向量翻转过来。
<pre class="lang:r decode:true " >
x <- seq(1:10, )
rev(x)
</pre>

36、`complete.cases()` 顾名思义，它的作用是得到完整观测（不含缺失）的索引，用于数据框缺失值的行删除。
<pre class="lang:r decode:true " >
nrow(mtcars)mtcars$mpg[mtcars$disp > 200] <- NA
mtcars
mtcars2 <- mtcars[complete.cases(mtcars), ]
mtcars2
</pre>

37、`nnet` 包中的 `avNNet()` 可以用来做 `Averaged` 神经网络模型。

38、`file.remove('filepath')` 可以用来删除文件夹中的文件，如果我们要删除重复性的中间文件，可以用它来实现。
<pre class="lang:r decode:true " >
file.create("tempfile.R")
file.remove("tempfile.R")
</pre>

39、`ada` 包中的 `ada()` 函数可以用来做 `Boosted` 分类树问题。

40、`unclass()` 可以将 `lm` 对象拆散成列表（`list`），方便我们获取未被显示的元素。
<pre class="lang:r decode:true " >
mod <- lm(wt ~ disp + cyl, data = mtcars)
unclass(mod)
</pre>

41、根据数据框（`df`）的两列进行排序可以使用 `df[order(df$col1, df$col2), ]`
<pre class="lang:r decode:true " >
mtcars
mtcars[order(mtcars$carb, mtcars$hp), ]
</pre>

42、将一个 N 阶因子变量转为 N 个 0-1 变量最简单的方式是 `model.matrix(~as.factor(Data)+0)`
<pre class="lang:r decode:true " >
model.matrix(~as.factor(mtcars$carb)+0)
</pre>

43、对一个时间序列去季节趋势可以使用 `seaadj()`：
[http://goo.gl/Oio7s2](http://goo.gl/Oio7s2).

44、在一个函数内对函数外的变量的赋值使用 `<<-`，而不要用 `<-`。

45、在 Windows 中，使用 `memory.limit(size=desired-size)` 可以限制 R 使用内存的大小，其他操作系统，使用 `mem.limits()`。

46、使用 `file.copy(from=fromFile, to = toFile, overwrite = TRUE)` 可以实现文件的复制。

47、`debugonce()` 可以调试一次代码，它与 `debug()` 的区别是无需使用 `undebug()` 跳出调试。

48、在 R 中，将一个因子类型的变量（`factor`）转化为一组 0/1 虚拟变量可以使用 `bins <- model.matrix(~ 0 + varName, data)`，在回归的时候经常会用到这个。（同 42）

49、`arules` 包中的 `discretize()` 函数可以很方便的将一个连续变量转为分类变量（`categorical`）。

50、`NROW()` 类似于 `nrow()`，不过前者对向量也适用，相比 `length()` 更具有鲁棒性。

51、在 R 里面输入 `commandArgs()`，将会返回使用 cmd 运行 R 脚本所需要传递的参数。

52、在函数内使用 `attr(myFunc, "AttrName") <- myVal`，在我们下次调用 `myFunc` 的时候将会记住 `AttrName` 这个属性。

53、`object.size()` 可以得到给定 R 对象所消耗的内存。

54、当我们处理比较大的 R 项目的时候，可以使用 `ls.str()` 查看这些 R 对象的结构信息。

55、`dir(path='dir_path')` 将会列出 `dir_path` 下的所有文件及文件夹。

56、`library(help = libname)` 会显示 `libname` 这个包的所有函数以及所带的数据集。（前提是必须安装了这个包）
<pre class="lang:r decode:true " >
install.packages("AER")
library(help = AER)
</pre>

57、`get("objectNameString")` 会获取对象名称为 `objectNameString` 的对象。如果这个对象在一个特定的环境中，使用 envir 参数。
<pre class="lang:r decode:true " >
x <- c(1, 2, 3)
get("x")
</pre>

58、使用 cmd 运行 R 代码：`"C:\your-R-path\R.exe" CMD BATCH --vanilla --slave` 
<pre class="lang:r decode:true " >
"c:\project-path\my_script.R" #（可以用这个写自动运行的脚本，比如批处理。）
</pre>

59、可以使用 `cor.test(x,y)` 计算 `x` 与 `y` 的相关性。

60、如果你要做交互式的数据展示，Shiny 是一个很好的选择，这里是 Shiny 的一张备忘单。
[http://bit.ly/1pFWGJW](http://bit.ly/1pFWGJW)
