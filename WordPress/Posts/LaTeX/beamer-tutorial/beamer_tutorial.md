## 阅读须知：

**此文给出的命令没有非常仔细的解释，如果不甚理解，可以期待本站拟于 12 月出的一个与之配套的视频教程**

本站所发为网页版本，PDF版本下载见文后。

## 缘何
### Beamer 有哪些好处

+ 学术偏好，就是任性
+ 和 LaTeX 搭配，兼容 LaTeX 命令
+ 高度可读性与清晰的逻辑
+ 输出为 PDF，跨平台显示无差异

### 怎么获取？

+ 安装 CTeX Full 版本
+ 安装 TeX Live 或者其他发行版

### 一个简单的例子
<pre class="lang:tex decode:true " >
\documentclass{beamer}
\usepackage[UTF8,space,hyperref]{ctex}
\usetheme{warsaw}
\author{ddswhu}
\title{First Start}

\begin{document}

\frame{\titlepage}

\begin{frame}[c]\frametitle{frame title}
The context goes here
\end{frame}

\end{document}
</pre>

## 文档结构

### 帧
我们看到的每一页 PDF 即是所谓幻灯片的帧，Beamer 的帧分为三类，帧对于 beamer 就像书页对于书。

+ 标题页帧
<pre class="lang:tex decode:true " >
 \frame{\titlepage}
</pre>
+ 普通帧
<pre class="lang:tex decode:true " >
\begin{frame}[对齐方式]\frametitle{帧标题}
内容
\end{frame}
</pre>
+ 空白帧
<pre class="lang:tex decode:true " >
\begin{frame}[plain]
空白帧没有标题
\end{frame}
</pre>

### 标题页帧
标题页帧是我们的第一帧，在这上面，我们会有标题、作者、时间、机构，LOGO 等信息，可以显示在标题的主要信息如下：
<pre class="lang:tex decode:true " >
\title[short title]{long title}
\subtitle[short subtitle]{long subtitle}
\author[short name]{long name}
\date[short date]{long date}
\institution[short name]{long name}
\titlegraphic{\includegraphics[width=0.17\textwidth]{ias.pdf}}
</pre>

### 目录与节、小节
**目录**
<pre class="lang:tex decode:true " >
\begin{frame}\frametitle{Outline}
\tableofcontents[part=1,pausesections]
\end{frame}
</pre>

**节与小节**
<pre class="lang:tex decode:true " >
\section{section name}
\subsection{subsection name}
\subsubsection{sub-subsection name}
\section*{section name}
</pre>
最后一个命令生成一个节（section） ，但是，这个节不进入目录中。

## 列表环境

三类列表环境，包括无序列表（itemize） 、有序列表（enumerate） 、描述列表（description） 。其中前两者非常常用，使用非常简单。

### 无序列表 itemize 示例

<pre class="lang:tex decode:true " >
\begin{itemize}
\item The first item
\item The second item
\item The third item
\item The fourth item
\end{itemize}
</pre>
效果：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/itemize.png](http://elegantlatex.org/wp-content/uploads/2014/12/itemize.png)</center>

### 有序列表 enumerate 示例
<pre class="lang:tex decode:true " >
\begin{enumerate}
\item The first item
\item The second item
\item The third item
\item The fourth item
\end{enumerate}
</pre>
效果：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/enumerate.png](http://elegantlatex.org/wp-content/uploads/2014/12/enumerate.png)</center>


### 描述列表 description 示例
<pre class="lang:tex decode:true " >
\begin{description}
\item[First Item] Description of first item
\item[Second Item] Description of second item
\item[Third Item] Description of third item
\item[Forth Item] Description of forth item
\end{description}
</pre>
效果：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/description.png](http://elegantlatex.org/wp-content/uploads/2014/12/description.png)</center>

## 段落文本

### 文本命令
<pre class="lang:tex decode:true " >
\emph{Sample Text}
\textbf{Sample Text}
\textit{Sample Text}
\textsl{Sample Text}
\alert{Sample Text}
\textrm{Sample Text}
\textsf{Sample Text}
\textcolor{green}{Sample Text}
\structure{Sample Text}
</pre>
效果：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/text.png](http://elegantlatex.org/wp-content/uploads/2014/12/text.png)</center>

### 字体与字号

+ 字体主题：`\usefonttheme[onlymath]{serif}`
+ 字体大小：`\documentclass[11pt]{beamer}`，可选项为 10-11-12pt
+ 字体族　：`\usepackage{helvet}`，可选项为
<pre class="lang:tex decode:true " >
serif avant bookman chancery charter
euler helvet mathtime mathptm mathptmx
newcent palatino pifont utopia
</pre>

### 分栏

**多栏显示**：在我们做讲稿的时候，有时候为了使得幻灯片更加工整，充实，会在一旁插入图片、表格或者说明性的文字，这个时候可以使用 beamer 中的多栏环境（columns）或者 LaTeX 中的子页环境
（minipage） 。
<pre class="lang:tex decode:true " >
\begin{columns}
\column{.xx\textwidth}
First column text and/or code
\column{.xx\textwidth}
Second column text and/or code
\end{columns}
</pre>

## 帧内结构
### 区块
Beamer 中一个非常有特色的是它带了一些区块（block） ，这些区块环境与普通文本能很好地区分开来，适用于各种定理，引理以及示例。默认的 Beamer 有如下环境：

+ block 普通环境
+ theorem 定理环境
+ lemma 引理环境
+ proof 证明环境
+ corollary 推论环境
+ example 示例环境
+ alertblock 警示环境

比如定理环境效果：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/thm-block.png](http://elegantlatex.org/wp-content/uploads/2014/12/thm-block.png)</center>

## 图与表格
插图与插表格的命令和 LaTeX 没有区别，插表的命令如下：

<pre class="lang:tex decode:true " >
\begin{table}[tb]
\centering
\caption{Caption here\label{tab:tablename}}
\begin{tabular}{l|cc} \hline
\textbf{column 1} & \textbf{column 2} & \textbf{column 3} \\ \hline
Hello & Beamer & NAN \\ \hline
$\alpha+\beta$ & $\gamma+\eta$ & 34\% \\ \hline
\end{tabular}
\end{table}
</pre>

插图的命令如下：

<pre class="lang:tex decode:true " >
\begin{figure}[tb]
\centering
\includegraphics[width=0.9\textwidth]{figure.png}
\caption{Caption here\label{fig:figure1}}
\end{figure}
</pre>

插图与插表效果图：
<center>![http://elegantlatex.org/wp-content/uploads/2014/12/table-figure.png](http://elegantlatex.org/wp-content/uploads/2014/12/table-figure.png)</center>

## 主题
Beamer 因为有各种主题才使得有生气，不过，大部分人还在用默认的主题，其中，Warsaw 用的非常多，建议避免。默认的主题如下：

<pre class="lang:tex decode:true " >
Antibes Bergen Berkeley Berlin
Boadilla Copenhagen Darmstadt Dresden
Frankfurt Goettingen Hannover Ilmenau
Juanlespins Madrid Malmoe Marburg
Montpellier Paloalto Pittsburgh Rochester
Singapore
</pre>

可以查看 [http://www.ctan.org/tex-archive/macros/latex/contrib/beamer/doc/](http://www.ctan.org/tex-archive/macros/latex/contrib/beamer/doc/) 上各种主题的 PDF 效果。

### 颜色主题

颜色主题有三种，分别是 colortheme，inner color theme，outter color theme。 colortheme 控制着全部的颜色，inner color theme 控制着帧内一些元素的颜色，主要是 block，outter color theme 控制着 headline，footline，sidebar 等元素的颜色。使用的方法都是一致的。即 `\usecolortheme{default}`。

**Beamer 中的颜色主题：**
<pre class="lang:tex decode:true " >
color theme: albatross crane beetle dove fly seagull wolverine beaver
inner color: lily orchid rose
outter color: whale seahorse dolphin
</pre>

## 想了解更多？

+ The Beamer Class User Guide for v3.10(官方文档)
+ Beamer v3.0 Guide(Ki-JooKim)
+ Beamer v3.0 指南 (黄旭华译)
+ A Beamer Tutorial in Beamer(本文内容来源)

## 广告时间
ElegantLaTeX 项目组致力于设计美观的 LaTeX 系列模板，我们的主页是 [http://elegantlatex.org](http://elegantlatex.org/)！欢迎关注我们的微博：[@ElegantLaTeX](http://weibo.com/u/5088233297)，ElegantLaTeX 目前成员有：

+ Ethan D ([http://ddswhu.com/](http://ddswhu.com/))
+ 勤劳的小L ([http://liam0205.me/](http://liam0205.me/))
+ 逐鹿人 ([http://wangmurong.org.cn/](http://wangmurong.org.cn/))
+ fitsir ([http://fitsir.me/](http://fitsir.me/))
+ WD (Error 404 -- Not Found)

如果你有一颗乐于奉献的心、对 LaTeX 比较感兴趣，或者对设计有兴趣、独特见解，欢迎加入我们！

[download info="Beamer 教程" time="2014-12-05" cat="技巧"]
<a href="http://elegantlatex.org/wp-content/uploads/2014/12/Beamer_tutorial.pdf" target="_blank">本站下载</a>
[/download]
