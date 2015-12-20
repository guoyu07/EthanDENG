## 使用 dplyr 包进行数据操作与清洗

在我们数据分析的实际应用中，我们可能会花费大量的时间在数据清洗上，而如果使用 R 里面自带的一些函数（`base` 包的 `transform` 等），可能会觉得力不从心，或者不是很人性化。好在我们有其他选择。这里我们介绍 `dplyr` 包。

## 单表操作函数（one table verbs）

+ filter: 保留满足条件的行
+ select: 使用列名选出列
+ arrange: 对数据的所有行排序
+ mutate: 添加新的变量
+ summarise: 分类汇总

这些函数的结构如下：

+ 第一个参数为 data frame 名
+ 接下来的参数是指定函数操作的依据（或条件）
+ 通常返回的是一个 data frame 

我们这里一个一个函数介绍，为了更好地表述我们的操作，我们这里使用一个构造的 data frame。
<pre class="lang:r decode:true " >
df <- data.frame(
      color = c("blue", "black", "blue", "blue", "black"),
      value = 1:5)
</pre>  

### filter 
`filter` 用于选择满足条件的观测（行），第一个参数是 data frame 名字，第二个参数是条件。这里举两个例子，我们对上面构造的 data frame 进行 filter 操作。第一个例子要求选取 `color == blue` 的观测； 第二个例子要求选取 `value == 1` 或者 `value == 4 ` 的观测。

我们的 data frame 如下：
<pre class="lang:r decode:true " >
> df
  color value
1  blue     1
2 black     2
3  blue     3
4  blue     4
5 black     5
</pre>

例子：
<pre class="lang:r decode:true " >
# 选取 `color == blue` 的观测
> filter(df, color == "blue")
  color value
1  blue     1
2  blue     3
3  blue     4
 # 选取 `value == 1` 或者 `value == 4 ` 的观测。
> filter(df, value %in% c(1, 4))
  color value
1  blue     1
2  blue     4
</pre>

效果如下：
<center>![dplyr](http://ddswhu.com/wp-content/uploads/2015/02/dplyr.png)</center>


**注意**： 这里需要提醒的是，对于多条件的选择，需要完整条件的，然后使用集合运算符将条件拼接起来。集合运算符有 `!`、`|`、`&`、`xor`(交补)。条件的判断符有`>(=)`、`<(=)`、`==`、`!=`、`%in%` (判断元素是否在集合或者列表内，返回逻辑值)。
<pre class="lang:r decode:true " >
filter(flights, dest %in% c("SFO", "OAK"))
filter(flights, dest == "SFO" | dest == "OAK")
 # 下面是错误写法
filter(flights, dest == "SFO" | "OAK")
</pre>

### select 

`select` 用于选择列，比如
<pre class="lang:r decode:true " >
> select(df, color)
  color
1  blue
2 black
3  blue
4  blue
5 black
> select(df, -color)
  value
1     1
2     2
3     3
4     4
5     5
</pre>

**注意**：`select` 中负号表示不选择。其中变量的声明还有其他形式，比如`B:F`表示从 B 列到 F 列所有列；`ends_with("string")` 表示选取列名以 string 结尾的全部列；`contains("string")` 表示选取列名中含有 string 的所有列。代码如下：
<pre class="lang:r decode:true " >
select(flights, arr_delay, dep_delay)
select(flights, arr_delay:dep_delay)
select(flights, ends_with("delay"))
select(flights, contains("delay"))
</pre>

### arrange 

`arrange` 用于根据变量排序，如果排序依据（列）是字符，按照字母表的顺序，如果是数字，默认按照从小到大的顺序排序，如果需要使用逆序排，可以使用`desc(var)` 或者 `-var`。
<pre class="lang:r decode:true " >
> arrange(df, color)
  color value
1 black     2
2 black     5
3  blue     1
4  blue     3
5  blue     4
> arrange(df, desc(value))
  color value
1 black     5
2  blue     4
3  blue     3
4 black     2
5  blue     1
</pre>

**注意**：多个排序依据直接把列名放在函数内，用逗号隔开；可以在排序里面使用计算，比如
<pre class="lang:r decode:true " >
arrange(flights, date, hour, minute)
arrange(flights, desc(dep_delay - arr_delay))
</pre>

### mutate 

`mutate` 用于添加新的变量，直接使用列名进行计算得到新变量即可。而且它很有特色地方是，可以使用刚添加的变量，也就是在一个语句中可以多个变量，而且变量可以来源于刚新建的变量。
<pre class="lang:r decode:true " >
> mutate(df, double = 2 * value, quadruple = 2 * double)
  color value double quadruple
1  blue     1      2         4
2 black     2      4         8
3  blue     3      6        12
4  blue     4      8        16
5 black     5     10        20
</pre>

### summarise 

`summarise` 可以用于“分类汇总”，但不是传统意义上的分类汇总，它还能做更多。
<pre class="lang:r decode:true " >
> by_color <- group_by(df, color) # 分组依据
> summarise(by_color, total = sum(value)) # 分组求和
Source: local data frame [2 x 2]
  color total
1 black     7
2  blue     8
</pre>
实际上它是把我们现有的完整 data frame 依据分组依据（这里是 `color`）拆分成多个 data frame，然后对每个 data frame 分别计算，类似于 `ddply`。

使用经历：分组依据可以多个，比如根据城市、月份、年份，我们对数据进行分类汇总，可以得到每个城市每一年每月的情况。

`summarise` 可以使用的函数有：

+ min(x), median(x), max(x), quantile(x, p)
+ n(), n_distinct(), sum(x), mean(x)
+ sum(x > 10), mean(x > 10)
+ sd(x), var(x), iqr(x), mad(x)

## 参考资料：

Hadley Wickham：*Data manipulation with dplyr*.

## 结语

本文只是一个引子，`dplyr` 包还有很多内容值得大家学习，用于更加高效的清洗数据，事实上，我现在每次处理数据的时候都需要用到这个包，确实非常好的一个包，用法简单，功能强大，推荐大家去学习使用！
