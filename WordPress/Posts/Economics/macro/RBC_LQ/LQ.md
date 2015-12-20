<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_HTMLorMML.js"></script>
## 本文说明

本文适用于经济学中 RBC 模型 Linear-Quadratic 方法的计算，如果只是为了了解 Jacobian 矩阵和 Hessian 矩阵的计算方法，可以直接略过某些设定以及术语！

## 函数的泰勒展开

令 \\(W = (z,s,d)^T\\)，\\(R(z,s,d)\\) 在 \\(\bar{W} = (\bar{z},\bar{s},\bar{d})^T\\) 处展开如下

\\[
R(z,s,d) = \bar{R} + (W-\bar{W})^T \bar{J} + \frac{1}{2} (W-\bar{W})^T \bar{H} (W-\bar{W})
\\]

其中 \\(\bar{R}\\) 为 \\(R(z,s,d)\\) 在 \\((\bar{z},\bar{s},\bar{d})^T\\) 处的取值，在我们这个问题里为稳定点的值，\\(\bar{J}\\) 和 \\(\bar{H}\\) 分别为 Jacobian 矩阵和 Hessian 矩阵（在稳定点的值）。

关于 Jacobian 矩阵与 Hessian 矩阵，我们不给出定义，只给出 Matlab 和 R 计算 Jacobian 矩阵与 Hessian 矩阵的方法。

## Matlab 计算 Jacobian 矩阵与 Hessian 矩阵

### Matlab 求解偏微分

在讲下面环节之前，我们想先看 Matlab 怎么求函数的偏微分。Matlab 计算微分的命令为 `diff(func,arg)`，一个简单的例子如下

<pre class="lang:matlab decode:true " >
syms x y z
f = cos(x)*sin(y) + z;
diff(func,'x')
 </pre> 

### Matlab 计算 Jacobian 矩阵

由偏微分我们可以通过如下计算得到 Jacobian 矩阵

<pre class="lang:matlab decode:true " >
 % define the return function
syms z k x
r = log(exp(z)*k^a-x);

 % the steady state of capital, investment and shocks
K = ( (a*b)/(1-b*(1-d)) )^(1/(1-a));
X = d*K;
Z = 0;

 % compute the partial derivatives with respect to z k x
rz = diff(r,'z');
rk = diff(r,'k');
rx = diff(r,'x');
J = [rz;rk;rx];
J0 = double(subs(J,[z,k,x],[Z,K,X]))

 % another direct method to compute Jacobian matrix 
Jx = jacobian(r,[z,k,x]);
Jx0 = double(subs(Jx',[z,k,x],[Z,K,X]))
</pre>

### Matlab 计算 Hessian 矩阵

<pre class="lang:matlab decode:true " >
 % setting as former section
syms z k x
...
J = [rz;rk;rx];
 % compute Hessian Matrix
 % method 1
H = [diff(rz,'z'),diff(rz,'k'),diff(rz,'x');
     diff(rk,'z'),diff(rk,'k'),diff(rk,'x');
     diff(rx,'z'),diff(rx,'k'),diff(rx,'x')];

 % method 2
H = jacobian(jacobian(r,[z,k,x]),[z,k,x]);

 % method 3
H = hessian(r,[z,k,x]);

 % eval at (Z,K,X)
H0 = double(subs(H,[z,k,x],[Z,K,X]))
 % output of the code
H0 =

   -0.3959   -0.0370    1.1206
   -0.0370   -0.0379    0.1047
    1.1206    0.1047   -0.7389
</pre>

## R 语言计算 Jacobian 矩阵与 Hessian 矩阵

说起 R 语言，真是伤心啊，由于不懂 R 语言这些人脑袋里想的是啥，看了半天没看懂怎么求 Jacobian 矩阵和 Hessian 矩阵，直到最后顿悟了！我们仍然使用上面的例子来演示。

在计算矩阵之前，需要安装 `numDeriv` 包，这是一个数值微分的包，详细内容可以参考 [numDeriv](http://cran.r-project.org/web/packages/numDeriv/index.html)。安装之后我们加载它。

<pre class="lang:r decode:true " >
install.packages("numDeriv")
library(numDeriv)
</pre>

下一步，我们为模型设定参数，也即函数的参数设置。并且计算出稳定点（steady state）的值，记为 \\(W=(Z,K,X)^T\\)。

<pre class="lang:r decode:true " >
 # parameter for the economy
a <- 0.33
b <- 0.96
p <- 0.95
d <- 0.10

 # the steady state(SS) of capital, investment and shocks
K <- ((a*b)/(1-b*(1-d)))^(1/(1-a))
X <- d*K
Z <- 0
W <- as.matrix(c(Z,K,X))
</pre>

然后定义 return function 为

<pre class="lang:r decode:true " >
re_fun <- function(u) {
    z <- u[1]; k <- u[2]; x <- u[3];
    return(log(exp(z)*k^a-x))
}
</pre>

再用如下命令计算得到 Jacobian 矩阵与 Hessian 矩阵。

<pre class="lang:r decode:true " >
 # jabobian matrix and hessian matrix
 # Taylor Expansion of return function
R0 <- re_fun(W)
J0 <- t(jacobian(re_fun,W))
H0 <- hessian(re_fun,W)
</pre>

## LQ 方法的完整代码

LQ 原版本代码参见 [RBC-LQ](https://dge.repec.org/codes/marimon-scott/Diaz/lqxk.m)，修改版以及 R 语言版 见文后下载部分。

[file]

