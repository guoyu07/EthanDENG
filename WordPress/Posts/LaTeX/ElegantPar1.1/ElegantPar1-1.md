##  ElegantPar 重要更新 

我们之前发布了旁注 ElegantPar 命令[点击前往](http://elegantlatex.org/2014/10/22/elegantpar-marginpar/)，反响不错，有同学反应这个命令无法在抄录环境中以及数学环境中使用，确实，如果这个命令如果不能支持数学式将是一大遗憾！当然我们也没有闲着，[EthanD](http://ddswhu.com/) 对源代码进行了修改，使其能支持了数学式。至于抄录环境，我觉得用的机会太少了，不考虑拓展到抄录环境，如果您有想法，请联系我们！

### 完整示例

这个样式是 marginnote （原来为 marginpar） 与 Ti*k*Z 的结合，支持 pdflatex 与 xelatex 编译，命令含有两个参数，`\elegantpar{#1}{#2}`，其中，第一个参数是旁注所标注的文本（更新之后兼容数学式），第二个参数为旁注的内容，一个完整的例子如下：

<pre class="lang:tex decode:true " >
\documentclass[a4paper,12pt]{article}

\usepackage{mathpazo}
\usepackage{bm}
\usepackage{tikz}
\usepackage[space,UTF8]{ctex}
\usepackage{marginnote}

\definecolor{tcolor}{RGB}{255,127,  0} % default: 0,124,53
\definecolor{lcolor}{RGB}{255,178,102} % default: 153,255,153
\definecolor{pcolor}{RGB}{251,204,231} % default: 216,255,216

\newif\ifstartedinmathmode
\newcommand{\elegantpar}[2]{%
 \relax\ifmmode\startedinmathmodetrue\else\startedinmathmodefalse\fi
  {\color{tcolor}\ifstartedinmathmode \ensuremath{\bm\langle #1 \bm\rangle}\else $\bm\langle$#1$\bm\rangle$\fi}%
  \begin{tikzpicture}[remember picture, baseline=-0.75ex]%
    \node[coordinate] (inText) {};%
  \end{tikzpicture}%
  \marginnote{%
    \renewcommand{\baselinestretch}{1.0}%
    \begin{tikzpicture}[remember picture]%
      \draw node[fill= pcolor, rounded corners,text width=\marginparwidth] (inNote){\footnotesize #2};%
    \end{tikzpicture}%
    }%
  \begin{tikzpicture}[remember picture, overlay]%
    \draw[draw = lcolor, thick]
      ([yshift=-0.55em] inText)
        -| ([xshift=-0.55em] inNote.west)
        -| (inNote.west);%
  \end{tikzpicture}%
}

\setlength{\marginparwidth}{2.5cm}

\begin{document}
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et \elegantpar{dolore magna aliqua}{This is Beautiful the elegantpar Style for English Text}. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

\begin{equation}
a^{2}+b^{2} = \elegantpar{c^{2}}{勾股定理}
\end{equation}

倒是作者分析到湘西的苗人的「仇外」避汉，这种思想其实并非是针对民族的，\elegantpar{而是阶层性的}{否则无以解释下层苗民对苗地土司的反抗}，因为当时官吏的主体无疑是统治阶级的民族――这种历史背景，导致了民族性质的被强调。雪峰山以东变成上层群体，毗邻的山西只有回避。这种区域内的消长平衡文化，在地理上以谷地为界限屏障，形成了自四川盆地往东的湖湘盆地、鄱赣盆地。这种变化，其实已较千把年前的「桃花源」 改变了许多$\elegantpar{a+c}{Just for fun}$。「不知有汉，无论魏晋」，湘西已经被雪峰以东的主导力量载荷入时代的范畴中去，到了曾国藩那时代，湘西其实已经纳入近代历史，而到了毛泽东时代，湘西业已是中国大历史的核心之一部分，即使那时「乡下」在我们的福建，和那年代的湘西，又有什么分别？一样是静悄悄的罢。 $2\elegantpar{x}{方程的解与数学符号的选择无关}=3$。

\end{document}
</pre>

效果为：

<center>![ELegantPar1.1](http://elegantlatex.org/wp-content/uploads/2014/11/ElegantPar1.1.jpg)</center>

### 关于颜色自定义（参考前文）

这个样式可以自定义用到的三个颜色 `tcolor`、`lcolor`、`pcolor`，分别表示旁注所标注的文本颜色、线条颜色以及旁注内容文本颜色。默认的颜色定义为

<pre class="lang:tex decode:true " >
\definecolor{tcolor}{RGB}{0,124,53} 
\definecolor{lcolor}{RGB}{153,255,153} 
\definecolor{pcolor}{RGB}{216,255,216} 
</pre>


### 数学环境中的使用

+ Inline math environment: 
<pre class="lang:tex decode:true " >
$a + \elegantpar{b}{The parameter $b$} = c$
</pre>
+ Display math environment:
<pre class="lang:tex decode:true " >
\begin{equation}
a^{2}+b^{2} = \elegantpar{c^{2}}{勾股定理}
\end{equation}
</pre>

## 更新日志：

+ 2014-10-22 ElegantPar1.0 发布，支持文本
+ 2014-11-03 ElegantPar1.1 更新，支持数学式

### 本次更新

+ 取消使用`\textcolor{tcolor}{...}`，直接使用 `{\color{tcolor}...}`，目的是为了兼容数学式。
+ 使用 `marginnote` 宏包中的 `\marginnote` 命令替换 `\marginpar`，因为 `\marginpar` 不能再数学式中使用
+ 增加对数学环境进行判断，使用 `\ifstartedinmathmode...\else...\fi` 结构

## 参考资料

+ [How to determine if in the math mode](http://tex.stackexchange.com/questions/46492/newcommand-how-to-determine-if-in-math-mode-and-then-include)
+ [Hanging margin notes in equation environment](http://www.latex-community.org/forum/viewtopic.php?f=46&t=4702)

[download info="ElegantPar1.1 代码下载" time="2014-11-03" cat="项目线"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/11/ElegantPar1.1.zip" target="_blank">本站下载</a>
[/download]
