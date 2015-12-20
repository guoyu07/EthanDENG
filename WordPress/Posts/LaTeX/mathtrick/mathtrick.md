## LaTeX 数学式的精细调整

从整体来看， LaTeX 数学排版的数学公式已经非常精美，但是在复杂的的公式的个别细微之处，如果能够人工调整下字符间距或字符尺寸等，则会使之更加完美！

## 定界符的调整

常用的定界符主要是各种括号。为了能够调整定界符的大小以适应其中的数学结构的高低，LaTeX 提供了 `\big`、`\Big`、`\bigg`、`\Bigg` 共 4 个档次的加高命令，以及 `\left` 和 `\right` 两个自动确定高度命令，公式宏包 `amsmath` 又对这些命令的性能进行了改进。

    \begin{equation*}
    (\frac{a}{b}), 
    \big(\frac{a}{b}\big),
    \Big(\frac{a}{b}\Big),
    \bigg(\frac{a}{b}\bigg),
    \Bigg(\frac{a}{b}\Bigg),
    \left(\frac{a}{b}\right)
    \end{equation*}

六个字体尺寸相同的公式，但各自的定界符高矮不一，对比排版效果：

<center><img src="http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case1.png" alt="case1" width="434" height="102"/></center>


通常，对于比较复杂的数学结构，我们直接采用 `\left` 和 `\right`，让系统去确定高度，而不必使用 `\big` 等命令一档一档的试。但是 `\left` 和 `\right` 并非适合所有的情况，当数学结构中有上下标的时候，它们会使定界符的高度明显超过上下标；如果只有上标或者下标，它们仍然按上下标来处理。

    \begin{equation*}
    \bigg[\sum x\bigg]^{2},
    \left[\sum x \right]^{2},
    \bigg[\sum_{j} x \bigg]^{2},
    \left[\sum_{j} x \right]^{2}.
    \end{equation*}

对比排版效果：

<center><img src="http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case2.png" alt="case2" width="454" height="149"/></center>

在本例中，前两个数学式没有上下标，使用 `\left` 和 `\right` 效果较好；而后面两个有下标，使用 `\bigg` 效果较好。

再有，当定界符嵌套时，一般都希望外层的定界符略大于内层的，但是 `\left` 和 `\right` 做不到这一点。

    \begin{equation*}
    \left[(a+b)-c\right],\big[(a+b)-c\big]
    \end{equation*}

对比排版效果：

<center><img src="http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case3.png" alt="case3" width="372" height="78"/></center>

在 LaTeX 系统中，花括号，方括号和圆括号可以成对使用也可以单个使用，但是 `\left` 和 `\right` 命令必须成对使用，如果公式中只有一个左花括号，除了使用 `\left\{` 之外，还要在右侧某处（不能断行）空置一个带小圆点的 `\right` 命令，即：`\right.`，反之亦然。

## 未知空白的确定

有时为了多个数学式能够上下对齐， 需要留出一定的水平空白，但很难测定空白的确切宽度。遇到这种情况可使川仿真空白命令 `\phantom{参数}`，它可以精确地预留出排版参数所需的水平空白。

    \begin{minipage}{0.45\textwidth}
    \begin{gather*}
              -3p \geq x \geq -n\\
                p \geq x \geq -n
    \end{gather*}
    \end{minipage}
    \hfil
    \begin{minipage}{0.45\textwidth}
    \begin{gather*}
              -3p \geq x \geq -n\\
    \phantom{-3}p \geq x \geq -n
    \end{gather*}
    \end{minipage}

对比排版效果：

<center>![case4.png](http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case4.png)</center>

## 省略号的调整

系统提供了两个省略号命令: `\ldots` 和 `\cdots`，前者的三个圆点与逗号、顿号的位置平齐，后者的与加减号的中心平齐。在什么情况用什么省略号并没有一定之规，通常跟在加减号后的用 `\cdots`，跟在逗号或顿号后的用 `\ldots`。根据 AMS 出版物的排版惯例，公式宏包 `amsmath` 定义了以下一组省略号命令以适应不同情况的需要。

+ `dotsc` 　　紧跟在逗号后面的省略号；
+ `dotsb` 　　紧跟在二元运算符或者关系符后面的省略号；
+ `dotsm` 　　紧跟在乘积后面的省略号；
+ `dotsi` 　　紧跟在积分符号后面的省略号；
+ `dotso` 　　用于其他情况的省略号。

下面有一个说明性的例子

    Then we have the series $A_{1},A_{2},\dotsc,A_{n}$, 
    the original sum $A_{1}+A_{2}+\dotsb+A_{n}$, 
    the orthogonal product $A_{1} A_{2}\dotsm A_{n}$, 
    and the infinite integral
    \begin{equation*}
    \int_{A_{1}}\int_{A_{2}} \dotsi \int_{A_{n}}
    \end{equation*}

对比排版效果：

<center>![case5.png](http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case5.png)</center>

## 积分符号的上下标

定积分的上下标通常都位于积分符的右侧；如果希望将上下标分别置于积分符的顶端和底端, 可使用 `\mathop` 命令；但 `\mathop` 是以积分符的水平中线作为端线，而积分符具有一定的斜度，致使上下标与积分符的实际上下端产生一段水平偏差，可改为使用 `\limits` 命令解决这个问题；也可以直接使用 `\intop` 命令；在 `\intop` 命令后插入 `\nolimits` 命令，也可将上下标改回到积分符的右侧。

    \begin{equation*}
    \int_{a}^{b}           \quad
    \mathop{\int}_{a}^{b}  \quad
    \int\limits_{a}^{b}    \quad
    \intop_{a}^{b}         \quad
    \intop\nolimits_{a}^{b}
    \end{equation*}

对比排版效果：

<center><img src="http://elegantlatex.qiniudn.com/wp-content/uploads/2014/08/case6.png" alt="case6" width="436" height="133"/></center>

注意，其中 1 与 5 的效果是一样的，3 和 4 的效果是一样的。

## 结束语

LaTeX 中很多细节的处理在很多教程中都有涉及，但是，很多人可能没在意这些细节，或者说没办法精力去注意这些细节，毕竟大多数人还停留在交任务的阶段，此文内容来源于 《LaTeX2e 完全学习手册》 第八章第九节-精细调整 部分，本文略有修改，仅作抛砖引玉之用，如果需要更加详细、更多的内容，请参考学习手册。

