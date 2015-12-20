## 原文信息
本文是翻译稿，原文作者是 [Nick Higham](https://nickhigham.wordpress.com/)，原文链接：[Top 5 Beamer Tips](https://nickhigham.wordpress.com/2013/01/18/top-5-beamer-tips/)。

## 关于 Beamer
如果你是做学术的老师或者学生（经济学或者数学啥的），那么你肯定见过很多 Beamer 制作的讲稿，我们本文并不是讲如何制作 Beamer，如果你想学习如何制作 Beamer，请参考本站博文 [使用 Beamer 制作学术讲稿](http://ddswhu.com/2014/12/05/beamer-slides-tutorial/)。

## 使用 Beamer 的五个小技巧

### 隐藏导航符号
我听过很多很多由 Beamer 制作的讲座，但是我并没有看过有人使用 Beamer 右下角（底部）的那些用于导航的符号，我们可以使用下面的命令取消掉导航符号的显示。

<pre class="lang:tex decode:true " >
\setbeamertemplate{navigation symbols}{}
</pre>

### 添加额外幻灯片
如果我们需要添加一些额外的讲稿进来，但不想我们的页码（通常在页脚）受到影响，我们可以使用 `appendixnumberbeamer` 宏包来实现，如果发行版本没有带这个包，可以从 [CTAN](http://www.ctan.org/pkg/appendixnumberbeamer) 下载，然后放到我们的主文档所在文件夹内。使用方法如下：

<pre class="lang:tex decode:true " >
\usepackage{appendixnumberbeamer} % 放在导言区
...
\appendix 
\begin{frame}{First Extra slide}
   ...
\end{frame}
</pre>

### 参考文献的写法
我们可以使用下面的命令添加参考文献，最好放在 `\appendix` 后面。

<pre class="lang:tex decode:true " >
\begin{frame}[allowframebreaks]{References}
\def\newblock{}
\bibliographystyle{plain}
\bibliography{mybib}
\end{frame}
</pre>

使用 `allowframebreaks` 选项是为了自动分帧。

### 每一节显示目录
在我们做一个比较长的报告时，我们可能会想在每一节添加一个目录，让听众清楚内容讲到哪了，我们可以在导言区添加如下的命令。

<pre class="lang:tex decode:true " >
\setbeamerfont{myTOC}{series=\bfseries,size=\Large}
\AtBeginSection[]{\frame{\frametitle{Outline}%
                  \usebeamerfont{myTOC}\tableofcontents[current]}}
</pre>

为了得到节的标题信息，我们会在帧与帧之间添加 `\section[short_title]{long_title}`, 其中 `short_title` 是短标题，用于 “页眉” 信息（header）显示。如果你不想要显示每帧的页眉信息（header），可以使用下面的命令。

<pre class="lang:tex decode:true " >
\setbeamertemplate{headline}{}
</pre>

### 多栏显示
有时候我们有图需要并排摆放，一个好方法是使用分栏，尤其是当两个图不同的高度的时候，然后在每一栏插入我们需要的图片。代码如下：

<pre class="lang:tex decode:true " >
\begin{columns}[c] % Columns centered vertically.
\column{5.5cm}     % Adjust column width to taste.
\includegraphics ...
\column{5cm}
\includegraphics ...
\end{columns}
</pre>
