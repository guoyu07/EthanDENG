## 问题
大家可能在绘图的时候会碰到这个问题，比如 R 的用户会发现，base R 里面绘图的数据和 ggplot2 所需的数据不太一样。具体来说，对于 base R 来说，wide 型数据更适合，而对于 ggplot2，如果是 wide 型数据，则不太方便，需要迁就于 qplot 函数，而不是使用 ggplot 函数。

## 数据类型
### long 型数据（tuition.csv）
<center>![long](http://ddswhu.com/wp-content/uploads/2015/07/long.png)</center>

### wide 型数据
<center>![wide](http://ddswhu.com/wp-content/uploads/2015/07/wide.png)</center>

## Stata 软件 long wide 互转
<pre class="lang:default decode:true " >
insheet using "E:\Sola\Git\Love2Share\reshape\tuition.csv", clear
 * long -> wide
reshape wide falltuit,i(inst) j(year)

 * wide -> long: method 1
reshape long falltuit,i(inst) j(year)
 * wide -> long: method 2
reshape long falltuit,i(inst)
rename _j year
</pre>

在 long 转为 wide 的时候，需要保留的是 falltuit 的值，而 inst 作为行，year 作为列。

在将 wide 转为 long 的时候，行需要保留的是仍然是 inst，而对于 year，如果不用 j(year) 这个选项的话，需要自行把列名 _j 改为 year。

## R 语言 long wide 互转

<pre class="lang:r decode:true " >
setwd("E:/Sola/Git/Love2Share/reshape")
long.df <- read.csv("tuition.csv")
library(tidyr)

 # long -> wide
wide.df <- spread(long.df, "year", "falltuit")
 # names(wide.df)[3:5] <- paste("falltuit", names(wide.df)[3:5], sep = "")

 # wide -> long (method 1)
long.dfx <- gather(wide.df,"year","falltuit",starts_with("201"))
 # wide -> long (method 2)
long.dfx <- gather(wide.df,"year","falltuit",3:5)
</pre>

tidyr 是 Hadley Wickham 开发的一个用于清洗数据的一个非常优秀的包（与 dplyr + ggplot2 搭配起来非常给力）。之前我们可能会使用 reshape(2) 这个包。如果你没有接触过 tidyr 这个包，一定要去尝试下哦！

tidyr 中最有用的两个函数就是 spread 和 gather，基本用法如上。year 作为 key, 而 falltuit 作为 value。最后面两个方法差别在于声明需要 gather 的列，前者是声明条件，后面是指明列。

## 参考文献

+ [Reshaping data in Stata (wide to long and long to wide)](https://www.youtube.com/watch?v=CMey0Qu08xo)
+ [Long to Wide data formatting with Spread function_tidyr R statistics](https://www.youtube.com/watch?v=hWxHR6BhiNM)
+ [Wide to Long data formatting and line plot with ggplot2](https://www.youtube.com/watch?v=EhWHmf6c7p8)
