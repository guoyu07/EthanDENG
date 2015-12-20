## 问题来源
如何画不等距的直方图？这个问题是别人问我的，不过博主觉得这个图没有必要，所以一直没画，今天试了下，还发现了一些好东西，分享给大家！

## 源数据格式
我们把源数据读入 R 之后，看到源数据的形式如下：

<pre class="lang:r decode:true " >
> data
     V1
1  11.5
2  12.1
3   9.9
4   9.3
5   7.8
6   6.2
7   6.6
8   7.0
</pre>

那如何画呢？

### 第一次尝试
博主首先想到的是搜索网上，google 之后，看到了一个方法，参看 [ggplot2: Variable Width Column Chart](https://learnr.wordpress.com/2009/03/29/ggplot2-variable-width-column-chart/)，然后 follow 这篇博文的思路，我们首先对数据进行处理，得到如下格式的数据

<pre class="lang:r decode:true " >
> data
  x freq     height width
1 A    9 0.18750000     2
2 B   15 0.31250000     2
3 C    5 0.10416667     2
4 D    9 0.18750000     4
5 E    8 0.16666667     8
6 F    2 0.04166667    10
</pre>

然后根据上面我们参考的文献，使用下面绘图命令

<pre class="lang:r decode:true " >
df <- read.csv("datax.csv")
df$w <- cumsum(df$width) + 2
df$wm <- df$w - df$width
df$wt <- with(df, wm + (w - wm)/2)
ggplot(df, aes(ymin = 0)) + geom_rect(aes(xmin = wm, xmax = w, ymax = height)) + scale_x_continuous(breaks=df$w) + theme_bw()
</pre>

我们得到如下的图：
<center>![rec](http://ddswhu.com/wp-content/uploads/2015/06/rec2.png)</center>

好像成功了！哈哈，是不是不明觉厉？有些事我就不点破了。

### 另外的方法
另外一种方法实际上用到的命令是 `geom_hist` 命令，并且设定 `width` 参数，代码如下：

<pre class="lang:r decode:true " >
dati <- read.csv("datam.csv")
bins <- c(2,4,6,8,12,20,30)
ggplot(dati) +  geom_histogram( aes(x=class,y = ..density.., weight=num), breaks = bins, position = "identity") + scale_x_continuous(breaks = bins,labels=bins)
</pre>

效果图如下：
<center>![hist](http://ddswhu.com/wp-content/uploads/2015/06/hist2.png)</center>

### 评价
这两种方法你觉得怎样？看出了什么猫腻吗？哈哈，等待大家去发现！


## 参考文献

+ [ggplot2: Variable Width Column Chart](https://learnr.wordpress.com/2009/03/29/ggplot2-variable-width-column-chart/)
+ [Histograms with variable size binwidth in ggplot2](http://stackoverflow.com/questions/19389482/histograms-with-variable-size-binwidth-in-ggplot2)
+ [add axis ticks and labels in ggplot2 r](http://stackoverflow.com/questions/10488279/add-axis-ticks-and-labels-in-ggplot2-r)
