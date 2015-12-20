## 问题来源

这其实是本模板的一个错误更正帖，有用户在使用我们模板的过程中，问到定理环境的交叉引用问题，经过验证，这确实是我们的错误。特更此帖，如果有之前下载我们的模板（2014-04-15之前）或者之后不在本站下载的，并且需要用到定理类环境的交叉引用，但是却有问题的用户，你可以先看下这帖子，我们已经修改模板的定理环境设置，可以去下载页面下载。

## 知识点

我们最常用的两种新建环境的方式是

+ 借助系统自带的 \newenvironment 命令（最常用）
+ 借助 environ 宏包

`\newenvironment` 命令虽然最常用，但是遇到括号匹配的问题的行不通了，比如我们下面的一个例子，我们在环境中使用了 TikZ 代码，导致无法使用 `\newenvironment` 命令创建环境。 这个时候我们可以使用 `environ`宏包得以实现，我们的 ElegantLaTeX 系列模板也是使用这两种方法创建的环境。

作为定理类的环境的扩展，有些人会用 `ntheorem` 宏包来创建，这个方法也是比较好的。我们这里不采用这个。值得注意的是，定理类环境通常是有编号的，而且可以作为交叉引用的对象。为了节约篇幅，下面直接介绍正确的创建方法。

## 代码实现

我们这里直接给出这两种命令创建的定理类环境（以 example 环境为例，感谢 [Heiko Oberdiek](http://tex.stackexchange.com/users/16967/heiko-oberdiek)）：

<pre class="lang:tex decode:true " >
\documentclass{book}
 
\usepackage{lipsum}
\usepackage{mathpazo}
 
\newcounter{exam}[chapter]
\setcounter{exam}{0}
\renewcommand{\theexam}{\thechapter.\arabic{exam}}
 
 % % Method 1
 
 % \newenvironment{example}[1][]{\refstepcounter{exam}\par\medskip\noindent%
 %    \textbf{Example \theexam~ #1} \rmfamily}{\medskip}
 
 % Method 2
\usepackage{environ,tikz}
\tikzstyle{title}=[right=10pt,fill=gray,text=green!50]
\tikzstyle{context}=[thick,rectangle,draw=gray,inner sep=10pt, inner ysep=10pt]
\NewEnviron{example}[1][{}]{%
    \par
    \centering
    \addvspace{\medskipamount}%
    \begin{tikzpicture}
        \node[context](box){%
            \begin{minipage}{0.93\textwidth}
                \refstepcounter{exam}%
                \BODY
            \end{minipage}};
        \node[title] at (box.north west){\textbf{Example \theexam\ #1}};
    \end{tikzpicture}%
    \par
}
 
\begin{document}
 
\setcounter{chapter}{2}
 
\begin{example}[First]\label{exam:1}
    \lipsum[4]
\end{example}
 
\lipsum[2]
 
\begin{example}[Second]\label{exam:2}
    \lipsum[5]
\end{example}
 
Example~\ref{exam:1} and~\ref{exam:2} are the new environments!
 
\end{document}
</pre>

**效果图如下**：

<center>![new-environ](http://elegantlatex.org/wp-content/uploads/2014/09/new-environ.png)</center>

原帖地址：

[http://tex.stackexchange.com/questions/171641/cross-reference-of-custom-environments-created-with-environ-and-tikz-package](http://tex.stackexchange.com/questions/171641/cross-reference-of-custom-environments-created-with-environ-and-tikz-package)

[download info="自定义环境" time="2014-04-19" cat="项目线"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/09/custom-environment.zip" target="_blank">本站下载</a>
[/download]
