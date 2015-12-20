## 如何在 Stata 里面跑 R 代码

在一个计量软件（Stata）里面跑统计软件（R）代码？ 是的，你没有看错，虽说这个想法有点猎奇，但是，你仔细想下，会觉得如果能实现，那么 R 与 Stata 就能协同工作了，一个不懂 R 语言的 Stata 用户可以使用 Stata 来运行你的代码，是不是感觉世界明亮多了？，废话不多说，我们来看怎么实现吧？

## 准备工作
### 安装 rsource
首先，要让 Stata 软件能够运行 R 代码，先要在 Stata 里面安装一个包（rsource），安装的命令如下：
<pre class="lang:default decode:true " >
ssc install rsource
</pre>

## 实现
### R 代码

首先我们写一个 R code，内容如下：
<pre class="lang:r decode:true " >
data(swiss)                                       # 使用 swiss 数据集
attach(swiss)                                     
library(foreign)                                  # 加载 foreign 包，可以写入输出其他软件的数据格式
write.dta(swiss, "D:/swiss.dta")                  # 将数据集保存为 Stata 数据
model <- lm(Fertility ~ Agriculture + Catholic)   # 线性回归
summary(model)                                    # 回归的汇总信息
</pre>

我们把这个文件存为 `mytest.R`，存在 D 盘下，即`D:/mytest.R`

### Stata 代码

首先，新建一个 do 文件，然后把下面代码输入其中，Stata 代码如下：
<pre class="lang:default decode:true " >
/*Command (1) */

cd "D:/"

/*Command (2) */

global Rterm_path `"F:\Program Files\R-3.1.2\bin\x64\R.exe"'

global Rterm_options `"--vanilla"'

/*Command (3) */

rsource using mytest.R,roptions(--slave)

/*Command (4) */

use "swiss.dta"

regress Fertility Agriculture Catholic
</pre>

运行之后，首先是 mytest.R 的结果显示如下（在 Stata 中）：

<center>![rstata](http://ddswhu.com/wp-content/uploads/2014/12/rstata.png)</center>

然后是 Stata `regress` 的结果：

<center>![stata](http://ddswhu.com/wp-content/uploads/2014/12/stata.png)</center>

### 解释
这里这个例子中，由于 swiss 数据集是 R 自带的，为了能够与 Stata 的回归结果进行对比，使用了 foreign 包把数据集写到 D 盘中（`D:/swiss.dta`），以便 Stata 使用（`use "swiss.dta"`）。本质上，如果只是为了让 Stata 运行 R 代码并不需要 `foreign` 包，也不需要 Stata 代码中的第四部分代码（`use .... regress ... `），使用到的最核心的 Stata 命令是：
<pre class="lang:r decode:true " >
rsource using mytest.R,roptions(--slave)
</pre>

## 结语
这个方法其实挺好的，对于懂 R 语言以及 Stata 的用户来说，在两个软件之间互转明显可以增加自己的选择以及可操作性，但是，对于某个软件的忠实捍卫者或者大牛，这个东西就不是那么重要了。

**原文链接（英文）**：[Run R Through Stata On Mac](http://danielmarcelino.com/running-r-through-stata-on-mac-os/)
