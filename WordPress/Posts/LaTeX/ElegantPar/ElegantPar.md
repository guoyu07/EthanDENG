## 新样式 ElegantPar 发布 

勤劳的小 L 这周又给我们带来了新品——旁注命令（ElegantPar）！这次，我们发布的旁注样式，将作为 ElegantLaTeX 项目组相关模板的补充，敬请期待！

这个样式是 marginpar 与 Ti*k*Z 的结合，支持 pdflatex 与 xelatex 编译，命令含有两个参数，`\elegantpar{#1}{#2}`，其中，第一个参数是旁注所标注的文本，第二个参数为旁注的内容，一个完整的例子如下：

<pre class="lang:tex decode:true " >
\documentclass[a4paper,12pt]{article}

\usepackage{mathpazo}
\usepackage{bm}
\usepackage{tikz}
\usepackage[space,UTF8]{ctex}

\definecolor{tcolor}{RGB}{255,127,  0} % default: 0,124,53
\definecolor{lcolor}{RGB}{255,178,102} % default: 153,255,153
\definecolor{pcolor}{RGB}{251,204,231} % default: 216,255,216

\newcommand{\elegantpar}[2]{%
  \textcolor{tcolor}{$\bm\langle{}\!{}$#1${}\!{}\bm\rangle$}%
  \begin{tikzpicture}[remember picture, baseline=-0.75ex]%
    \node[coordinate] (inText) {};%
  \end{tikzpicture}%
  \marginpar{%
    \renewcommand{\baselinestretch}{1.0}%
    \begin{tikzpicture}[remember picture]%
      \draw node[fill= pcolor, rounded corners,text width=\marginparwidth] (inNote){\footnotesize#2};%
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


倒是作者分析到湘西的苗人的「仇外」避汉，这种思想其实并非是针对民族的，\elegantpar{而是阶层性的}{否则无以解释下层苗民对苗地土司的反抗与苗汉通婚在下层的实现可能}，因为当时官吏的主体无疑是统治阶级的民族――这种历史背景，导致了民族性质的被强调。雪峰山以东变成上层群体，毗邻的山西只有回避。这种区域内的消长平衡文化，在地理上以谷地为界限屏障，形成了自四川盆地往东的湖湘盆地、鄱赣盆地，\elegantpar{各有一套自己的平衡规则存在着}{从而也使自称「乡下人」的下层隐逸群落，自称为「边民」}。这种变化，其实已较千把年前的「桃花源」 改变了许多。「不知有汉，无论魏晋」，湘西已经被雪峰以东的主导力量载荷入时代的范畴中去，到了曾国藩那时代，湘西其实已经纳入近代历史，而到了毛泽东时代，湘西业已是中国大历史的核心之一部分，即使那时「乡下」在我们的福建，和那年代的湘西，又有什么分别？一样是静悄悄的罢。

\end{document}
</pre>

效果为：

<center>![ELegantPar](http://elegantlatex.org/wp-content/uploads/2014/10/ltxtest-ex2.jpg)</center>

## 关于颜色自定义

这个样式可以自定义用到的三个颜色 `tcolor`、`lcolor`、`pcolor`，分别表示旁注所标注的文本颜色、线条颜色以及旁注内容文本颜色。默认的颜色定义为

<pre class="lang:tex decode:true " >
\definecolor{tcolor}{RGB}{0,124,53} 
\definecolor{lcolor}{RGB}{153,255,153} 
\definecolor{pcolor}{RGB}{216,255,216} 
</pre>

默认的颜色效果为

<center>![ElegantPar(Default)](http://elegantlatex.org/wp-content/uploads/2014/10/ltxtest-ex1.jpg)</center>

[download info="ElegantPar 代码下载" time="2014-10-22" cat="项目线"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/10/ElegantPar.zip" target="_blank">本站下载</a>
[/download]
