在 R 中，我们能很方便的构建自己的函数做最大似然估计。本文将结合例子进行讲解。

## 语法结构
完成最大似然估计有两步，第一步是构造最大似然函数，这和我们一般的函数声明没太大差别；第二步是对最大似然函数做最优化。 这两步可以在 R 中交互地实现，也可以放在一个 `.R` 的文本文件中，然后运行这个文件。建议大家使用文件形式，特别是在可能需要运行多次的时候，交互形式可能不太方便。

### 声明对数似然函数

对数似然函数声明和普通函数声明没太大差别，一个函数声明中通常包含一个参数向量（pars）以及一个数据对象（object）。

对数似然函数声明的形式如下：

<pre class="lang:r decode:true " >
fun_name <- function(pars,object){
    # declarations
    logl <- loglikelihood function
    return(-logl)
    }
</pre>

其中，`fun_name` 是我们所定义函数的函数名，只要是满足 R 中变量命令的规则均可。`pars` 是参数的名字，`object` 是数据对象。而 `logl` 是我们的对数似然函数，返回的是 `-logl` 是因为我们之后用到的最优化函数 `optim` 是求最小值的一个函数。而我们需要的是最大化对数似然函数。

**示例 1**
我们考虑如下泊松对数似然函数，
<center>![Possion.MaxL](http://ddswhu.com/wp-content/uploads/2015/03/poisson.png)</center>

我们的函数声明如下：
<pre class="lang:r decode:true " >
poisson.lik<-function(mu,y){
    n <- nrow(y)
    logl <- sum(y)*log(mu) - n*mu - sum(lfactorial(y))
    return(-logl)
    }
</pre>  

其实，由于后面一部分与参数无关，在我们写函数的时候也可以省略这部分。这里` poisson.lik` 是我们声明的函数名，我们在后面优化的时候需要用到这个函数（作为 `optim` 的参数）。参数（向量）为 `mu`，而 `y` 为数据对象的占位符，类似于 C 语言中的形式参数。

**示例 2**
假设我们的样本来源于正态分布抽样，我们现在需要估计这个正态分布的均值和方差，正态分布的对数似然函数如下
<center>![Normal1.MaxL](http://ddswhu.com/wp-content/uploads/2015/03/normal.png)</center>

对应的函数声明如下：
<pre class="lang:r decode:true " >
normal.lik1 <- function(theta,y){
    mu <- theta[1]
    var <- theta[2]
    n <- nrow(y)
    logl <- -.5*n*log(2*pi) -.5*n*log(var) - (1/(2*var))*sum((y-mu)**2)
    return(-logl)
    }
</pre>

这里 `theta` 是我们所关心的参数（向量），需要注意的是，在我们声明最大似然函数的时候，在碰到多参数的时候，需要用参数向量，而不是多个参数的写法。`theta[1]` 是我们的均值 `mu`，而 `theta[2]` 是方差 `var`。

通过简单变形，上述的正态分布的最大似然函数（完整形式）可以写成
<center>![Normal2.MaxL](http://ddswhu.com/wp-content/uploads/2015/03/normal2.png)</center>

对应的函数声明变为：
<pre class="lang:r decode:true " >
normal.lik2<-function(theta,y){
    mu <- theta[1]
    sigma <- theta[2]
    n <- nrow(y)
    z <- (y-mu)/sigma
    logl <- -n*log(sigma) - sum(log(dnorm(z)))
    return(-logl)
    }
</pre>

其中，我们用到了系统自带的一个函数 `dnorm`，表示标准正态分布的密度函数（density function），这里，我们需要估计的一个参数是标准差 `sigma` 而不是方差 `var`。

## 最优化对数似然函数
我们声明对数似然函数之后，可以使用 `optim` 函数做最优化，`optim` 的函数使用方法为
<pre class="lang:r decode:true " >
optim(starting values, log-likelihood, data)
</pre>

`starting values` 为初始值，而 `log-likelihood` 为我们之前定义过的对数似然函数，`data` 为使用到的数据。`optim` 函数有多种求最值的方法，分别是 `"Nelder-Mead"（默认）, "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"` 使用方法为 `optim(...,method = "BFGS")`。

### 用法
如果是单个参数，可以如下使用
<pre class="lang:r decode:true " >
optim(1,poisson.lik,y=data,method="BFGS")
 </pre> 
这里 1 是初值，使用的方法是 `BFGS`。对于多个参数的形式，初值需要使用向量的形式：
<pre class="lang:r decode:true " >
optim(c(0,1),normal.lik1,y=y,method="BFGS")
</pre>

## 输出
+  `$par`：估计 MLE 估计得到的参数；
+  `$value`：最大似然函数值；
+  `$counts`：调用最大似然函数、梯度的次数；
+  `$convergence`：0 表示正常收敛了，1 表示迭代 10000次之后仍然不收敛；
+  `$message`：最优化过程中的信息，最好的情况是 `NULL`，表示没有任何警告或者错误。

## 致谢：

本文主要内容来源于讲义：[Marco R. Steenbergen] 的 *Maximum Likelihood Programming in R*。

